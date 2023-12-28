.DEFAULT_GOAL := help

.PHONY: test
test: helm-test ## Alias to helm tests

.PHONY: helm-package
helm-package:  ## Create a chart package in ./charts
	helm package . --destination ./charts

.PHONY: helm-template
helm-template:  ## Apply chart locally to view generated Kubernetes definitions
	helm template --values=values.yaml .

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
