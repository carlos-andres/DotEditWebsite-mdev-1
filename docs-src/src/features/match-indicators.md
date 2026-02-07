# Match Indicators

Match indicators are a visual feature unique to DotEdit that helps you see which keys correspond across panels when they appear at different line positions.

## The Problem

When using key-based diff, matched keys can appear at very different positions in each file. For example, `REDIS_HOST` might be on line 3 in the left file and line 45 in the right file. While DotEdit correctly identifies them as the same key and shows the diff, it can be hard to visually connect the two entries when they're far apart.

Generic diff tools (like FileMerge or PhpStorm's built-in diff) can't solve this because they're line-based — they don't know which keys correspond across files. DotEdit's key awareness makes this possible.

## How It Works

For **modified** keys that appear at different line positions in the left and right files, DotEdit adds numbered, color-coded indicators in the outer gutter columns:

- A colored number appears next to the key in the **left** gutter margin
- The same colored number appears next to the matching key in the **right** gutter margin
- The number and color pair visually link the two entries

### Example

```
Left file:                              Right file:
  1  APP_URL=http://localhost     ①       1  DB_HOST=production.db
  2  DB_HOST=localhost            ②       2  DB_PORT=5432
  3  REDIS_HOST=127.0.0.1        ③       3  APP_URL=https://prod.com    ①
                                          4  REDIS_HOST=redis.internal   ③
```

In this example:
- `①` connects `APP_URL` (left line 1) to `APP_URL` (right line 3)
- `②` marks `DB_HOST` — it may be modified but at a different position
- `③` connects `REDIS_HOST` (left line 3) to `REDIS_HOST` (right line 4)

## Color Cycling

Match indicators use a rotating palette of 5-6 distinct colors, inspired by IntelliJ's Rainbow Brackets feature. The numbers disambiguate when colors repeat in files with many mispositioned keys.

## When Indicators Appear

Match indicators are shown only for keys that are:

1. **Modified** — the key exists in both files with different values
2. **Mispositioned** — the key appears at a different line number on each side

Keys that are equal, left-only, or right-only do not get match indicators. Modified keys at the same line position also skip indicators since they're already visually adjacent.

## Reducing Visual Noise

Match indicators only appear when they add value — when keys are far apart and the visual connection would otherwise be lost. If you reorganize both files (via [Semantic Reorganization](semantic-reorg.md)), most keys will end up at similar positions, naturally reducing the number of indicators needed.

## Related

- [Key-Based Diff](key-based-diff.md) — The matching algorithm that makes this feature possible
- [Semantic Reorganization](semantic-reorg.md) — Align keys to reduce mispositioned matches
- [Interface Overview](../getting-started/interface-overview.md) — Where indicators appear in the layout
