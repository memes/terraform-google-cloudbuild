# Google Cloud Build trigger module for GitHub sources

This module helps configure a Google Cloud Build trigger that acts upon changes
in a GitHub repo without synchronizing to a Google Source Code Repository. The
trigger event can be a push to a branch, tagging, or for a pull request.

> NOTE: This module requires that the [Cloud Build app](https://cloud.google.com/build/docs/automating-builds/build-repos-from-github#installing_gcb_app)
> has been authorized to interact with your target GitHub repositories.

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
| <a name="module_trigger"></a> [trigger](#module\_trigger) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name to give to the Cloud Build trigger. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id where the Cloud Build trigger will be installed. | `string` | n/a | yes |
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | The GitHub repository that will be the source of Cloud Build trigger events. Must<br>be in the form owner/repo. For example, to trigger off events in this repo,<br>`source_repo = "memes/terraform-google-cloudbuild"`. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | An optional description to apply to the Cloud Build trigger. | `string` | `""` | no |
| <a name="input_dir"></a> [dir](#input\_dir) | The directory path, relative to repository root, where the Cloud Build run will<br>be executed. Default is an empty string. | `string` | `""` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | A flag to create/modify the Cloud Build trigger into a disabled state. | `bool` | `false` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The path, relative to repository root, to the Cloud Build YAML file. The default<br>configuration will declare the filename 'cloudbuild.yml'. | `string` | `"cloudbuild.yml"` | no |
| <a name="input_ignored_files"></a> [ignored\_files](#input\_ignored\_files) | An optional set of file globs to ignore when determining the set of source<br>changes. If provided, the list of changed files will be filtered through this<br>list of globs, and the trigger action will proceed only if there are unfiltered<br>files remaining. Default is an empty list, meaning any changes in repo should<br>trigger the action, subject to `included_files`. | `list(string)` | `[]` | no |
| <a name="input_included_files"></a> [included\_files](#input\_included\_files) | An optional set of file globs to explicitly match when determining the set of<br>source changes. If provided, the list of changed files will be filtered through this<br>list of globs, and the trigger action will proceed only if there are positive<br>matches. Default is an empty list, meaning any changes in repo should<br>trigger the action, subject to `ignored_files`. | `list(string)` | `[]` | no |
| <a name="input_invert_regex"></a> [invert\_regex](#input\_invert\_regex) | If set, the tag or branch regexes used to match GitHub events will be inverted.<br>Default is false. | `bool` | `false` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | An optional way to override the service account used by Cloud Build. If left<br>empty (default), the standard Cloud Build service account for project specified<br>in `project_id` will be used during execution. | `string` | `""` | no |
| <a name="input_substitutions"></a> [substitutions](#input\_substitutions) | A map of substitution key:value pairs that can be referenced in the build<br>definition. Default is empty. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An optional set of tags to annotate the Cloud Build trigger. | `set(string)` | `[]` | no |
| <a name="input_trigger_config"></a> [trigger\_config](#input\_trigger\_config) | Defines the trigger configuration to use; the default value will If the intent is to trigger on a PR<br>(i.e. `is_pr_trigger` field is true), `branch_regex` field is required and<br>`comment_control` can be set to an appropriate value, or left as blank.<br><br>If the intent is to trigger on pushes (default, `is_pr_trigger` field is false),<br>then *one* of `branch_regex` or `tag_regex` must be specified, and<br>`comment_control` must be left blank.<br><br>If unspecified, the default option will create a trigger for pushes that are tagged<br>with any value. | <pre>object({<br>    is_pr_trigger   = bool<br>    branch_regex    = string<br>    tag_regex       = string<br>    comment_control = string<br>  })</pre> | <pre>{<br>  "branch_regex": null,<br>  "comment_control": null,<br>  "is_pr_trigger": false,<br>  "tag_regex": ".*"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified identifier of the created Cloud Build trigger. |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | The project-local identifier of the created Cloud Build trigger. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
