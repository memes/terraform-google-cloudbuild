terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.8.0"
    }
  }
}

# If the caller has provided a service account email, get a reference to the
# service account attributes as the Cloud Build trigger requires the resource
# name, not an email.
data "google_service_account" "sa" {
  count      = coalesce(var.service_account, "unspecified") != "unspecified" ? 1 : 0
  account_id = var.service_account
}

# Create a Cloud Build trigger to deploy changes to this repo
resource "google_cloudbuild_trigger" "trigger" {
  project         = var.project_id
  name            = var.name
  description     = var.description
  disabled        = var.disabled
  service_account = length(data.google_service_account.sa) == 1 ? data.google_service_account.sa[0].name : ""
  tags            = var.tags
  substitutions   = var.substitutions
  ignored_files   = var.ignored_files
  included_files  = var.included_files
  filename        = var.filename

  # Google Source Repository trigger
  dynamic "trigger_template" {
    for_each = { for k, v in var.trigger_config : k => v if k == "gsr" && v != null }
    content {
      project_id   = trigger_template.value.project_id
      repo_name    = trigger_template.value.name
      dir          = var.dir
      invert_regex = var.invert_regex
      branch_name  = coalesce(trigger_template.value.branch_regex, "unspecified") != "unspecified" ? trigger_template.value.branch_regex : null
      tag_name     = coalesce(trigger_template.value.tag_regex, "unspecified") != "unspecified" ? trigger_template.value.tag_regex : null
    }
  }

  # GitHub trigger
  dynamic "github" {
    for_each = { for k, v in var.trigger_config : k => v if k == "github" && v != null }
    content {
      owner = github.value.owner
      name  = github.value.name

      dynamic "pull_request" {
        for_each = github.value.is_pr_trigger ? { (github.key) = github.value } : {}
        content {
          branch          = pull_request.value.branch_regex
          comment_control = pull_request.value.comment_control
          invert_regex    = var.invert_regex
        }
      }

      dynamic "push" {
        for_each = github.value.is_pr_trigger ? {} : { (github.key) = github.value }
        content {
          branch       = push.value.branch_regex
          tag          = push.value.tag_regex
          invert_regex = var.invert_regex
        }
      }
    }
  }

  # Pub/Sub trigger
  dynamic "pubsub_config" {
    for_each = { for k, v in var.trigger_config : k => v if k == "pubsub" && v != null }
    content {
      topic                 = pubsub_config.value.topic
      service_account_email = pubsub_config.value.service_account_email
    }
  }

  # Webhook trigger
  dynamic "webhook_config" {
    for_each = { for k, v in var.trigger_config : k => v if k == "webhook" && v != null }
    content {
      secret = webhook_config.value.secret
    }
  }
}
