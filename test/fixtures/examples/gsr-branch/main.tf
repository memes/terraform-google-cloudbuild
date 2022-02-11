terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.8.0"
    }
  }
}

module "test" {
  source      = "../../../ephemeral/gsr-branch/"
  project_id  = var.project_id
  source_repo = var.gsr_repo
}
