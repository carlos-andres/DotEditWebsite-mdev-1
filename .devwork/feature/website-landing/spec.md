# Spec: DotEdit Marketing Website + Documentation

> Generated via brainstorming interview — 2026-02-07

---

## 1. Project Overview

**Goal:** Build a single-page marketing website for DotEdit (a native macOS `.env` file diff & editor app) with a separate documentation section. The site explains what DotEdit does, shows it in action, and drives downloads.

**Target audience:** Developers managing multiple environments (dev/staging/prod), homelab admins, small teams working with `.env` configs.

**Domain:** `dotedit.app` (or similar, TBD — structure is domain-agnostic)

**Hosting:** Siteground shared hosting — static files uploaded via SFTP. No server runtime.

---

## 2. Tech Stack

| Layer | Tool | Version | Purpose |
|-------|------|---------|---------|
| **Site generator** | Astro | 5.x | Static site, zero JS by default, content-first |
| **Styling** | Tailwind CSS | 4.x | Utility-first, `class` dark mode strategy |
| **Interactions** | Vanilla JS | ES2022 | Cursor, scroll reveals, parallax, copy sparkle |
| **Documentation** | mdBook | latest | Markdown → static HTML docs site |
| **Fonts** | Google Fonts | — | Instrument Serif, Inter, JetBrains Mono |
| **Icons** | Lucide or inline SVG | — | Minimal icon set for features |

**No frontend framework** (no React, Vue, Svelte). Pure Astro components + HTML.

### Build & Deploy

```bash
# Build docs (mdBook → public/docs/)
npm run build:docs

# Build everything (Astro landing + static docs)
npm run build

# Output: dist/ folder → upload to Siteground via SFTP
```

---

## 3. Decision Matrix: Documentation Tooling

| Criteria | mdBook | Starlight | VitePress | MkDocs Material |
|----------|--------|-----------|-----------|-----------------|
| **Install** | `brew install mdbook` (single binary) | `npm create astro` + config | `npm init` + config | `pip install` + Python env |
| **Config** | One `book.toml` | `astro.config.mjs` + Starlight config | `config.mts` | `mkdocs.yml` |
| **Input** | Markdown + `SUMMARY.md` | Markdown + frontmatter | Markdown + sidebar config | Markdown + nav config |
| **Output** | Static HTML/CSS/JS | Static HTML/CSS/JS | Static HTML/CSS/JS | Static HTML/CSS/JS |
| **Default look** | Clean GitBook-style, zero theming | Polished but needs color override | Clean but needs config | Very polished, needs Python |
| **Search** | Built-in (elasticlunr) | Built-in (Pagefind) | Built-in (MiniSearch) | Built-in (lunr) |
| **Dark mode** | Built-in toggle | Built-in | Built-in | Built-in |
| **Dependencies** | None (standalone Rust binary) | Node.js + Astro ecosystem | Node.js + Vite ecosystem | Python + pip |
| **Regenerate** | `mdbook build` (< 1 sec) | `npm run build` (seconds) | `npm run build` (seconds) | `mkdocs build` (seconds) |
| **Learning curve** | Minimal — TOML + SUMMARY.md | Medium — Astro + Starlight API | Medium — Vue ecosystem | Low — YAML + Markdown |

### Decision: **mdBook**

**Rationale:** Zero dependencies beyond the binary. No theming needed — the default look is clean and GitBook-like out of the box. One command regenerates everything. The landing page (Astro) and docs (mdBook) stay fully decoupled — no shared build pipeline, no version conflicts, no complexity.

### mdBook Usage Reference

```bash
# Install
brew install mdbook

# Initialize (one-time)
cd docs-src && mdbook init

# Project structure
docs-src/
├── book.toml          # Config: title, authors, output dir
└── src/
    ├── SUMMARY.md     # Table of contents (defines sidebar nav)
    ├── getting-started/
    │   ├── installation.md
    │   ├── quick-start.md
    │   └── interface-overview.md
    ├── features/
    │   ├── key-based-diff.md
    │   └── ...
    └── ...

# book.toml
[book]
title = "DotEdit Documentation"
authors = ["DotEdit"]
language = "en"
src = "src"

[output.html]
default-theme = "light"
preferred-dark-theme = "ayu"
git-repository-url = "https://github.com/xxx/DotEdit"

# Build → outputs to docs-src/book/
mdbook build

# Serve locally with hot reload
mdbook serve --open

# Regenerate anytime
mdbook build && cp -r docs-src/book/* public/docs/
```

