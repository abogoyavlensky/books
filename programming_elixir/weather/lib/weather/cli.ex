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
    |> IO.inspect
  end

  @doc """
  Parse xml data from successful http response.
  """
  def parse_response(data) do
    data
    |> SweetXml.xpath(
      ~x"//current_observation",
      credit: ~x"./credit/text()",
      location: ~x"./location/text()",
      station_id: ~x"./station_id/text()",
      lat: ~x"./latitude/text()",
      lng: ~x"./longitude/text()",
      updated: ~x"./observation_time/text()",
      updated_rfc822: ~x"./observation_time_rfc822/text()",
      weather: ~x"./weather/text()",
      temperature: ~x"./temperature_string/text()",
      dewpoint: ~x"./dewpoint_string/text()",
      relative_humidity: ~x"./relative_humidity/text()",
      heat_index: ~x"./heat_index_string/text()",
      wind: ~x"./wind_string/text()",
      visibility: ~x"./visibility_mi/text()",
      pressure: ~x"./pressure_string/text()",
      altimetr: ~x"./pressure_in/text()",
    )
  end
end
