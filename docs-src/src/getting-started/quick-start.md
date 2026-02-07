# Quick Start

This guide walks you through comparing two `.env` files in under a minute.

## Step 1: Launch DotEdit

Open DotEdit from your Applications folder, Launchpad, or Spotlight (`Cmd+Space`, type "DotEdit").

You'll see the **File Selection** screen with two panels — left and right — each containing a drop zone, a Browse button, and a list of recent files.

## Step 2: Load Two Files

You have three ways to load files:

### Drag and Drop

Drag a `.env` file from Finder onto the left drop zone, and another onto the right drop zone.

### Browse

Click the **Browse** button under each drop zone. The file picker is pre-filtered to `.env` files (`.env`, `.env.local`, `.env.production`, etc.).

### Recent Files

If you've used DotEdit before, your recently opened files appear below each drop zone. Click any file to load it.

## Step 3: Compare

Click the **Compare** button at the center of the screen. DotEdit validates both files and opens the **Comparison View**.

> **Note:** Both panels must have a file selected. DotEdit also prevents you from comparing a file against itself.

## Step 4: Read the Diff

The comparison view shows your files side by side with color-coded differences:

| Color | Meaning |
|-------|---------|
| **Blue** background | Key exists in both files but values differ (modified) |
| **Green** background (left) | Key exists only in the left file |
| **Green** background (right) | Key exists only in the right file |
| No highlight | Key and value are identical |

The center **gutter** shows symbols for each row:

| Symbol | Meaning |
|--------|---------|
| `=` | Keys are equal |
| `~` | Values are modified |
| `»` | Transfer left value to right |
| `«` | Transfer right value to left |

## Step 5: Transfer a Value

See a key where the left file has the correct value? Click the `»` arrow in the gutter to copy that value to the right file. The arrow `«` does the reverse — copies the right value to the left.

After a transfer:
- The diff updates instantly
- The target panel shows a red dot indicating unsaved changes
- The transferred row may turn from blue/green to unhighlighted if values now match

## Step 6: Save

Click the **Save** button in the action bar below the panel you modified, or press `Cmd+S` to save the focused panel.

DotEdit creates a backup (`.env.backup`) of the original file before saving, unless you've disabled this in [Settings](../settings/file-handling.md).

## What's Next

Now that you've completed a basic comparison and transfer, explore these features:

- **[Key-Based Diff](../features/key-based-diff.md)** — How DotEdit matches keys regardless of line position
- **[Semantic Reorganization](../features/semantic-reorg.md)** — Auto-group keys by prefix for cleaner diffs
- **[Inline Editing](../features/inline-editing.md)** — Edit values directly in the diff view
- **[Interface Overview](interface-overview.md)** — Full tour of every UI element

> **Tip:** Use `Cmd+R` to reload both files from disk at any time, and `Cmd+F` to search within a panel.
