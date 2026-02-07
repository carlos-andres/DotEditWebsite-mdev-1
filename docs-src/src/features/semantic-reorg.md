# Semantic Reorganization

Semantic Reorganization groups and sorts your `.env` keys by prefix, making large files easier to scan and compare. Instead of a flat list of 50+ keys, you get organized sections like `# === APP ===`, `# === DB ===`, `# === REDIS ===`.

## Why Reorganize?

Real-world `.env` files grow organically. Keys get added wherever is convenient, and over time the file becomes a jumble:

```
REDIS_PORT=6379
APP_URL=http://localhost
DB_HOST=localhost
APP_DEBUG=true
DB_PORT=3306
REDIS_HOST=127.0.0.1
APP_NAME=MyApp
DB_NAME=app_db
```

After reorganization:

```
# === APP ===
APP_DEBUG=true
APP_NAME=MyApp
APP_URL=http://localhost

# === DB ===
DB_HOST=localhost
DB_NAME=app_db
DB_PORT=3306

# === REDIS ===
REDIS_HOST=127.0.0.1
REDIS_PORT=6379
```

When both files are reorganized, key-based diff becomes especially clean — matched keys tend to appear at similar positions, making differences visually obvious.

## Two Modes: Preview and Apply

DotEdit offers reorganization in two distinct modes:

### Preview (Display Only)

Preview reorders the rows visually without modifying the underlying file data. It's a display-only mode — your file stays untouched.

- Access via **Reorganize > Preview > Both Panels** in the toolbar
- The toolbar shows a `✦` indicator when preview is active
- Edits still map back to the original line positions
- Save preserves the original file order
- Clear the preview via **Reorganize > Clear Preview**

Preview is mutually exclusive with Align and Sequential modes — only one visual reorder can be active at a time.

### Apply (Permanent)

Apply rewrites the file's line order permanently. The file content is replaced with the reorganized structure.

- Access via **Reorganize > Apply > Left / Right / Both** in the toolbar
- The panel is marked as dirty (unsaved changes)
- This is a **single undo step** — press `Cmd+Z` to restore the original order
- Save writes the reorganized order to disk

## How Prefix Extraction Works

DotEdit detects the dominant naming convention in your file and uses the appropriate delimiter to extract prefixes:

| Convention | Example Key | Delimiter | Extracted Prefix |
|------------|-------------|-----------|-----------------|
| SCREAMING_SNAKE | `DB_HOST` | `_` | `DB` |
| snake_case | `db_host` | `_` | `db` |
| dot.notation | `app.url` | `.` | `app` |
| kebab-case | `db-host` | `-` | `db` |
| camelCase | `dbHost` | uppercase boundary | `db` |
| PascalCase | `DbHost` | uppercase boundary | `Db` |

### Convention Detection

DotEdit scans all keys in the target panel and classifies each one. The convention used by the majority of keys wins. For example, if 80% of your keys use `SCREAMING_SNAKE` and 20% use `dot.notation`:

- `SCREAMING_SNAKE` becomes the dominant convention
- Keys using `dot.notation` are placed in an `# === OTHER ===` group

### Mixed Conventions Warning

If DotEdit detects mixed naming conventions, it shows a warning with the breakdown before proceeding.

### Low Key Count

When a file has fewer than 5 keys, convention detection has low confidence. DotEdit warns you and asks for confirmation before reorganizing.

## Group Structure

Each prefix group contains:

1. A **group header comment**: `# === PREFIX ===` (uppercased)
2. Keys **sorted alphabetically** within the group
3. A **blank line** separating groups

Keys without a delimiter (single-segment keys like `PORT` or `DEBUG`) each become their own group.

## Comment Handling

Reorganization restructures the file, which affects existing comments. You can control how comments are handled via Settings > Reorganize:

| Mode | Behavior |
|------|----------|
| **Move with key** (default) | Comments are attached to the key that follows them and move together |
| **Move to end** | All original comments are collected in a `# === COMMENTS ===` section at the bottom |
| **Discard** | Original comments are removed (group headers are still added) |

> **Note:** A confirmation dialog appears before applying reorganization to warn that the file structure will change.

### Orphan Comments

Comments at the end of the file (with no following key) are placed at the bottom of the reorganized output, regardless of the comment handling mode.

## Reorganize with Comment Removal

Two convenience options combine reorganization with comment handling:

- **Preview > Both & Hide Comments** — Preview the reorganized order with comment rows hidden
- **Apply > Both & Remove Comments** — Apply reorganization and strip all comment and blank lines

## Scope Selection

Both Preview and Apply modes let you choose which panels to affect:

- **Left Panel** — Reorganize only the left file
- **Right Panel** — Reorganize only the right file
- **Both Panels** — Reorganize both files (most common)

## Related

- [Key-Based Diff](key-based-diff.md) — Pairs well with reorganization for clean comparisons
- [Collapse & Dedup](collapse-dedup.md) — Remove duplicates before reorganizing for best results
- [Parsing Rules](../file-format/parsing-rules.md) — How keys and values are parsed