---

## 4. Color System

**Palette: 3 colors only** — Blue accent + Neutral grays + Base white/black.

### Light Mode

| Token | Hex | Usage | AAA Contrast vs White |
|-------|-----|-------|-----------------------|
| `--color-text` | `#111827` (gray-900) | Body text | 15.4:1 |
| `--color-text-secondary` | `#4B5563` (gray-600) | Secondary text | 7.5:1 |
| `--color-text-muted` | `#9CA3AF` (gray-400) | Captions, hints | 3.0:1 (large text only) |
| `--color-accent` | `#2563EB` (blue-600) | CTAs, links, interactive | 4.6:1 (AA large) |
| `--color-accent-hover` | `#1D4ED8` (blue-700) | Hover states | 6.4:1 |
| `--color-bg` | `#FFFFFF` | Page background | — |
| `--color-bg-subtle` | `#F8FAFC` (slate-50) | Section alternation | — |
| `--color-border` | `#E5E7EB` (gray-200) | Subtle borders | — |

### Dark Mode

| Token | Hex | Usage | AAA Contrast vs bg |
|-------|-----|-------|--------------------|
| `--color-text` | `#F1F5F9` (slate-100) | Body text | 14.8:1 |
| `--color-text-secondary` | `#94A3B8` (slate-400) | Secondary text | 7.1:1 |
| `--color-accent` | `#60A5FA` (blue-400) | CTAs, links | 8.1:1 |
| `--color-accent-hover` | `#93C5FD` (blue-300) | Hover states | 10.8:1 |
| `--color-bg` | `#0F172A` (slate-900) | Page background | — |
| `--color-bg-subtle` | `#1E293B` (slate-800) | Section alternation | — |
| `--color-border` | `#334155` (slate-700) | Subtle borders | — |

All text/background combinations meet **WCAG AAA** (7:1+) for normal text. Accent color used on interactive elements only — paired with underline for links or used on dark/contrasting backgrounds.

---

## 5. Typography

| Role | Font | Weight | Size (desktop) | Size (mobile) |
|------|------|--------|----------------|---------------|
| Hero headline | Instrument Serif | 400 | 56px / 1.1 | 36px / 1.15 |
| Section headlines | Instrument Serif | 400 | 36px / 1.2 | 28px / 1.25 |
| Body | Inter | 400 | 18px / 1.6 | 16px / 1.6 |
| Body bold | Inter | 600 | 18px / 1.6 | 16px / 1.6 |
| Small/caption | Inter | 400 | 14px / 1.5 | 13px / 1.5 |
| Nav links | Inter | 500 | 15px / 1.0 | 15px / 1.0 |
| Code snippets | JetBrains Mono | 400 | 14px / 1.6 | 13px / 1.6 |

Serif/sans contrast (Instrument Serif + Inter) follows the folk.app approach — elegant headlines, clean functional body text.

---

## 6. Page Structure

Single page, ~7 scroll sections at `max-width: 1200px` centered.

### 6.1 Nav (sticky, 64px height)

- **Left:** DotEdit logo (app icon 28px + "DotEdit" wordmark in Inter 600)
- **Right:** "Docs" text link → `/docs/` + "Download" blue pill button + dark mode toggle (sun/moon icon)
- **Behavior:** `backdrop-filter: blur(12px)` + `background: rgba(255,255,255,0.8)` on scroll (dark mode inverted)
- **Mobile:** Hamburger menu for links, download button always visible

### 6.2 Hero

- **Headline** (Instrument Serif, 56px): "Compare your .env files, side by side"
- **Subtext** (Inter 18px, `--color-text-secondary`): "A native macOS app for diffing, syncing, and organizing environment files. See what changed. Transfer what you need."
- **CTA row:**
  - Primary: "Download for macOS" (blue solid pill, arrow-down icon)
  - Secondary: `brew install --cask dotedit` (outlined pill, monospace text, click-to-copy with dot sparkle)
- **Note** (Inter 14px, muted): "Free and open source · macOS 15+ · Apple Silicon & Intel"
- **Spacing:** 120px top padding (below nav), 80px bottom before screenshot

### 6.3 Hero Screenshot

- Full-width (max 1100px) app screenshot — side-by-side diff comparison view
- Styled as macOS window: rounded corners (12px), subtle `box-shadow` (0 24px 48px rgba(0,0,0,0.12))
- Scroll-triggered: fades in from 24px below, 600ms ease-out
- Parallax: moves at 0.85x scroll speed
- Shadow shifts 2-3px with mouse position (subtle depth illusion)

