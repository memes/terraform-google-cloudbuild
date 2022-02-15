# frozen_string_literal: true

project_id = input('output_project_id')
trigger_id = input('output_trigger_id')
github_repo = input('output_github_repo')
trigger_config = input('output_trigger_config')
invert_regex = input('output_invert_regex', value: false)

control 'github-common' do
  impact 1.0
  title 'Ensure Cloud Build trigger is configured for GitHub'

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).github do
    it { should_not be nil }
    its('owner') { should cmp github_repo.split('/')[0] }
    its('name') { should cmp github_repo.split('/')[1] }
  end
end

# rubocop:disable Metrics/BlockLength
control 'github-pr' do
  impact 1.0
  title 'Ensure Cloud Build trigger is configured for GitHub PR'

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).github.pull_request do
    it { should_not be nil }
    if invert_regex
      its('invert_regex') { should be true }
    else
      its('invert_regex') { should be nil }
    end
    if trigger_config['branch_regex'].nil? || trigger_config['branch_regex'].empty?
      its('branch') { should cmp nil }
    else
      its('branch') { should cmp trigger_config['branch_regex'] }
    end
    if trigger_config['comment_control'].nil? ||
       trigger_config['comment_control'].empty? ||
       trigger_config['comment_control'] == 'COMMENTS_DISABLED'
      its('comment_control') { should be nil }
    else
      its('comment_control') { should cmp trigger_config['comment_control'] }
    end
  end

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).github.push do
    it { should_not be nil }
    its('invert_regex') { should be nil }
    its('branch') { should be nil }
    its('tag') { should be nil }
  end
end
# rubocop:enable Metrics/BlockLength

# rubocop:disable Metrics/BlockLength
control 'github-push' do
  impact 1.0
  title 'Ensure Cloud Build trigger exists for GitHub push'

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).github.pull_request do
    it { should_not be nil }
    its('invert_regex') { should be nil }
    its('branch') { should be nil }
    its('comment_control') { should be nil }
  end

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).github.push do
    it { should_not be nil }
    if invert_regex
      its('invert_regex') { should be true }
    else
      its('invert_regex') { should be nil }
    end
    if trigger_config['branch_regex'].nil? || trigger_config['branch_regex'].empty?
      its('branch') { should cmp nil }
    else
      its('branch') { should cmp trigger_config['branch_regex'] }
    end
    if trigger_config['tag_regex'].nil? || trigger_config['tag_regex'].empty?
      its('tag') { should cmp nil }
    else
      its('tag') { should cmp trigger_config['tag_regex'] }
    end
  end
end
# rubocop:enable Metrics/BlockLength
