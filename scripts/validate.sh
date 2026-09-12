#!/usr/bin/env bash
set -euo pipefail

echo "Validating project files..."

test -f app/Dockerfile
test -f app/index.html
test -f Jenkinsfile

echo "Validation completed."
