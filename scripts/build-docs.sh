#!/bin/bash
set -e
cd "$(dirname "$0")/../docs-src"
mdbook build
cd ..
mkdir -p public/docs
cp -r docs-src/book/* public/docs/
echo "✓ Docs built and copied to public/docs/"