### 6.4 Features Strip (3 cards, horizontal row)

- **Key-Based Diff:** "Matches by key name, not line position. Reordered files compare correctly." — icon: `GitCompareArrows` or similar
- **Gutter Transfers:** "Move values between files with one click. Update existing keys or append new ones." — icon: `ArrowLeftRight`
- **Semantic Reorg:** "Auto-group keys by prefix. Preview the layout before applying." — icon: `LayoutList`
- **Card style:** No border, no background — just icon (24px, blue accent) + title (Inter 600, 18px) + description (Inter 400, 16px, secondary)
- **Layout:** 3-column grid, 32px gap
- **Animation:** Scroll-triggered staggered reveal (100ms apart), fade-in + translateY(24px)

### 6.5 Second Screenshot + Caption

- App screenshot showing gutter transfers or reorg in action
- Left-aligned layout: screenshot (60% width) + right-aligned caption text (40%)
- Caption: brief explanation of what the screenshot shows
- Subtle background gradient shift begins here (`--color-bg` → `--color-bg-subtle`)
- Scroll-triggered fade-in

### 6.6 Trust Strip

- Single centered line: "Native macOS · SwiftUI · 242 tests · Open source"
- Inter 14px, `--color-text-muted`
- Optional: GitHub stars badge via `shields.io`
- Separator: thin `1px` top border in `--color-border`

### 6.7 Download CTA (repeated)

- **Headline** (Instrument Serif, 36px): "Ready to tame your .env files?"
- Same two CTA buttons from hero (download + Homebrew)
- Centered, generous padding (80px top/bottom)

### 6.8 Footer

- Three columns:
  - **Product:** Download, Documentation, GitHub, Changelog
  - **Legal:** MIT License, Privacy Policy
  - **Built with:** "Made with Astro, SwiftUI, and focus"
- Copyright: "© 2026 DotEdit"
- Muted text, `--color-text-muted`, Inter 14px
- Top border: `1px` `--color-border`

---

## 7. Micro-Interactions

### 7.1 Custom Cursor

- Default cursor hidden via `cursor: none` on `<body>`
- Replaced with 12px blue dot (`border-radius: 50%`, `--color-accent`)
- **Hover on interactive elements:** dot scales to 40px, applies `mix-blend-mode: difference`
- **Movement:** smooth trailing via `lerp()` at 60fps (`requestAnimationFrame`)
- **Mobile/touch:** disabled entirely — `@media (pointer: coarse)` restores native cursor
- **Reduced motion:** `@media (prefers-reduced-motion: reduce)` restores native cursor

### 7.2 Scroll-Triggered Reveals

- Each section: `opacity: 0` + `translateY(24px)` → `opacity: 1` + `translateY(0)`
- Triggered via `IntersectionObserver`, `threshold: 0.15`
- Duration: 600ms, `ease-out`
- Feature cards: stagger 100ms (left → center → right)
- **Reduced motion:** elements visible immediately, no transition

### 7.3 Background Gradient Shift

- Hero → Features: `--color-bg` (pure white/dark)
- Features → Second Screenshot: transitions to `--color-bg-subtle` (cool blue-gray tint)
- CTA → Footer: back to `--color-bg`
- Achieved via CSS `background-color` on `<section>` elements — no JS
- Transition between sections is smooth via adjacent section colors

### 7.4 Screenshot Parallax

- Hero screenshot: `transform: translateY(calc(var(--scroll) * 0.15))` — moves 15% slower than scroll
- Shadow follows mouse position (max 3px shift in X/Y via `mousemove` listener)
- **Reduced motion:** static positioning, fixed shadow

### 7.5 Copy Dot Sparkle

- Trigger: click on Homebrew/download code snippet
- **Text feedback:** content swaps to "Copied!" with checkmark icon, reverts after 2s
- **Dot explosion:** 8-12 dots (3-4px diameter) burst from click origin
  - Blue accent color at varying opacities (0.4–1.0)
  - Fly 20-40px outward in random radial directions
  - 400ms duration, fade to opacity 0
  - CSS `@keyframes` for animation, JS spawns + removes DOM elements
- **Reduced motion:** text swap only, no particle animation

---

## 8. Accessibility (WCAG AAA)

