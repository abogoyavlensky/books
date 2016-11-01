defmodule WeatherCLITest do
  use ExUnit.Case
  doctest Weather.CLI
  
  import Weather.CLI, only: [parse_args: 1, get_items_list: 2]
  
  test ":help returned if --help or -h given" do
    assert parse_args(["--help"]) == :help
    assert parse_args(["-h"]) == :help
  end  
  test "section_id returned if -s given" do
    assert parse_args(["-s", "test"]) == "test"
  end
  test ":help returned if -s is not param" do
    assert parse_args([]) == :help
  end  
  test "get_items_list to return right values" do
    len = 5
    items = %{first: %{name: "name", value: "value", extra: ""}, 
              second: %{name: "name2", value: "value2", extra: "extra2"}}
    right_result = [" name: value", "name2: value2 extra2"]
    assert get_items_list(items, len) == right_result    
  end
end
