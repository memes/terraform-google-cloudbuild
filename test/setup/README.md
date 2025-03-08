# Setup

The Terraform in this folder will be executed before creating resources and can
be used to setup service accounts, service principals, etc, that are used by the
inspec-* verifiers.

## Configuration

Create a local `terraform.tfvars` file that configures the testing project
constraints.

```hcl
# The GCP project id where the Cloud Build triggers will be created, and the
# ephemeral Google Source Repo created. You will need owner-like permissions here.
project_id  = "my-project-id"

# An existing GitHub repository for which Cloud Build app has *already* been
# authorized, can be public or private.
# The tests will not make any changes to the repo, but the GitHub module will
# fail to create trigger if the pre-requisite Cloud Build app authorization has
# not been completed.
github_repo = "owner/repo"
```

<!-- markdownlint-disable MD033 MD034 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.5 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sa"></a> [sa](#module\_sa) | terraform-google-modules/service-accounts/google | 4.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_sourcerepo_repository.gsr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sourcerepo_repository) | resource |
| [local_file.harness_tfvars](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_pet.prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_uuid.gsr](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | GitHub repo to use for testing. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_harness_tfvars"></a> [harness\_tfvars](#output\_harness\_tfvars) | The name of the generated harness.tfvars file that will be a common input to all<br/>test fixtures. |
| <a name="output_sa"></a> [sa](#output\_sa) | The email identifier of the service account created for trigger testing. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 MD034 -->
