#
# Echo all inputs as outputs, to make sure default values are seen by the controls
#

output "prefix" {
  value = "example"
}

output "project_id" {
  value = var.project_id
}

output "github_repo" {
  value = var.github_repo
}

output "filename" {
  value = "examples/github-pr/cloudbuild.yml"
}

output "trigger_config" {
  value = {
    is_pr_trigger   = true
    branch_regex    = "main$"
    comment_control = "COMMENTS_ENABLED"
  }
}

output "name" {
  value = "github-pr"
}

output "description" {
  value = "An example Cloud Build trigger on PR in GitHub repo."
}

output "disabled" {
  value = false
}

output "service_account" {
  value = ""
}

output "tags" {
  value = []
}

output "ignored_files" {
  value = []
}

output "included_files" {
  value = []
}

output "substitutions" {
  value = {
    _MSG = "Example GitHub simple PR trigger."
  }
}

output "dir" {
  value = ""
}

output "invert_regex" {
  value = false
}

#
# Module under test outputs
#

output "id" {
  value = module.test.id
}

output "trigger_id" {
  value = module.test.trigger_id
}
