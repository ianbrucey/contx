#!/bin/bash

# Universal Context Engineering Framework
# Augment Sync Script - Converts universal context to Augment rules format

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONTX_DIR="$PROJECT_ROOT"
AUGMENT_DIR="$PROJECT_ROOT/../.augment/rules"

echo "🔄 Syncing Universal Context to Augment Rules..."

# Create Augment rules directory if it doesn't exist
mkdir -p "$AUGMENT_DIR"
mkdir -p "$AUGMENT_DIR/task-templates"
mkdir -p "$AUGMENT_DIR/domain-contexts"

# Function to convert universal context to Augment format
convert_to_augment() {
    local source_file="$1"
    local target_file="$2"
    local rule_type="$3"
    local description="$4"
    
    echo "Converting $source_file to $target_file..."
    
    # Create Augment rule with YAML frontmatter
    cat > "$target_file" << EOF
---
type: $rule_type
description: "$description"
---

EOF
    
    # Append the content (skip the first line if it's a title)
    if [[ "$source_file" == *.md ]]; then
        tail -n +2 "$source_file" >> "$target_file"
    else
        cat "$source_file" >> "$target_file"
    fi
}

# Convert global context to Always rule
echo "📋 Converting global context..."
convert_to_augment \
    "$CONTX_DIR/global-context.md" \
    "$AUGMENT_DIR/global-context.md" \
    "always" \
    "Global project context and architectural guidance for all tasks"

# Convert templates to Manual rules
echo "📝 Converting task templates..."

convert_to_augment \
    "$CONTX_DIR/templates/simple-task.md" \
    "$AUGMENT_DIR/task-templates/simple-task-template.md" \
    "manual" \
    "Template for straightforward tasks that can be completed in under 2 hours"

convert_to_augment \
    "$CONTX_DIR/templates/complex-task.md" \
    "$AUGMENT_DIR/task-templates/complex-task-template.md" \
    "manual" \
    "Template for complex multi-step tasks requiring structured planning and architectural consideration"

convert_to_augment \
    "$CONTX_DIR/templates/research-task.md" \
    "$AUGMENT_DIR/task-templates/research-template.md" \
    "manual" \
    "Template for investigation, discovery, and research tasks"

# Convert domain contexts to Auto rules
echo "🏗️ Converting domain contexts..."

if [[ -f "$CONTX_DIR/domain-contexts/auth-context.md" ]]; then
    convert_to_augment \
        "$CONTX_DIR/domain-contexts/auth-context.md" \
        "$AUGMENT_DIR/domain-contexts/auth-context.md" \
        "auto" \
        "Authentication, authorization, user management, login, JWT, sessions, security, auth middleware, tokens"
fi

if [[ -f "$CONTX_DIR/domain-contexts/database-context.md" ]]; then
    convert_to_augment \
        "$CONTX_DIR/domain-contexts/database-context.md" \
        "$AUGMENT_DIR/domain-contexts/database-context.md" \
        "auto" \
        "Database operations, SQL, ORM, migrations, queries, schema design, performance optimization"
fi

if [[ -f "$CONTX_DIR/domain-contexts/api-context.md" ]]; then
    convert_to_augment \
        "$CONTX_DIR/domain-contexts/api-context.md" \
        "$AUGMENT_DIR/domain-contexts/api-context.md" \
        "auto" \
        "API design, REST, GraphQL, endpoints, HTTP methods, request response, validation, error handling"
fi

# Convert any additional domain contexts
for context_file in "$CONTX_DIR/domain-contexts"/*.md; do
    if [[ -f "$context_file" ]]; then
        filename=$(basename "$context_file")
        case "$filename" in
            "auth-context.md"|"database-context.md"|"api-context.md")
                # Already handled above
                ;;
            *)
                # Convert other domain contexts
                context_name=$(basename "$filename" .md)
                convert_to_augment \
                    "$context_file" \
                    "$AUGMENT_DIR/domain-contexts/$filename" \
                    "auto" \
                    "Domain-specific context for $context_name"
                ;;
        esac
    fi
done

# Create Augment-specific user guidelines
echo "👤 Creating user guidelines..."
cat > "$AUGMENT_DIR/../user-guidelines.md" << 'EOF'
# Context Engineering Workflow for Augment

## Task Workspace System:
1. **Create Task Workspace**: Use ./scripts/create-task-workspace.sh [task-id] [description] [complexity]
2. **Reference Task Context**: Include task workspace path in conversations for context continuity
3. **Maintain Progress**: Update task files throughout development sessions
4. **Track Decisions**: Document architectural choices in task decision logs

## For Every New Task:
1. Create dedicated task workspace with appropriate template
2. Always reference @global-context for project alignment
3. For simple tasks (< 2 hours): Use @simple-task-template
4. For complex tasks (> 2 hours): Use @complex-task-template
5. For research/investigation: Use @research-template
6. Let auto rules trigger for domain-specific context
7. Use task management tools for complex multi-step work
8. Always suggest testing after implementation

## Task Workspace Integration:
- Reference task workspace: "I'm working on task AUTH-001 at .contx/tasks/task-AUTH-001-user-login/"
- Maintain context across sessions with persistent task files
- Update progress and decisions throughout implementation
- Use task-specific context alongside global and domain contexts

## Quality Standards:
- Break down work into ~20-minute professional developer tasks
- Include explicit acceptance criteria
- Document architectural decisions in decision logs
- Consider forward compatibility and technical debt
- Update context documents when making architectural changes
- Maintain task state across multiple work sessions

## Template Usage:
- Reference templates with @ symbol: @simple-task-template
- Templates provide structured guidance for consistent task execution
- Auto rules will trigger based on keywords in your task description
- Task workspaces preserve template structure with progress tracking

## Task Management:
- Use task workspace system for persistent context
- Update task states: NOT_STARTED → IN_PROGRESS → COMPLETE
- Document decisions and work logs during implementation
- Reference task workspace for context continuity across sessions
EOF

echo "✅ Augment sync completed!"
echo ""
echo "📁 Files created in .augment/rules/:"
echo "   - global-context.md (Always rule)"
echo "   - task-templates/ (Manual rules)"
echo "   - domain-contexts/ (Auto rules)"
echo ""
echo "📋 Next steps:"
echo "   1. Open Augment and verify rules are loaded"
echo "   2. Add user guidelines to Augment Settings > User Guidelines"
echo "   3. Test with: 'Implement user login. Use @complex-task-template'"
echo ""
echo "🔧 Usage examples:"
echo "   Simple task: 'Fix the login button styling. Use @simple-task-template'"
echo "   Complex task: 'Implement user dashboard. Use @complex-task-template'"
echo "   Research: 'Investigate caching strategies. Use @research-template'"
EOF
