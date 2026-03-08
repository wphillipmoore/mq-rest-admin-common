#!/usr/bin/env bash
set -euo pipefail
# Tier 1 — Lint

export DOCKER_DEV_IMAGE="${DOCKER_DEV_IMAGE:-dev-python:3.14}"
export DOCKER_TEST_CMD="${DOCKER_TEST_CMD:-files=\$(find scripts -type f \\( -name '*.sh' -o -path '*/git-hooks/*' \\) | sort) && if [ -n \"\$files\" ]; then echo \"\$files\" | xargs shellcheck; else echo 'No shell scripts found.'; fi}"

if ! command -v st-docker-test >/dev/null 2>&1; then
  echo "ERROR: st-docker-test not found on PATH." >&2
  echo "Set up standard-tooling: export PATH=../standard-tooling/.venv/bin:\$PATH" >&2
  exit 1
fi
exec st-docker-test
