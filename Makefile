.DEFAULT_GOAL := help

.PHONY: package
package:  ## Create a chart package in ./charts
	helm package ./linkstack --destination ./charts

.PHONY: template
template:  ## Apply chart locally to view generated Kubernetes definitions
	helm template --values=values.yaml .

.PHONY: lint
lint: ## Lint helm templates
	helm lint --strict ./

.PHONY: test
test: helm-test ## Run all tests

.PHONY: helm-test
helm-test:  ## Run helm tests
	helm test linkstack

# Implements this pattern for autodocumenting Makefiles:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#
# Picks up all comments that start with a ## and are at the end of a target definition line.
.PHONY: help
help:  ## Display command usage
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
