.PHONY: help setup test lint clean build venv
.DEFAULT_GOAL := help

# Detect if we're in a devcontainer or need a virtual environment
VENV_DIR := .venv
PYTHON := $(if $(DEVCONTAINER),python,$(VENV_DIR)/bin/python)
PIP := $(if $(DEVCONTAINER),pip,$(VENV_DIR)/bin/pip)

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

venv: ## Create virtual environment (for local development)
	@if [ ! -d "$(VENV_DIR)" ]; then \
		echo "Creating virtual environment..."; \
		python3 -m venv $(VENV_DIR); \
	fi

setup: venv ## Install dependencies
	@echo "Installing dependencies..."
	@if [ -z "$(DEVCONTAINER)" ]; then \
		echo "Using virtual environment..."; \
		$(PIP) install --upgrade pip setuptools; \
		$(PIP) install ansible-core ansible-lint yamllint "molecule>=4" "molecule-plugins>=24" pre-commit; \
	else \
		echo "Using devcontainer environment..."; \
		pip install --upgrade pip setuptools; \
		pip install ansible-core ansible-lint yamllint "molecule>=4" "molecule-plugins>=24" pre-commit; \
	fi
	@if [ -z "$(DEVCONTAINER)" ]; then $(VENV_DIR)/bin/pre-commit install; else pre-commit install; fi

test: ## Run molecule tests (delegated driver - no containers)
	@echo "Running molecule tests (localhost)..."
	@if [ -z "$(DEVCONTAINER)" ]; then $(VENV_DIR)/bin/molecule test; else molecule test; fi

debug-molecule: ## Debug molecule setup
	@echo "Checking molecule setup..."
	@if [ -z "$(DEVCONTAINER)" ]; then \
		$(VENV_DIR)/bin/molecule --version; \
		$(VENV_DIR)/bin/molecule drivers; \
	else \
		molecule --version; \
		molecule drivers; \
	fi

lint: ## Run linters
	@echo "Running linters..."
	@if [ -z "$(DEVCONTAINER)" ]; then \
		$(VENV_DIR)/bin/ansible-lint; \
		$(VENV_DIR)/bin/yamllint .; \
	else \
		ansible-lint; \
		yamllint .; \
	fi

build: ## Build collection
	@echo "Building collection..."
	cd padminisys.debug && ansible-galaxy collection build --force

clean: ## Clean up
	@echo "Cleaning up..."
	@if [ -z "$(DEVCONTAINER)" ]; then $(VENV_DIR)/bin/molecule destroy || true; else molecule destroy || true; fi
	rm -rf padminisys.debug/*.tar.gz
	find . -name "*.pyc" -delete 2>/dev/null || true

clean-all: clean ## Clean up including virtual environment
	rm -rf $(VENV_DIR)
