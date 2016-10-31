defmodule Weather.NOAA do
  @moduledoc """
  Clinet API for National Oceanic and Atmospheric Administration's 
  http://w1.weather.gov/xml/current_obs
  """
  
  @url "http://w1.weather.gov/xml/current_obs/"
    
  @doc """
  Fetchs xml data from NOAA source site by given station_id id.
  """
  def fetch(station_id) do
    station_id
    |> noaa_url
    |> HTTPoison.get
    |> handle_response      
  end

  @doc """
  Returns NOAA url for single station_id.
  
  ## Examples
      
      iex> Weather.NOAA.noaa_url "KdTo"
      http://w1.weather.gov/xml/current_obs/KDTO.xml
  """
  def noaa_url(station_id), do: "#{@url}#{String.upcase(station_id)}.xml"

  @doc """
  Handle http GET response which contains data or handle an error returned.
  """
  def handle_response({:ok, data}) do
    data.body    
  end
  def handle_response({:error, _}) do
    IO.puts "Error has appeared while fetching from NOAA."
    System.halt(2)
  end
end
