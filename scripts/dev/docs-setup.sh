#!/usr/bin/env bash
# Local docs development setup for mq-rest-admin-common.
#
# Usage:
#   ./scripts/dev/docs-setup.sh        # install deps + generate mapping docs
#   ./scripts/dev/docs-setup.sh serve   # also start local dev server

set -euo pipefail

echo "Installing MkDocs dependencies..."
pip install mkdocs-material mike

echo "Generating mapping documentation..."
python3 scripts/dev/generate_mapping_docs.py

echo ""
echo "Setup complete. To preview the site locally:"
echo "  mike serve -F docs/site/mkdocs.yml"

if [[ "${1:-}" == "serve" ]]; then
    echo ""
    echo "Starting local dev server..."
    mike serve -F docs/site/mkdocs.yml
fi
