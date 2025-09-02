#!/bin/bash

# Universal Context Engineering Framework
# Task Workspace Creation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTX_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKS_DIR="$CONTX_DIR/tasks"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Universal Context Engineering Framework${NC}"
echo -e "${BLUE}Task Workspace Creation${NC}"
echo "=============================================="
echo ""

# Function to display usage
usage() {
    echo "Usage: $0 [task-id] [brief-description] [complexity]"
    echo ""
    echo "Parameters:"
    echo "  task-id           : Unique identifier (e.g., AUTH-001, API-042)"
    echo "  brief-description : Short description (e.g., user-login, notification-system)"
    echo "  complexity        : simple | complex | research"
    echo ""
    echo "Examples:"
    echo "  $0 AUTH-001 user-login-endpoint simple"
    echo "  $0 NOTIF-001 realtime-notifications complex"
    echo "  $0 PERF-001 database-optimization research"
    echo ""
    exit 1
}

# Check parameters
if [[ $# -ne 3 ]]; then
    echo -e "${RED}❌ Error: Incorrect number of parameters${NC}"
    echo ""
    usage
fi

TASK_ID="$1"
BRIEF_DESC="$2"
COMPLEXITY="$3"

# Validate complexity
if [[ ! "$COMPLEXITY" =~ ^(simple|complex|research)$ ]]; then
    echo -e "${RED}❌ Error: Complexity must be 'simple', 'complex', or 'research'${NC}"
    echo ""
    usage
fi

# Create task folder name
TASK_FOLDER="task-${TASK_ID}-${BRIEF_DESC}"
TASK_PATH="$TASKS_DIR/$TASK_FOLDER"

# Check if task already exists
if [[ -d "$TASK_PATH" ]]; then
    echo -e "${YELLOW}⚠️  Task workspace already exists: $TASK_FOLDER${NC}"
    echo "Do you want to:"
    echo "1. Resume existing task"
    echo "2. Create new version"
    echo "3. Cancel"
    read -p "Choose option (1-3): " choice
    
    case $choice in
        1)
            echo -e "${GREEN}📂 Resuming existing task workspace${NC}"
            echo "Task path: $TASK_PATH"
            exit 0
            ;;
        2)
            TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
            TASK_FOLDER="task-${TASK_ID}-${BRIEF_DESC}-${TIMESTAMP}"
            TASK_PATH="$TASKS_DIR/$TASK_FOLDER"
            ;;
        3)
            echo -e "${YELLOW}❌ Cancelled${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid choice${NC}"
            exit 1
            ;;
    esac
fi

# Create tasks directory if it doesn't exist
mkdir -p "$TASKS_DIR"

# Create task workspace
echo -e "${BLUE}📁 Creating task workspace: $TASK_FOLDER${NC}"
mkdir -p "$TASK_PATH"

# Select appropriate template
case $COMPLEXITY in
    "simple")
        TEMPLATE_FILE="$CONTX_DIR/templates/simple-task.md"
        TEMPLATE_NAME="Simple Task Template"
        ;;
    "complex")
        TEMPLATE_FILE="$CONTX_DIR/templates/complex-task.md"
        TEMPLATE_NAME="Complex Task Template"
        ;;
    "research")
        TEMPLATE_FILE="$CONTX_DIR/templates/research-task.md"
        TEMPLATE_NAME="Research Task Template"
        ;;
esac

# Copy template to task workspace
echo -e "${BLUE}📋 Setting up $TEMPLATE_NAME${NC}"
cp "$TEMPLATE_FILE" "$TASK_PATH/task-definition.md"

# Create additional workspace files
echo -e "${BLUE}📝 Creating workspace files${NC}"

# Create task metadata file
cat > "$TASK_PATH/task-metadata.json" << EOF
{
  "taskId": "$TASK_ID",
  "briefDescription": "$BRIEF_DESC",
  "complexity": "$COMPLEXITY",
  "status": "not_started",
  "createdAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "updatedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "estimatedHours": null,
  "actualHours": null,
  "assignee": null,
  "priority": "medium",
  "tags": [],
  "relatedTasks": [],
  "codeFiles": [],
  "dependencies": []
}
EOF

