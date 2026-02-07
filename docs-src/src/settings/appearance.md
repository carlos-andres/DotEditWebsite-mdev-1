# Appearance Settings

DotEdit's appearance settings let you customize the visual presentation of the editor to match your preferences and environment.

## Accessing Settings

Open Settings from:
- The **gear icon** in the toolbar (comparison view)
- The **gear icon** on the file selection screen

All settings apply immediately — there's no "Apply" or "Save" button.

## Theme

| Option | Behavior |
|--------|----------|
| **System** (default) | Follows your macOS appearance setting (light or dark) |
| **Light** | Always uses the light theme |
| **Dark** | Always uses the dark theme |

DotEdit adapts its entire interface to the selected theme: panels, gutter, toolbar, status bar, and diff colors all respond to the theme choice.

The diff highlighting colors are calibrated for both themes:
- **Blue** for modified entries works in both light and dark modes
- **Green** for left-only and right-only entries is adjusted for contrast
- **Orange** for warnings maintains visibility in both themes

## Editor Font Family

DotEdit defaults to **SF Mono** (Apple's system monospace font). You can switch to any monospace font installed on your Mac:

- **System** — Uses SF Mono (the default)
- Any installed monospace font (e.g., JetBrains Mono, Fira Code, Menlo, Monaco, Source Code Pro)

DotEdit enumerates available monospace fonts from your system via the macOS font manager. The font picker in Settings shows all detected monospace fonts.

> **Note:** Only the editor panels and gutter line numbers use the selected font. UI elements like toolbar labels, status bar text, and dialogs use the system font for consistency with macOS conventions.

If a previously selected font is uninstalled, DotEdit falls back gracefully to the system monospace font.

## Font Size

Adjust the editor font size from **12pt to 20pt**. You can change it from:

- **Settings > Font Size** — direct selection
- **Toolbar > Font Size dropdown** — quick access during comparison
- **Keyboard shortcuts:**

| Shortcut | Action |
|----------|--------|
| `Cmd+=` or `Cmd++` | Increase font size by 1pt |
| `Cmd+-` | Decrease font size by 1pt |
| `Cmd+0` | Reset to default (12pt) |

Font size applies to both editor panels and the gutter line numbers.

## Word Wrap

| State | Behavior |
|-------|----------|
| **Off** (default) | Long lines extend beyond the panel width; horizontal scrollbar appears |
| **On** | Long lines wrap within the panel width |

Toggle word wrap from Settings or the **wrap** button in the toolbar.

Word wrap is useful for files with very long values (e.g., base64 encoded secrets, JWT tokens) where horizontal scrolling becomes cumbersome.

## Line Numbers

| State | Behavior |
|-------|----------|
| **On** (default) | Line numbers are visible in the gutter for both panels |
| **Off** | Line numbers are hidden; gutter shows only transfer arrows and status symbols |

Toggle from Settings or the **#** button in the toolbar. Hiding line numbers gives more horizontal space to the editor panels.

## Settings Persistence

All appearance settings are saved to UserDefaults and persist across app launches:

- Theme choice
- Font family
- Font size
- Word wrap state
- Line number visibility

## Related

- [Diff Options](diff-options.md) — Settings that affect comparison behavior
- [File Handling](file-handling.md) — Backup and save settings
- [Interface Overview](../getting-started/interface-overview.md) — Where settings controls appear in the UI
