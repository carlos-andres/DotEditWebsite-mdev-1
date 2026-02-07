# Export Prefix

Some `.env` files use the `export` prefix for shell compatibility, allowing the file to be sourced directly with `source .env` or `. .env` in bash/zsh. DotEdit recognizes and handles this prefix.

## The `export` Prefix

```
# Standard .env format:
DB_HOST=localhost

# Shell-compatible format:
export DB_HOST=localhost
```

Both formats define the same key (`DB_HOST`) with the same value (`localhost`), but some tools treat them differently.

## How DotEdit Handles It

DotEdit provides three modes for handling the `export` prefix, configurable in **Settings > Diff Comparison > Export prefix**:

### Preserve (Default)

The `export` prefix is kept as part of the key during comparison. This means `export DB_HOST` and `DB_HOST` are treated as **different keys**:

```
# Left:  export DB_HOST=localhost
# Right: DB_HOST=localhost
# Result: LEFT ONLY and RIGHT ONLY (different keys)
```

This is the safest default — it preserves the exact file content and makes no assumptions about intent.

### Remove

The `export` prefix is stripped before comparison. Both forms are matched as the same key:

```
# Left:  export DB_HOST=localhost
# Right: DB_HOST=localhost
# Result: EQUAL (same key "DB_HOST", same value)
```

The `export` keyword is stripped only for comparison purposes. The actual file content is not modified — the prefix remains in the raw line. When you save, the file retains its original `export` prefix (or lack thereof).

### Skip

Lines with the `export` prefix are excluded from the diff entirely. They are still displayed in the panel but don't participate in key matching:

```
# Left file:
export DB_HOST=localhost
DB_PORT=3306

# Right file:
DB_HOST=production.db
DB_PORT=5432

# With Skip mode:
# - "export DB_HOST=localhost" is excluded from diff
# - DB_PORT is compared normally (modified: 3306 vs 5432)
# - DB_HOST on the right is "right only" (the export version was skipped)
```

Skip mode is useful when one file uses `export` for shell sourcing and you want to compare only the non-exported keys.

## Detection

DotEdit detects the `export` prefix by checking if the key portion (before `=`) starts with `export ` or `export\t` (followed by a space or tab). The actual key name is everything after the `export` keyword:

```
export DB_HOST=localhost
#      ^^^^^^^ key: "DB_HOST"

export  DB_HOST=localhost
#       ^^^^^^^ key: "DB_HOST" (extra whitespace handled)
```

## Transfer Behavior

When transferring a value between panels, the [Transfer Mode](../features/gutter-transfers.md) setting determines how the `export` prefix is handled:

- **Full Line** mode: The entire raw line is copied, including any `export` prefix
- **Value Only** mode: Only the value changes — the target keeps its own `export` prefix (or lack thereof)

## Common Scenarios

### Comparing Shell-Sourced vs Standard Files

If your staging `.env` uses `export` (for direct sourcing in deployment scripts) and your local `.env` does not, use **Remove** mode to compare the actual key-value pairs without noise from the prefix difference.

### Mixed Export Usage

If some keys have `export` and some don't within the same file, DotEdit handles each line independently. The export prefix detection is per-line, not per-file.

## Related

- [Parsing Rules](parsing-rules.md) — How keys and values are extracted
- [Diff Options](../settings/diff-options.md) — Where to change the export prefix setting
- [Gutter Transfers](../features/gutter-transfers.md) — How transfers handle export prefixes