### Color & Contrast
- All text/background pairs meet 7:1 minimum contrast ratio (AAA)
- Interactive accent color (blue) meets 4.5:1 on background — supplemented with underline for links
- Focus indicators: 3px solid blue outline with 2px offset, visible in both themes

### Semantic HTML
- `<header>`, `<nav>`, `<main>`, `<section>`, `<footer>` landmarks
- All sections have `aria-labelledby` pointing to their heading
- Skip-to-content link as first focusable element
- Images: descriptive `alt` text on screenshots, decorative SVGs use `aria-hidden="true"`

### Keyboard Navigation
- Full tab navigation through all interactive elements
- `:focus-visible` styling (no focus ring on mouse click, visible on keyboard)
- Download/copy buttons operable via Enter and Space
- Dark mode toggle accessible via keyboard
- Nav links have clear focus order

### Motion & Preferences
- `prefers-reduced-motion: reduce` disables all animations (cursor, parallax, reveals, sparkle)
- `prefers-color-scheme` respected for initial theme (overridable via toggle)
- No auto-playing video or infinite animations

### Screen Readers
- Landmark roles explicit
- CTA buttons have descriptive `aria-label` where icon-only
- Copy confirmation announced via `aria-live="polite"` region
- Dark mode toggle state announced

---

## 9. Documentation Structure (/docs/)

Powered by **mdBook**. Source in `docs-src/`, output copied to `public/docs/`.

### SUMMARY.md (table of contents)

```markdown
# Summary

# Getting Started
- [Installation](getting-started/installation.md)
- [Quick Start](getting-started/quick-start.md)
- [Interface Overview](getting-started/interface-overview.md)

# Features
- [Key-Based Diff](features/key-based-diff.md)
- [Gutter Transfers](features/gutter-transfers.md)
- [Semantic Reorganization](features/semantic-reorg.md)
- [Collapse & Dedup](features/collapse-dedup.md)
- [Search](features/search.md)
- [Inline Editing](features/inline-editing.md)
- [File Watching](features/file-watching.md)
- [Match Indicators](features/match-indicators.md)

# File Format
- [Parsing Rules](file-format/parsing-rules.md)
- [Quoted & Multiline Values](file-format/quoted-multiline.md)
- [Export Prefix](file-format/export-prefix.md)
- [Encoding & BOM](file-format/encoding-bom.md)

# Settings
- [Appearance](settings/appearance.md)
- [Diff Options](settings/diff-options.md)
- [File Handling](settings/file-handling.md)

# Reference
- [Keyboard Shortcuts](reference/keyboard-shortcuts.md)

# FAQ & Troubleshooting
- [File Permissions](faq/file-permissions.md)
- [Network Volumes](faq/network-volumes.md)
- [Read-Only Files](faq/read-only-files.md)
- [Common Errors](faq/common-errors.md)
```

**22 pages total.** Content sourced from DotEdit's `.devwork/_scratch/phase0/` docs, decisions (DEC-001–053), and specs.

---

## 10. Demo .env Files

**Location:** `src/assets/demo/.env.staging` + `src/assets/demo/.env.production`

Two carefully crafted demo files for screenshots. Designed to showcase:
- Key-based matching across different line positions (sections ordered differently)
- Value differences (modified keys with realistic staging→prod changes)
- Missing keys on each side (left-only, right-only)
- Comments and section headers (semantic reorg demo)
- Realistic naming — SaaS app "Acme" with staging vs production configs

### Diff highlights these files produce:

| Type | Keys |
|------|------|
| **Equal** | `APP_NAME`, `APP_TIMEZONE`, `DB_PORT`, `DB_USER`, `AWS_REGION`, `SESSION_DRIVER`, `FEATURE_NEW_DASHBOARD`, `FEATURE_DARK_MODE` |
| **Modified** | `DB_HOST`, `DB_PASSWORD`, `DB_SSL_MODE`, `APP_ENV`, `APP_DEBUG`, `APP_URL`, `APP_LOG_LEVEL`, `JWT_SECRET`, `JWT_EXPIRY`, `SESSION_LIFETIME`, `MAIL_MAILER`, `MAIL_FROM_ADDRESS`, `MAIL_FROM_NAME`, `REDIS_URL`, `REDIS_PREFIX`, `REDIS_TTL`, `AWS_BUCKET`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `FEATURE_BETA_API` |
| **Right-only (prod)** | `DB_POOL_SIZE`, `DB_READ_REPLICA`, `OAUTH_GITHUB_CLIENT_ID`, `OAUTH_GITHUB_CLIENT_SECRET`, `SENTRY_DSN`, `DATADOG_API_KEY`, `DATADOG_APP_KEY`, `UPTIME_WEBHOOK` |
| **Left-only (staging)** | (none — staging is the simpler config) |
| **Section reorder** | Staging: DB→Redis→App→Auth→Mail→Storage→Flags. Production: App→DB→Redis→Auth→Mail→Storage→Monitoring→Flags |

