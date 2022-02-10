terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.8.0"
    }
  }
}

module "trigger" {
  source          = "../../"
  project_id      = var.project_id
  name            = var.name
  description     = var.description
  disabled        = var.disabled
  service_account = var.service_account
  tags            = var.tags
  ignored_files   = var.ignored_files
  included_files  = var.included_files
  substitutions   = var.substitutions
  filename        = var.filename
  invert_regex    = var.invert_regex
  dir             = var.dir
  trigger_config = {
    gsr = {
      project_id   = split("/", var.source_repo)[1]
      name         = split("/", var.source_repo)[3]
      branch_regex = var.trigger_config.branch_regex
      tag_regex    = var.trigger_config.tag_regex
    }
    github  = null
    pubsub  = null
    webhook = null
  }
}
