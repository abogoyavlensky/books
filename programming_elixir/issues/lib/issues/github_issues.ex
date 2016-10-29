defmodule Issues.GithubIssues do
@moduledoc """
Contains tools to fetch issues from github and handle response.
"""

  require Logger

  @user_agent [{"User-Agent", "Elixir abogoyavlensky@gmail.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    user
    |> issues_url(project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, body}) do    
    Logger.info "Successfull response"
    Logger.debug fn -> inspect(body) end
    {:ok, :jsx.decode(body.body)}
  end
  def handle_response({status, body}) do
    Logger.error "Error #{status} returned"
    {status, :jsx.decode(body.body)}
  end  
end
