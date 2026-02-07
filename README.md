# DotEdit Website

Marketing website and documentation for [DotEdit](https://github.com/dotedit/dotedit), a native macOS app for comparing .env files side by side.

## Stack

- **Astro 5** — static site generator
- **Tailwind CSS 4** — utility-first styling
- **mdBook** — documentation (`docs-src/`)
- **Vanilla JS** — micro-interactions

## Development

```bash
# Install dependencies
npm install

# Start dev server (http://localhost:4321)
npm run dev
```

## Build for Production

```bash
# 1. Build docs (mdBook → public/docs/)
npm run build:docs

# 2. Build site (Astro → dist/)
npm run build

# 3. Preview production build locally
npm run preview
```

The `dist/` folder contains the final static files ready for upload.

## Deploy to Siteground

```bash
# Build everything
npm run build:docs && npm run build

# Upload dist/ contents to Siteground via File Manager or SFTP
# Target: public_html/ (or your configured document root)
```

## Project Structure

```
src/
├── layouts/BaseLayout.astro     # HTML shell, fonts, meta, dark mode
├── components/                  # Nav, Hero, Screenshot, Features, etc.
├── pages/index.astro            # Landing page
├── pages/404.astro              # Custom 404
└── styles/global.css            # Color system, animations, cursor

docs-src/                        # mdBook source (22 pages)
├── src/SUMMARY.md
├── src/{getting-started,features,file-format,settings,reference,faq}/
└── book.toml

public/                          # Static assets
├── screenshots/                 # WebP + PNG fallback
├── docs/                        # mdBook build output (gitignored)
└── favicon, icons
```

## Security

- **npm audit:** 5 moderate (lodash in `@astrojs/check` — dev-only, not shipped)
- **No secrets** in source code
- **No `eval()`, `innerHTML`, or `document.write`** in client code
- **Zero client-side JS libraries** — only inline vanilla JS
- **No forms, APIs, or user input** — static HTML only
- **External resources:** Google Fonts CDN only
- **Recommended server headers** (configure in `.htaccess` after deploy):
  ```apache
  Header set X-Content-Type-Options "nosniff"
  Header set X-Frame-Options "DENY"
  Header set Referrer-Policy "strict-origin-when-cross-origin"
  Header set Strict-Transport-Security "max-age=31536000; includeSubDomains"
  ```

## Design

- 3 colors: Blue accent (#2563EB/#60A5FA) + neutrals + white/black
- Bricolage Grotesque (headlines) + Inter (body) + JetBrains Mono (code)
- WCAG AAA contrast, semantic HTML, prefers-reduced-motion
- Lighthouse: 98 / 100 / 100 / 100
