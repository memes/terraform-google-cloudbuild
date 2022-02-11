#
# Echo all inputs as outputs, to make sure default values are seen by the controls
#

output "prefix" {
  value = "example"
}

output "project_id" {
  value = var.project_id
}

output "gsr_repo" {
  value = var.gsr_repo
}

output "filename" {
  value = "../../../ephemeral/gsr-tag/cloudbuild.yml"
}

output "trigger_config" {
  value = {
    branch_regex = null
    tag_regex    = ".*"
  }
}

output "name" {
  value = "gsr-tag"
}

output "description" {
  value = "An example Cloud Build trigger on new tags in Google Source Repository."
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
    _MSG = "Example GSR simple tag trigger."
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
