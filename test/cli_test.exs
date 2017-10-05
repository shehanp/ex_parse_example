defmodule CliTest do
	use ExUnit.Case
	doctest Issues
	
	import Issues.CLI, only: [ parse_args: 1 ]
	
	test ​"​​:help returned by option parsing with -h and --help options"​ ​do
		assert parse_args([​"​​-h"​,     ​"​​anything"​]) == ​:help
		assert parse_args([​"​​--help"​, ​"​​anything"​]) == ​:help​
	end
	
	# test "nil returned by option parsing with -h and --help options" do
	# 	assert parse_args(["-h",     "anything"]) == :help
	# 	assert parse_args(["--help", "anything"]) == :help
	# end
	
	test "three values returned if three given" do
		assert parse_args(["shehanp", "test", "99"]) == { "shehanp", "test", 99}
	end
	
	test "count is default when only 2 numbers given" do
		assert parse_args(["shehanp", "something"]) == { "shehanp", "something", 4}
	end
end