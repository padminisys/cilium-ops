# Padminisys Debug Collection

A simple Ansible collection for debugging purposes.

## Requirements

- Ansible Core >= 2.15
- Python >= 3.11

## Installation

```bash
ansible-galaxy collection install padminisys.debug
```

## Usage

```bash
ansible-playbook padminisys.debug.hello -i inventory.yml
```

## Development

### Option 1: Dev Container (Recommended)

Provides consistent environment across all developers:

1. Open in VS Code
2. Click "Reopen in Container"
3. Run: `make test`

### Option 2: Local Development

Uses Python virtual environment:

```bash
# Setup (creates .venv automatically)
make setup

# Run tests
make test

# Run linters
make lint

# Build collection
make build
```

### Commands

- `make help` - Show available commands
- `make setup` - Install dependencies (venv or devcontainer)
- `make test` - Run molecule tests on localhost (no containers)
- `make lint` - Run ansible-lint and yamllint
- `make build` - Build collection for Galaxy
- `make clean` - Clean up artifacts

## Testing

Molecule tests run directly on localhost inside the development environment - no containers required. This is perfect for simple collections with basic playbooks.

## License

MIT

## Author

Manish Dad (manish@padminisys.com)
