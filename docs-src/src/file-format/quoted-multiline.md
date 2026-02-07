# Quoted & Multiline Values

DotEdit supports single-quoted, double-quoted, and backtick-quoted values, as well as multiline values that span multiple lines within quotes.

## Quote Styles

| Style | Syntax | Behavior |
|-------|--------|----------|
| **Unquoted** | `KEY=value` | Literal value, entire remainder after `=` |
| **Single-quoted** | `KEY='value'` | Literal, no interpolation |
| **Double-quoted** | `KEY="value"` | Escape sequences and interpolation |
| **Backtick-quoted** | `` KEY=`value` `` | Multiline support (dotenvx convention) |

## Unquoted Values

The most common format. Everything after the `=` is the value:

```
DB_HOST=localhost
APP_URL=http://localhost:3000
API_KEY=abc123def456
```

Unquoted values include everything on the line — including spaces and `#` characters:

```
GREETING=Hello World
DB_PASS=my#secret
# value of GREETING: "Hello World"
# value of DB_PASS: "my#secret"
```

## Single-Quoted Values

Wrapped in single quotes. The content is literal — no escape sequences are processed:

```
DB_PASS='my "special" password'
# Parsed value: my "special" password
```

Single quotes are useful when values contain double quotes or special characters.

## Double-Quoted Values

Wrapped in double quotes. Escape sequences like `\n`, `\t`, and `\\` are recognized by dotenv libraries at runtime, though DotEdit stores the raw content as-is:

```
MESSAGE="Hello\nWorld"
# Stored value: Hello\nWorld (literal backslash-n in DotEdit)
# Runtime value (via dotenv): Hello[newline]World
```

## Backtick-Quoted Values

A convention from dotenvx for multiline content:

```
DESCRIPTION=`This is a
multiline value
with backticks`
```

## Value Comparison

DotEdit compares parsed values — the content inside the quotes, without the quote characters themselves:

```
# These are considered EQUAL — same parsed value "my secret":
DB_PASS="my secret"
DB_PASS='my secret'
```

The quote style is preserved on each side but doesn't affect the diff result.

## Multiline Values

### Detection

A multiline value is detected when:

1. The value starts with a quote character (`"`, `'`, or `` ` ``)
2. The closing quote is **not** found on the same line

DotEdit reads subsequent lines until it finds the matching closing quote.

### Example

```
PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----
MIIBogIBAAJBALRiMLAHudeSA/x3hB2f+2NRkJLA
hN1gxVMq2g9+JCt0Gvcopq8hfFN0ZFg
-----END RSA PRIVATE KEY-----"
```

This is parsed as a single entry with key `PRIVATE_KEY`. The entire block — from the opening `"` on line 1 through the closing `"` on line 4 — is one multiline value.

### Display

In the comparison view, multiline entries appear as a single row. The gutter shows the line range (e.g., `1-4` for a value spanning lines 1 through 4).

### Transfer

Multiline values transfer as a complete block — one click in the gutter moves the entire value. This counts as a single undo step.

### Reorganization

During [Semantic Reorganization](../features/semantic-reorg.md), multiline entries move as a unit with their key. The block stays intact.

## Unclosed Quotes

If a quote opens but never closes (reaching the end of file), DotEdit:

1. Parses the remainder of the file as the value content
2. Adds an **Unclosed quote** warning to the warnings panel
3. Highlights the line with an orange/yellow background

```
API_KEY="this quote never closes
DB_HOST=localhost
# Warning: unclosed quote starting at API_KEY
# Everything after the opening " is treated as part of the value
```

This is a common mistake when editing `.env` files manually, and the warning helps you catch it.

## Related

- [Parsing Rules](parsing-rules.md) — General line parsing and key detection
- [Export Prefix](export-prefix.md) — How `export` interacts with quoted values
- [Inline Editing](../features/inline-editing.md) — Editing quoted and multiline values
