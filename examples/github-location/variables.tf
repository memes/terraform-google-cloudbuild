variable "project_id" {
  type        = string
  description = <<-EOD
The GCP project id where the Cloud Build trigger will be installed.
EOD
}

variable "source_repo" {
  type        = string
  description = <<-EOD
The GitHub repository that will be the source of Cloud Build trigger events. Must
be in the form owner/repo. For example, to trigger off events in this repo,
`source_repo = "memes/terraform-google-cloudbuild"`.
EOD
}
