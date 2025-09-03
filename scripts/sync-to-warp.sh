#!/bin/bash

# Universal Context Engineering Framework
# Warp Sync Script - Converts universal context to Warp rules format

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONTX_DIR="$PROJECT_ROOT"
TARGET_DIR="$PROJECT_ROOT/.."

echo "🔄 Syncing Universal Context to Warp Rules..."

# Function to create Warp-compatible markdown
create_warp_rule() {
    local content="$1"
    local title="$2"
    
    echo "# $title"
    echo ""
    echo "$content"
    echo ""
}

# Create main WARP.md file in project root that points to .augment rules
echo "📋 Creating main WARP.md file that references .augment rules..."
cat > "$TARGET_DIR/WARP.md" << 'EOF'
# Project Context for Warp AI

This file provides context for Warp AI to understand the project structure, patterns, and requirements.

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

### Task Execution Guidelines

When working on tasks in this project:

#### Simple Tasks (< 2 hours)
For bug fixes, small features, configuration changes:
1. Check `.augment/rules/global-context.md` for project patterns
2. Reference relevant domain context files
3. Use appropriate task template from `.augment/rules/task-templates/`
4. Follow established coding standards and practices

#### Complex Tasks (> 2 hours)
For new features, architectural changes, integrations:
1. Start with problem definition using `.augment/rules/task-templates/`
2. Research solution options and document findings
3. Create detailed implementation plan
4. Execute implementation in phases
5. Follow multi-agent coordination if other agents are involved

#### Research Tasks
For investigation and discovery work:
1. Use research task template from `.augment/rules/task-templates/`
2. Document findings in structured format
3. Provide recommendations with clear rationale
4. Store results in `.augment/tasks/` directory

## Quick Reference
- **Project Guidelines**: See `.augment/rules/global-context.md`
- **Task Templates**: See `.augment/rules/task-templates/`
- **Domain Expertise**: See `.augment/rules/domain-contexts/`
- **Agent Coordination**: See `.augment/rules/multi-agent-coordination.md`

EOF

# Note: Subdirectory-specific rules are now consolidated in .augment/rules/
echo "📁 All context rules are now centralized in .augment/rules/ directory"

echo "✅ Warp sync completed!"
echo ""
echo "📁 Files created:"
echo "   - WARP.md (Points to consolidated .augment/rules/ framework)"
echo ""
echo "📋 Next steps:"
echo "   1. Open Warp terminal in your project directory"
echo "   2. Warp will reference the consolidated .augment/rules/ context"
echo "   3. All agents now use the same source of truth"
echo ""
echo "🔧 Usage:"
echo "   - WARP.md points to .augment/rules/ for all context"
echo "   - Check .augment/rules/global-context.md for project guidance"
echo "   - Use .augment/rules/task-templates/ for structured work"
echo "   - Reference .augment/rules/domain-contexts/ for specialized tasks"
EOF
