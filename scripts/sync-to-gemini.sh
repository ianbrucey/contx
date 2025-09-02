#!/bin/bash

# Universal Context Engineering Framework
# Gemini CLI Sync Script - Converts universal context to Gemini CLI format

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONTX_DIR="$PROJECT_ROOT"
TARGET_DIR="$PROJECT_ROOT/.."

echo "🔄 Syncing Universal Context to Gemini CLI format..."

# Create main GEMINI.md file in project root
echo "📋 Creating main GEMINI.md file..."
cat > "$TARGET_DIR/GEMINI.md" << 'EOF'
# Project Context for Gemini CLI

This file provides comprehensive context for Gemini CLI to understand the project structure, patterns, and development requirements.

## Project Overview

EOF

# Append global context content (remove the title line)
tail -n +2 "$CONTX_DIR/global-context.md" >> "$TARGET_DIR/GEMINI.md"

cat >> "$TARGET_DIR/GEMINI.md" << 'EOF'

## Development Workflow

### Task Classification and Approach

**Simple Tasks (< 2 hours)**
- Bug fixes and small feature additions
- Configuration changes and simple refactoring
- Documentation updates

Process:
1. Define the issue clearly with impact assessment
2. Identify specific files requiring changes
3. Consider integration points and potential conflicts
4. Implement with appropriate testing
5. Verify acceptance criteria are met

**Complex Tasks (> 2 hours)**
- New feature development and architectural changes
- Database schema modifications and API implementations
- External service integrations

Process:
1. Detailed problem definition with business context
2. Solution design with architectural alignment
3. Phased implementation planning
4. Comprehensive testing strategy
5. Documentation and decision logging

**Research Tasks**
- Technology evaluation and feasibility studies
- Performance analysis and security audits
- Architecture assessment

Process:
1. Define research objectives and success criteria
2. Plan investigation phases with clear deliverables
3. Analyze findings with pros/cons evaluation
4. Provide recommendations with supporting evidence
5. Document insights for future reference

## Technical Context

### Authentication & Authorization
EOF

# Append auth context if it exists
if [[ -f "$CONTX_DIR/domain-contexts/auth-context.md" ]]; then
    echo "Adding authentication context..."
    # Remove title and add content
    tail -n +2 "$CONTX_DIR/domain-contexts/auth-context.md" >> "$TARGET_DIR/GEMINI.md"
fi

cat >> "$TARGET_DIR/GEMINI.md" << 'EOF'

### Database Operations
EOF

# Append database context if it exists
if [[ -f "$CONTX_DIR/domain-contexts/database-context.md" ]]; then
    echo "Adding database context..."
    tail -n +2 "$CONTX_DIR/domain-contexts/database-context.md" >> "$TARGET_DIR/GEMINI.md"
fi

cat >> "$TARGET_DIR/GEMINI.md" << 'EOF'

### API Design & Implementation
EOF

# Append API context if it exists
if [[ -f "$CONTX_DIR/domain-contexts/api-context.md" ]]; then
    echo "Adding API context..."
    tail -n +2 "$CONTX_DIR/domain-contexts/api-context.md" >> "$TARGET_DIR/GEMINI.md"
fi

