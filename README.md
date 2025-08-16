# Padminisys Debug Collection

A simple Ansible collection for debugging purposes.

## Requirements

- Ansible Core >= 2.15
- Python >= 3.11
- Podman (for testing)

## Installation

```bash
ansible-galaxy collection install padminisys.debug
```

## Usage

```bash
ansible-playbook padminisys.debug.hello -i inventory.yml
```

## Development

### Local Setup

```bash
# Install dependencies
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
- `make setup` - Install dependencies locally
- `make test` - Run molecule tests with Podman
- `make lint` - Run ansible-lint and yamllint
- `make build` - Build collection for Galaxy
- `make clean` - Clean up test containers and artifacts

## Testing

Molecule tests run in Podman containers, so you don't need any special development environment - just install the tools locally and run `make test`.

## License

MIT

## Author

Manish Dad (manish@padminisys.com)
