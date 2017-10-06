defmodule Issues.CLI do
	@default_count 4
	
	@moduledoc """
	handle the command line parsing and the dispatch to the various functions that end up generating a table of the last _n_ issues in a github project
	"""
	
	def run(command) do
		command
		|>parse_args
		|>process
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
	
	def process(:help) do
		IO.puts """
		usage: issues <user> <project> [count | #@default_count]
		"""
		System.halt(0)
	end
	
	def process({user, project, _count}) do
		Issues.GitHubIssues.fetch(user, project)
		|> decode_response
	end
	
	def decode_response({:ok, body}), do: body
	def decode_response({:error, error}) do
		{_, message} = List.keyfind(error, "message", 0)
		IO.puts "Error fetching from Github: #{error["message"]}"
		System.halt(2)
	end
end