#!/bin/bash

# Universal Context Engineering Framework
# Task Workspace Creation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTX_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_ROOT="$(cd "$CONTX_DIR/.." && pwd)"
TASKS_DIR="$PROJECT_ROOT/.augment/tasks"
TEMPLATES_DIR="$PROJECT_ROOT/.augment/rules/task-templates"

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

# Create multi-file task structure using new templates
echo -e "${BLUE}📋 Setting up multi-file task structure${NC}"

# Create artifacts directory
mkdir -p "$TASK_PATH/artifacts/diagrams"
mkdir -p "$TASK_PATH/artifacts/prototypes"
mkdir -p "$TASK_PATH/artifacts/references"

# Copy and customize the four-phase templates
echo -e "${BLUE}📝 Creating Phase 1: Problem Definition${NC}"
cp "$TEMPLATES_DIR/01-problem-definition.md" "$TASK_PATH/01-problem-definition.md"

echo -e "${BLUE}📝 Creating Phase 2: Research${NC}"
cp "$TEMPLATES_DIR/02-research.md" "$TASK_PATH/02-research.md"

echo -e "${BLUE}📝 Creating Phase 3: Implementation Plan${NC}"
cp "$TEMPLATES_DIR/03-plan.md" "$TASK_PATH/03-plan.md"

echo -e "${BLUE}📝 Creating Phase 4: Implementation Log${NC}"
cp "$TEMPLATES_DIR/04-implementation.md" "$TASK_PATH/04-implementation.md"

# Customize the problem definition template with task details
sed -i.bak "s/\[Unique identifier for this task\]/$TASK_ID/g" "$TASK_PATH/01-problem-definition.md"
sed -i.bak "s/\[Descriptive name for the task\]/$BRIEF_DESC/g" "$TASK_PATH/01-problem-definition.md"
sed -i.bak "s/\[Date when task was created\]/$(date)/g" "$TASK_PATH/01-problem-definition.md"
sed -i.bak "s/\[Simple\/Complex\/Research\]/$COMPLEXITY/g" "$TASK_PATH/01-problem-definition.md"
rm "$TASK_PATH/01-problem-definition.md.bak" 2>/dev/null || true

# Create additional workspace files
echo -e "${BLUE}📝 Creating workspace files${NC}"

# Create task metadata file with new structure
cat > "$TASK_PATH/task-metadata.json" << EOF
{
  "taskId": "$TASK_ID",
  "briefDescription": "$BRIEF_DESC",
  "complexity": "$COMPLEXITY",
  "status": "problem_definition",
  "currentPhase": "01-problem-definition",
  "createdAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "updatedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "estimatedHours": null,
  "actualHours": null,
  "assignee": null,
  "priority": "medium",
  "tags": [],
  "relatedTasks": [],
  "codeFiles": [],
  "dependencies": [],
  "phases": {
    "01-problem-definition": {
      "status": "in_progress",
      "startedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
      "completedAt": null
    },
    "02-research": {
      "status": "not_started",
      "startedAt": null,
      "completedAt": null
    },
    "03-plan": {
      "status": "not_started",
      "startedAt": null,
      "completedAt": null
    },
    "04-implementation": {
      "status": "not_started",
      "startedAt": null,
      "completedAt": null
    }
  }
}
EOF

# Create progress tracking file with multi-phase structure
cat > "$TASK_PATH/progress.md" << EOF
# Task Progress: $TASK_ID - $BRIEF_DESC

## Current Status
- **Current Phase**: Problem Definition (01)
- **Overall Progress**: 5% (Workspace created)
- **Last Updated**: $(date)
- **Next Session Focus**: Complete problem definition and requirements

## Phase Progress
### Phase 1: Problem Definition (01-problem-definition.md)
- **Status**: In Progress
- **Progress**: 10% (Template created)
- **Started**: $(date)
- **Next Steps**: Define problem statement and success criteria

### Phase 2: Research (02-research.md)
- **Status**: Not Started
- **Progress**: 0%
- **Dependencies**: Complete Phase 1

### Phase 3: Implementation Plan (03-plan.md)
- **Status**: Not Started
- **Progress**: 0%
- **Dependencies**: Complete Phase 2

### Phase 4: Implementation (04-implementation.md)
- **Status**: Not Started
- **Progress**: 0%
- **Dependencies**: Complete Phase 3

## Session Log
### Session 1 - $(date)
- **Duration**: [To be filled]
- **Phase Focus**: Setup and Problem Definition
- **Accomplishments**:
  - Task workspace created with multi-file structure
  - All four phase templates initialized
  - Artifacts directory structure created
