class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository)
    if repository.may_to_fetching?
      repository.to_fetching!
      unless repository_attributes = RepositoryDataFetcher.new(repository.link).fetch_attributes
        repository.to_failed!
      end

      repository.assign_attributes(repository_attributes)
      if repository.save!
        repository.to_fetched!
      else
        repository.to_failed!
      end
    end
  end
end
