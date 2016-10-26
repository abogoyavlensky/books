defmodule Issues.GithubIssues do
@moduledoc """
Contains tools to fetch issues from github and handle response.
"""

  @user_agent [{"User-Agent", "Elixir abogoyavlensky@gmail.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    user
    |> issues_url(project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({status, body}) do
    {status, :jsx.decode(body.body)}
  end
end
