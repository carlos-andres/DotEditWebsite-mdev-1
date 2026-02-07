# File Handling Settings

These settings control how DotEdit loads, saves, and backs up your `.env` files.

## Backup Before Save

| State | Behavior |
|-------|----------|
| **On** (default) | Creates a `.backup` copy of the original file before saving |
| **Off** | Overwrites the original file directly |

### How Backups Work

When you save a file with backup enabled, DotEdit:

1. Copies the **current file on disk** to a backup path
2. Writes the **new content** to the original path using an atomic write (write to temp file, then rename)

### Backup Naming

The backup file is created in the same directory as the original, with `.backup` appended:

| Original | Backup |
|----------|--------|
| `.env` | `.env.backup` |
| `.env.local` | `.env.local.backup` |
| `.env.production` | `.env.production.backup` |

If a previous backup already exists, it is **overwritten** — only the most recent backup is kept.

### Recovery

Since DotEdit clears the undo stack on save, the backup file is your recovery mechanism if you need to revert to the pre-save state. Simply rename the `.backup` file back to the original name.

> **Tip:** Keep backups enabled (the default) unless you have an external version control system managing your `.env` files.

## Atomic Writes

DotEdit always uses atomic writes for saving:

1. Content is written to a temporary file (`.dotedit_tmp_<uuid>`) in the same directory
2. The temporary file is renamed to replace the original

This approach prevents data corruption if the write is interrupted (e.g., by a crash or power loss). If the write fails, the original file is untouched.

## Permission Preservation

When saving, DotEdit preserves the original file's POSIX permissions. If your `.env` file has restricted permissions (e.g., `0600` — owner read/write only), those permissions survive the save operation.

This is important for production `.env` files where file permissions are part of the security model.

## File Size Limit

DotEdit rejects files larger than **2 MB** during loading. This prevents accidental memory consumption from non-`.env` files. The error message shows the actual file size and the limit.

Legitimate `.env` files are typically well under 100 KB, so this limit should never affect normal usage.

## Accepted File Patterns

DotEdit accepts files matching these patterns:

| Pattern | Examples |
|---------|----------|
| `.env` | Exact match |
| `.env.*` | `.env.local`, `.env.production`, `.env.example` |
| `*.env` | `dashboard.env`, `api-v2.env` |
| `*.env.*` | `dashboard.env.local` |

These patterns are **rejected** regardless of other matches:

| Suffix | Reason |
|--------|--------|
| `.backup` | Backup files (including DotEdit's own backups) |
| `.tmp` | Temporary files |
| `.temp` | Temporary files |

This filtering applies to the file picker, drag-and-drop, and file validation.

## Line Ending Handling

DotEdit normalizes line endings to `\n` (LF) internally for consistent processing. When saving, the **original line ending style** is preserved:

- Files loaded with `\r\n` (CRLF, Windows) are saved with CRLF
- Files loaded with `\n` (LF, Unix/macOS) are saved with LF
- Files loaded with `\r` (CR, classic Mac) are saved with CR

This prevents unwanted line ending changes when comparing or editing files from different operating systems.

## Recent Files

DotEdit remembers recently opened files for quick re-access on the file selection screen.

- Stored in app preferences (UserDefaults)
- Security-scoped bookmarks are used for sandbox-safe access
- **Clear recents** link at the bottom of each recent files list removes the history

## Related

- [Appearance](appearance.md) — Theme, font, and display settings
- [Diff Options](diff-options.md) — Comparison behavior settings
- [File Watching](../features/file-watching.md) — How DotEdit monitors files for external changes
- [File Permissions FAQ](../faq/file-permissions.md) — Troubleshooting permission issues
