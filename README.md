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

### Setup Dev Container

1. Open in VS Code
2. Click "Reopen in Container"
3. Run: `make setup`

### Testing

```bash
make test    # Run molecule tests with Podman
make lint    # Run linters
make build   # Build collection
```

### Commands

- `make help` - Show available commands
- `make setup` - Install dependencies
- `make test` - Run tests
- `make lint` - Run linters
- `make build` - Build collection
- `make clean` - Clean up

## License

MIT

## Author

Manish Dad (manish@padminisys.com)
