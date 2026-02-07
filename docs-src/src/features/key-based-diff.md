# Key-Based Diff

Key-based diffing is DotEdit's default comparison mode and its core differentiator from generic diff tools. Instead of comparing files line by line, DotEdit matches entries by their key name — regardless of where the key appears in each file.

## Why Key-Based?

In a typical `.env` file, key ordering varies between environments. A developer might add `REDIS_PORT` at the bottom of one file and in the middle of another. Line-based tools would show the entire file as different, drowning out the actual changes.

DotEdit solves this by matching on key names:

```
# Left file (.env.local)        # Right file (.env.production)
DB_HOST=localhost                APP_URL=https://prod.example.com
DB_PORT=3306                     DB_HOST=db.internal
APP_URL=http://localhost         DB_PORT=5432
REDIS_HOST=127.0.0.1            REDIS_HOST=redis.internal
```

A line-based diff would flag almost every line as different. DotEdit's key-based diff recognizes:

| Key | Status |
|-----|--------|
| `DB_HOST` | **Modified** — `localhost` vs `db.internal` |
| `DB_PORT` | **Modified** — `3306` vs `5432` |
| `APP_URL` | **Modified** — `http://localhost` vs `https://prod.example.com` |
| `REDIS_HOST` | **Modified** — `127.0.0.1` vs `redis.internal` |

All four keys are matched correctly despite being in different order.

## How It Works

1. **Parse** both files into key-value entries (comments and blank lines are excluded from the diff)
2. **Build a lookup** from the right file's keys
3. **Walk left entries** in order — for each key, check if the right file has the same key
4. **Categorize** each pair into one of four categories:

| Category | Color | Meaning |
|----------|-------|---------|
| **Equal** | None | Same key, same value |
| **Modified** | Blue | Same key, different value |
| **Left only** | Green (left side) | Key exists only in the left file |
| **Right only** | Green (right side) | Key exists only in the right file |

5. **Right-only keys** are appended at the end — keys from the right file that had no match on the left

## Duplicate Key Handling

When a key appears multiple times in the same file, only the **first occurrence** is used for matching. This mirrors the behavior of most dotenv libraries, which use the first (or last) occurrence of a duplicate key.

Duplicate keys are visually highlighted and can be cleaned up with [Dedup](collapse-dedup.md).

## Value Comparison

Values are compared as whole strings after trimming surrounding whitespace. DotEdit does not perform character-level highlighting within values — a value either matches or it doesn't.

```
# These are considered EQUAL (whitespace around = is normalized):
DB_HOST = localhost
DB_HOST=localhost
```

Quoted values are compared by their inner content:

```
# The parsed values are both "my secret" — EQUAL:
DB_PASS="my secret"
DB_PASS='my secret'
```

## Sequential Mode

DotEdit also offers a **Sequential** (line-by-line) diff mode, available as a toolbar toggle. In sequential mode, lines are compared by position — line 1 vs line 1, line 2 vs line 2, and so on. This includes comments and blank lines in the comparison.

Sequential mode is useful when line order matters or when comparing files where keys are already aligned.

> **Tip:** If you reorganize both files first with [Semantic Reorganization](semantic-reorg.md), then switch to sequential mode, the comparison becomes very clean — keys are sorted identically, so only actual value differences appear.

## Case-Insensitive Matching

By default, key matching is case-sensitive: `DB_HOST` and `db_host` are different keys. You can enable **Ignore Case** from the toolbar to treat them as the same key during comparison.

This setting is session-only — it resets to off when you load a new file comparison. See [Diff Options](../settings/diff-options.md).

## Live Re-Diff

The diff recomputes automatically whenever you:

- Edit a value inline
- Transfer a value via the gutter
- Apply a reorganization
- Remove duplicates

Updates are debounced (~100ms) to keep the interface responsive during rapid editing. Background colors and gutter symbols refresh instantly after each change.

## Related

- [Gutter Transfers](gutter-transfers.md) — Act on diff results by transferring values
- [Collapse & Dedup](collapse-dedup.md) — Hide equal rows or clean up duplicates
- [Diff Options](../settings/diff-options.md) — Configure export prefix handling and case sensitivity
