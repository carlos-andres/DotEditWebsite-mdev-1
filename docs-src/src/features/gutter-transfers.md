# Gutter Transfers

The center gutter is where you act on differences. Each row with a diff shows clickable arrows that let you transfer values between the left and right panels with a single click.

## Transfer Arrows

The gutter displays two types of transfer arrows:

| Arrow | Direction | When it appears |
|-------|-----------|-----------------|
| `»` | Left to right | Modified rows, or keys that exist only on the left |
| `«` | Right to left | Modified rows, or keys that exist only on the right |

Equal rows have no transfer arrows — there's nothing to transfer.

When you hover over an arrow, the cursor changes to a pointing hand to indicate it's clickable.

## What Happens When You Click

### Modified Keys (key exists in both files)

Clicking `»` on a modified row **replaces** the right panel's value with the left panel's value. Clicking `«` does the reverse.

```
# Before transfer (modified — blue background):
Left:   DB_PORT=3306        »        Right: DB_PORT=5432

# After clicking »:
Left:   DB_PORT=3306        =        Right: DB_PORT=3306
```

The row changes from "modified" (blue) to "equal" (no highlight), and the transfer arrow disappears.

### Left-Only Keys (missing from right)

Clicking `»` on a left-only row **appends** the entry to the right panel.

```
# Before:
Left:   REDIS_PORT=6379     »        Right: (empty)

# After clicking »:
Left:   REDIS_PORT=6379     =        Right: REDIS_PORT=6379
```

The key is added at the end of the right file. If the right file has been reorganized, the key is inserted into the correct prefix group.

### Right-Only Keys (missing from left)

Clicking `«` works the same way in reverse — it appends the entry to the left panel.

## Key-Aware Transfers

DotEdit is smart about transfers. Before appending a key to the target panel, it checks whether that key already exists there (possibly at a different position). If the key is found:

- The **existing entry's value is updated** instead of creating a duplicate
- This prevents the common problem of duplicate keys after transfers

If the key is not found, it's appended at the end of the file.

## Transfer Mode

In Settings, you can choose between two transfer modes:

| Mode | Behavior |
|------|----------|
| **Full Line** | Copies the entire raw line including the key, export prefix, and quote style |
| **Value Only** | Keeps the target's key name, export prefix, and quote style — only the value changes |

**Value Only** is useful when your files use different conventions:

```
# Left file uses export prefix:
export DB_HOST=localhost

# Right file does not:
DB_HOST=production.db

# Full Line transfer → overwrites the whole line:
export DB_HOST=localhost

# Value Only transfer → preserves right's format:
DB_HOST=localhost
```

## Multiline Values

Multiline values (spanning multiple lines within quotes) are transferred as a single block. The entire value moves as one unit — you won't end up with partial transfers.

```
PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----
MIIBogIBAAJBALRiMLAH...
-----END RSA PRIVATE KEY-----"
```

This entire block transfers as one action and counts as one undo step.

## Undo Support

Every transfer is registered as a single undo step on the **target** panel. Press `Cmd+Z` or click the Undo button in the target panel's action bar to revert a transfer.

Transfers and manual edits maintain separate undo entries, so you can interleave transfers with edits and undo them independently.

## After a Transfer

After any transfer:

1. The **diff recomputes** instantly — background colors and gutter symbols update
2. The target panel is marked as **dirty** (unsaved changes indicator appears)
3. The status bar **diff summary** updates to reflect the new state

## Related

- [Key-Based Diff](key-based-diff.md) — How DotEdit determines which keys match
- [Inline Editing](inline-editing.md) — Edit values directly instead of transferring
- [Interface Overview](../getting-started/interface-overview.md) — Visual guide to the gutter layout
