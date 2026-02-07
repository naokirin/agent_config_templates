---
description: Format TypeScript/JavaScript source with Prettier
---

# Run Format

Format TypeScript and JavaScript source files with Prettier.

1. Check for Prettier (package.json scripts or `prettier` in devDependencies; `.prettierrc`, `prettier.config.*`).
2. Run `npm run format` or `npx prettier --write .` (or the project's format script) to format all configured files.
3. If the user specified a path, run Prettier on that path only (e.g. `npx prettier --write path/to/file.ts`).
4. Ensure no formatting-related changes are left unapplied; report any Prettier errors.
