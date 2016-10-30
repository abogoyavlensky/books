defmodule Weather.NOAA do
  @moduledoc """
  Clinet API for National Oceanic and Atmospheric Administration's 
  http://w1.weather.gov/xml/current_obs
  """
  
  @url "http://w1.weather.gov/xml/current_obs/"
    
  
  def fetch(location) do
  location
  |> noaa_url
  |> HTTPoison.get
  |> handle_response
  |> IO.puts
    
  end
  
  def noaa_url(location), do: "#{@url}#{String.upcase(location)}.xml"
  
  def handle_response({:ok, data}) do
    data.body
  end
  def handle_response({:error, reason}) do
    reason
  end  
end
