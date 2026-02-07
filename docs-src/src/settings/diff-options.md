# Diff Options

These settings control how DotEdit compares entries between the two panels.

## Export Prefix Handling

Controls how lines with the `export` prefix are treated during comparison.

| Mode | Behavior |
|------|----------|
| **Preserve** (default) | `export DB_HOST` and `DB_HOST` are different keys |
| **Remove** | `export` is stripped before comparing — both match as `DB_HOST` |
| **Skip** | `export`-prefixed lines are excluded from the diff entirely |

See [Export Prefix](../file-format/export-prefix.md) for detailed examples of each mode.

> **Tip:** If you're comparing a shell-sourced `.env` (with `export`) against a standard one (without), use **Remove** mode to focus on actual value differences.

## Case-Insensitive Key Matching

| State | Behavior |
|-------|----------|
| **Off** (default) | `DB_HOST` and `db_host` are different keys |
| **On** | `DB_HOST` and `db_host` are the same key |

When enabled, key names are lowercased before matching. This is useful when comparing files from different frameworks that use different casing conventions.

You can toggle this setting from:
- **Settings > Diff Comparison > Case-insensitive key matching**
- **Toolbar > Ignore Case** checkbox

### Session-Only Behavior

Case-insensitive key matching and sequential diff mode are **session-only** settings. They reset to their defaults (off) when you load a new file comparison. This ensures every new comparison starts with clean, predictable behavior.

Other settings (theme, font, backup, export prefix mode, transfer mode) persist across sessions.

## Sequential Diff Mode

While not strictly a setting (it's a toolbar toggle), sequential mode changes the comparison algorithm:

| Mode | Behavior |
|------|----------|
| **Key-based** (default) | Matches entries by key name regardless of position |
| **Sequential** | Compares entries line by line, position matters |

In sequential mode:
- Line 1 is compared to line 1, line 2 to line 2, and so on
- Comments and blank lines are included in the comparison
- Order matters — the same keys in different positions show as different

Sequential mode is available from the **Sequential** button in the toolbar's Diff Modes group. Like case-insensitive matching, it resets to off for each new comparison.

> **Note:** Sequential mode works best when both files have the same structure. If you reorganize both files first with [Semantic Reorganization](../features/semantic-reorg.md), sequential mode becomes very clean.

## Transfer Mode

Controls what gets transferred when you click a gutter arrow.

| Mode | Behavior |
|------|----------|
| **Full Line** (default) | Copies the entire raw line, including key, export prefix, and quote style |
| **Value Only** | Keeps the target's key format, replaces only the value |

See [Gutter Transfers](../features/gutter-transfers.md) for examples of how each mode works.

## Reorganize Comment Handling

Controls how existing comments are treated during [Semantic Reorganization](../features/semantic-reorg.md).

| Mode | Behavior |
|------|----------|
| **Move with key** (default) | Comments travel with the key that follows them |
| **Move to end** | All comments are collected at the bottom |
| **Discard** | Comments are removed entirely |

## Settings Summary

| Setting | Default | Persists | Location |
|---------|---------|----------|----------|
| Export prefix | Preserve | Yes | Settings sheet |
| Case-insensitive | Off | No (session) | Settings + Toolbar |
| Sequential diff | Off | No (session) | Toolbar only |
| Transfer mode | Full Line | Yes | Settings sheet |
| Reorg comments | Move with key | Yes | Settings sheet |

## Related

- [Appearance](appearance.md) — Visual settings (theme, font, word wrap)
- [File Handling](file-handling.md) — Backup and save settings
- [Key-Based Diff](../features/key-based-diff.md) — How the default diff algorithm works
- [Export Prefix](../file-format/export-prefix.md) — Detailed export prefix behavior
