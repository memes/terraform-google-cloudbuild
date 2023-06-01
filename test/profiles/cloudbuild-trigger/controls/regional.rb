# frozen_string_literal: true

project_id = input('output_project_id')
trigger_id = input('output_trigger_id')
id = input('output_id')
location = input('output_location', value: 'global')

# inspec-gcp doesn't support regional Cloud Build triggers yet, so this control
# has very limited use.
control 'regional' do
  impact 1.0
  title 'Ensure regional Cloud Build trigger has expected attributes'

  describe id do
    it { should cmp "projects/#{project_id}/locations/#{location}/triggers/#{trigger_id}" }
  end
end
