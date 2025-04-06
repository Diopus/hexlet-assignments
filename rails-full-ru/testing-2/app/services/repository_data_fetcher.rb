class RepositoryDataFetcher
  def initialize(link)
    @link = link
    @client = Octokit::Client.new
  end

  def fetch_attributes
    octokit_repo = Octokit::Repository.from_url(@link)
    repository_data = @client.repository(octokit_repo)
    {
      owner_name: repository_data.owner.login,
      repo_name: repository_data.name,
      description: repository_data.description,
      default_branch: repository_data.default_branch,
      watchers_count: repository_data.watchers_count,
      language: repository_data.language,
      repo_created_at: repository_data.created_at,
      repo_updated_at: repository_data.updated_at
    }
  end
end
