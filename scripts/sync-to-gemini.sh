#!/bin/bash

# Universal Context Engineering Framework
# Gemini CLI Sync Script - Converts universal context to Gemini CLI format

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONTX_DIR="$PROJECT_ROOT"
TARGET_DIR="$PROJECT_ROOT/.."

echo "🔄 Syncing Universal Context to Gemini CLI format..."

# Create main GEMINI.md file in project root that points to .augment rules
echo "📋 Creating main GEMINI.md file that references .augment rules..."
cat > "$TARGET_DIR/GEMINI.md" << 'EOF'
# Project Context for Gemini CLI

This file provides comprehensive context for Gemini CLI to understand the project structure, patterns, and development requirements.

## Consolidated Context Framework

**IMPORTANT**: This project uses a consolidated context framework located in the `.augment/rules/` directory.
All agents (Warp, Gemini, Augment) should reference the same source of truth for consistency.

### Context Files Location
- **Global Context**: `.augment/rules/global-context.md`
- **Domain Contexts**: `.augment/rules/domain-contexts/`
  - API Design: `.augment/rules/domain-contexts/api-context.md`
  - Authentication: `.augment/rules/domain-contexts/auth-context.md`
  - Database: `.augment/rules/domain-contexts/database-context.md`
  - Draft Agent: `.augment/rules/domain-contexts/draft-agent-context.md`
- **Task Templates**: `.augment/rules/task-templates/`
- **Multi-Agent Coordination**: `.augment/rules/multi-agent-coordination.md`

### How to Use This Framework
1. **Always check `.augment/rules/global-context.md`** for project-wide guidance
2. **Reference domain-specific contexts** in `.augment/rules/domain-contexts/` for specialized tasks
3. **Use task templates** from `.augment/rules/task-templates/` for structured work
4. **Follow multi-agent coordination** rules when working with other AI agents

### Gemini CLI Specific Instructions
- Use the `/memory add` command to store important project learnings
- Reference `.augment/rules/` files when making architectural decisions
- Follow the task workflow templates for structured problem-solving
- Coordinate with other agents using `.augment/rules/multi-agent-coordination.md`

EOF

cat >> "$TARGET_DIR/GEMINI.md" << 'EOF'

## Quick Reference Guide

### Task Workflow
1. **Problem Definition**: Use `.augment/rules/task-templates/01-problem-definition.md`
2. **Research Phase**: Use `.augment/rules/task-templates/02-research.md`
3. **Implementation Plan**: Use `.augment/rules/task-templates/03-plan.md`
4. **Implementation**: Use `.augment/rules/task-templates/04-implementation.md`

### Domain Expertise
- **API Design**: Reference `.augment/rules/domain-contexts/api-context.md`
- **Authentication**: Reference `.augment/rules/domain-contexts/auth-context.md`
- **Database**: Reference `.augment/rules/domain-contexts/database-context.md`
- **Draft Agent**: Reference `.augment/rules/domain-contexts/draft-agent-context.md`

### Project Guidelines
- **Global Context**: Always check `.augment/rules/global-context.md` first
- **Multi-Agent Work**: Follow `.augment/rules/multi-agent-coordination.md`
- **Task Storage**: Store all work in `.augment/tasks/` directory

### Gemini CLI Best Practices
- Use `/memory add` to store important project insights
- Reference consolidated rules instead of creating duplicate context
- Follow the structured task workflow for complex problems
- Coordinate with other agents through shared `.augment/` structure

EOF

# Note: All context is now centralized in .augment/rules/
echo "📁 All context rules are now centralized in .augment/rules/ directory"

cat >> "$TARGET_DIR/GEMINI.md" << 'EOF'

---

**Note**: All detailed context, guidelines, and templates are now centralized in the `.augment/rules/` directory.
This GEMINI.md file serves as a pointer to the consolidated framework to ensure consistency across all AI agents.

For detailed guidance, always reference:
- `.augment/rules/global-context.md` for project-wide standards
- `.augment/rules/domain-contexts/` for specialized knowledge
- `.augment/rules/task-templates/` for structured workflows
- `.augment/rules/multi-agent-coordination.md` for collaboration

EOF

# Note: All context is now centralized in .augment/rules/
echo "📁 All context rules are now centralized in .augment/rules/ directory"

echo "✅ Gemini CLI sync completed!"
echo ""
echo "📁 Files created:"
echo "   - GEMINI.md (Points to consolidated .augment/rules/ framework)"
echo ""
echo "📋 Next steps:"
echo "   1. Install Gemini CLI if not already installed"
echo "   2. Navigate to your project directory"
echo "   3. Run 'gemini' to start AI-assisted development"
echo "   4. Gemini will reference the consolidated .augment/rules/ context"
echo ""
echo "🔧 Usage:"
echo "   - GEMINI.md points to .augment/rules/ for all context"
echo "   - Check .augment/rules/global-context.md for project guidance"
echo "   - Use .augment/rules/task-templates/ for structured work"
echo "   - Reference .augment/rules/domain-contexts/ for specialized tasks"
echo "   - Use /memory add to store important project learnings"
EOF
