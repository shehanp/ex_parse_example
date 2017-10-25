defmodule Dump do
	def something(rows, headers) do
		for header <- headers, do: IO.puts(rows[header])
	end
end