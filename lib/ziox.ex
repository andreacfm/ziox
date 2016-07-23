defmodule Ziox do
  
  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([]) do
    IO.puts "No args"
  end

  def process({options,["up"],_}) do
    Ziox.Up.process(options)
  end

  def process({_,_,_}) do
    IO.puts('Unknown command zio!')
  end

  defp parse_args(args) do
    {options,cmd,_} = OptionParser.parse(args,
      strict: [dir_set: :string],
      aliases: [s: :dir_set]
    )
  end
end
