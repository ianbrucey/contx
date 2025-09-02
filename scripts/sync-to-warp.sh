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

# Create main WARP.md file in project root
echo "📋 Creating main WARP.md file..."
cat > "$TARGET_DIR/WARP.md" << 'EOF'
# Project Context for Warp AI

This file provides context for Warp AI to understand the project structure, patterns, and requirements.

## Project Overview

EOF

# Append global context content (remove the title line)
tail -n +2 "$CONTX_DIR/global-context.md" >> "$TARGET_DIR/WARP.md"

cat >> "$TARGET_DIR/WARP.md" << 'EOF'

## Task Execution Guidelines

When working on tasks in this project:

### Simple Tasks (< 2 hours)
For bug fixes, small features, configuration changes:
1. Clearly define the issue and impact
2. Identify specific files to change
3. Consider potential conflicts with existing code
4. Include testing strategy
5. Document acceptance criteria

### Complex Tasks (> 2 hours)
For new features, architectural changes, integrations:
1. Start with detailed problem definition
2. Design solution with architectural alignment
3. Plan implementation in phases
4. Consider scalability and maintainability
5. Include comprehensive testing strategy
6. Document decisions and rationale

### Research Tasks
For investigation and discovery work:
1. Define clear research objectives
2. Identify information sources
3. Plan investigation phases
4. Document findings and analysis
5. Provide recommendations with rationale

## Domain-Specific Guidelines

### Authentication & Authorization
EOF

# Append auth context if it exists
if [[ -f "$CONTX_DIR/domain-contexts/auth-context.md" ]]; then
    echo "Adding authentication context..."
    tail -n +2 "$CONTX_DIR/domain-contexts/auth-context.md" >> "$TARGET_DIR/WARP.md"
fi

cat >> "$TARGET_DIR/WARP.md" << 'EOF'

### Database Operations
EOF

# Append database context if it exists
if [[ -f "$CONTX_DIR/domain-contexts/database-context.md" ]]; then
    echo "Adding database context..."
    tail -n +2 "$CONTX_DIR/domain-contexts/database-context.md" >> "$TARGET_DIR/WARP.md"
fi

cat >> "$TARGET_DIR/WARP.md" << 'EOF'

### API Design & Implementation
EOF

# Append API context if it exists
if [[ -f "$CONTX_DIR/domain-contexts/api-context.md" ]]; then
    echo "Adding API context..."
    tail -n +2 "$CONTX_DIR/domain-contexts/api-context.md" >> "$TARGET_DIR/WARP.md"
fi

# Create subdirectory-specific WARP.md files for common directories
echo "📁 Creating subdirectory-specific rules..."

# Frontend directory rules
if [[ -d "$TARGET_DIR/../src" ]] || [[ -d "$TARGET_DIR/../frontend" ]] || [[ -d "$TARGET_DIR/../client" ]]; then
    mkdir -p "$TARGET_DIR/../src" 2>/dev/null || true
    cat > "$TARGET_DIR/../src/WARP.md" << 'EOF'
# Frontend Development Context

## Component Development
- Follow established component patterns
- Implement proper prop validation
- Include accessibility considerations
- Write component tests
- Document component usage

## State Management
- Use established state management patterns
- Keep state as local as possible
- Implement proper error boundaries
- Handle loading and error states

## Styling Guidelines
- Follow established CSS/styling conventions
- Ensure responsive design
- Maintain design system consistency
- Optimize for performance

## Testing Requirements
- Unit tests for components
- Integration tests for user flows
- Accessibility testing
- Performance testing
EOF
fi

# Backend/API directory rules
if [[ -d "$TARGET_DIR/../api" ]] || [[ -d "$TARGET_DIR/../backend" ]] || [[ -d "$TARGET_DIR/../server" ]]; then
    mkdir -p "$TARGET_DIR/../api" 2>/dev/null || true
    cat > "$TARGET_DIR/../api/WARP.md" << 'EOF'
# Backend Development Context

## API Development
- Follow RESTful design principles
- Implement proper error handling
- Include input validation
- Add comprehensive logging
- Write API documentation

## Database Operations
- Use transactions for multi-table operations
- Implement proper indexing
- Handle database errors gracefully
- Include migration scripts
- Optimize query performance

## Security Considerations
- Validate all inputs
- Implement proper authentication
- Use parameterized queries
- Handle sensitive data securely
- Include security headers
EOF
fi

# Tests directory rules
if [[ -d "$TARGET_DIR/../tests" ]] || [[ -d "$TARGET_DIR/../test" ]] || [[ -d "$TARGET_DIR/../__tests__" ]]; then
    mkdir -p "$TARGET_DIR/../tests" 2>/dev/null || true
    cat > "$TARGET_DIR/../tests/WARP.md" << 'EOF'
# Testing Context

## Test Development Guidelines
- Write descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Include edge cases and error conditions
- Mock external dependencies
- Maintain test data isolation

## Test Types
- Unit tests: Test individual functions/components
- Integration tests: Test component interactions
- End-to-end tests: Test complete user workflows
- Performance tests: Test system performance
- Security tests: Test security vulnerabilities

## Test Maintenance
- Keep tests up to date with code changes
- Remove obsolete tests
- Refactor tests when code is refactored
- Monitor test coverage
- Fix flaky tests promptly
EOF
fi

# Database/migrations directory rules
if [[ -d "$TARGET_DIR/../migrations" ]] || [[ -d "$TARGET_DIR/../db" ]]; then
    mkdir -p "$TARGET_DIR/../migrations" 2>/dev/null || true
    cat > "$TARGET_DIR/../migrations/WARP.md" << 'EOF'
# Database Migration Context

## Migration Guidelines
- Always include both up and down migrations
- Test migrations on staging before production
- Use transactions for complex migrations
- Include data migrations when needed
- Document breaking changes

## Schema Design
- Follow established naming conventions
- Include proper indexes
- Implement foreign key constraints
- Consider performance implications
- Plan for future scalability

## Data Safety
- Backup data before major migrations
- Test rollback procedures
- Validate data integrity after migrations
- Monitor migration performance
- Have rollback plan ready
EOF
fi

echo "✅ Warp sync completed!"
echo ""
echo "📁 Files created:"
echo "   - WARP.md (Main project rules)"
echo "   - src/WARP.md (Frontend-specific rules)"
echo "   - api/WARP.md (Backend-specific rules)"
echo "   - tests/WARP.md (Testing-specific rules)"
echo "   - migrations/WARP.md (Database-specific rules)"
echo ""
echo "📋 Next steps:"
echo "   1. Open Warp terminal in your project directory"
echo "   2. Warp will automatically load the relevant rules"
echo "   3. Rules apply based on your current directory context"
echo ""
echo "🔧 Usage:"
echo "   - Rules automatically apply to all AI interactions in Warp"
echo "   - Navigate to subdirectories for more specific context"
echo "   - Rules provide guidance for terminal-based development tasks"
EOF
