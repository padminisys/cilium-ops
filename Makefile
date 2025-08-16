.PHONY: help install lint test clean build ee-build setup dev-setup
.DEFAULT_GOAL := help

# Variables
COLLECTION_NAME := padminisys.debug
EE_IMAGE_NAME := ee-$(COLLECTION_NAME)
EE_TAG := latest

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Initial setup for development environment
	@echo "Setting up development environment..."
	pip install --upgrade pip
	pip install -r requirements.txt
	ansible-galaxy install -r requirements.yml --force
	pre-commit install
	@echo "Setup complete!"

dev-setup: setup ## Alias for setup
	@echo "Development environment ready!"

install: ## Install collection dependencies
	@echo "Installing collection dependencies..."
	ansible-galaxy install -r requirements.yml --force

lint: ## Run all linters
	@echo "Running linters..."
	pre-commit run --all-files

lint-ansible: ## Run ansible-lint only
	@echo "Running ansible-lint..."
	ansible-lint --force-color --offline

lint-yaml: ## Run yamllint only
	@echo "Running yamllint..."
	yamllint .

test: ## Run molecule tests
	@echo "Running molecule tests..."
	molecule test

test-converge: ## Run molecule converge (apply playbook)
	@echo "Running molecule converge..."
	molecule converge

test-verify: ## Run molecule verify (run tests)
	@echo "Running molecule verify..."
	molecule verify

test-destroy: ## Clean up molecule test instances
	@echo "Destroying molecule instances..."
	molecule destroy

build: ## Build the collection
	@echo "Building collection..."
	cd $(COLLECTION_NAME) && ansible-galaxy collection build --force

ee-build: ## Build execution environment
	@echo "Building execution environment..."
	ansible-builder build -t $(EE_IMAGE_NAME):$(EE_TAG) .

ee-run: ## Run playbook with execution environment
	@echo "Running playbook with execution environment..."
	ansible-navigator run $(COLLECTION_NAME)/playbooks/hello.yml --eei $(EE_IMAGE_NAME):$(EE_TAG) -m stdout

clean: ## Clean up build artifacts and test instances
	@echo "Cleaning up..."
	molecule destroy || true
	rm -rf $(COLLECTION_NAME)/*.tar.gz
	rm -rf .pytest_cache/
	rm -rf .tox/
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true

check: lint test ## Run all checks (lint + test)
	@echo "All checks completed!"

ci: ## Run CI pipeline locally
	@echo "Running CI pipeline locally..."
	$(MAKE) lint
	$(MAKE) test
	$(MAKE) build
	@echo "CI pipeline completed successfully!"

release-check: ## Check if ready for release
	@echo "Checking release readiness..."
	@echo "1. Running linters..."
	$(MAKE) lint
	@echo "2. Running tests..."
	$(MAKE) test
	@echo "3. Building collection..."
	$(MAKE) build
	@echo "Release check completed successfully!"

info: ## Show project information
	@echo "Project: $(COLLECTION_NAME)"
	@echo "EE Image: $(EE_IMAGE_NAME):$(EE_TAG)"
	@echo ""
	@echo "Available files:"
	@ls -la $(COLLECTION_NAME)/ 2>/dev/null || echo "Collection directory not found"
	@echo ""
	@echo "Python version:"
	@python --version
	@echo ""
	@echo "Ansible version:"
	@ansible --version | head -1

watch: ## Watch for changes and run tests
	@echo "Watching for changes... (Press Ctrl+C to stop)"
	@while true; do \
		inotifywait -r -e modify,create,delete . --exclude '\.git|__pycache__|\.pytest_cache|\.tox' 2>/dev/null; \
		echo "Changes detected, running tests..."; \
		$(MAKE) test || true; \
		echo "Waiting for next change..."; \
	done
