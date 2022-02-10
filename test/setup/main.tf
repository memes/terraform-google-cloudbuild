terraform {
  required_version = ">= 0.14.5"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

resource "random_pet" "prefix" {
  length = 1
  keepers = {
    project = var.project_id
  }
}

module "sa" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "4.1.0"
  project_id = var.project_id
  prefix     = random_pet.prefix.id
  names = [
    "cloud-build",
  ]
  display_name  = "terraform-google-cloudbuild test SA"
  description   = "Automated testing service account"
  generate_keys = false
}

resource "random_uuid" "gsr" {
  keepers = {
    project = var.project_id
  }
}

resource "google_sourcerepo_repository" "gsr" {
  project = var.project_id
  name    = random_uuid.gsr.result
}

# Generate a harness.tfvars file that will be used to seed fixtures
resource "local_file" "harness_tfvars" {
  filename = "${path.module}/harness.tfvars"
  content  = <<-EOT
prefix     = "${random_pet.prefix.id}"
project_id = "${var.project_id}"
github_repo = "${var.github_repo}"
gsr_repo = "${google_sourcerepo_repository.gsr.id}"
EOT
}
