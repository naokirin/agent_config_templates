# General Template

Language-agnostic Claude Code and Cursor configuration for any repository. Incorporates patterns from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) (common rules, planner and code-reviewer agents, plan/code-review commands).

Use this template when:

- You want a single, generic setup for any project (no specific language).
- You want to add common rules and workflows first, then apply a language template (e.g. `python`, `typescript`) so that hooks and settings merge.

## What’s included

| Component | Contents |
|-----------|----------|
| **Rules** | coding-style, git-workflow, testing, performance, patterns, hooks, agents, security (from ECC common/) |
| **Agents** | planner, code-reviewer |
| **Commands** | `/plan`, `/code-review` |
| **Skills** | general-workflow (plan → TDD → code review → commit) |
| **Hooks** | None by default; merge with a language template to add format/lint hooks |

## Applying this template

From the repo root:

```bash
./apply-template.sh general [TARGET_DIR]
```

Or download and run the script from another repo:

```bash
curl -sL https://raw.githubusercontent.com/naokirin/agent_config_templates/main/apply-template.sh -o apply-template.sh
chmod +x apply-template.sh
./apply-template.sh general .
```

## Combining with a language template

You can apply `general` first, then a language template (e.g. `python`). When prompted:

- **Merge .claude/settings.json?** — Choose **Y** to keep general’s empty hooks and add the language’s format/lint hooks.
- **Merge .cursor/hooks.json?** — Choose **Y** to keep general’s empty `afterFileEdit` and add the language’s format hook.

Result: common rules and plan/code-review everywhere, plus language-specific formatting and commands.

## Prerequisites

- **Git** (for `/code-review` via `git diff`).
- No language-specific tools; add them when you apply a language template.

## See also

- **.claude/README.md** — Claude Code layout and commands.
- **.cursor/README.md** — Cursor rules and structure.
- **CLAUDE.md** — Project-level instructions (principles, verification, workflows).
