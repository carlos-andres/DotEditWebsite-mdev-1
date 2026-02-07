# Parsing Rules

DotEdit parses `.env` files according to the de facto dotenv convention. There is no formal `.env` specification — DotEdit follows the patterns established by popular dotenv libraries across Node.js, Python, Ruby, and PHP.

## Line Types

Every line in a `.env` file is classified as one of four types:

| Type | Example | Diff behavior | Editable |
|------|---------|---------------|----------|
| **Key-value** | `DB_HOST=localhost` | Compared by key match | Yes |
| **Comment** | `# Database settings` | Excluded from key-based diff | Yes |
| **Blank** | *(empty line)* | Excluded from diff | N/A |
| **Malformed** | `this has no equals sign` | Highlighted as warning | Yes |

## Key-Value Parsing

A key-value line is any line that contains an `=` sign and is not a comment.

### Key Detection

The **key** is everything before the first `=`, with surrounding whitespace trimmed:

```
DB_HOST=localhost        → key: "DB_HOST"
  DB_PORT = 3306         → key: "DB_PORT"
DB_URL=postgres://u:p@h  → key: "DB_URL"  (only first = is the delimiter)
```

### Value Detection

The **value** is everything after the first `=`. This means values can contain `=` characters:

```
DB_URL=postgres://user:pass@host:5432/db?sslmode=require
# key: "DB_URL"
# value: "postgres://user:pass@host:5432/db?sslmode=require"
```

### Whitespace Around `=`

Whitespace around the `=` delimiter is stripped for comparison purposes. Both of these are treated as having the same key and value:

```
DB_HOST = localhost
DB_HOST=localhost
```

### Empty Values

A key with nothing after the `=` is valid and treated as an empty value:

```
SECRET_KEY=
# key: "SECRET_KEY", value: "" (empty string)
```

This is distinct from a missing key. In the diff, an empty value on one side and a missing key on the other shows as a difference.

## Comments

Lines starting with `#` (after whitespace trimming) are classified as comments:

```
# This is a comment
  # This is also a comment (leading whitespace is fine)
```

Comments are:
- **Displayed** in both panels
- **Editable** — you can modify comment text
- **Excluded from key-based diff** — comments do not participate in the matching algorithm
- **Included in sequential diff** — in line-by-line mode, comments are compared by position

### Inline Comments

For **unquoted** values, a `#` after the value is considered part of the value (following standard dotenv behavior):

```
DB_HOST=localhost # production server
# value: "localhost # production server" (the # is part of the value)
```

Inside **quoted** values, `#` is always literal:

```
DB_PASS="my#secret"
# value: "my#secret"
```

## Blank Lines

Empty lines (or lines containing only whitespace) are classified as blank. They are preserved in the file and displayed in the comparison view, but are excluded from the key-based diff.

## Malformed Lines

Lines that are not comments, not blank, and do not contain an `=` sign are classified as malformed:

```
this is not a valid entry
MISSING_EQUALS
```

Malformed lines trigger a warning in the [warnings panel](../getting-started/interface-overview.md) with an orange highlight. They are still displayed and editable — you can fix them by adding an `=` sign.

## Key Validation

DotEdit follows the standard key format: `[A-Za-z_][A-Za-z0-9_]*`. Keys that use non-standard characters (dots, hyphens, unicode) trigger a `Non-standard key` warning but are still parsed and compared normally.

```
# Standard keys (no warning):
DB_HOST=localhost
APP_URL=http://localhost
_PRIVATE=true

# Non-standard keys (warning, but still parsed):
app.url=http://localhost
db-host=localhost
```

> **Note:** Non-standard keys work fine in DotEdit. The warning exists because some dotenv libraries may not handle these key formats.

## Variable Interpolation

DotEdit displays `${VAR}` syntax as-is without resolving it. DotEdit is a file editor, not an environment loader:

```
BASE_URL=https://example.com
API_URL=${BASE_URL}/api
# Displayed literally as: ${BASE_URL}/api
```

## Duplicate Keys

When the same key appears more than once in a file, all occurrences are displayed with a visual highlight and a warning. The [key-based diff](../features/key-based-diff.md) matches against the first occurrence of each key.

Use the [Dedup](../features/collapse-dedup.md) feature to clean up duplicate keys.

## Related

- [Quoted & Multiline Values](quoted-multiline.md) — How quoted and multiline values are handled
- [Export Prefix](export-prefix.md) — How `export KEY=value` lines are treated
- [Encoding & BOM](encoding-bom.md) — Character encoding and byte order mark handling
