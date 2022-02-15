# Google Cloud Build trigger module for GSR sources

This module helps configure a Google Cloud Build trigger that acts upon changes
in a Google Source Repository, including those that are mirrors of other Git
repositories. The trigger event can be a push to a branch, or on a new tag.

> NOTE: This module adds triggers to GSR. If you are looking for triggers that
> can respond to GitHub events without *mirroring*, see if the [GitHub](../github/)
> module is more suitable.

## Defining the trigger constraints

The `trigger_config` variable is used to define how the Cloud Build will be
triggered; only one of `branch_regex` or `tag_regex` may be specified, to match
against source events by branch or tag, respectively.

### Triggering by tag

If `trigger_config` is not specifically set, the default trigger configuration
will be for **any** tag that is applied to the source repository. This is because
the default value uses `.*` as the tag matching regex. To change this to a more
restrictive set of tags, set the `trigger_config` value appropriately.

For example, to restrict the trigger to tags that begin with `v1`, the trigger
configuration could be:

```hcl
trigger_config = {
    tag_regex = "v1.*$"
    # Disable branch matching
    branch_regex = null
}
```

> NOTE: `tag_regex` must be a valid [RE2](https://github.com/google/re2/wiki/Syntax)
regular expression.

### Triggering by branch

To trigger on changes in a branch (or branches), `tag_regex` must be disabled and
a valid `branch_regex` specified.

For example, to restrict the trigger to changes to `dev` branch, the trigger
configuration could be:

```hcl
trigger_config = {
    branch_regex = "dev$"
    # Disable tag matching
    tag_regex = null
}
```

> NOTE: `branch_regex` must be a valid [RE2](https://github.com/google/re2/wiki/Syntax)
regular expression.

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
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | The Google Source Repository repository that will be the source of Cloud Build<br>trigger events. Must be a fully-qualified repo name of the form<br>'projects/my-gcp-project/repos/my-repo'. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | An optional description to apply to the Cloud Build trigger. | `string` | `""` | no |
| <a name="input_dir"></a> [dir](#input\_dir) | The directory path, relative to repository root, where the Cloud Build run will<br>be executed. Default is an empty string. | `string` | `""` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | A flag to create/modify the Cloud Build trigger into a disabled state. | `bool` | `false` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The path, relative to repository root, to the Cloud Build YAML file. The default<br>configuration will declare the filename 'cloudbuild.yml'. | `string` | `"cloudbuild.yml"` | no |
| <a name="input_ignored_files"></a> [ignored\_files](#input\_ignored\_files) | An optional set of file globs to ignore when determining the set of source<br>changes. If provided, the list of changed files will be filtered through this<br>list of globs, and the trigger action will proceed only if there are unfiltered<br>files remaining. Default is an empty list, meaning any changes in repo should<br>trigger the action, subject to `included_files`. | `list(string)` | `null` | no |
| <a name="input_included_files"></a> [included\_files](#input\_included\_files) | An optional set of file globs to explicitly match when determining the set of<br>source changes. If provided, the list of changed files will be filtered through this<br>list of globs, and the trigger action will proceed only if there are positive<br>matches. Default is an empty list, meaning any changes in repo should<br>trigger the action, subject to `ignored_files`. | `list(string)` | `null` | no |
| <a name="input_invert_regex"></a> [invert\_regex](#input\_invert\_regex) | If set, the tag or branch regular expressions used to match Google Source Repository<br>events will be effectively inverted, and events that *do not match* the tag or<br>branch pattern will be executed. Default is false. | `bool` | `false` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | An optional way to override the service account used by Cloud Build. If left<br>empty (default), the standard Cloud Build service account for project specified<br>in `project_id` will be used during execution. | `string` | `""` | no |
| <a name="input_substitutions"></a> [substitutions](#input\_substitutions) | A map of substitution key:value pairs that can be referenced in the build<br>definition. Default is empty. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An optional set of tags to annotate the Cloud Build trigger. | `set(string)` | `[]` | no |
| <a name="input_trigger_config"></a> [trigger\_config](#input\_trigger\_config) | Defines the trigger configuration to use; exactly one of the fields branch\_regex,<br>or tag\_regex must not be empty, and set invert\_regex to true to<br>trigger on changes to branches or tags that don't match the respective regex.<br><br>If unspecified, the default option will match on any tag value. | <pre>object({<br>    branch_regex = string<br>    tag_regex    = string<br>  })</pre> | <pre>{<br>  "branch_regex": null,<br>  "tag_regex": ".*"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified identifier of the created Cloud Build trigger. |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | The project-local identifier of the created Cloud Build trigger. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
