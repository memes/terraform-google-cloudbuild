terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36.0"
    }
  }
}

# The default GitHub submodule will trigger a build when a PR is opened on the
# main branch of GitHub repo
module "trigger" {
  source      = "memes/cloudbuild/google//modules/github"
  version     = "1.1.0"
  name        = "example-github-pr"
  description = "An example Cloud Build trigger on PR in GitHub repo."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/github-pr/cloudbuild.yml"
  substitutions = {
    _MSG = "Example GitHub simple PR trigger."
  }
  trigger_config = {
    is_pr_trigger   = true
    branch_regex    = "main$"
    tag_regex       = null
    comment_control = "COMMENTS_ENABLED"
  }
}
