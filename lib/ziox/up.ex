defmodule Ziox.Up do
  require Logger

  def process(options) do
    File.cd("/Users/andrea/dev/elixir")
    {:ok, dirs} = File.ls

    dirs
    |> only_git
    |> Enum.map(&Task.async(fn ->
        case System.cmd("git", ["pull", "--rebase"], cd: Path.expand(&1), stderr_to_stdout: true) do
          {out, 0} -> IO.puts "\n[INFO] - UP for #{Path.expand(&1)}\n" <> out
          {out, 1} -> IO.puts "\n[ERROR] - UP for #{Path.expand(&1)} failed"
        end
      end))
    |> Enum.map(fn (pid) -> Task.await(pid) end)

  end

  def only_git(dirs) do
    Enum.filter dirs, fn (dir) ->
      File.dir?(dir) && File.exists?(dir <> "/.git")
    end
  end

end
