# Collapse & Dedup

DotEdit provides two tools to reduce noise in the comparison view: **Collapse** hides identical rows, and **Dedup** removes duplicate keys.

## Collapse

### What It Does

Collapse hides all rows where the key and value are identical on both sides. This lets you focus on the differences without scrolling past dozens of matching entries.

### How to Use

Click the **Collapse** button in the toolbar (eye icon). When active:

- Identical rows are hidden from the view
- The button label changes to **Show All**
- The status bar shows a count: `N hidden`
- The `eye.slash` icon indicates that rows are hidden

Click again to restore all rows.

### Behavior Details

- Collapse is **visual only** — no data is modified
- The diff summary in the status bar still counts all rows, but the view only shows differences
- [Search](search.md) automatically expands collapsed regions if a match is found inside a hidden row
- Gutter arrows are unaffected — collapsed rows are always equal, so they have no transfer actions

### When to Use

Collapse is most useful with large `.env` files where most keys are identical across environments and you want to zero in on the handful that differ.

## Dedup

### What It Does

Dedup scans a panel for duplicate keys (the same key name appearing more than once) and removes the extras, keeping only the first occurrence of each key.

### How to Use

Click the **Dedup** dropdown in the toolbar (minus icon) and choose a scope:

| Option | Effect |
|--------|--------|
| **Left Panel** | Dedup only the left file |
| **Right Panel** | Dedup only the right file |
| **Both Panels** | Dedup both files |

### What Happens

1. DotEdit scans the selected panel(s) for keys that appear more than once
2. The **first occurrence** of each duplicate key is kept
3. Subsequent occurrences are removed
4. A toast notification confirms the action: `"Removed 3 duplicates: DB_HOST (line 12), APP_KEY (line 45), REDIS_PORT (line 67)"`

If no duplicates are found, a toast shows: `"No duplicates found"`.

### Undo Support

Dedup is registered as a **single undo step**. Press `Cmd+Z` or click Undo in the panel's action bar to restore all removed duplicates.

### Duplicate Detection

Duplicate keys are highlighted visually in the comparison view even before you run Dedup. The warnings panel also lists each duplicate with its line number.

DotEdit highlights duplicates regardless of their values — if `DB_HOST` appears on line 5 and line 20, both lines are flagged even if they have the same value.

### Dedup Before Reorg

If you attempt to reorganize a file that contains duplicates, DotEdit shows a suggestion toast recommending you dedup first. This ensures clean groups without redundant entries.

## Common Workflows

### Focus on Differences

1. Open two files
2. Click **Collapse** to hide identical rows
3. Review and transfer only the differences

### Clean Up a Messy File

1. Open the file on both sides (or compare against a clean reference)
2. Run **Dedup** to remove duplicate keys
3. Run **Reorganize** to group and sort
4. Save

### Before Deploying

1. Compare `.env.local` against `.env.production`
2. Collapse identical rows
3. Transfer any missing keys to production
4. Save the production file

## Related

- [Key-Based Diff](key-based-diff.md) — How matching works with duplicate keys
- [Semantic Reorganization](semantic-reorg.md) — Group and sort after deduplication
- [Search](search.md) — Search auto-expands collapsed rows