This mix gives rich, visually interesting diffs for screenshots: plenty of blue (modified), green (prod-only), and demonstrates key-based matching across different line positions.

### Files reference (see `src/assets/demo/` for full content)

- `.env.staging` — 37 keys, 7 sections, simpler values
- `.env.production` — 42 keys, 8 sections (adds Monitoring), hardened values
---

## 11. Project Structure

```
DotEditWebsite/
├── .devwork/
│   └── feature/website-landing/
│       ├── spec.md              ← this file
│       ├── status.md
│       ├── plan.md
│       └── todo.md
├── src/
│   ├── layouts/
│   │   └── BaseLayout.astro     # HTML shell, meta, fonts, dark mode script
│   ├── components/
│   │   ├── Nav.astro
│   │   ├── Hero.astro
│   │   ├── Screenshot.astro
│   │   ├── Features.astro
│   │   ├── TrustStrip.astro
│   │   ├── DownloadCTA.astro
│   │   ├── Footer.astro
│   │   ├── DarkModeToggle.astro
│   │   └── CopyButton.astro     # Homebrew snippet with sparkle
│   ├── pages/
│   │   └── index.astro          # Single landing page, composes all components
│   ├── styles/
│   │   └── global.css           # Tailwind imports, CSS custom properties, cursor, animations
│   └── assets/
│       ├── screenshots/         # Optimized PNG/WebP from DotEdit app
│       ├── demo/                # .env.staging + .env.production for reproducible screenshots
│       ├── logo/                # App icon + wordmark SVG
│       └── icons/               # Feature card SVG icons
├── docs-src/                    # mdBook source (decoupled from Astro)
│   ├── book.toml
│   └── src/
│       ├── SUMMARY.md
│       ├── getting-started/
│       ├── features/
│       ├── file-format/
│       ├── settings/
│       ├── reference/
│       └── faq/
├── public/
│   ├── docs/                    # mdBook build output (git-ignored, built by script)
│   └── favicon.ico
├── scripts/
│   └── build-docs.sh            # mdbook build && cp -r docs-src/book/* public/docs/
├── astro.config.mjs
├── tailwind.config.mjs
├── package.json
├── CLAUDE.md
└── .gitignore
```

---

## 12. Responsive Breakpoints

| Breakpoint | Width | Layout Changes |
|------------|-------|----------------|
| **Mobile** | < 640px | Single column, stacked features, smaller hero text, hamburger nav |
| **Tablet** | 640–1024px | 2-column features, reduced spacing |
| **Desktop** | > 1024px | Full layout, 3-column features, max-width 1200px |

Screenshots scale down proportionally. Custom cursor disabled below 1024px.

---

## 13. Screenshots Checklist

Capture from DotEdit app with demo `.env` files loaded:

| # | State | Purpose | Theme |
|---|-------|---------|-------|
| 1 | Side-by-side diff view (key-based) | Hero screenshot — the money shot | Light |
| 2 | Gutter transfer in action OR semantic reorg preview | Second screenshot — shows workflow | Light |
| 3 | (Optional) Same as #1 in dark mode | For dark mode section or toggle demo | Dark |

**Format:** PNG at 2x resolution (Retina), then convert to WebP with fallback. Max width 2200px source.

---

## 14. Inspiration References

| Site | What to take | What to avoid |
|------|-------------|---------------|
| [folk.app](https://www.folk.app/) | Serif/sans typography contrast, generous whitespace, scroll reveals, clean section rhythm | Too many feature sections, video embeds |
| [taskpaper.com](https://www.taskpaper.com/) | Minimal structure, clear CTA, text-first | Too flat, dated feel, no visual spark |
| [rectangleapp.com](https://rectangleapp.com) | Straightforward macOS app presentation | Text-heavy, no visual design |
| [linearmouse.app](https://linearmouse.app) | Alternating screenshot/text layout, Homebrew install, dark/light | Gradient accents (we use blue only) |
