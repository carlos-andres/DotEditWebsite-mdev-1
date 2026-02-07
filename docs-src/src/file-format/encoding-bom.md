# Encoding & BOM

DotEdit handles character encoding and byte order marks (BOM) to ensure your `.env` files are parsed correctly, even when they come from different operating systems or editors.

## UTF-8 Encoding

DotEdit reads and writes all files as **UTF-8**. This is the standard encoding for `.env` files across all platforms and dotenv libraries.

If a file cannot be decoded as UTF-8, DotEdit shows an error: `"File is not valid UTF-8"` and refuses to load it.

## Byte Order Mark (BOM)

### What Is a BOM?

A UTF-8 BOM is a 3-byte sequence (`EF BB BF`) at the very beginning of a file. Some Windows editors (notably older versions of Notepad) add it automatically. The BOM is invisible in most text editors but can cause real problems.

### The Problem

When a BOM is present, the first key in the file gets corrupted. The BOM bytes become part of the key name:

```
# File with BOM (invisible bytes shown as [BOM]):
[BOM]DB_HOST=localhost
DB_PORT=3306
```

The parser sees the key as `\uFEFFDB_HOST` instead of `DB_HOST`. This causes:

- The key doesn't match `DB_HOST` in the other file
- dotenv libraries may fail to find the variable
- The corrupted key is invisible in most editors

### How DotEdit Handles It

When DotEdit loads a file with a BOM:

1. **Detection:** The BOM is detected during file loading
2. **Warning:** A toast notification appears: `"File has UTF-8 BOM"`
3. **Stripping:** The BOM is automatically stripped before parsing, so the first key is read correctly
4. **Warning badge:** The BOM warning appears in the warnings panel

The BOM is stripped only in memory for correct parsing. The file on disk is not modified until you save.

## Line Endings

### Detection

DotEdit detects the line ending style used in each file:

| Style | Characters | Origin |
|-------|-----------|--------|
| LF (`\n`) | Unix/macOS/Linux | Most common for `.env` files |
| CRLF (`\r\n`) | Windows | Files created on Windows |
| CR (`\r`) | Classic Mac OS | Rare, legacy systems |

### Normalization

On load, all line endings are normalized to `\n` (LF) for internal processing. This means the comparison view always works with consistent line endings, regardless of the original file format.

### Preservation on Save

When saving, DotEdit preserves the **original line ending style** of each file. If a file was loaded with CRLF line endings, it is saved with CRLF line endings. This prevents unnecessary diffs when files are shared across operating systems.

## Binary File Detection

DotEdit is designed for text files only. If you attempt to load a file that contains null bytes (a strong indicator of binary content), DotEdit rejects it with an error:

```
Not a valid text file (binary content detected): /path/to/file
```

DotEdit checks the first 8KB of the file for null bytes. This catches accidentally loading compiled binaries, images, or other non-text files without reading the entire file.

## File Size Limit

DotEdit enforces a **2 MB** file size limit. Files larger than 2 MB are rejected with an error showing the actual file size. This is a generous limit — legitimate `.env` files are typically well under 100 KB. The guard prevents accidental loading of large files that would consume excessive memory.

## Related

- [Parsing Rules](parsing-rules.md) — How file content is parsed after encoding handling
- [Common Errors](../faq/common-errors.md) — Error messages related to encoding
- [File Handling](../settings/file-handling.md) — Save and backup settings