# Add any additional domain contexts
for context_file in "$CONTX_DIR/domain-contexts"/*.md; do
    if [[ -f "$context_file" ]]; then
        filename=$(basename "$context_file")
        case "$filename" in
            "auth-context.md"|"database-context.md"|"api-context.md")
                # Already handled above
                ;;
            *)
                # Add other domain contexts
                context_name=$(basename "$filename" .md | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
                echo "" >> "$TARGET_DIR/GEMINI.md"
                echo "### $context_name" >> "$TARGET_DIR/GEMINI.md"
                tail -n +2 "$context_file" >> "$TARGET_DIR/GEMINI.md"
                ;;
        esac
    fi
done

cat >> "$TARGET_DIR/GEMINI.md" << 'EOF'

## Code Quality Standards

### General Principles
- Write clean, readable, and maintainable code
- Follow established coding conventions and patterns
- Include comprehensive error handling
- Implement proper logging and monitoring
- Write tests for all new functionality

### Documentation Requirements
- Document complex business logic
- Include API documentation for endpoints
- Maintain up-to-date README files
- Document architectural decisions
- Include troubleshooting guides

### Performance Considerations
- Optimize database queries and indexes
- Implement appropriate caching strategies
- Monitor and profile application performance
- Consider scalability in design decisions
- Minimize resource usage and memory leaks

### Security Best Practices
- Validate and sanitize all inputs
- Implement proper authentication and authorization
- Use parameterized queries to prevent SQL injection
- Handle sensitive data securely
- Keep dependencies updated and secure

## Development Environment

### Local Development Setup
- Follow established environment setup procedures
- Use consistent development tools and versions
- Maintain environment configuration documentation
- Implement proper local testing procedures

### Version Control Practices
- Write clear, descriptive commit messages
- Use feature branches for development
- Follow established branching strategies
- Include proper code review processes
- Maintain clean commit history

### Deployment Considerations
- Follow established deployment procedures
- Test in staging environment before production
- Implement proper rollback procedures
- Monitor application health after deployments
- Document deployment processes and requirements

## Troubleshooting and Debugging

### Common Issues and Solutions
- Database connection problems
- Authentication and authorization failures
- Performance bottlenecks and optimization
- Integration issues with external services
- Environment configuration problems

### Debugging Strategies
- Use appropriate logging levels and formats
- Implement comprehensive error tracking
- Use debugging tools effectively
- Follow systematic troubleshooting approaches
- Document solutions for future reference

### Monitoring and Alerting
- Implement application health checks
- Monitor key performance metrics
- Set up appropriate alerting thresholds
- Track error rates and response times
- Monitor resource usage and capacity

## Team Collaboration

### Communication Guidelines
- Use clear and descriptive task descriptions
- Document decisions and rationale
- Share knowledge and insights with team
- Ask for help when needed
- Provide constructive feedback in reviews

### Knowledge Sharing
- Maintain up-to-date documentation
- Share learnings from problem-solving
- Contribute to team knowledge base
- Participate in code reviews actively
- Document lessons learned from projects

---

This context file is automatically loaded by Gemini CLI and provides comprehensive guidance for all development activities in this project. The context is designed to ensure consistent, high-quality development practices across all team members and AI-assisted development sessions.
EOF

# Create subdirectory-specific GEMINI.md files for enhanced context
echo "📁 Creating subdirectory-specific context files..."

# Frontend directory context
if [[ -d "$TARGET_DIR/../src" ]] || [[ -d "$TARGET_DIR/../frontend" ]] || [[ -d "$TARGET_DIR/../client" ]]; then
    mkdir -p "$TARGET_DIR/../src" 2>/dev/null || true
    cat > "$TARGET_DIR/../src/GEMINI.md" << 'EOF'
# Frontend Development Context

## Component Development Guidelines
- Follow established component architecture patterns
- Implement proper prop validation and TypeScript types
- Include accessibility considerations (ARIA labels, keyboard navigation)
- Write comprehensive component tests
- Document component usage and examples

## State Management Best Practices
- Use appropriate state management solutions
- Keep state as local as possible
- Implement proper error boundaries
- Handle loading and error states consistently
- Optimize re-renders and performance

## Styling and Design System
- Follow established CSS/styling conventions
- Ensure responsive design across devices
- Maintain design system consistency
- Use CSS-in-JS or CSS modules appropriately
- Optimize for performance and bundle size

## Frontend Testing Strategy
- Unit tests for components and utilities
- Integration tests for user workflows
- Accessibility testing with appropriate tools
- Performance testing and optimization
- Cross-browser compatibility testing
EOF
fi

# Backend directory context
if [[ -d "$TARGET_DIR/../api" ]] || [[ -d "$TARGET_DIR/../backend" ]] || [[ -d "$TARGET_DIR/../server" ]]; then
    mkdir -p "$TARGET_DIR/../api" 2>/dev/null || true
    cat > "$TARGET_DIR/../api/GEMINI.md" << 'EOF'
# Backend Development Context

## API Development Standards
- Follow RESTful design principles and conventions
- Implement comprehensive error handling and logging
- Include thorough input validation and sanitization
- Add detailed API documentation (OpenAPI/Swagger)
- Write integration and unit tests for all endpoints

## Database Integration Patterns
- Use transactions for multi-table operations
- Implement proper database indexing strategies
- Handle database errors gracefully with retries
- Include database migration scripts
- Optimize query performance and monitor slow queries

## Security Implementation
- Validate and sanitize all user inputs
- Implement proper authentication and authorization
- Use parameterized queries to prevent SQL injection
- Handle sensitive data securely with encryption
- Include security headers and CORS configuration

## Performance and Scalability
- Implement appropriate caching strategies
- Monitor and optimize API response times
- Handle concurrent requests efficiently
- Plan for horizontal and vertical scaling
- Implement rate limiting and throttling
EOF
fi

echo "✅ Gemini CLI sync completed!"
echo ""
echo "📁 Files created:"
echo "   - GEMINI.md (Main project context)"
echo "   - src/GEMINI.md (Frontend-specific context)"
echo "   - api/GEMINI.md (Backend-specific context)"
echo ""
echo "📋 Next steps:"
echo "   1. Install Gemini CLI if not already installed"
echo "   2. Navigate to your project directory"
echo "   3. Run 'gemini' to start AI-assisted development"
echo "   4. Context will be automatically loaded from GEMINI.md files"
echo ""
echo "🔧 Usage:"
echo "   - Context automatically loads when you start Gemini CLI"
echo "   - Hierarchical context provides progressive detail"
echo "   - Memory management preserves conversation context"
echo "   - Use natural language to describe development tasks"
EOF
