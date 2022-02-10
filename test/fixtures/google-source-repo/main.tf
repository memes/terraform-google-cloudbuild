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
  source          = "../../../modules/google-source-repo/"
  project_id      = var.project_id
  name            = format("%s-%s", var.prefix, var.name)
  description     = var.description
  disabled        = var.disabled
  service_account = var.service_account
  tags            = var.tags
  ignored_files   = var.ignored_files
  included_files  = var.included_files
  substitutions   = var.substitutions
  filename        = var.filename
  source_repo     = var.gsr_repo
  dir             = var.dir
  invert_regex    = var.invert_regex
  trigger_config  = var.trigger_config
}
