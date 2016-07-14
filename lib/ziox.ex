defmodule Ziox do

  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([]) do
    IO.puts "No args"
  end

  def process(options) do
    IO.inspect(options)
  end

  defp parse_args(args) do
    {options,cmd,_} = OptionParser.parse(args,
      switches: [dir_set: :string],
      aliases: [s: :dir_set]
    )
  end

end
