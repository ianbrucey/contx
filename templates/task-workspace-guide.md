# Task Workspace System Guide

## Overview

The Task Workspace System extends the Universal Context Engineering Framework with persistent, structured workspaces for development tasks. Each task gets a dedicated folder with complete context preservation across multiple work sessions.

## Core Concepts

### Task Workspace Structure
```
.contx/tasks/task-[ID]-[description]/
├── task-definition.md      # Main task planning (uses appropriate template)
├── progress.md            # Session tracking and completion status
├── decisions.md           # Architectural and technical decisions
├── code-links.md          # Files, dependencies, and integration points
├── next-steps.md          # Action items and session planning
├── task-metadata.json     # Machine-readable task data
└── README.md              # Workspace overview and instructions
```

### Task Lifecycle
1. **Creation**: Establish workspace with appropriate template
2. **Definition**: Complete problem statement and solution planning
3. **Execution**: Implement across multiple sessions with progress tracking
4. **Completion**: Finalize documentation and capture lessons learned

## Phase 1: Task Workspace Creation

### Creating a New Task Workspace

```bash
# Create task workspace
./scripts/create-task-workspace.sh [task-id] [brief-description] [complexity]

# Examples:
./scripts/create-task-workspace.sh AUTH-001 user-login-endpoint simple
./scripts/create-task-workspace.sh NOTIF-001 realtime-notifications complex
./scripts/create-task-workspace.sh PERF-001 database-optimization research
```

### Complexity Guidelines

| Complexity | Duration | Examples | Template Used |
|------------|----------|----------|---------------|
| **Simple** | < 2 hours | Bug fixes, config changes, small features | simple-task.md |
| **Complex** | > 2 hours | New features, architecture changes, integrations | complex-task.md |
| **Research** | Variable | Investigation, evaluation, feasibility studies | research-task.md |

### What Gets Created

The script automatically creates:
- ✅ **Structured workspace** with all necessary files
- ✅ **Appropriate template** based on complexity
- ✅ **Progress tracking** system
- ✅ **Decision logging** framework
- ✅ **Code dependency** tracking
- ✅ **Session planning** tools

## Phase 2: Task Definition & Planning

### 1. Purpose & Solution Definition

Complete `task-definition.md` with:

**Problem Statement**:
- Clear description of what needs to be solved
- Business context and impact
- Current state vs. desired state

**Solution Approach**:
- High-level technical approach
- Key components and integration points
- Expected deliverables

### 2. Strategic Rationale

Document in `task-definition.md`:
- Why this solution is optimal
- How it aligns with project architecture
- What future capabilities it enables
- Technical debt considerations

### 3. Research & Discovery

Use `code-links.md` to track:
- Files to modify/create/delete
- Dependencies and version requirements
- Integration points with existing systems
- Related code patterns and components

**For extensive research**, create a separate research task:
```bash
./scripts/create-task-workspace.sh RESEARCH-001 auth-implementation-options research
```

### 4. Implementation Planning

Break down work in `task-definition.md`:
- **Phases**: Logical groupings of work
- **Sessions**: Individual work periods
- **Deliverables**: Concrete outputs for each phase
- **Acceptance Criteria**: Testable success conditions

## Phase 3: Execution Management

### Session-Based Development

Each work session follows this pattern:

1. **Session Start**:
   ```bash
   # Review current state
   cat .contx/tasks/task-AUTH-001-user-login/progress.md
   cat .contx/tasks/task-AUTH-001-user-login/next-steps.md
   ```

2. **Work Execution**:
   - Implement planned features
   - Document decisions in `decisions.md`
   - Update `code-links.md` with actual files modified
   - Track progress in `progress.md`

3. **Session End**:
   ```bash
   # Update status and progress
   ./scripts/update-task-status.sh AUTH-001 in_progress 45
   
   # Update next-steps.md for next session
   edit .contx/tasks/task-AUTH-001-user-login/next-steps.md
   ```

### Progress Tracking

