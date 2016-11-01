defmodule Weather.CLI do
  @moduledoc """
  Module to process cli interface of weather app.
  """
  
  import SweetXml
  
  @doc """
  Processes data flow from fetching xml data for single station_id to displaing 
  it as pretty and human readable table.
  """
  def process(station_id) do
    station_id
    |> Weather.NOAA.fetch
    |> parse_response
    |> get_result_list
    |> Enum.each(&IO.puts/1)
  end

  @doc """
  Parse xml data from successful http response.
  """
  def parse_response(data) do
    data
    |> SweetXml.xpath(
      ~x"//current_observation",
      location: ~x"./location/text()",
      station_id: ~x"./station_id/text()",
      lat: ~x"./latitude/text()",
      lng: ~x"./longitude/text()",
      items: [
        ~x".",
        updated: ~x"./observation_time/text()"
        |> SweetXml.transform_by(&parse_param("Last Updated", &1)),
        updated_rfc822: ~x"./observation_time_rfc822/text()"
        |> SweetXml.transform_by(&parse_param("", &1)),
        weather: ~x"./weather/text()"
        |> SweetXml.transform_by(&parse_param("Weather", &1)),
        temperature: ~x"./temperature_string/text()"
        |> SweetXml.transform_by(&parse_param("Temperature", &1)),
        dewpoint: ~x"./dewpoint_string/text()"
        |> SweetXml.transform_by(&parse_param("Dewpoint", &1)),
        relative_humidity: ~x"./relative_humidity/text()"
        |> SweetXml.transform_by(&parse_param("Relative Humidity", &1, "%")),
        heat_index: ~x"./heat_index_string/text()"
        |> SweetXml.transform_by(&parse_param("Heat Index", &1)),
        wind: ~x"./wind_string/text()"
        |> SweetXml.transform_by(&parse_param("Wind", &1)),
        visibility: ~x"./visibility_mi/text()"
        |> SweetXml.transform_by(&parse_param("Visibility", &1, "miles")),
        pressure: ~x"./pressure_string/text()"
        |> SweetXml.transform_by(&parse_param("MSL Pressure", &1)),
        altimetr: ~x"./pressure_in/text()" 
        |> SweetXml.transform_by(&parse_param("Altimeter", &1, "in Hg"))
      ]
    )
  end
  
  @doc """
  Parses param from xpath.
  
  ## Examples
      iex> Weather.CLI.parse_param("name", "value")
      %{name: "name", value: "value", extra: ""}
      
      iex> Weather.CLI.parse_param("name", "value", "extra")
      %{name: "name", value: "value", extra: "extra"}      
  """
  def parse_param(name, value, extra \\ "")
  def parse_param(name, value, ""), do: %{name: name, value: value, extra: ""}
  def parse_param(name, value, extra) do
    %{name: name, value: value, extra: extra}
  end
  
  @doc"""
  Returns list of all string including title to display for user.
  """
  def get_result_list(data) do
    len = get_max_len_of_names(data[:items])
    results = data[:items] |> get_items_list(len)
    
    title = to_string(data[:location])
    title_len = len + div(String.length(title), 2) + 2
    coord = "(#{data[:station_id]}) #{data[:lat]}N #{data[:lng]}W"
    coord_len = len + div(String.length(coord), 2) + 2
    results = [String.pad_leading(coord, coord_len), "\n" | results]
    
    [String.pad_leading(title, title_len) | results]
  end
  
  @doc """
  Returns list of string from items to display for user.
  """
  def get_items_list(items, len) do    
    items
    |> Map.values
    |> Enum.map(&row_join(&1, len)) 
  end
  
  @doc """
  Returns max length of names through the weather fields (items).
  
  ## Examples
      iex> items = %{first: %{name: "Test"}, second: %{name: "Longer"}}
      iex> Weather.CLI.get_max_len_of_names(items)
      6
  """
  def get_max_len_of_names(items) do
    len = items
    |> Map.values
    |> Enum.map(&String.length(&1.name))
    |> Enum.max    
  end

  @doc """
  Returns string for row from item's values.
  
  ## Examples
      iex> Weather.CLI.row_join(%{name: "", value: "value", extra: ""}, 5)
      "       value"
      
      iex> Weather.CLI.row_join(%{name: "name", value: "value", extra: ""}, 5)
      " name: value"

      iex> Weather.CLI.row_join(%{name: "name", value: "value", extra: "extra"}, 
      ...> 5)
      " name: value extra"
      
  """
  def row_join(%{name: "", value: value, extra: ""}, len) do
    "#{String.pad_leading("", len)}  #{value}"
  end  
  def row_join(%{name: name, value: value, extra: ""}, len) do
    "#{String.pad_leading(name, len)}: #{value}"
  end
  def row_join(%{name: name, value: value, extra: extra}, len) do
    "#{String.pad_leading(name, len)}: #{value} #{extra}"
  end
end
