defmodule Issues.CLI do
	@default_count 4
	
	@moduledoc """
	handle the command line parsing and the dispatch to the various functions that end up generating a table of the last _n_ issues in a github project
	"""
	
	def run(command) do
		parse_args(command)
	end
	
	@doc """
	
	`command` - Will return a tuple of `{user, project, count}`, or `:help` 
	
	"""
	def parse_args(command) do
		parse = OptionParser.parse(command, switches: [help: :boolean],
										  aliases: [ h:   :help])
		case parse do
			{[help: true], _, _} -> :help
			{_, [ user, project, count], _} -> { user, project, String.to_integer(count) }
			{_, [ user, project], _} -> { user, project, @default_count}
			_ -> :help
		end
	end
	
end