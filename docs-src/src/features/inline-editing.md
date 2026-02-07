# Inline Editing

DotEdit's panels are fully editable — you can click on any row and modify its content directly, just like in an IDE code editor.

## How It Works

Click on any row in either panel to start editing. There's no special edit mode or toggle — the panels are always editable. Type your changes and the diff updates instantly.

```
# Click on the value and change it:
DB_PORT=3306  →  DB_PORT=5432
```

The moment you change a value:

1. The **diff recomputes** — background colors and gutter symbols update in real time
2. The panel is marked as **dirty** — a modified indicator appears in the status bar
3. The entry is **re-parsed** — if you change a key name, it becomes a different key in the diff

## What You Can Edit

- **Values:** Change `DB_HOST=localhost` to `DB_HOST=production.db`
- **Keys:** Rename `DB_HOOST=localhost` to `DB_HOST=localhost` (fixing a typo)
- **Comments:** Edit comment text like `# Database config`
- **Entire lines:** Rewrite a line from scratch

## Undo and Redo

Each panel has its own independent undo stack.

| Action | Shortcut | Button |
|--------|----------|--------|
| Undo | `Cmd+Z` | Undo button in panel action bar |
| Redo | `Cmd+Shift+Z` | Redo button in panel action bar |

Undo works for both manual edits and [gutter transfers](gutter-transfers.md). Each action is a discrete undo step, so you can interleave edits and transfers and undo them individually.

### Undo Stack Behavior

- **Save clears the undo stack.** Once you save, you cannot undo back to the pre-save state. If you have backup enabled, the backup file serves as your recovery mechanism.
- **Reload clears the undo stack.** Loading fresh content from disk resets the undo history.
- **Reorganize and Dedup** are each a single undo step — one `Cmd+Z` reverts the entire operation.

## Dirty State Tracking

Each panel tracks its own dirty state independently. A panel becomes dirty when:

- You edit any content
- A gutter transfer modifies the panel
- Reorganize or Dedup is applied

The dirty state is visible in the status bar as "(modified)" next to the file path. The Save button in the action bar highlights with an accent color when the panel has unsaved changes.

## Live Re-Diff

DotEdit re-parses and re-diffs after every edit, with a ~100ms debounce to stay responsive during rapid typing. This means:

- Background colors update as you type
- Gutter symbols change if a previously modified row becomes equal (or vice versa)
- The status bar diff summary stays current
- [Search](search.md) results update to reflect your changes

## Unsaved Changes Protection

DotEdit prevents accidental data loss:

- **Back to file selection:** If either panel has unsaved changes, a confirmation dialog appears with options: Save All / Discard / Cancel
- **Reload:** If a panel is dirty and you press `Cmd+R`, DotEdit warns before overwriting your changes
- **Quit:** `Cmd+Q` triggers the same unsaved changes dialog
- **External file change:** If the file changes on disk while you have unsaved edits, DotEdit shows a dialog with options: Reload from Disk / Keep My Version

## Tips

- Click anywhere on a row to start editing — no need to double-click
- Press `Cmd+S` to save the currently focused panel, or `Cmd+Option+S` to save both
- After editing a key name, the diff engine re-matches it — this is useful for fixing typos
- If you make a mistake, `Cmd+Z` is your friend — even gutter transfers can be undone

## Related

- [Gutter Transfers](gutter-transfers.md) — Transfer values with a single click instead of editing
- [File Handling](../settings/file-handling.md) — Backup and save behavior settings
- [Keyboard Shortcuts](../reference/keyboard-shortcuts.md) — Save, undo, redo shortcuts
