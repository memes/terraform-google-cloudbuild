# frozen_string_literal: true

project_id = input('output_project_id')
trigger_id = input('output_trigger_id')
gsr_repo = input('output_gsr_repo')
trigger_config = input('output_trigger_config')
invert_regex = input('output_invert_regex', value: false)

# rubocop:disable Metrics/BlockLength
control 'gsr' do
  impact 1.0
  title 'Ensure Cloud Build trigger is configured for Google Source Repository'

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).trigger_template do
    it { should_not be nil }
    its('project_id') { should cmp gsr_repo.split('/')[1] }
    its('repo_name') { should cmp gsr_repo.split('/')[3] }
    if invert_regex
      its('invert_regex') { should be true }
    else
      its('invert_regex') { should be nil }
    end
    if trigger_config['branch_regex'].nil? || trigger_config['branch_regex'].empty?
      its('branch_name') { should be nil }
    else
      its('branch_name') { should cmp trigger_config['branch_regex'] }
    end
    if trigger_config['tag_regex'].nil? || trigger_config['tag_regex'].empty?
      its('tag_name') { should be nil }
    else
      its('tag_name') { should cmp trigger_config['tag_regex'] }
    end
    if trigger_config['commit_sha'].nil? || trigger_config['commit_sha'].empty?
      its('commit_sha') { should be nil }
    else
      its('commit_sha') { should cmp trigger_config['commit_sha'] }
    end
  end
end
# rubocop:enable Metrics/BlockLength
