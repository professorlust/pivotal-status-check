class GithubClient
  def initialize
    @client = Octokit::Client.new \
      access_token: GITHUB_ACCESS_TOKEN,
      api_endpoint: GITHUB_ENTERPRISE_API
  end

  def process_pull_request(pull_request)
    @pivotal = PivotalClient.new(pull_request)
    set_status \
      pull_request: pull_request,
      state: @pivotal.accepted? ? 'success' : 'failure',
      options: pivotal_story_information
  end

  def set_status(name: nil, sha: nil, state: '', options: {}, pull_request: {})
    @client.create_status \
      name || pull_request.dig('base','repo','full_name'),
      sha || pull_request.dig('head','sha'),
      state,
      options.merge(context: 'Pivotal Acceptance State')
  end

  def find_branch(pivotal_tracker_id: '')
    @client.branches(GITHUB_REPO).find do |branch|
      branch[:name].include?(pivotal_tracker_id)
    end
  end

  private

  def pivotal_story_information
    {
      target_url: @pivotal.story.url,
      # description: "Pivotal Story",
      context: 'Pivotal Acceptance State'
    }
  end
end
