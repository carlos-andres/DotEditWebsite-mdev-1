# Search

DotEdit includes a search feature that lets you find keys or values across both panels, with highlighted matches and keyboard navigation.

## Opening Search

There are two ways to open the search bar:

- Press `Cmd+F`
- Click the **Search** button (magnifying glass) in a panel's action bar

The search bar appears within the comparison view.

## Search Scope

By default, search looks across **both panels**. You can narrow the scope to a single side:

- **Left only** — matches only in the left panel
- **Right only** — matches only in the right panel
- **Both** — matches in either panel (default)

## How Matching Works

Search is **case-insensitive** and matches against the full raw line content of each entry. This means you can search for:

- **Key names:** typing `DB_HOST` finds all rows containing that key
- **Values:** typing `localhost` finds all rows where the value contains "localhost"
- **Partial matches:** typing `redis` matches `REDIS_HOST`, `REDIS_PORT`, and any value containing "redis"

## Navigating Results

Once you have matches:

| Action | Effect |
|--------|--------|
| `Enter` or `Down arrow` | Jump to next match |
| `Up arrow` | Jump to previous match |
| `Escape` | Close the search bar |

The search bar shows your position in the results: `3 of 12` (current match out of total).

If there are no matches, the bar displays `0 of 0`.

## Highlighted Matches

All matching rows are highlighted in the view. The **current match** (the one you've navigated to) gets an additional visual indicator to distinguish it from other matches.

## Search and Collapsed Rows

If [Collapse](collapse-dedup.md) is active and a search match is found inside a hidden (identical) row, DotEdit **automatically expands** that row so you can see the match. You won't miss results just because they're in collapsed sections.

## Search and Visual Modes

Search works across all view modes:

- **Normal view** — searches the standard comparison rows
- **Align mode** — searches the aligned rows
- **Reorganize Preview** — searches the preview-reordered rows

The search re-executes automatically when you switch modes, so your query stays active.

## Clearing Search

Press `Escape` to close the search bar and clear all highlights. The search state (query text, match index) is reset.

## Tips

- Use search to quickly locate a specific key in a large file — type the key name and press Enter to jump right to it
- Search works well with Collapse: collapse identical rows, then search for a specific key among the differences
- The search query persists while you edit — if you change a value that was a match, the match list updates in real time

## Related

- [Collapse & Dedup](collapse-dedup.md) — Search interacts with collapsed rows
- [Keyboard Shortcuts](../reference/keyboard-shortcuts.md) — `Cmd+F` and navigation keys
