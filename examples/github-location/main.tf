terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
    }
  }
}

# The default GitHub submodule will trigger on any changes pushed to the upstream
# GitHub branch.
module "trigger" {
  source      = "memes/cloudbuild/google//modules/github"
  version     = "1.1.0"
  name        = "example-github-location"
  description = "An example Cloud Build trigger on branch changes in GitHub repo that builds in us-west1"
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/github-location/cloudbuild.yml"
  location    = "us-west1"
  substitutions = {
    _MSG = "Example GitHub simple trigger in us-west1."
  }
  trigger_config = {
    is_pr_trigger   = false
    branch_regex    = "main$"
    tag_regex       = null
    comment_control = null
  }
}
