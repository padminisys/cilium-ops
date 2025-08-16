.PHONY: help setup test lint clean build
.DEFAULT_GOAL := help

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies
	@echo "Installing dependencies..."
	pip install --upgrade pip
	pip install ansible-core ansible-lint yamllint molecule molecule-plugins[podman] pre-commit
	pre-commit install

test: ## Run molecule tests
	@echo "Running molecule tests..."
	molecule test

lint: ## Run linters
	@echo "Running linters..."
	ansible-lint
	yamllint .

build: ## Build collection
	@echo "Building collection..."
	cd padminisys.debug && ansible-galaxy collection build --force

clean: ## Clean up
	@echo "Cleaning up..."
	molecule destroy || true
	rm -rf padminisys.debug/*.tar.gz
	find . -name "*.pyc" -delete 2>/dev/null || true