# Create progress tracking file
cat > "$TASK_PATH/progress.md" << EOF
# Task Progress: $TASK_ID - $BRIEF_DESC

## Current Status
- **Status**: Not Started
- **Progress**: 0%
- **Last Updated**: $(date)
- **Next Session Focus**: Initial task definition and planning

## Session Log
### Session 1 - $(date)
- **Duration**: [To be filled]
- **Accomplishments**: Task workspace created
- **Decisions Made**: [To be filled]
- **Blockers Encountered**: [To be filled]
- **Next Steps**: Complete task definition using template

## Completion Checklist
- [ ] Task definition completed
- [ ] Implementation plan created
- [ ] Code implementation finished
- [ ] Testing completed
- [ ] Documentation updated
- [ ] Code review completed (if applicable)
- [ ] Deployment completed (if applicable)

## Time Tracking
| Session | Date | Duration | Focus Area | Progress Made |
|---------|------|----------|------------|---------------|
| 1 | $(date +"%Y-%m-%d") | [TBD] | Setup | Workspace created |

## Notes
[Add any additional notes, insights, or context here]
EOF

# Create decision log
cat > "$TASK_PATH/decisions.md" << EOF
# Decision Log: $TASK_ID - $BRIEF_DESC

## Architectural Decisions

### [Date] - [Decision Title]
- **Context**: [Why this decision was needed]
- **Decision**: [What was decided]
- **Rationale**: [Why this option was chosen]
- **Alternatives Considered**: [Other options evaluated]
- **Consequences**: [Expected impact and trade-offs]
- **Status**: [Proposed/Accepted/Superseded]

## Technical Decisions

### [Date] - [Decision Title]
- **Context**: [Technical context requiring decision]
- **Decision**: [Technical choice made]
- **Rationale**: [Technical reasoning]
- **Implementation Notes**: [How to implement]
- **Testing Requirements**: [How to validate]

## Process Decisions

### [Date] - [Decision Title]
- **Context**: [Process or workflow context]
- **Decision**: [Process choice made]
- **Rationale**: [Why this process]
- **Impact**: [Effect on team/project]
- **Review Date**: [When to reassess]

---
**Decision Log Guidelines:**
- Document all significant decisions made during task execution
- Include context, rationale, and alternatives considered
- Update status as decisions evolve
- Reference decisions in code comments where applicable
EOF

# Create code links file
cat > "$TASK_PATH/code-links.md" << EOF
# Code Files and Dependencies: $TASK_ID - $BRIEF_DESC

## Files to Modify
| File Path | Purpose | Status | Notes |
|-----------|---------|--------|-------|
| [path/to/file] | [Description] | [Not Started/In Progress/Complete] | [Notes] |

## Files to Create
| File Path | Purpose | Status | Notes |
|-----------|---------|--------|-------|
| [path/to/file] | [Description] | [Not Started/In Progress/Complete] | [Notes] |

## Dependencies
| Dependency | Type | Version | Purpose | Status |
|------------|------|---------|---------|--------|
| [package-name] | [npm/pip/etc] | [version] | [Purpose] | [To Add/Added] |

## Related Code Patterns
| Pattern/Component | Location | Relevance | Notes |
|-------------------|----------|-----------|-------|
| [Pattern name] | [File/directory] | [How it relates] | [Usage notes] |

## Integration Points
| System/Service | Interface | Purpose | Status |
|----------------|-----------|---------|--------|
| [Service name] | [API/DB/etc] | [Integration purpose] | [Not Started/Complete] |

## Testing Files
| Test File | Type | Coverage | Status |
|-----------|------|----------|--------|
| [test-file.spec.js] | [Unit/Integration/E2E] | [What it tests] | [Not Started/Complete] |

---
**Usage Notes:**
- Update this file as you identify code dependencies
- Link to specific files and line numbers where relevant
- Track testing requirements for each component
- Document integration patterns for future reference
EOF

# Create next steps file
cat > "$TASK_PATH/next-steps.md" << EOF
# Next Steps: $TASK_ID - $BRIEF_DESC

