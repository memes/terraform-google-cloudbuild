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
  version     = "1.1.0"
  name        = "example-gsr-branch"
  description = "An example Cloud Build trigger on branch updates in Google Source Repository."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/gsr-branch/cloudbuild.yml"
  substitutions = {
    _MSG = "Example GSR simple branch trigger."
  }
  trigger_config = {
    branch_regex = "master$"
    tag_regex    = null
  }
}
