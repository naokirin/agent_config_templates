---
name: unity-refactor
description: Refactors Unity/C# code while preserving behavior. Use when simplifying scripts, applying style rules, or improving structure without changing functionality.
---

# Unity Refactor

## When to Use

- Simplifying MonoBehaviour or utility code.
- Applying C# or Unity style conventions.
- Extracting components or ScriptableObjects.
- Reducing allocations or improving performance without changing behavior.

## Workflow

1. **Behavior first**: Refactors must not change observable behavior. Rely on existing tests.
2. **Incremental**: Prefer small, reviewable steps. One logical change per commit when possible.
3. **Verification**: After each step, run relevant tests and ensure the project compiles. Confirm no new failures.
4. **Style**: Follow C# and Unity conventions; use project format command if available.

## Best Practices Reference

Fetch these guides when refactoring toward specific patterns:
- **C# formatting**: https://unity.com/how-to/formatting-best-practices-c-scripting-unity
- **C# naming**: https://unity.com/how-to/naming-and-code-style-tips-c-scripting-unity
- **Object pooling**: https://learn.unity.com/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity
- **Engine optimization**: https://docs.unity3d.com/Manual/best-practice-guides.html
