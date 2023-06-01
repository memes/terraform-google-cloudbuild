terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
    }
  }
}

# The default GitHub submodule will trigger on any tag pushed to the upstream
# GitHub repo.
module "trigger" {
  source      = "memes/cloudbuild/google//modules/github"
  version     = "1.0.1"
  name        = "example-github-tag"
  description = "An example Cloud Build trigger on new tags in GitHub repo."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/github-tag/cloudbuild.yml"
  substitutions = {
    _MSG = "Example GitHub simple tag trigger."
  }
}
