# Example: Cloud Build triggered on Google Source Repo tag

This example will create a Cloud Build trigger for a GSR repo, which will be
triggered whenever **any** tag is pushed to the repository.

> By default, the [google-source-repo](../../modules/google-source-repo/) module
> has a default `trigger_config` with a wildcard that matches any tag value, so an explicit
> configuration is not needed. See the [google-source-repo](../../modules/google-source-repo/)
> module documentation for more details.

```hcl
module "trigger" {
  source      = "memes/cloudbuild/google//modules/google-source-repo"
  version     = "1.0.0"
  name        = "example-gsr-tag"
  description = "An example Cloud Build trigger on new tags in Google Source Repository."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/gsr-tag/cloudbuild.yml"
  substitutions = {
    _MSG = "Example GSR simple tag trigger."
  }
}
```

## Usage

1. Create a `terraform.tfvars` file to set the project id and GitHub repo

    ```hcl
    project_id  = "my-google-project"
    source_repo = "memes/terraform-google-cloudbuild"
    ```

2. Create the trigger

    ```shell
    terraform init
    terraform apply
    ```

At this point there is a new Cloud Build trigger that will execute the steps
given in [cloudbuild.yml](cloudbuild.yml) whenever any tag is pushed to the
GitHub repo.

<!-- markdownlint-disable no-inline-html no-bare-urls -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.8.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_trigger"></a> [trigger](#module\_trigger) | memes/cloudbuild/google//modules/google-source-repo | 1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id where the Cloud Build trigger will be installed. | `string` | n/a | yes |
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | The Google Source Repository repository that will be the source of Cloud Build<br>trigger events. Must be a fully-qualified repo name of the form<br>'projects/my-gcp-project/repos/my-repo'. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified identifier of the created Cloud Build trigger. |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | The project-local identifier of the created Cloud Build trigger. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
