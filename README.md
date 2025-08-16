# Padminisys Debug Collection

[![CI](https://github.com/your-username/your-repo/workflows/CI/badge.svg)](https://github.com/your-username/your-repo/actions)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-padminisys.debug-blue.svg)](https://galaxy.ansible.com/padminisys/debug)

A simple Ansible collection with debugging capabilities for development and testing purposes.

## Description

This collection contains a basic playbook that demonstrates debugging functionality. It's designed to be a starting point for Ansible collection development with a complete development environment setup.

## Requirements

- Ansible Core >= 2.18.0
- Python >= 3.11
- Docker (for molecule testing)

## Installation

### From Ansible Galaxy

```bash
ansible-galaxy collection install padminisys.debug
```

### From Source

```bash
git clone <repository-url>
cd <repository-name>
ansible-galaxy collection install padminisys.debug/ --force
```

## Development Environment

This repository is configured with a complete development environment including:

- **Dev Container**: Reproducible development environment with VS Code
- **Molecule**: Testing framework for Ansible content
- **Linting**: ansible-lint, yamllint, and pre-commit hooks
- **CI/CD**: GitHub Actions pipeline
- **Execution Environment**: Container image for ansible-navigator and AWX

### Getting Started with Dev Container

1. Open the repository in VS Code
2. When prompted, click "Reopen in Container" or use Command Palette: `Dev Containers: Reopen in Container`
3. Wait for the container to build and install dependencies
4. You're ready to develop!

### Local Development Setup

If you prefer not to use dev containers:

```bash
# Install Python dependencies
pip install -r requirements.txt

# Install pre-commit hooks
pre-commit install

# Install collection dependencies
ansible-galaxy install -r requirements.yml
```

## Testing

### Running Molecule Tests

```bash
# Run all molecule tests
molecule test

# Run specific test steps
molecule converge  # Apply the playbook
molecule verify    # Run verification tests
molecule destroy   # Clean up test instances
```

### Running Linters

```bash
# Run all linters via pre-commit
pre-commit run --all-files

# Run individual linters
ansible-lint
yamllint .
```

## Usage

### Using the Collection Playbook

```bash
# Run the hello playbook
ansible-playbook padminisys.debug.hello -i inventory.yml
```

### In Your Playbooks

```yaml
---
- name: Example playbook using padminisys.debug collection
  hosts: all
  tasks:
    - name: Include debug playbook
      ansible.builtin.include: padminisys.debug.hello
```

## Execution Environment

This collection includes configuration for building an Execution Environment (EE) for use with ansible-navigator and AWX:

```bash
# Build the execution environment
ansible-builder build -t ee-padminisys-debug:latest

# Run playbooks with the EE
ansible-navigator run padminisys.debug/playbooks/hello.yml --eei ee-padminisys-debug:latest
```

## AWX Integration

To use this collection in AWX:

1. **Create a Project**: Point to this Git repository
2. **Create Job Templates**: Use the playbooks from `padminisys.debug/playbooks/`
3. **Set Execution Environment**: Use the built EE image or configure AWX to build it
4. **Configure Credentials**: Set up any required credentials for your targets

### Example AWX Job Template Configuration

- **Name**: Debug Collection Test
- **Job Type**: Run
- **Inventory**: Your target inventory
- **Project**: This repository
- **Playbook**: `padminisys.debug/playbooks/hello.yml`
- **Execution Environment**: `ee-padminisys-debug:latest`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `molecule test`
5. Run linters: `pre-commit run --all-files`
6. Submit a pull request

### Development Workflow

1. **Make Changes**: Edit files in the collection
2. **Test Locally**: Run `molecule test` to verify changes
3. **Lint Code**: Pre-commit hooks will run automatically, or run manually
4. **Commit**: Use conventional commit messages
5. **Push**: CI will run automatically on push/PR

## CI/CD Pipeline

The repository includes a GitHub Actions pipeline that:

- **Lints** all YAML and Ansible content
- **Tests** with Molecule on multiple distributions
- **Builds** the collection artifact
- **Publishes** to Ansible Galaxy on tagged releases

### Release Process

1. Update version in `padminisys.debug/galaxy.yml`
2. Update `CHANGELOG.md`
3. Commit changes
4. Create and push a git tag: `git tag v1.0.1 && git push origin v1.0.1`
5. GitHub Actions will automatically publish to Galaxy

## File Structure

```
.
├── .devcontainer/
│   └── devcontainer.json          # Dev container configuration
├── .github/
│   └── workflows/
│       └── ci.yml                 # GitHub Actions CI pipeline
├── .vscode/
│   └── settings.json              # VS Code workspace settings
├── molecule/
│   └── default/                   # Molecule test scenario
├── padminisys.debug/              # The actual collection
│   ├── galaxy.yml                 # Collection metadata
│   └── playbooks/
│       └── hello.yml              # Example playbook
├── .ansible-lint                  # Ansible-lint configuration
├── .pre-commit-config.yaml        # Pre-commit hooks configuration
├── .yamllint.yml                  # YAML linting rules
├── bindep.txt                     # System dependencies for EE
├── execution-environment.yml      # EE build configuration
├── requirements.txt               # Python dependencies
├── requirements.yml               # Ansible Galaxy dependencies
└── README.md                      # This file
```

## License

MIT

## Author Information

This collection was created by Manish Dad (manish@padminisys.com).

## Support

For issues and questions:

- **GitHub Issues**: [Create an issue](https://github.com/your-username/your-repo/issues)
- **Email**: manish@padminisys.com

---

**Happy Automating!** 🚀
