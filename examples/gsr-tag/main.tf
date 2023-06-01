terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
    }
  }
}

# The default Google Source Repo submodule will trigger on any tag pushed to GSR
# repo.
module "trigger" {
  source      = "memes/cloudbuild/google//modules/google-source-repo"
  version     = "1.1.0"
  name        = "example-gsr-tag"
  description = "An example Cloud Build trigger on new tags in Google Source Repository."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/gsr-tag/cloudbuild.yml"
  substitutions = {
    _MSG = "Example GSR simple tag trigger."
  }
}
