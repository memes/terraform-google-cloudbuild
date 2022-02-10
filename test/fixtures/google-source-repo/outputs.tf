#
# Echo all inputs as outputs, to make sure default values are seen by the controls
#

output "prefix" {
  value = var.prefix
}

output "project_id" {
  value = var.project_id
}

output "gsr_repo" {
  value = var.gsr_repo
}

output "filename" {
  value = var.filename
}

output "trigger_config" {
  value = var.trigger_config
}

output "name" {
  value = var.name
}

output "description" {
  value = var.description
}

output "disabled" {
  value = var.disabled
}

output "service_account" {
  value = var.service_account
}

output "tags" {
  value = var.tags
}

output "ignored_files" {
  value = var.ignored_files
}

output "included_files" {
  value = var.included_files
}

output "substitutions" {
  value = var.substitutions
}

output "dir" {
  value = var.dir
}

output "invert_regex" {
  value = var.invert_regex
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
