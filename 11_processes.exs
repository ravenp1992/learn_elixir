# Processes

# In Elixir, all code runs inside processes. Processes are isolated from each other, run concurrent to
# one another and communicate via message passing. Processes are not only the basis for concurrency in
# Elixir, but they also provide the means for building distributed and fault-tolerant programs.

# Elixir's processes should not be confused with operating system processes. Processes in Elixir are
# extremely lightweight in terms of memory and CPU (even compared to threads as used in many other
# programming languages). Because of this, it is not uncommon to have tens or even hundreds of thousands
# of processes running simultaneously.

# Spawning processes
# The basic mechanism for spawning new processes is the auto-imported spawn/1 function:
# pid = spawn(fn -> 1 + 2 end)
# IO.inspect(pid)

# spawn/1 takes a function which it will execute in another process.
# Notice spawn/1 returns a PID (Process identifier). At this point, the process you spawned is very
# likely dead. The spawed process will execute the given function and exit after the function is done:
# pid = spawn(fn -> 1 + 2 end)
# Process.alive?(pid)
# -> false

# We can retrieve the PID of the current process by calling self/0:
# IO.inspect(Process.alive?(self()))

# Sending and receiving messages
# We can send messages to a process with send/2 and receive them with receive/1:
# send(self(), {:hello, "world"})

# receive do
#   {:hello, msg} -> IO.puts(msg)
#   {:world, _msg} -> IO.puts("Won't match")
# end

# When a message is sent to a process, the message is stored in the process mailbox. The receive/1 block
# goes through the current process mailbox searching for a message that matches anny of the given patterns.
# receive/1 support guards and many clauses, such as case/2.

# The process that send the message does not block on send/2, it puts the message in the recipient's mailbox
# and continues. In particular, a process cn send messages to itself.

# If there is no message in the mailbox matching any of the patterns, the current process will wait until
# a matching message arrives. A timeout can also be specified:

# receive do
#   {:hello, msg} -> IO.puts(msg)
# after
#   1_000 -> IO.puts("nothing after 1s")
# end

# A timeout of 0 can be given when you already expect the message to be in the mailbox.

# self() return the current process pid
# parent = self()

# spawn(fn -> raise "oops" end)
# spawn an new process that send data to the parent
# spawn(fn -> send(parent, {:hello, self()}) end)
# spawn(fn -> send(parent, {:new, self()}) end)
# spawn(fn -> send(parent, {:world, self()}) end)

# receive do
#   {:hello, pid} ->
#     IO.puts("Go hello from #{inspect(pid)}")

#   {:new, pid} ->
#     IO.puts("Go hello from #{inspect(pid)}")

#   {:world, pid} ->
#     IO.puts("Go hello from #{inspect(pid)}")
# after
#   10_000 -> IO.puts("nothing after 10s")
# end

# Links
# The majority of times we spawn processes in Elixir, we spawn them as linked processes.
# Before we show an example with spawn_link/1, let's see what happens when a process started with spawn/1 fails:

# run this in iex
# IO.inspect(spawn(fn -> raise "oops" end))

# It will merely logged an error but the parent process is still running. That's because processes are
# isolated. If we want the failure in one process to propagate to another one, we should link them.

# run this in iex
# self()
# spawn_link(fn -> raise "oops" end)

# Because processes are linked, we now see a message saying the parent process, which is the shell process,
# has received an EXIT signal from another process causing the shell to terminate. IEx detects this
# situation and starts a new shell session.

# spawn/1 and spawn_link/1 are the basic primitives for creating processes in Elixir.

# Tasks
# Tasks build on top of the spawn functions to provide better error reports and introspection:

# run in iex
# Task.start(fn -> raise "oops" end)

# Instead of spawn/1 and spawn_link/1, we use Task.start/1 and Task.start_link/1 which returns {:ok, pid}
# rather than just the PID. This is what enables tasks to be used in supervision trees, Furthermore, Task
# provides convenience functions, like Task.async/1 and Task.await/1, and functionality to ease distribution.

# State
# we haven't talked about state so far. If you are building an application that requires state, for example
# to keep your application configuration, or you need to parse a file and keep it in memory, where would you store it?.

# Processes are the most common answer to this question. We can write processes that loop infinitely,
# maintain state, and send and receive messages. As an example, let's write a module that starts new
# processes that work as a key-value store in a file named kv.exs:

# {:ok, pid} = KV.start_link()
# send(pid, {:get, :hello, self()})
# flush()

# send(pid, {:put, :hello, :world})
# send(pid, {:get, :hello, self()})
# flush()

# Notice how the process is keeping a state and we can get and update this state by sending the process
# messages. In fact, any process that knows the pid above will be able to send it messages and manipulate the state.

# It is also possible to register the pid, giving it a name, and following everyone that knows the
# name to send it messages:

# Process.register(pid, :kv)
# send(:kv, {:get, :hello, self()})
# flush()

# Using processes to maintain state and name registration are very common patterns in Elixir applications.
# However, most of the time, we won't implement those patterns manually as above, but by using one of the
# many abstractions that ship with Elixir. For example, Elixir provides
# Agents, which are simple abstractions around state. Our code above could be directly written as:

{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
Agent.get(pid, fn map -> Map.get(map, :hello) end)
