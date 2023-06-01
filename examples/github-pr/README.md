# Example: Cloud Build triggered on GitHub PRs

This example will create a Cloud Build trigger for a GitHub repo, which will be
triggered whenever a PR is created or modified, with a requirement that a repo
owner or collaborator add a comment to the PR allowing the action to run (see
[Creating GitHub Triggers](https://cloud.google.com/build/docs/automating-builds/build-repos-from-github#creating_github_triggers)
for more details).

> To enable this scenario, the module declaration has a `trigger_config` with
> `is_pr_trigger` set to `true`, `branch_regex` set to `main$`, and `comment_control`
> set to `COMMENTS_ENABLED`; `trigger_config.tag_regex` must be null.

```hcl
module "trigger" {
  source      = "memes/cloudbuild/google//modules/github"
  version     = "1.0.0"
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
PR that has changes to merge to `main`.

<!-- markdownlint-disable no-inline-html no-bare-urls -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | The GitHub repository that will be the source of Cloud Build trigger events. Must<br>be in the form owner/repo. For example, to trigger off events in this repo,<br>`source_repo = "memes/terraform-google-cloudbuild"`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified identifier of the created Cloud Build trigger. |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | The project-local identifier of the created Cloud Build trigger. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
