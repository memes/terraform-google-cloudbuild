output "id" {
  value       = module.trigger.id
  description = <<-EOD
The fully-qualified identifier of the created Cloud Build trigger.
EOD
}

output "trigger_id" {
  value       = module.trigger.trigger_id
  description = <<-EOD
The project-local identifier of the created Cloud Build trigger.
EOD
}
