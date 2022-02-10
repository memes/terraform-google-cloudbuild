# Google Cloud Build module for Terraform

This

> PREFER TO USE THE SPECIFIC SUBMODULE FOR YOUR TRIGGER!

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
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable no-inline-html no-bare-urls -->
