# Cursor Configuration for Unity / C#

This directory is a Cursor configuration template for Unity projects using C#, based on Unity coding conventions and Microsoft C# style. Copy it as `.cursor` at the root of your Unity project to use it.

This template is provided alongside a Claude Code configuration (`.claude` + `CLAUDE.md`) in the same repo; use the one that matches your editor. Content is kept in sync where applicable.

## Prerequisites

- **Unity** 2021.3 LTS or newer (or match your project version)
- **.NET** (for `dotnet format` when using generated .sln/.csproj)
- **Unity Test Framework** (optional but recommended): package `com.unity.test-framework` for tests

## Structure

| Directory / file | Description |
|------------------|-------------|
| **rules/** | Rules applied always or by file pattern (.mdc) |
| **skills/** | Skills for Unity development, refactoring, and testing |
| **commands/** | Commands run from chat with `/` (.md) |
| **agents/** | Custom subagents (test runner, code reviewer) |
| **hooks.json** | Hooks (e.g. dotnet format after .cs edit) |
| **hooks/** | Hook scripts |

## Usage

1. Copy this directory into your Unity project root as `.cursor`.
   ```bash
   cp -r unity/.cursor /path/to/your/unity_project/.cursor
   ```
2. If using the format hook, make the script executable.
   ```bash
   chmod +x .cursor/hooks/format-csharp.sh
   ```
3. Open the project in Cursor; Rules, Skills, Commands, and Agents load automatically. Use `/` to see commands; agents are invoked when needed.

## Rules

- **unity-core.mdc** (alwaysApply): Project-wide principles, directory layout, style policy, and reference links.
- **csharp-style.mdc**: C# style for `**/*.cs`.
- **unity-scripts.mdc**: MonoBehaviour, ScriptableObject, and Unity API conventions for `Assets/**/*.cs`.
- **unity-testing.mdc**: Unity Test Framework (NUnit) for `**/*Tests*.cs`.

## Commands

- `/run-tests-unity` — Run Unity tests and fix failures (delegates to **unity-tester** agent).
- `/run-format-unity` — Run dotnet format on C# when .sln exists.
- `/code-review-unity` — Review Unity/C# code for style, conventions, and maintainability (delegates to **unity-code-reviewer** agent).

## Agents (subagents)

- **unity-tester**: Runs Unity Test Framework tests, identifies failing tests, and fixes code or tests to make them pass.
- **unity-code-reviewer**: Reviews code for C# style, Unity conventions, performance, and maintainability.

## Hooks

- **afterFileEdit**: Runs `format-csharp.sh` after editing `.cs` files. If a `.sln` exists in project root and `dotnet format` is available, runs format on the edited file. Otherwise the script does nothing.

## Verification and style

After code changes, the agent should verify with tests and (when available) dotnet format. Style is defined in the `rules/` .mdc files and optionally enforced by dotnet format or EditorConfig; keep rules focused on principles and workflow.
