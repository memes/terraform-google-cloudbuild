# Google Cloud Build module for Terraform

![GitHub release](https://img.shields.io/github/v/release/memes/terraform-google-cloudbuild?sort=semver)
![Maintenance](https://img.shields.io/maintenance/yes/2024)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Google Cloud Build offers a variety of different ways to implement a GitOps-like
trigger, with support for many commercial Git hosting providers. The purpose of
these modules is to make it easier to create a Cloud Build trigger for common
trigger scenarios; e.g. a GitHub App trigger, a GSR trigger, etc.

While it is possible to use this root module directly, the scenario specific
submodules have additional validation to make it easier to provision a suitable
trigger without running afoul of the full Cloud Build trigger constraints. To
reinforce this, all examples use a scenario module.

> TL;DR - PREFER TO USE THE SCENARIO SPECIFIC SUBMODULE FOR YOUR TRIGGER!

## Scenario modules

* [GitHub](modules/github/)

    Use this module to add a Cloud Build trigger for source that is hosted in
    GitHub (or GitHub Enterprise), and the Cloud Build app for GitHub is
    authorized to access the repository. An alternative is to allow GCP to mirror
    the source to a GSR and use the [Google Source](modules/google-source-repo)
    module instead.

* [Google Source Repository](modules/google-source-repo/)

    Use this module to add a Cloud Build trigger that reacts to changes in
    GSR. This includes cases where source from an external repository is being
    mirrored into GSR (e.g. from BitBucket, GitLab, or an existing GitHub mirrored
    repository).

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md) for guidelines.

<!-- markdownlint-disable no-inline-html no-bare-urls -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloudbuild_trigger.trigger](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name to give to the Cloud Build trigger. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id where the Cloud Build trigger will be installed. | `string` | n/a | yes |
| <a name="input_trigger_config"></a> [trigger\_config](#input\_trigger\_config) | The trigger\_config variable defines the type of trigger (GitHub, GSR, etc), and<br>the specific configuration options needed. The combination of fields is too<br>complex to validate effectively, use a scenario specific submodule which hides<br>this complexity! | <pre>object({<br>    gsr = object({<br>      project_id   = string<br>      name         = string<br>      branch_regex = string<br>      tag_regex    = string<br>    })<br>    github = object({<br>      owner           = string<br>      name            = string<br>      branch_regex    = string<br>      tag_regex       = string<br>      is_pr_trigger   = bool<br>      comment_control = string<br>    })<br>    pubsub = object({<br>      topic                 = string<br>      service_account_email = string<br>    })<br>    webhook = object({<br>      secret = string<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | An optional description to apply to the Cloud Build trigger. | `string` | `""` | no |
| <a name="input_dir"></a> [dir](#input\_dir) | The directory path, relative to repository root, where the Cloud Build run will<br>be executed. Default is an empty string. | `string` | `""` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | A flag to create/modify the Cloud Build trigger into a disabled state. | `bool` | `false` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The path, relative to repository root, to the Cloud Build YAML file. The default<br>configuration will declare the filename 'cloudbuild.yml'. | `string` | `"cloudbuild.yml"` | no |
| <a name="input_ignored_files"></a> [ignored\_files](#input\_ignored\_files) | An optional set of file globs to ignore when determining the set of source<br>changes. If provided, the list of changed files will be filtered through this<br>list of globs, and the trigger action will proceed only if there are unfiltered<br>files remaining. Default is an empty list, meaning any changes in repo should<br>trigger the action, subject to `included_files`. | `list(string)` | `[]` | no |
| <a name="input_included_files"></a> [included\_files](#input\_included\_files) | An optional set of file globs to explicitly match when determining the set of<br>source changes. If provided, the list of changed files will be filtered through this<br>list of globs, and the trigger action will proceed only if there are positive<br>matches. Default is an empty list, meaning any changes in repo should<br>trigger the action, subject to `ignored_files`. | `list(string)` | `[]` | no |
| <a name="input_invert_regex"></a> [invert\_regex](#input\_invert\_regex) | If set, the tag or branch regular expressions used to match GitHub events will<br>be effectively inverted, and events that *do not match* the tag or branch pattern<br>will be executed. Default is false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the location of the Cloud Build pool to use for the triggered workload.<br>The default value is 'global', but any supported Cloud Build location may be used. | `string` | `"global"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | An optional way to override the service account used by Cloud Build. If left<br>empty (default), the standard Cloud Build service account for project specified<br>in `project_id` will be used during execution. | `string` | `""` | no |
| <a name="input_substitutions"></a> [substitutions](#input\_substitutions) | A map of substitution key:value pairs that can be referenced in the build<br>definition. Default is empty. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An optional set of tags to annotate the Cloud Build trigger. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified identifier of the created Cloud Build trigger. |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | The project-local identifier of the created Cloud Build trigger. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
