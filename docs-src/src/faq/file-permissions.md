# File Permissions

DotEdit runs as a sandboxed macOS application, which means it must request permission to access your files. This page explains how permissions work and how to resolve common issues.

## How File Access Works

### First Time Access

When you open a file through DotEdit's file picker (Browse button) or drag-and-drop, macOS grants DotEdit temporary access to that file. This is the standard macOS sandbox model — apps can only access files the user explicitly provides.

### Security-Scoped Bookmarks

For the **Recent Files** feature, DotEdit uses security-scoped bookmarks. When you open a file, DotEdit saves a bookmark that allows it to access the same file in future sessions without requiring you to re-select it.

This means:
- Files you open through Browse or drag-and-drop are accessible immediately
- Recent files can be re-opened across app launches
- No blanket file system access is required

### Bookmark Expiration

Security-scoped bookmarks can expire if:
- The file is moved to a different location
- The file is deleted and recreated
- macOS revokes the bookmark (rare)

If a bookmark expires, the recent file entry will fail to load. Simply re-select the file through Browse or drag-and-drop to create a new bookmark.

## Permission Prompts

### File Picker

When you use the Browse button, macOS shows a standard Open dialog. Selecting a file grants DotEdit access — no additional prompts are needed.

### Drag and Drop

Dragging a file from Finder onto DotEdit's drop zone grants access through the macOS drag-and-drop permission system. This works the same as the file picker.

### Desktop and Documents

If your `.env` files are in `~/Desktop` or `~/Documents`, macOS may show a system prompt asking if DotEdit should have access to that folder. Click **OK** to grant access.

You can manage these permissions in **System Settings > Privacy & Security > Files and Folders**.

## Saving Files

### Write Permissions

When saving, DotEdit needs write access to:
1. The original file (to replace it)
2. The directory (to create the temporary file for atomic writes)
3. The directory (to create the backup file, if backups are enabled)

If any of these fail, you'll see a save error. Common causes:
- The file or directory is owned by a different user
- The file has read-only permissions
- The directory is on a read-only volume

### Read-Only Files

If DotEdit detects that a file is read-only on load, it shows a warning badge on the filename. You can still view and edit the file in memory, but saving will offer a **Save As** dialog to write to an alternative location.

See [Read-Only Files](read-only-files.md) for more details.

## Troubleshooting

### "Operation not permitted" or "Permission denied"

This usually means macOS sandbox restrictions are blocking access.

**Solutions:**
1. Re-select the file through Browse or drag-and-drop
2. Check System Settings > Privacy & Security > Files and Folders
3. Ensure DotEdit has access to the folder containing your file

### "File not found" for a Recent File

The security-scoped bookmark may have expired, or the file was moved/deleted.

**Solution:** Remove the entry from Recent Files (click "Clear recents") and re-open the file through Browse.

### Cannot Save to Network Volumes

Network volumes may have additional permission restrictions. See [Network Volumes](network-volumes.md).

### Cannot Save to System Directories

DotEdit cannot write to system-protected directories like `/System`, `/usr`, or `/Library`. If your `.env` files are in these locations, copy them to a user-accessible directory first.

## Related

- [Read-Only Files](read-only-files.md) — Handling read-only file situations
- [Network Volumes](network-volumes.md) — Working with files on network drives
- [File Handling](../settings/file-handling.md) — Backup and save settings
