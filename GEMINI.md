# Gemini CLI Context Rules (Static)

Purpose
- This file is authored in the contx/ submodule and copied to the project root by the setup script.
- It explains how Gemini CLI should load context and where the single source of truth lives.

How Gemini should think about this project
- The source of truth is in `context-engine/` at the project root.
- Always begin with `context-engine/global-context.md` to understand architecture, constraints, and direction.
- Domain specifics (auth, database, API, draft workflow, etc.) live under `context-engine/domain-contexts/`.
- Tasks are organized under `context-engine/tasks/` using the documented naming convention (see contx/README.md).

Workflow for agents (Gemini CLI)
1) Load `context-engine/global-context.md` first.
2) Load any relevant `context-engine/domain-contexts/*.md` based on the topic.
3) If the user references a task folder (task-*), use the four-phase docs in that task: 01-problem-definition, 02-research, 03-plan, 04-implementation.
4) Keep decisions and next steps updated in the task folder for continuity.

Note
- This file is static by design. Do not append dynamic content here. If broader context changes, update `context-engine/global-context.md` and resync.

