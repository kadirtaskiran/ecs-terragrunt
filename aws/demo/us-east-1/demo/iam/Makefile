CURRENT_DIR := $(shell pwd)

contract:
	terragrunt plan -out=${CURRENT_DIR}/.tfplan
	terragrunt show -json ${CURRENT_DIR}/.tfplan > tfplan.json
	conftest test -p ./test/contract/common.rego tfplan.json
	conftest test -p ./test/contract/iam.rego tfplan.json

apply:
	terragrunt apply -auto-approve

destroy:
	terragrunt destroy -auto-approve

plan:
	terragrunt plan

test-only:
	conftest test -p ./test/contract/common.rego tfplan.json
	conftest test -p ./test/contract/iam.rego tfplan.json