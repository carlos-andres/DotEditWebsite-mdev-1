# Read-Only Files

DotEdit handles read-only files gracefully, allowing you to view and compare them even when saving isn't possible.

## Detection

When DotEdit loads a file, it checks the file's write permissions using `FileManager.isWritableFile`. If the file is not writable, DotEdit:

1. Sets the file as **read-only** internally
2. Shows a **warning badge** on the filename in the interface
3. Lists a "Read-Only" warning in the warnings panel

## What You Can Still Do

Read-only status only affects saving. You can still:

- **View** the file normally in the comparison view
- **Compare** it against another file
- **Edit** values in memory (changes are held in memory, not on disk)
- **Transfer** values using gutter arrows
- **Reorganize** and **dedup** in memory
- **Search** across the file
- **Copy** values to the other panel (which may be writable)

## Saving Read-Only Files

When you attempt to save a read-only panel, DotEdit shows a **Save As** dialog instead of writing to the original path. The dialog lets you choose:

- A different file name
- A different directory
- An alternative extension (`.txt`, `.ini`, etc.)

This way, your edits aren't lost — they're saved to a new location.

## Common Scenarios

### Comparing a Template Against a Working File

Many projects include a `.env.example` that's committed to version control with restricted permissions. You can open it in DotEdit to compare against your local `.env`:

```
Left:  .env.example  (read-only, committed to git)
Right: .env          (writable, your local config)
```

Transfer values from the template to your working file using `»` arrows. The writable panel saves normally, while the read-only template stays untouched.

### Files on Read-Only Volumes

If you're comparing files from a read-only disk image (DMG), a read-only network share, or a mounted backup:

- Both panels may be read-only
- Use Save As to write to a different location
- Consider copying the files locally before editing

### Permission Issues vs Read-Only

If a file shows as read-only but shouldn't be, check:

```bash
# View file permissions:
ls -la .env

# Make writable:
chmod u+w .env
```

Then reload the file in DotEdit (`Cmd+R`). The read-only badge should disappear.

## Root-Owned Files

Files owned by `root` or another user are typically read-only for your user account. To edit them:

1. Copy the file to a location you own
2. Edit in DotEdit
3. Copy it back with appropriate permissions:
   ```bash
   sudo cp .env /etc/app/.env
   ```

DotEdit does not request elevated privileges — it runs as your user account.

## Backup Behavior

DotEdit does not create backup files for read-only saves (via Save As), since:
- The original file isn't being modified
- The new file location may not have an existing version to back up

## Related

- [File Permissions](file-permissions.md) — Sandbox and permission details
- [File Handling](../settings/file-handling.md) — Backup and save settings
- [Common Errors](common-errors.md) — Error messages related to file access