- **Decisions Made**: Using new multi-phase task workflow
- **Blockers Encountered**: None
- **Next Steps**: Complete problem definition in 01-problem-definition.md

## Overall Completion Checklist
- [ ] Phase 1: Problem Definition completed and approved
- [ ] Phase 2: Research completed with solution recommendation
- [ ] Phase 3: Implementation plan created and reviewed
- [ ] Phase 4: Implementation completed with testing
- [ ] Documentation updated
- [ ] Code review completed (if applicable)
- [ ] Deployment completed (if applicable)

## Time Tracking
| Session | Date | Duration | Phase | Focus Area | Progress Made |
|---------|------|----------|-------|------------|---------------|
| 1 | $(date +"%Y-%m-%d") | [TBD] | Setup | Workspace Creation | Multi-phase structure created |

## Notes
This task uses the new multi-phase workflow structure:
1. **Problem Definition**: Clear problem statement and success criteria
2. **Research**: Investigation of solutions and technical decisions
3. **Plan**: Detailed implementation plan with phases and tasks
4. **Implementation**: Actual development work with progress tracking

Each phase has its own file and should be completed before moving to the next phase.
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

# Create next steps file with phase-based workflow
cat > "$TASK_PATH/next-steps.md" << EOF
# Next Steps: $TASK_ID - $BRIEF_DESC

## Current Phase: Problem Definition

### Immediate Next Steps (Current Session)
1. [ ] Complete problem statement in 01-problem-definition.md
2. [ ] Define current state analysis and limitations
3. [ ] Establish clear success criteria and acceptance criteria
4. [ ] Get stakeholder sign-off on problem definition
5. [ ] Move to Research phase (02-research.md)

## Phase-Based Workflow

### Phase 1: Problem Definition (01-problem-definition.md)
**Status**: In Progress
- [ ] Define core problem statement
- [ ] Analyze current state and limitations
- [ ] Establish success criteria
- [ ] Define acceptance criteria
- [ ] Get stakeholder approval

### Phase 2: Research (02-research.md)
**Status**: Not Started (Depends on Phase 1 completion)
- [ ] Investigate technical approaches
- [ ] Analyze codebase and existing patterns
- [ ] Research solution options
- [ ] Assess risks and trade-offs
- [ ] Make solution recommendation

### Phase 3: Implementation Plan (03-plan.md)
**Status**: Not Started (Depends on Phase 2 completion)
- [ ] Create detailed technical architecture
- [ ] Break down implementation into phases
- [ ] Identify specific files and changes
- [ ] Plan testing strategy
- [ ] Define rollback procedures

### Phase 4: Implementation (04-implementation.md)
**Status**: Not Started (Depends on Phase 3 completion)
- [ ] Execute implementation plan
- [ ] Track progress and decisions
- [ ] Document issues and resolutions
- [ ] Complete testing and validation
- [ ] Finalize documentation

## Blockers and Dependencies
- [ ] [Blocker description] - **Owner**: [Person] - **Due**: [Date]
- [ ] [Dependency description] - **Status**: [Status]

## Questions to Resolve (Current Phase)
- [ ] [Question about problem definition/requirements]
- [ ] [Question about scope/constraints]
- [ ] [Question about stakeholders/approval process]

## Research Needed (Future Phases)
- [ ] [Research topic] - **Priority**: [High/Medium/Low] - **Phase**: [2/3/4]
- [ ] [Investigation needed] - **Estimated Time**: [Duration] - **Phase**: [2/3/4]

## Review and Approval Needed
- [ ] Problem Definition Review - **Reviewer**: [Stakeholder] - **Type**: Business
- [ ] Technical Approach Review - **Reviewer**: [Tech Lead] - **Type**: Technical

---
**Multi-Phase Guidelines:**
- Complete each phase before moving to the next
- Update phase status in task-metadata.json
- Each phase has specific deliverables and success criteria
- Use artifacts/ directory for supporting materials
- Document decisions and rationale in each phase file
EOF

# Create README for the task workspace with new structure
cat > "$TASK_PATH/README.md" << EOF
# Task Workspace: $TASK_ID - $BRIEF_DESC

**Complexity**: $COMPLEXITY
**Created**: $(date)
**Current Phase**: Problem Definition
**Status**: In Progress

## Workspace Overview

This task workspace uses the new multi-phase workflow structure to break down complex work into manageable phases. Each phase has its own file and specific deliverables, making it easier to track progress and maintain context across multiple work sessions.

## Multi-Phase File Structure

