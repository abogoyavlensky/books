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
    # |> IO.inspect
    |> get_result_list
    # |> Enum.each(&IO.inspect/1)
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
  
  def parse_param(name, value, extra \\ "")
  def parse_param(name, value, ""), do: %{name: name, value: value, extra: ""}
  def parse_param(name, value, extra) do
    %{name: name, value: value, extra: extra}
  end
  
  def get_result_list(data) do
    data[:items]
    |> get_items_list
  end
  
  def get_items_list(items) do
    len = get_max_len_of_names(items)
    IO.puts len
    items
    |> Map.values
    |> Enum.map(&row_join(&1, len)) 
  end
  
  def get_max_len_of_names(items) do
    len = items
    |> Map.values
    |> Enum.map(&String.length(&1.name))
    |> Enum.max    
  end
  
  def row_join(%{name: name, value: value, extra: ""}, len) do
    pad = len - String.length(name)
    name = String.pad_leading(name, pad)
    "#{name}: #{value}"
  end
  def row_join(%{name: name, value: value, extra: extra}, len) do
    pad = len - String.length(name)
    name = String.pad_leading(name, pad)
    "#{name}: #{value} #{extra}\n"    
  end
end