## Immediate Next Steps (Current Session)
1. [ ] Complete task definition in task-definition.md
2. [ ] Fill in problem statement and business context
3. [ ] Define solution approach and technical requirements
4. [ ] Identify code files and dependencies
5. [ ] Create implementation plan with phases

## Upcoming Sessions
### Session 2: [Focus Area]
- [ ] [Specific task]
- [ ] [Specific task]
- [ ] [Specific task]

### Session 3: [Focus Area]
- [ ] [Specific task]
- [ ] [Specific task]
- [ ] [Specific task]

## Blockers and Dependencies
- [ ] [Blocker description] - **Owner**: [Person] - **Due**: [Date]
- [ ] [Dependency description] - **Status**: [Status]

## Questions to Resolve
- [ ] [Question about architecture/implementation]
- [ ] [Question about requirements/scope]
- [ ] [Question about integration/dependencies]

## Research Needed
- [ ] [Research topic] - **Priority**: [High/Medium/Low]
- [ ] [Investigation needed] - **Estimated Time**: [Duration]

## Review and Approval Needed
- [ ] [What needs review] - **Reviewer**: [Person] - **Type**: [Technical/Business]

---
**Guidelines:**
- Update this file at the end of each work session
- Break down large tasks into specific, actionable items
- Identify blockers early and assign ownership
- Keep questions and research items prioritized
EOF

# Create README for the task workspace
cat > "$TASK_PATH/README.md" << EOF
# Task Workspace: $TASK_ID - $BRIEF_DESC

**Complexity**: $COMPLEXITY  
**Created**: $(date)  
**Status**: Not Started

## Workspace Overview

This task workspace contains all context, planning, and progress tracking for the development task. It's designed to maintain continuity across multiple work sessions and provide complete context for resuming work.

## File Structure

| File | Purpose |
|------|---------|
| \`task-definition.md\` | Main task planning using $TEMPLATE_NAME |
| \`progress.md\` | Session tracking, progress updates, and completion status |
| \`decisions.md\` | Architectural and technical decisions made during implementation |
| \`code-links.md\` | Files to modify/create, dependencies, and integration points |
| \`next-steps.md\` | Action items, blockers, and upcoming session planning |
| \`task-metadata.json\` | Machine-readable task metadata and status |

## Getting Started

1. **Define the Task**: Complete \`task-definition.md\` using the provided template
2. **Plan Implementation**: Break down work into phases and sessions
3. **Track Progress**: Update \`progress.md\` during each work session
4. **Document Decisions**: Record important choices in \`decisions.md\`
5. **Maintain Context**: Update files as work progresses

## Resuming Work

When returning to this task:
1. Review \`progress.md\` for current status
2. Check \`next-steps.md\` for immediate actions
3. Reference \`decisions.md\` for context on previous choices
4. Update \`task-definition.md\` if requirements have changed

## Integration with AI Tools

This workspace integrates with the Universal Context Engineering Framework:
- Reference this workspace in AI conversations for context continuity
- Use task-specific context alongside global and domain contexts
- Maintain decision logs for AI to understand architectural choices

---
**Workspace ID**: $TASK_FOLDER  
**Template Used**: $TEMPLATE_NAME  
**Framework Version**: 1.0
EOF

echo ""
echo -e "${GREEN}✅ Task workspace created successfully!${NC}"
echo ""
echo -e "${BLUE}📁 Workspace Location:${NC} $TASK_PATH"
echo -e "${BLUE}📋 Template Used:${NC} $TEMPLATE_NAME"
echo ""
echo -e "${YELLOW}📝 Next Steps:${NC}"
echo "1. Complete task definition: edit $TASK_PATH/task-definition.md"
echo "2. Update progress tracking: edit $TASK_PATH/progress.md"
echo "3. Plan implementation phases"
echo "4. Begin development work"
echo ""
echo -e "${BLUE}🔧 Quick Commands:${NC}"
echo "cd $TASK_PATH"
echo "ls -la  # View all workspace files"
echo ""
echo -e "${GREEN}🎯 Ready to start development!${NC}"
EOF
