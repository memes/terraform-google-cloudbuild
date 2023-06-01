terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
    }
  }
}

module "test" {
  source      = "../../../ephemeral/github-tag/"
  project_id  = var.project_id
  source_repo = var.github_repo
}
