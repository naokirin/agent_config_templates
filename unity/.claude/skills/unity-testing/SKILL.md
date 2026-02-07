---
name: unity-testing
description: Writes and maintains Unity Test Framework (NUnit) tests. Use when adding or editing Edit Mode or Play Mode tests in a Unity project.
---

# Unity Testing

## When to Use

- Adding tests for new or existing scripts.
- Fixing failing tests or improving test coverage.
- Converting or adding Play Mode tests that need GameObjects or coroutines.

## Workflow

1. Follow project test conventions (CLAUDE.md Unity Testing section).
2. Place tests in `Assets/Tests/` or package test folders; use an assembly that references the Unity Test Framework and assemblies under test.
3. Use `[Test]` for Edit Mode and synchronous checks; use `[UnityTest]` for IEnumerator-based Play Mode tests.
4. Use NUnit `Assert`; create/destroy GameObjects in SetUp/TearDown to avoid leaks.
5. Name tests to describe scenario and expected outcome. Keep tests independent and order-agnostic.
6. Run the test suite (or relevant subset) to verify after changes.
