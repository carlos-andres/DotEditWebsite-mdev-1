# Common Errors

A reference for error messages you might encounter in DotEdit and how to resolve them.

## File Loading Errors

### "File not found"

```
File not found: /path/to/.env
```

**Cause:** The file was moved, renamed, or deleted after being selected but before DotEdit could load it.

**Fix:**
- Verify the file exists at the expected path
- Re-select the file through Browse or drag-and-drop
- If loading from Recent Files, the file may have been moved — clear recents and re-open

### "File too large"

```
File too large (5.2 MB): /path/to/file. Maximum is 2 MB.
```

**Cause:** DotEdit has a 2 MB file size limit to prevent excessive memory usage. Legitimate `.env` files are typically under 100 KB.

**Fix:**
- Verify you're opening the correct file — this may not be a `.env` file
- If it is a valid `.env` file over 2 MB, split it into smaller files or trim unnecessary content

### "Not a valid text file (binary content detected)"

```
Not a valid text file (binary content detected): /path/to/file
```

**Cause:** DotEdit detected null bytes in the first 8KB of the file, indicating binary content. This happens when accidentally loading compiled binaries, images, encrypted files, or other non-text content.

**Fix:**
- Make sure you're selecting a `.env` text file, not a binary file
- If the file is encrypted, decrypt it first before opening in DotEdit

### "File is not valid UTF-8"

```
File is not valid UTF-8: /path/to/.env
```

**Cause:** The file uses an encoding other than UTF-8 (e.g., Latin-1, Windows-1252, UTF-16).

**Fix:**
- Convert the file to UTF-8:
  ```bash
  iconv -f WINDOWS-1252 -t UTF-8 .env > .env.utf8
  mv .env.utf8 .env
  ```
- Or open the file in a text editor that can detect and convert encodings (e.g., VS Code, BBEdit)

## File Validation Errors

### "Filename must contain .env"

```
Filename must contain .env (got: config.yml)
```

**Cause:** DotEdit only opens `.env` files. The file you selected doesn't match any accepted pattern (`.env`, `.env.*`, `*.env`, `*.env.*`).

**Fix:** Rename the file to include `.env` in the name, or use a different tool for non-`.env` config files.

### "Files ending in .backup are not allowed"

```
Files ending in .backup are not allowed
```

**Cause:** DotEdit rejects files ending in `.backup`, `.tmp`, or `.temp` to prevent accidentally loading temporary or backup files.

**Fix:** If you need to view a backup file, rename it first:
```bash
cp .env.backup .env.restored
```

### "Same file selected for both panels"

```
Same file selected for both panels. Choose a different file.
```

**Cause:** You selected the same file path for both the left and right panels.

**Fix:** Select a different file for one of the panels. If you want to compare a file against itself (to check for duplicates), make a copy first.

## Save Errors

### "Failed to save file"

```
Failed to save file: <system error message>
```

**Cause:** The atomic write (write temp file, then rename) failed. Common reasons:
- Disk is full
- Directory permissions prevent file creation
- Network volume disconnected during write

**Fix:**
- Check available disk space: `df -h`
- Check directory permissions: `ls -la $(dirname /path/to/.env)`
- If on a network volume, verify the connection
- Try saving to a different location using Save As

### "Failed to create backup"

```
Failed to create backup: <system error message>
```

**Cause:** DotEdit couldn't create the `.backup` file before saving. The save itself has not been attempted yet.

**Fix:**
- Check directory permissions and disk space
- Disable backups in Settings if the backup isn't needed
- Check if an existing `.backup` file is locked or read-only

### "Failed to encode content as UTF-8"

```
Failed to encode content as UTF-8
```

**Cause:** The in-memory content couldn't be converted to UTF-8 bytes for writing. This is extremely rare and usually indicates corrupted in-memory state.

**Fix:** Reload the file from disk (`Cmd+R`) and retry your edits.

## File Watching Errors

### "File changed on disk" Dialog

This is not an error — it's a notification that the file was modified by another program while you have unsaved changes. See [File Watching](../features/file-watching.md) for details.

### Network Volume Disconnection

```
Failed to read file: <error> — network volume may be disconnected
```

**Cause:** The network volume hosting the file became unavailable.

**Fix:**
- Reconnect to the network volume
- Use `Cmd+R` to reload after reconnecting
- Your in-memory edits are preserved

## Warning Messages

These appear in the warnings panel and are informational rather than fatal:

| Warning | Meaning | Action |
|---------|---------|--------|
| **File has UTF-8 BOM** | A byte order mark was detected and stripped | Save the file to remove the BOM permanently |
| **File is read-only** | The file has restricted write permissions | Use Save As to save to a different location |
| **Unclosed quote** | A quote was opened but not closed before EOF | Add the missing closing quote |
| **Duplicate key** | A key appears more than once in the file | Use Dedup to remove duplicates |
| **Non-standard key** | Key contains dots, hyphens, or non-ASCII characters | Usually harmless; check your dotenv library's compatibility |
| **Malformed line** | Line has no `=` sign and is not a comment or blank | Fix the line or remove it |

## Drag and Drop Errors

### "Action not permitted" (toast)

**Cause:** You tried to drag a file onto the comparison view. Drag-and-drop only works on the file selection screen.

**Fix:** Use the Back button to return to file selection, then drag your file onto the drop zone.

### Drop Rejected (no feedback)

**Cause:** You dropped a non-`.env` file onto a drop zone.

**Fix:** Ensure the file matches an accepted pattern. See [File Handling](../settings/file-handling.md) for accepted patterns.

## Related

- [File Permissions](file-permissions.md) — Sandbox and access issues
- [Network Volumes](network-volumes.md) — Network-specific issues
- [Read-Only Files](read-only-files.md) — Working with read-only files
- [Encoding & BOM](../file-format/encoding-bom.md) — Encoding details
