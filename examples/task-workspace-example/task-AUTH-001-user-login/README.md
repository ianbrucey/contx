# Task Workspace: AUTH-001 - user-login

**Complexity**: complex  
**Created**: 2024-02-01  
**Status**: In Progress

## Workspace Overview

This task workspace contains all context, planning, and progress tracking for implementing a secure user login endpoint with JWT authentication. It's designed to maintain continuity across multiple work sessions and provide complete context for resuming work.

## File Structure

| File | Purpose |
|------|---------|
| `task-definition.md` | Main task planning using Complex Task Template |
| `progress.md` | Session tracking, progress updates, and completion status |
| `decisions.md` | Architectural and technical decisions made during implementation |
| `code-links.md` | Files to modify/create, dependencies, and integration points |
| `next-steps.md` | Action items, blockers, and upcoming session planning |
| `task-metadata.json` | Machine-readable task metadata and status |

## Getting Started

1. **Define the Task**: Complete `task-definition.md` using the provided template
2. **Plan Implementation**: Break down work into phases and sessions
3. **Track Progress**: Update `progress.md` during each work session
4. **Document Decisions**: Record important choices in `decisions.md`
5. **Maintain Context**: Update files as work progresses

## Resuming Work

When returning to this task:
1. Review `progress.md` for current status
2. Check `next-steps.md` for immediate actions
3. Reference `decisions.md` for context on previous choices
4. Update `task-definition.md` if requirements have changed

## Integration with AI Tools

This workspace integrates with the Universal Context Engineering Framework:
- Reference this workspace in AI conversations for context continuity
- Use task-specific context alongside global and domain contexts
- Maintain decision logs for AI to understand architectural choices

### Example AI Interactions

**Augment**:
```
"I'm working on task AUTH-001 user login endpoint. The workspace is at .contx/tasks/task-AUTH-001-user-login/. Help me implement the JWT validation middleware based on the decisions we've made."
```

**Warp** (from task directory):
```
"Based on the task definition and decisions made so far, how should I implement the password hashing with bcrypt?"
```

**Gemini CLI**:
```
> I'm working on the user authentication task in .contx/tasks/task-AUTH-001-user-login/. Review the task definition and help me with the database schema design.
```

---
**Workspace ID**: task-AUTH-001-user-login  
**Template Used**: Complex Task Template  
**Framework Version**: 1.0
