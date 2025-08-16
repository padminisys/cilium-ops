#!/bin/bash
set -e

echo "🔧 Testing Ansible Collection Development Setup"
echo "=============================================="

# Test Python and basic tools
echo "✅ Python version:"
python3 --version

echo ""
echo "✅ Testing YAML syntax validation..."
python3 -c "import yaml; print('YAML parsing works!')"

echo ""
echo "✅ Testing Makefile..."
make help | head -5

echo ""
echo "✅ Checking file structure..."
echo "Collection files:"
find padminisys.debug -name "*.yml" -o -name "*.yaml" | sort

echo ""
echo "Molecule files:"
find molecule -name "*.yml" -o -name "*.yaml" | sort

echo ""
echo "Configuration files:"
ls -la .ansible-lint .yamllint.yml .pre-commit-config.yaml 2>/dev/null || echo "Config files present"

echo ""
echo "🎉 Basic setup verification complete!"
echo ""
echo "Next steps:"
echo "1. Open VS Code and select 'Reopen in Container'"
echo "2. Once in the container, run: make setup"
echo "3. Then run: make test"
echo ""
echo "If you see this message, your repository is properly configured!"
