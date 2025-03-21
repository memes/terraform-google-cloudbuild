# Example: Regional Cloud Build triggered on GitHub branch changes

This example will create a Cloud Build trigger in us-west1 region, for a GitHub
repo triggered whenever a change is pushed to the repo's `main` branch.

> To enable this scenario, the module declaration has a `trigger_config` with
> `branch_regex` set to `main$`, and other `trigger_config` fields at their
> default values (false/null).

```hcl
module "trigger" {
  source      = "memes/cloudbuild/google//modules/github"
  version     = "1.0.0"
  name        = "example-github-branch"
  description = "An example Cloud Build trigger on branch changes in GitHub repo that builds in us-west1."
  source_repo = var.source_repo
  project_id  = var.project_id
  filename    = "examples/github-branch/cloudbuild.yml"
  location    = "us-west1"
  substitutions = {
    _MSG = "Example GitHub simple branch trigger in us-west1."
  }
  trigger_config = {
    is_pr_trigger   = false
    branch_regex    = "main$"
    tag_regex       = null
    comment_control = null
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
given in [cloudbuild.yml](cloudbuild.yml) whenever changes are pushed to GitHub
in a branch that matches the regular expression `main$`.

<!-- markdownlint-disable no-inline-html no-bare-urls -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_trigger"></a> [trigger](#module\_trigger) | memes/cloudbuild/google//modules/github | 1.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id where the Cloud Build trigger will be installed. | `string` | n/a | yes |
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | The GitHub repository that will be the source of Cloud Build trigger events. Must<br/>be in the form owner/repo. For example, to trigger off events in this repo,<br/>`source_repo = "memes/terraform-google-cloudbuild"`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified identifier of the created Cloud Build trigger. |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | The project-local identifier of the created Cloud Build trigger. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
