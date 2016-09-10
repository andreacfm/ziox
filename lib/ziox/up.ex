defmodule Ziox.Up do
  require Logger

  def process(options) do
    File.cd("/Users/andrea/dev/elixir")
    {:ok, dirs} = File.ls

    dirs
    |> only_git
    |> Enum.map(&Task.async(fn ->
          {out, exit_code} = System.cmd("git", ["pull", "--rebase", "origin/master"], cd: Path.expand(&1))
          Logger.info "UP for #{Path.expand(&1)}\n" <> out
        end))
    |> Enum.map(fn (pid) -> Task.await(pid) end)

  end

  def only_git(dirs) do
    Enum.filter dirs, fn (dir) ->
      File.dir?(dir) && File.exists?(dir <> "/.git")
    end
  end

end
