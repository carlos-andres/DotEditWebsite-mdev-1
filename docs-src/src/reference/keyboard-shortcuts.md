# Keyboard Shortcuts

All keyboard shortcuts available in DotEdit's comparison view.

## File Operations

| Shortcut | Action | Notes |
|----------|--------|-------|
| `Cmd+S` | Save focused panel | Saves the panel that currently has focus |
| `Cmd+Option+S` | Save all panels | Saves both left and right panels |
| `Cmd+R` | Reload from disk | Reloads both files; warns if unsaved changes |
| `Cmd+Q` | Quit DotEdit | Warns if unsaved changes |

## Editing

| Shortcut | Action | Notes |
|----------|--------|-------|
| `Cmd+Z` | Undo | Undoes the last action in the focused panel |
| `Cmd+Shift+Z` | Redo | Redoes the last undone action in the focused panel |

## Navigation

| Shortcut | Action | Notes |
|----------|--------|-------|
| `Escape` | Cancel / Back | Closes search bar, or navigates back to file selection |
| `Cmd+F` | Search | Opens the search bar |

## Search Navigation

When the search bar is active:

| Shortcut | Action |
|----------|--------|
| `Enter` or `Down arrow` | Next match |
| `Up arrow` | Previous match |
| `Escape` | Close search |

## Display

| Shortcut | Action | Notes |
|----------|--------|-------|
| `Cmd+=` or `Cmd++` | Increase font size | +1pt per press (max 20pt) |
| `Cmd+-` | Decrease font size | -1pt per press (min 12pt) |
| `Cmd+0` | Reset font size | Returns to default (12pt) |

## Help

| Shortcut | Action |
|----------|--------|
| `Cmd+/` | Open Help sheet |

## Quick Reference Card

```
 Save         ⌘S          Save All    ⌘⌥S
 Undo         ⌘Z          Redo        ⌘⇧Z
 Search       ⌘F          Help        ⌘/
 Reload       ⌘R          Quit        ⌘Q
 Font +       ⌘+          Font -      ⌘-
 Font Reset   ⌘0          Cancel      Esc
```

## Gutter Symbols (Mouse)

These are not keyboard shortcuts, but clickable symbols in the center gutter:

| Symbol | Action | When shown |
|--------|--------|------------|
| `»` | Transfer left value to right | Modified or left-only rows |
| `«` | Transfer right value to left | Modified or right-only rows |
| `=` | No action (visual only) | Equal rows |
| `~` | No action (visual only) | Modified rows |

## Tips

- `Cmd+S` saves whichever panel was last focused (clicked in). If you're unsure which panel has focus, use `Cmd+Option+S` to save both.
- Font size shortcuts work from anywhere in the comparison view — you don't need to focus a panel first.
- `Escape` has context-sensitive behavior: it closes the search bar first, then navigates back to file selection.
