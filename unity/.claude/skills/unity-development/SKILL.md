---
name: unity-development
description: Implements Unity features following conventions: scripts, components, ScriptableObjects, and editor tools. Use when adding or changing MonoBehaviours, ScriptableObjects, assembly definitions, or editor extensions in a Unity project.
---

# Unity Development

## When to Use

- Adding or modifying MonoBehaviour scripts, components, and prefabs.
- Creating or changing ScriptableObjects for data or events.
- Writing or changing Editor scripts, custom inspectors, or editor windows.
- Adding or updating Assembly Definition (.asmdef) files.

## Workflow

1. Follow the project's C# and Unity style rules (CLAUDE.md and any project rules) for all generated code.
2. **Scripts**: Use `[SerializeField]` for inspector-editable private fields; avoid public fields for non-serialized data. Match script file name to class name.
3. **Lifecycle**: Prefer `Awake` for setup and `OnEnable`/`OnDisable` for subscriptions; avoid heavy work in `Update` without caching.
4. **Assemblies**: Keep Editor code in Editor assemblies; do not reference Editor from runtime. Use test assemblies for test-only code.
5. **Tests**: Add or run relevant Edit Mode or Play Mode tests after changing behavior.

## Design Patterns

When implementing these patterns, fetch the relevant guide:

| Pattern | Use Case | Guide |
|---------|----------|-------|
| **Observer** | Event-driven communication | https://learn.unity.com/tutorial/create-modular-and-maintainable-code-with-the-observer-pattern |
| **State** | FSM for AI, game states | https://learn.unity.com/tutorial/develop-a-modular-flexible-codebase-with-the-state-programming-pattern-1 |
| **Object Pooling** | Frequent instantiation | https://learn.unity.com/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity |
| **MVC/MVP** | UI architecture | https://learn.unity.com/tutorial/build-a-modular-codebase-with-mvc-and-mvp-programming-patterns-1 |

## Quick Checks

- Ensure project compiles (Editor domain reload or build).
- Run relevant tests after changing logic.
- Verify .asmdef references and platforms when adding or moving scripts.
