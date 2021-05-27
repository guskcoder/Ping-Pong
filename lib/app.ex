defmodule App.Ping do
  def start() do
    wait()
  end

  def wait() do
    receive do
      {pid, :pong} ->
        send(pid, {self(), :ping})
        IO.puts "Recebi um pong"
    end
    wait()
  end
end

defmodule App.Pong do
  def start() do
    wait()
  end

  def wait() do
    receive do
      {pid, :ping} ->
        send(pid, {self(), :pong})
        IO.puts "Recebi um ping"
    end
    wait()
  end
end

defmodule App.Table do
  def start() do
    ping = spawn(App.Ping, :start, [])
    pong = spawn(App.Pong, :start, [])
    send(ping, {pong, :pong})
  end
end
