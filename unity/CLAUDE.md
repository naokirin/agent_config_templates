# Unity / C# Project

## Principles

- **Composition over Inheritance**: Prefer components; avoid deep MonoBehaviour inheritance. Use ScriptableObjects for data.
- **Editor and Runtime Separation**: Editor code in `Editor/` folders; use `#if UNITY_EDITOR` only when necessary.

## Commands

```bash
# Format (when .sln exists)
dotnet format *.sln

# Run tests
Unity -runTests -batchmode -testPlatform EditMode -testResults results.xml

# Build
Unity -batchmode -quit -buildTarget StandaloneWindows64 -executeMethod Build.PerformBuild
```

## Directory Layout

| Directory | Purpose |
|-----------|---------|
| `Assets/Scripts/` | Runtime C# scripts |
| `Assets/Scripts/Editor/` | Editor scripts |
| `Assets/Tests/` | Unity Test Framework tests |
| `Packages/` | Package manifests |
| `ProjectSettings/` | Unity settings |

## Style

- **Naming**: PascalCase for public/SerializeField; camelCase for private fields
- **Scripts**: `[SerializeField]` for private inspector fields; cache GetComponent
- **Tests**: Unity Test Framework (NUnit); `[Test]` for Edit Mode, `[UnityTest]` for Play Mode

## Unity Best Practices Quick Reference

Fetch and apply the relevant guide when working on these topics:

| Topic | Guide |
|-------|-------|
| Project structure, folders | https://unity.com/how-to/organizing-your-project |
| Version control (Git, LFS) | https://unity.com/how-to/version-control-systems |
| DevOps, CI/CD, branching | https://unity.com/how-to/devops-task-branch-workflow |
| C# formatting (braces, indent) | https://unity.com/how-to/formatting-best-practices-c-scripting-unity |
| C# naming conventions | https://unity.com/how-to/naming-and-code-style-tips-c-scripting-unity |
| Observer pattern | https://learn.unity.com/tutorial/create-modular-and-maintainable-code-with-the-observer-pattern |
| State pattern | https://learn.unity.com/tutorial/develop-a-modular-flexible-codebase-with-the-state-programming-pattern-1 |
| MVC/MVP architecture | https://learn.unity.com/tutorial/build-a-modular-codebase-with-mvc-and-mvp-programming-patterns-1 |
| Object pooling | https://learn.unity.com/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity |
| 2D Tilemap optimization | https://unity.com/how-to/optimize-performance-2d-games-unity-tilemap |
| Engine best practices | https://docs.unity3d.com/Manual/best-practice-guides.html |

## Reference

- [Unity Scripting Manual](https://docs.unity3d.com/Manual/ScriptingSection.html)
- [Unity C# conventions](https://docs.unity3d.com/Manual/coding-conventions.html)
- [Unity Test Framework](https://docs.unity3d.com/Packages/com.unity.test-framework@latest)

---

## Workflows

### Unity Development

When adding or modifying scripts, components, ScriptableObjects, or editor tools:

1. Follow project style rules (see Style and Tooling above and `.cursor/rules/` if present).
2. **Scripts**: Use `[SerializeField]` for inspector-editable private fields; avoid public fields for non-serialized data. Prefer properties for non-serialized state.
3. **Assembly Definition**: When creating or changing .asmdef, ensure references and platform settings match usage (Editor vs Runtime).
4. **Scenes/Prefabs**: Prefer references via inspector or addressables; avoid `Resources.Load` for large or many assets.
5. **Quick checks**: Compile in Editor, run relevant tests.

### Unity Refactor

When simplifying code or applying style/conventions:

1. **Behavior first**: Refactors must not change observable behavior. Rely on existing tests.
2. **Incremental**: Prefer small, reviewable steps.
3. **Verification**: Run tests and ensure project compiles; confirm no new failures.

### Unity Testing

When writing or editing tests:

1. Follow project test conventions (see `.cursor/rules/unity-testing.mdc` if present).
2. Place Edit Mode tests in appropriate test assemblies; use Play Mode only when runtime/GameObject behavior is required.
3. Use `[UnityTest]` for coroutine-based Play Mode tests; use `[Test]` for Edit Mode and synchronous checks.
4. Run tests via Test Runner or command line to verify.

---

## Code Review Guidelines

When reviewing Unity/C# code, check: C# style (naming, braces, null handling); Unity usage (MonoBehaviour lifecycle, SerializeField, no heavy work in Update); assembly boundaries and .asmdef; test coverage and test style; performance (allocations, GetComponent usage). Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
