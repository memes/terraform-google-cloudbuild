variable "project_id" {
  type        = string
  description = <<-EOD
The GCP project id where the Cloud Build trigger will be installed.
EOD
}

variable "source_repo" {
  type        = string
  description = <<-EOD
The Google Source Repository repository that will be the source of Cloud Build
trigger events. Must be a fully-qualified repo name of the form
'projects/my-gcp-project/repos/my-repo'.
EOD
}
