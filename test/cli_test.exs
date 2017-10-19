defmodule CliTest do
	use ExUnit.Case
	doctest Issues
	
	import Issues.CLI, only: [ parse_args: 1, sort_ascending: 1 ]
	
	test ":help returned by option parsing with -h and --help options" do
		assert parse_args(["-h", "anything"]) == :help
		assert parse_args(["--help", "anything"]) == :help
	end
	
	test "three values returned if three given" do
		assert parse_args(["shehanp", "test", "99"]) == { "shehanp", "test", 99}
	end
	
	test "count is default when only 2 numbers given" do
		assert parse_args(["shehanp", "something"]) == { "shehanp", "something", 4}
	end
	
	test "sort ascending order the correct way" do
		result = sort_ascending(fake_created_at_list(["c", "a", "b"]))
		issues = for issue <- result, do: Map.get(issue, "created_at")
	end
	
	defp fake_created_at_list(values) do
		for value <- values,
		do: %{"created_at" => value, "other_data" => "xxx"}
	end
end