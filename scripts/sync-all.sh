#!/bin/bash

# Universal Context Engineering Framework
# Universal Sync Script - Converts context to all supported AI tool formats

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_CONTX_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_ROOT="$(cd "$PROJECT_CONTX_DIR/.." && pwd)"

# Define the context-engine directory at the project root (outside contx)
CONTEXT_ENGINE_DIR="$PROJECT_ROOT/context-engine"

# Create the context-engine directory if it doesn't exist
mkdir -p "$CONTEXT_ENGINE_DIR/domain-contexts"
mkdir -p "$CONTEXT_ENGINE_DIR/templates"
mkdir -p "$CONTEXT_ENGINE_DIR/templates/specs"
mkdir -p "$CONTEXT_ENGINE_DIR/tasks"
mkdir -p "$CONTEXT_ENGINE_DIR/standards"
mkdir -p "$CONTEXT_ENGINE_DIR/specs"

# Copy global-context.md, domain-contexts, and templates to context-engine
cp "$PROJECT_CONTX_DIR/global-context.md" "$CONTEXT_ENGINE_DIR/global-context.md"
cp -r "$PROJECT_CONTX_DIR/domain-contexts/." "$CONTEXT_ENGINE_DIR/domain-contexts/"
cp -r "$PROJECT_CONTX_DIR/templates/." "$CONTEXT_ENGINE_DIR/templates/"
cp -r "$PROJECT_CONTX_DIR/standards/." "$CONTEXT_ENGINE_DIR/standards/"

# Agent files (static): copy authored files from contx into project root
mkdir -p "$PROJECT_ROOT/.augment"
cp -R "$PROJECT_CONTX_DIR/.augment/rules" "$PROJECT_ROOT/.augment/"

# Copy AGENTS.md to project root
cp "$PROJECT_CONTX_DIR/AGENTS.md" "$PROJECT_ROOT/AGENTS.md"

# Generate WARP.md and GEMINI.md from AGENTS.md
cp "$PROJECT_ROOT/AGENTS.md" "$PROJECT_ROOT/WARP.md"
cp "$PROJECT_ROOT/AGENTS.md" "$PROJECT_ROOT/GEMINI.md"

echo "Context synchronized successfully!"
