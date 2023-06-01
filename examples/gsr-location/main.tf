terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
    }
  }
}

# The default Google Source Repo submodule will trigger on any changes that occur
# in matching GSR branch.
module "trigger" {
  source      = "memes/cloudbuild/google//modules/google-source-repo"
  version     = "1.0.1"
  name        = "example-gsr-location"
  description = "An example Cloud Build trigger on branch updates in Google Source Repository that builds in us-west1."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/gsr-location/cloudbuild.yml"
  location    = "us-west1"
  substitutions = {
    _MSG = "Example GSR simple branch trigger in us-west1."
  }
  trigger_config = {
    branch_regex = "master$"
    tag_regex    = null
  }
}
