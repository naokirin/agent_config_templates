# Claude Code Configuration for Unity / C#

This directory is a Claude Code configuration template for Unity projects using C#, based on Unity coding conventions and Microsoft C# style. Copy it along with `CLAUDE.md` to the root of your Unity project to use it.

This template is provided alongside a Cursor configuration (`.cursor`) in the same repo; use the one that matches your editor. Content is kept in sync where applicable.

## Prerequisites

- **Unity** 2021.3 LTS or newer (or match your project version)
- **.NET** (for `dotnet format` when using generated .sln/.csproj)
- **Unity Test Framework** (optional but recommended): package `com.unity.test-framework` for tests

## Structure

| Directory / file | Description |
|------------------|-------------|
| **CLAUDE.md** | Project instructions: principles, style, workflows, code review guidelines |
| **.claude/agents/** | Custom sub-agents (test runner, code reviewer) |
| **.claude/skills/** | Skills for Unity development, refactoring, and testing |
| **.claude/commands/** | Slash commands run from chat with `/` |
| **.claude/hooks/** | Hook scripts (e.g. dotnet format after file edit) |
| **.claude/settings.json** | Hook configuration |

## Usage

1. Copy `CLAUDE.md` and `.claude/` into your Unity project root.
   ```bash
   cp unity/CLAUDE.md /path/to/your/unity_project/CLAUDE.md
   cp -r unity/.claude /path/to/your/unity_project/.claude
   ```
2. Make the hook script executable (optional, for C# formatting).
   ```bash
   chmod +x .claude/hooks/format-csharp.sh
   ```
3. Open the project with Claude Code. Commands, skills, and agents load automatically. Use `/` to see available commands.

## Commands

| Command | Description | Sub-agent |
|---------|-------------|-----------|
| `/run-tests` | Run Unity tests and fix failures | `unity-tester` |
| `/run-format` | Format C# with dotnet format (when .sln exists) | — |
| `/code-review-unity` | Review Unity/C# code for style and conventions | `unity-code-reviewer` |

## Sub-agents

| Agent | Description |
|-------|-------------|
| **unity-tester** | Runs Unity Test Framework tests, identifies failures, and fixes code or tests |
| **unity-code-reviewer** | Reviews code for C# style, Unity conventions, performance, and maintainability |

## Skills

| Skill | Auto-loaded when |
|-------|------------------|
| **unity-development** | Adding or modifying scripts, ScriptableObjects, editor tools |
| **unity-refactor** | Simplifying code, applying style, extracting components |
| **unity-testing** | Writing or editing Unity Test Framework tests |

## Hooks

| Event | Matcher | Script | Description |
|-------|---------|--------|-------------|
| PostToolUse | Edit\|Write | format-csharp.sh | Runs `dotnet format` on edited .cs files when a .sln exists in project root. No-op if dotnet or .sln is missing. |

## Verification

After code changes, verify with: project compile (Unity Editor or batchmode) and relevant tests. Use `/run-tests` and `/run-format` when available. See CLAUDE.md for full workflows.