Update `progress.md` with:
- **Session logs**: What was accomplished each session
- **Time tracking**: Actual vs. estimated time
- **Completion checklist**: Track deliverable completion
- **Blockers**: Document and assign ownership

### Decision Documentation

Record in `decisions.md`:
- **Architectural decisions**: High-level design choices
- **Technical decisions**: Implementation details
- **Process decisions**: Workflow or methodology choices
- **Context and rationale**: Why decisions were made

### Context Continuity

Maintain context across sessions:
- **Current state**: What's been completed
- **Next actions**: Immediate next steps
- **Blockers**: What's preventing progress
- **Context**: Decisions and discoveries made

## Task Management Integration

### Status Management

```bash
# Update task status
./scripts/update-task-status.sh [task-id] [status] [progress]

# Available statuses:
# - not_started: Task created but work hasn't begun
# - in_progress: Actively working on the task
# - blocked: Cannot proceed due to external dependency
# - on_hold: Temporarily paused
# - completed: Task finished and accepted
```

### Task Overview

```bash
# List all tasks with status
./scripts/list-tasks.sh

# Example output:
# TASK ID         DESCRIPTION                    STATUS       PROGRESS   UPDATED
# -------         -----------                    ------       --------   -------
# AUTH-001        user-login-endpoint            In Progress  45%        2024-02-01
# NOTIF-001       realtime-notifications         Not Started  0%         2024-01-30
# PERF-001        database-optimization          Completed    100%       2024-01-28
```

## AI Tool Integration

### Using with Augment

```
# Reference task workspace for context
"I'm working on task AUTH-001 user login endpoint. The workspace is at .contx/tasks/task-AUTH-001-user-login/. Help me implement the JWT validation middleware."

# AI will have access to:
✅ Task definition and requirements
✅ Previous decisions made
✅ Code files identified
✅ Progress and current state
```

### Using with Warp

```bash
# Navigate to task workspace
cd .contx/tasks/task-AUTH-001-user-login/

# Ask questions with full context
"Based on the task definition and decisions made so far, how should I implement the password hashing?"
```

### Using with Gemini CLI

```bash
# Reference task context
gemini
> I'm working on the user authentication task in .contx/tasks/task-AUTH-001-user-login/. Review the task definition and help me with the next implementation step.
```

## Best Practices

### Task Creation
- ✅ Use descriptive task IDs (AUTH-001, API-042, UI-015)
- ✅ Keep descriptions brief but clear
- ✅ Choose appropriate complexity level
- ✅ Create research tasks for investigation work

### Task Execution
- ✅ Update progress after each session
- ✅ Document decisions as they're made
- ✅ Track actual vs. estimated time
- ✅ Maintain next-steps for continuity

### Context Preservation
- ✅ Reference task workspace in AI conversations
- ✅ Update code-links.md as files are identified
- ✅ Document blockers and their resolution
- ✅ Capture lessons learned for future tasks

### Team Collaboration
- ✅ Use consistent task ID patterns
- ✅ Share decision logs with team
- ✅ Update global context with new patterns
- ✅ Archive completed tasks appropriately

## Troubleshooting

### Common Issues

**Task workspace not found**:
```bash
# List available tasks
./scripts/list-tasks.sh

# Check exact task folder name
ls .contx/tasks/
```

**Multiple tasks with same ID**:
- Use more specific task IDs
- Include timestamp in task creation
- Reference full folder name

**Lost context between sessions**:
- Review progress.md for current state
- Check next-steps.md for planned actions
- Review decisions.md for context

### Recovery Procedures

**Corrupted task workspace**:
```bash
# Backup current state
cp -r .contx/tasks/task-ID-desc .contx/tasks/task-ID-desc.backup

# Recreate workspace structure
./scripts/create-task-workspace.sh ID desc complexity

# Restore content from backup
```

**Missing progress tracking**:
```bash
# Update status to current state
./scripts/update-task-status.sh TASK-ID in_progress 50

# Manually update progress.md with session history
```

---

The Task Workspace System provides comprehensive context preservation and progress tracking for development tasks, ensuring no work is lost and context is maintained across multiple sessions and team members.
