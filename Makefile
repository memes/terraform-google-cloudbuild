.DEFAULT: test
.PHONY: test.%
test.%: test/setup/harness.tfvars
	kitchen test $*

.PHONY: test
test: test/setup/harness.tfvars
	kitchen test

.PHONY: destroy.%
destroy.%: test/setup/harness.tfvars
	kitchen destroy $*

.PHONY: destroy
destroy: test/setup/harness.tfvars
	kitchen destroy

.PHONY: verify.%
verify.%: test/setup/harness.tfvars
	kitchen verify $*

.PHONY: verify
verify: test/setup/harness.tfvars
	kitchen verify

.PHONY: converge.%
converge.%: test/setup/harness.tfvars
	kitchen converge $*

.PHONY: converge
converge: test/setup/harness.tfvars
	kitchen converge

EXAMPLES=github-branch github-pr github-tag gsr-branch gsr-tag

test/setup/harness.tfvars: $(wildcard test/setup/*.tf) $(wildcard test/setup/*.auto.tfvars) $(wildcard test/setup/terraform.tfvars) $(addprefix test/ephemeral/,$(addsuffix /main.tf,$(EXAMPLES)))
	terraform -chdir=$(@D) init -input=false
	terraform -chdir=$(@D) apply -input=false -auto-approve

# We want the examples to use the registry tagged versions of the module, but
# need to test against the local code. Make an ephemeral copy of each example
# with the source redirected to local module
test/ephemeral/%/main.tf: $(wildcard examples/%/*.tf)
	mkdir -p $(@D)
	rsync -avP --exclude .terraform \
		--exclude .terraform.lock.hcl \
		--exclude 'terraform.tfstate' \
		examples/$*/ $(@D)/
	sed -i '' -E -e '1h;2,$$H;$$!d;g' -e 's@module "trigger"[ \t]*{[ \t]*\n[ \t]*source[ \t]*=[ \t]*"memes/cloudbuild/google//modules/([^"]+)"\n[ \t]*version[ \t]*=[ \t]*"[^"]+"@module "trigger" {\n  source = "../../../modules/\1/"@' $@

.PHONY: clean
clean: $(wildcard test/setup/harness.tfvars)
	if test -n "$<" && test -f "$<"; then kitchen destroy; fi
	if test -n "$<" && test -f "$<"; then terraform -chdir=$(<D) destroy -auto-approve; fi

.PHONY: realclean
realclean: clean
	find test/reports -depth 1 -type d -exec rm -rf {} +
	find test/ephemeral -depth 1 -type d -exec rm -rf {} +
	find . -type d -name .terraform -exec rm -rf {} +
	find . -type d -name terraform.tfstate.d -exec rm -rf {} +
	find . -type f -name .terraform.lock.hcl -exec rm -f {} +
	find . -type f -name terraform.tfstate -exec rm -f {} +
	find . -type f -name terraform.tfstate.backup -exec rm -f {} +
	rm -rf .kitchen
