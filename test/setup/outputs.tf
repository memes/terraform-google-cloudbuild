output "harness_tfvars" {
  value       = abspath(local_file.harness_tfvars.filename)
  description = <<EOD
The name of the generated harness.tfvars file that will be a common input to all
test fixtures.
EOD
}

output "sa" {
  value       = module.sa.email
  description = <<-EOD
The email identifier of the service account created for trigger testing.
EOD
}
