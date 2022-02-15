# How to contribute

Contributions are welcome to this repo, but we do have a few guidelines for
contributors.

## Open an issue and pull request for changes

All submissions, including those from project members, are required to go through
review. We use GitHub Pull Requests for this workflow, which should be linked with
an issue for tracking purposes.
See [GitHub](https://help.github.com/articles/about-pull-requests/) for more details.

## Pre-Commit

[Pre-commit](https://pre-commit.com/) is used to ensure that all files have
consistent formatting and to avoid committing secrets. Please install and
integrate the tool before pushing changes to GitHub.

1. Install pre-commit in venv or globally: see [instructions](https://pre-commit.com/#installation)
2. Fork and clone this repo
3. Install pre-commit hook to git

   E.g.

   ```shell
   pip install pre-commit
   pre-commit install
   ```

The hook will ensure that `pre-commit` will be run against all staged changes
during `git commit`.

## Testing

This repo uses [kitchen-terraform](https://newcontext-oss.github.io/kitchen-terraform/)
to create test cases for modules and examples. The Terraform in [setup](test/setup/)
folder will create a harness for the test cases, after which the `kitchen` command
can be used to launch and verify scenarios.

1. Install the ruby gems

   ```shell
   bundle install
   ```

2. Set test harness parameters

   Create/modify `test/setup/terraform.tfvars`

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

3. Run the tests

   The simplest way is to execute `make` in the root directory. The default
   target will setup the test harness foundations, and then cycle through
   `kitchen test` for all scenarios.

   Reports for all tests are generated in `test/reports/YYYY-MM-DD-HH-MM-SS`.

   > NOTE: Individual kitchen actions can be executed through `make`, with the
   > correct dependencies, by substituting `make action[.pattern]` for
   > `kitchen action [pattern]`. For example, instead of `kitchen verify PATTERN`,
   > use `make verify.PATTERN`. Bare actions are supported too, e.g. `make test`
   > instead of `kitchen test`.

4. Clean-up after testing

   This will remove any remaining converged kitchen tests, and destroy any shared
   Google Cloud resources.

   ```shell
   make clean
   ```
