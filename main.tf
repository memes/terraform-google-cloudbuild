terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
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
  location        = var.location

  dynamic "build" {
    for_each = var.local_filename != null ? [yamldecode(file(var.local_filename))] : []

    content {
      dynamic "step" {
        for_each = try(build.value.steps, [])

        content {
          id               = try(step.value.id, null)
          name             = try(step.value.name, null)
          script           = try(step.value.script, null)
          entrypoint       = try(step.value.entrypoint, null)
          args             = try(step.value.args, [])
          env              = try(step.value.env, [])
          dir              = try(step.value.dir, null)
          secret_env       = try(step.value.secretEnv, [])
          timeout          = try(step.value.timeout, null)
          allow_failure    = try(step.value.allow_failure, null)
          allow_exit_codes = try(step.value.allow_exit_codes, null)
          wait_for         = try(step.value.wait_for, null)
          dynamic "volumes" {
            for_each = try(step.value.volumes, [])

            content {
              name = try(volumes.value.name, null)
              path = try(volumes.value.path, null)
            }
          }
        }
      }

      dynamic "artifacts" {
        for_each = try([build.value.artifacts], [])

        content {
          images = try(artifacts.value.images, [])
          objects {
            location = try(artifacts.value.location, null)
            paths    = try(artifacts.value.paths, null)
            timing   = try(artifacts.value.timing, null)
          }
        }
      }

      dynamic "secret" {
        for_each = try([build.value.secret], [])

        content {
          kms_key_name = try(secret.value.kmsKeyName, null)
          secret_env   = try(secret.value.secretEnv, {})
        }
      }

      dynamic "available_secrets" {
        for_each = try([build.value.availableSecrets], [])

        content {
          dynamic "secret_manager" {
            for_each = try(available_secrets.value.secretManager, [])

            content {
              version_name = try(secret_manager.value.versionName, null)
              env          = try(secret_manager.value.env, null)
            }
          }
        }
      }

      dynamic "options" {
        for_each = try([build.value.options], [])

        content {
          source_provenance_hash  = try(options.value.sourceProvenanceHash, null)
          requested_verify_option = try(options.value.requestedVerifyOption, null)
          machine_type            = try(options.value.machineType, null)
          disk_size_gb            = try(options.value.diskSizeGb, null)
          substitution_option     = try(options.value.substitutionOption, null)
          dynamic_substitutions   = try(options.value.dynamicSubstitutions, null)
          log_streaming_option    = try(options.value.logStreamingOption, null)
          worker_pool             = try(options.value.pool, null)
          logging                 = try(options.value.logging, null)
          env                     = try(options.value.env, null)
          secret_env              = try(options.value.secretEnv, [])

          dynamic "volumes" {
            for_each = try(options.value.volumes, [])

            content {
              name = try(volumes.value.name, null)
              path = try(volumes.value.path, null)
            }
          }  
        }
      }

      tags            = try(build.value.tags, [])
      images          = try(build.value.images, [])
      substitutions   = try(build.value.substitutions, {})
      queue_ttl       = try(build.value.queueTtl, null)
      logs_bucket     = try(build.value.logsBucket, null)
      timeout         = try(build.value.timeout, "600s")
    }
  }

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
