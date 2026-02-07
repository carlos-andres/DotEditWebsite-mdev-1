# File Watching

DotEdit monitors both loaded files for external changes using macOS file system events (FSEvents). When another application or process modifies a file that's open in DotEdit, you'll be notified immediately.

## How It Works

When you load files into the comparison view, DotEdit starts watching both file paths using `DispatchSource` file system monitoring. It listens for write, rename, and delete events.

### Clean Panel (No Unsaved Changes)

If the file changes externally and the panel has **no unsaved changes**, DotEdit automatically reloads the file in the background. A subtle flash indicates the reload occurred.

This is the most common case — when you edit a file in another editor and switch back to DotEdit, it silently picks up the changes.

### Dirty Panel (Unsaved Changes Exist)

If the panel **has unsaved changes** when an external modification is detected, DotEdit shows a confirmation dialog:

```
Left file changed on disk
/path/to/.env was modified externally.
You have unsaved changes.

[ Reload from Disk ]  [ Keep My Version ]
```

| Option | Effect |
|--------|--------|
| **Reload from Disk** | Discards your in-memory changes and loads the latest version from disk |
| **Keep My Version** | Ignores the external change and keeps your edits |

## Manual Reload

You can manually reload both files at any time:

- Press `Cmd+R`
- Click the **Reload** button (circular arrow) in the toolbar

If either panel has unsaved changes, the same confirmation dialog appears before reloading.

## Suppression During Save

When DotEdit saves a file, it **suppresses** the file watcher temporarily. This prevents DotEdit's own save operation from triggering a "file changed externally" notification. The watcher resumes automatically after a brief delay (~50ms).

## Symlink Handling

If your `.env` file is a symlink, DotEdit resolves the symlink and watches the real file path. Changes to the underlying file are detected correctly.

## File Deletion

If a watched file is deleted while open in DotEdit, the file watcher detects this and shows an error notification. Your in-memory content is preserved — you can use **Save** (which effectively becomes **Save As**) to write it to a new location.

## Debouncing

File system events can fire rapidly (e.g., when an editor performs an atomic write by creating a temp file and renaming). DotEdit debounces incoming events to avoid redundant reloads and flickering.

## Limitations

- File watching relies on macOS FSEvents, which may not work reliably on all network volumes. See [Network Volumes](../faq/network-volumes.md).
- If a file is replaced (deleted and recreated) rather than modified in place, the watcher may need to be re-established. DotEdit handles this automatically by reconnecting the watcher.

## Related

- [Inline Editing](inline-editing.md) — Unsaved changes interact with file watching
- [File Handling Settings](../settings/file-handling.md) — Backup behavior before saving
- [Network Volumes](../faq/network-volumes.md) — Limitations on network drives
