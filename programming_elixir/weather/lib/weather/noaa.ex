defmodule Weather.NOAA do
  @moduledoc """
  Clinet API for National Oceanic and Atmospheric Administration's 
  http://w1.weather.gov/xml/current_obs
  """

  require Logger
  
  @url "http://w1.weather.gov/xml/current_obs/"
    
  @doc """
  Fetchs xml data from NOAA source site by given station_id id.
  """ 
  def fetch(station_id) do
    Logger.info "Fetching #{station_id} data"
    station_id
    |> noaa_url
    |> HTTPoison.get
    |> handle_response      
  end

  @doc """
  Returns NOAA url for single station_id.
  
  ## Examples
      
      iex> Weather.NOAA.noaa_url "KdTo"
      "http://w1.weather.gov/xml/current_obs/KDTO.xml"
  """
  def noaa_url(station_id), do: "#{@url}#{String.upcase(station_id)}.xml"

  @doc """
  Handle http GET response which contains data or handle an error returned.
  
  ## Examples
      iex> resp = {:ok, %{:status_code => 200, :body => "body"}}
      iex> Weather.NOAA.handle_response(resp)
      "body"
  """
  def handle_response({:ok, %{:status_code => 200, :body => body}}) do
    Logger.info "Successfull response"
    Logger.debug(fn -> inspect(body) end) 
    body
  end 
  def handle_response({:ok, %{:status_code => status, :body => _body}}) do
    Logger.error("Error with status #{status} has happend while 
                  fetching from NOAA.")
    System.halt(2)    
  end
  def handle_response({:error, _}) do
    Logger.error "Error has happend while fetching from NOAA."
    System.halt(2)
  end
end