### Core Phase Files
| File | Phase | Purpose |
|------|-------|---------|
| \`01-problem-definition.md\` | Phase 1 | Define problem statement, requirements, and success criteria |
| \`02-research.md\` | Phase 2 | Research solutions, analyze options, make technical decisions |
| \`03-plan.md\` | Phase 3 | Create detailed implementation plan with phases and tasks |
| \`04-implementation.md\` | Phase 4 | Track implementation progress and document decisions |

### Supporting Files
| File | Purpose |
|------|---------|
| \`progress.md\` | Overall progress tracking across all phases |
| \`decisions.md\` | Architectural and technical decisions made during work |
| \`code-links.md\` | Files to modify/create, dependencies, and integration points |
| \`next-steps.md\` | Phase-based action items and upcoming work planning |
| \`task-metadata.json\` | Machine-readable task metadata with phase tracking |

### Artifacts Directory
| Directory | Purpose |
|-----------|---------|
| \`artifacts/diagrams/\` | Architecture diagrams, flowcharts, wireframes |
| \`artifacts/prototypes/\` | Code prototypes, proof-of-concepts, experiments |
| \`artifacts/references/\` | Research materials, documentation, external resources |

## Phase-Based Workflow

### Phase 1: Problem Definition
- **Goal**: Clearly define the problem and establish success criteria
- **Deliverable**: Approved problem definition with stakeholder sign-off
- **Next**: Move to Research phase

### Phase 2: Research
- **Goal**: Investigate solutions and make informed technical decisions
- **Deliverable**: Recommended solution with rationale and risk assessment
- **Next**: Move to Implementation Planning phase

### Phase 3: Implementation Plan
- **Goal**: Create detailed technical plan for implementation
- **Deliverable**: Comprehensive implementation plan ready for execution
- **Next**: Move to Implementation phase

### Phase 4: Implementation
- **Goal**: Execute the plan and track progress
- **Deliverable**: Working solution with complete documentation
- **Next**: Task completion and review

## Getting Started

1. **Start with Problem Definition**: Complete \`01-problem-definition.md\`
2. **Get Approval**: Ensure stakeholders approve the problem definition
3. **Research Solutions**: Move to \`02-research.md\` to investigate approaches
4. **Plan Implementation**: Create detailed plan in \`03-plan.md\`
5. **Execute**: Track implementation in \`04-implementation.md\`

## Resuming Work

When returning to this task:
1. Check \`progress.md\` for current phase and overall status
2. Review the current phase file for specific context
3. Check \`next-steps.md\` for immediate actions
4. Reference \`decisions.md\` for previous choices and rationale

## Integration with AI Tools

This workspace integrates with the consolidated .augment framework:
- Reference \`.augment/rules/global-context.md\` for project guidance
- Use \`.augment/rules/domain-contexts/\` for specialized knowledge
- Follow \`.augment/rules/multi-agent-coordination.md\` for collaboration
- Store all work in \`.augment/tasks/\` for consistency

---
**Workspace ID**: $TASK_FOLDER
**Framework Version**: 2.0 (Multi-Phase)
**Template Location**: .augment/rules/task-templates/
EOF

echo ""
echo -e "${GREEN}✅ Multi-phase task workspace created successfully!${NC}"
echo ""
echo -e "${BLUE}📁 Workspace Location:${NC} $TASK_PATH"
echo -e "${BLUE}📋 Framework Version:${NC} 2.0 (Multi-Phase Workflow)"
echo -e "${BLUE}🎯 Current Phase:${NC} Problem Definition"
echo ""
echo -e "${YELLOW}📝 Phase-Based Next Steps:${NC}"
echo "1. Phase 1: Complete problem definition in 01-problem-definition.md"
echo "2. Phase 2: Research solutions in 02-research.md"
echo "3. Phase 3: Create implementation plan in 03-plan.md"
echo "4. Phase 4: Track implementation in 04-implementation.md"
echo ""
echo -e "${BLUE}📋 Phase Files Created:${NC}"
echo "• 01-problem-definition.md (Current phase - start here)"
echo "• 02-research.md (Next phase)"
echo "• 03-plan.md (Implementation planning)"
echo "• 04-implementation.md (Development tracking)"
echo ""
echo -e "${BLUE}🔧 Quick Commands:${NC}"
echo "cd $TASK_PATH"
echo "ls -la  # View all workspace files"
echo "cat README.md  # View workspace guide"
echo ""
echo -e "${GREEN}🎯 Ready to start with Problem Definition phase!${NC}"
EOF
