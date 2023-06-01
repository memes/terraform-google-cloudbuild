terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
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
  dir             = var.dir
  invert_regex    = var.invert_regex
  trigger_config = {
    github = {
      owner           = split("/", var.source_repo)[0]
      name            = split("/", var.source_repo)[1]
      branch_regex    = var.trigger_config.branch_regex
      is_pr_trigger   = var.trigger_config.is_pr_trigger
      tag_regex       = var.trigger_config.is_pr_trigger ? null : var.trigger_config.tag_regex
      comment_control = var.trigger_config.is_pr_trigger ? var.trigger_config.comment_control : null
    }
    gsr     = null
    pubsub  = null
    webhook = null
  }
  location = var.location
}
