---
description: Format shell scripts with shfmt
---

# Run Format (shfmt)

Format shell script files with shfmt.

1. Check for shfmt (in PATH or project config). If not available, report and skip.
2. Run `shfmt -w -i 2 -ci .` (or the project's format options) to format all configured files. Adjust `-i` (indent) and `-ci` (indent switch cases) per project convention if documented.
3. If the user specified a path, run the formatter on that path only.
4. Ensure no formatting-related changes are left unapplied; report any formatter errors.
