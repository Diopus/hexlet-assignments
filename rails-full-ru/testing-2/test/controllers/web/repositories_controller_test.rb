# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN
  test 'should create repository' do
    response_json = load_fixture('files/response.json')
    
    stub_request(:get, 'https://api.github.com/repos/octokit/octokit.rb').
      to_return(
        body: response_json,
        status: 200,
        headers: { content_type: 'application/json; charset=utf-8' }
      )

    link = 'https://github.com/octokit/octokit.rb'

    post repositories_url, params: { repository: { link: link} }
    
    repository = Repository.find_by ({ link: link })

    assert { repository }
    assert { repository.description.present? }
    assert_redirected_to repository_url(repository)
  end
  # END
end
