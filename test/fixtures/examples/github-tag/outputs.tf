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
  value = "examples/github-tag/cloudbuild.yml"
}

output "trigger_config" {
  value = {
    is_pr_trigger   = false
    branch_regex    = null
    tag_regex       = ".*"
    comment_control = null
  }
}

output "name" {
  value = "github-tag"
}

output "description" {
  value = "An example Cloud Build trigger on new tags in GitHub repo."
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
    _MSG = "Example GitHub simple tag trigger."
  }
}

output "dir" {
  value = ""
}

output "invert_regex" {
  value = false
}

output "location" {
  value = "global"
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
