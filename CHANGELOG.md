# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial collection setup with basic debug playbook
- Complete development environment configuration
- Dev container support for reproducible development
- Molecule testing framework setup
- Comprehensive linting configuration (ansible-lint, yamllint, pre-commit)
- GitHub Actions CI/CD pipeline
- Execution environment configuration for ansible-navigator and AWX
- Makefile with common development tasks
- Comprehensive documentation

### Changed
- N/A

### Deprecated
- N/A

### Removed
- N/A

### Fixed
- N/A

### Security
- N/A

## [1.0.0] - 2024-XX-XX

### Added
- Initial release of padminisys.debug collection
- Basic hello world playbook for debugging purposes
- Collection metadata and structure

---

## Release Process

1. Update version in `padminisys.debug/galaxy.yml`
2. Update this CHANGELOG.md with release notes
3. Commit changes: `git commit -m "Release vX.Y.Z"`
4. Create and push tag: `git tag vX.Y.Z && git push origin vX.Y.Z`
5. GitHub Actions will automatically build and publish to Galaxy

## Version Guidelines

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backwards compatible manner
- **PATCH** version when you make backwards compatible bug fixes

## Categories

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** in case of vulnerabilities
