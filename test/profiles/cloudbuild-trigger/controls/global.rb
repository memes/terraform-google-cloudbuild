# frozen_string_literal: true

prefix = input('output_prefix')
project_id = input('output_project_id')
trigger_id = input('output_trigger_id')
name = input('output_name')
description = input('output_description', value: '')
disabled = input('output_disabled', value: false)
tags = input('output_tags', value: []).sort
ignored_files = input('output_ignored_files', value: []).sort
included_files = input('output_included_files', value: []).sort
substitutions = input('output_substitutions', value: {})
filename = input('output_filename')

# rubocop:disable Metrics/BlockLength
control 'global' do
  impact 1.0
  title 'Ensure global Cloud Build trigger has expected common attributes'

  describe google_cloudbuild_trigger(project: project_id, id: trigger_id) do
    it { should exist }
    its('name') { should match(/^#{prefix}-#{name}$/) }
    if description.empty?
      its('description') { should be nil }
    else
      its('description') { should cmp description }
    end
    if tags.empty?
      its('tags') { should be nil }
    else
      its('tags') { should_not be nil }
      its('tags.sort') { should cmp tags }
    end
    if disabled
      its('disabled') { should be true }
    else
      its('disabled') { should be nil }
    end
    if substitutions.empty?
      its('substitutions') { should be nil }
    else
      its('substitutions') { should cmp substitutions }
    end
    if ignored_files.empty?
      its('ignored_files') { should be nil }
    else
      its('ignored_files.sort') { should cmp ignored_files }
    end
    if included_files.empty?
      its('included_files') { should be nil }
    else
      its('included_files.sort') { should cmp included_files }
    end
  end
end
# rubocop:enable Metrics/BlockLength

control 'global-filename' do
  impact 1.0
  title 'Ensure global Cloud Build trigger has expected declared filename attributes'
  describe google_cloudbuild_trigger(project: project_id, id: trigger_id) do
    its('filename') { should cmp filename }
    its('build') { should_not be nil }
  end
  describe google_cloudbuild_trigger(project: project_id, id: trigger_id).build do
    its('source') { should be nil }
    its('tags') { should be nil }
    its('images') { should be nil }
    its('queue_ttl') { should be nil }
    its('logs_bucket') { should be nil }
    its('timeout') { should be nil }
    its('secrets') { should be nil }
    its('steps') { should be nil }
    its('artifacts') { should be nil }
    its('options') { should be nil }
  end
end
