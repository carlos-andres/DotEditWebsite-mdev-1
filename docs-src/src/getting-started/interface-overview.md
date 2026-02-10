# Interface Overview

DotEdit has two main screens: the **File Selection** screen and the **Comparison View**. This page maps every element you'll see in the interface.

## File Selection Screen

The entry point when you launch DotEdit.

### Layout

```
+----------------------------+----------------------------+
|        LEFT PANEL          |       RIGHT PANEL          |
|  +----------------------+  |  +----------------------+  |
|  |   Drop .env here     |  |  |   Drop .env here     |  |
|  +----------------------+  |  +----------------------+  |
|  /path/to/.env             |  /path/to/.env             |
|  [Browse...]               |  [Browse...]               |
|  -- Recent --              |  -- Recent --              |
|  * ../.env.local           |  * ../.env.production      |
|                            |                            |
|              [ Compare ]                                |
|               [*]   ?                                   |
+---------------------------------------------------------+
```

### Elements

| Element | Purpose |
|---------|---------|
| **Drop zones** | Drag `.env` files here from Finder |
| **Browse** | Opens a file picker filtered to `.env` patterns |
| **Recent files** | Previously opened files — click to load |
| **Compare** | Validates both selections and opens the comparison view |
| **Settings (gear)** | Opens the settings sheet |
| **Help (?)** | Opens the help sheet |

## Comparison View

The main working screen, organized from top to bottom.

### Toolbar

The top bar with global controls, split into logical groups:

```
(<-)  Reorganize  Dedup  Comments  Collapse | Align  Sequential | Ignore Case | wrap  #  12 | reload [*] ?
|--|  |---------- Operations --------------|  |-- Diff Modes --|  |-----------|  |- Display -|  |- Utils -|
```

| Button | Function |
|--------|----------|
| **Back (arrow)** | Return to file selection (warns if unsaved changes) |
| **Reorganize** | Dropdown: Preview or Apply semantic reorganization by prefix groups |
| **Dedup** | Dropdown: Remove duplicate keys from Left / Right / Both panels |
| **Comments** | Dropdown: Show/Hide comments, or Remove All |
| **Collapse** | Toggle: hide rows where key and value are identical |
| **Align** | Visual alignment of matched keys across panels (display only) |
| **Sequential** | Switch to position-based (line-by-line) diff mode |
| **Ignore Case** | Toggle case-insensitive key matching |
| **Wrap** | Toggle word wrap in editor panels |
| **Line numbers (#)** | Toggle line number visibility in the gutter |
| **Font size** | Dropdown to select editor font size (12-20pt) |
| **Reload** | Reload both files from disk (`Cmd+R`) |
| **Settings** | Open the settings sheet |
| **Help** | Open the help sheet (`Cmd+/`) |

### File Headers

Below the toolbar, each panel displays its file name and path.

### Left and Right Panels

The two main content areas showing file contents. Each row displays:

- The raw line content (key=value, comment, or blank line)
- Background color indicating diff status
- Editable inline — click any value to start editing

### Center Gutter

The gutter sits between the two panels and contains five columns:

```
[ » transfer-right ] [ L# ] [ status ] [ R# ] [ « transfer-left ]
```

| Column | Content |
|--------|---------|
| **Transfer right (`»`)** | Click to copy left value to the right panel |
| **Left line number** | Line number from the left file |
| **Status symbol** | `=` (equal), `~` (modified), or blank |
| **Right line number** | Line number from the right file |
| **Transfer left (`«`)** | Click to copy right value to the left panel |

Transfer arrows only appear on rows with differences. Equal rows show no clickable arrows. See [Gutter Transfers](../features/gutter-transfers.md) for details.

### Match Indicators

When matched keys appear at different line positions, colored numbered indicators appear in the outer edges of the gutter, visually connecting corresponding keys across panels. See [Match Indicators](../features/match-indicators.md).

### Per-Panel Action Bars

Below each panel, a centered action bar provides panel-specific controls:

```
[ Save ] [ Undo ] [ Redo ] [ Search ]
```

| Button | Function |
|--------|----------|
| **Save** | Write this panel to disk (highlights when unsaved changes exist) |
| **Undo** | Undo the last change in this panel (`Cmd+Z`) |
| **Redo** | Redo the last undone change (`Cmd+Shift+Z`) |
| **Search** | Open the search bar for this panel (`Cmd+F`) |

### Status Bar

The bottom bar spanning the full width of the window:

```
../.env (modified)  |  42 keys  |  3~  1<  2>  |  5 hidden  | ! 2  |  ../.env.prod
|-- Left file ------|  |- Keys -|  |-- Diff --|  | Collapsed | |Warn|  |-- Right file --|
```

| Segment | Content |
|---------|---------|
| **Left path** | Clamped file path — hover for full path. Shows "(modified)" if unsaved |
| **Key count** | Number of unique keys per panel |
| **Diff summary** | Count of modified (`~`), left-only (`«`), and right-only (`»`) differences |
| **Collapsed** | Number of hidden identical rows (when collapse is active) |
| **Warnings** | Clickable badge showing total warnings — opens the warnings panel |
| **Right path** | Same as left path, for the right file |

### Warnings Panel

An expandable panel at the bottom of the window listing all file issues:

- Unclosed quotes
- BOM detected
- Malformed lines
- Non-standard key names
- Duplicate keys
- Read-only file status

Click any warning to jump to that line in the relevant panel.

## Window Behavior

- **Default size:** 1024 x 768 pixels
- **Panel split:** 50/50 by default with a draggable divider between the panels
- **Horizontal scroll:** Each panel scrolls independently when content exceeds panel width
- **Drag and drop:** Only accepted on the file selection screen. Drops on the comparison view show a "not permitted" toast.
