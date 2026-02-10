# DotEdit Website

Marketing website and documentation for [DotEdit](https://github.com/carlos-andres/DotEdit), a native macOS app for comparing `.env` files side by side.

## Links

- **Live site:** [dotedit.app](https://dotedit.app)
- **Documentation:** [dotedit.app/docs](https://dotedit.app/docs)
- **Presentation:** [slides.dotedit.app](https://slides.dotedit.app)

## Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Framework | Astro | 5.17.1 |
| CSS | Tailwind CSS | 4.1.18 |
| Language | TypeScript | 5.9.3 (strict) |
| Docs | mdBook | 0.5.2 |
| Fonts | Google Fonts CDN | Bricolage Grotesque, Inter, JetBrains Mono |
| Output | Static HTML/CSS/JS | Zero runtime |
| Deploy | SFTP → Siteground | `dist/` → `public_html/` |

## Requirements

- Node.js 18+
- npm
- [mdBook](https://rust-lang.github.io/mdBook/) (for documentation build)

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

# Type check
npm run check
```

The `dist/` folder contains the final static files ready for upload.

## Deploy to Siteground

```bash
# Build everything
npm run build:docs && npm run build

# Upload dist/ contents to Siteground via File Manager or SFTP
# Target: public_html/ (or your configured document root)
```

## Main Features

### Landing Page
- Single-page marketing site with 6 sections: Nav, Hero, Screenshot, Features, TrustStrip, DownloadCTA, Footer
- Dark mode toggle with `prefers-color-scheme` respect and no-flash inline script
- Micro-interactions: custom cursor, parallax screenshot, scroll reveals — all gated behind `prefers-reduced-motion`

### Documentation
- 22-page mdBook documentation (decoupled build pipeline)
- Covers: getting started, features, file format reference, settings, FAQ
- Built separately via `npm run build:docs` → served at `/docs/`

### Accessibility & Performance
- WCAG AAA compliance — all text/bg pairs at 7:1+ contrast ratio
- Semantic HTML with landmarks, ARIA labels, skip-to-content, focus-visible
- Lighthouse: 98 / 100 / 100 / 100
- Zero client-side JS libraries — vanilla JS only

## Project Structure

```
DotEditWebsite/
├── src/
│   ├── layouts/BaseLayout.astro     # HTML shell, fonts, meta, dark mode
│   ├── components/                  # 9 Astro components
│   │   ├── Nav.astro
│   │   ├── Hero.astro
│   │   ├── Screenshot.astro
│   │   ├── Features.astro
│   │   ├── TrustStrip.astro
│   │   ├── DownloadCTA.astro
│   │   ├── Footer.astro
│   │   └── DarkModeToggle.astro
│   ├── pages/
│   │   ├── index.astro              # Landing page
│   │   └── 404.astro                # Custom 404
│   ├── styles/global.css            # Color system, animations, cursor
│   └── assets/                      # Screenshots, demo envs, logo
├── docs-src/                        # mdBook source (22 pages, ~2,392 lines)
│   ├── src/SUMMARY.md
│   ├── src/{getting-started,features,file-format,settings,reference,faq}/
│   └── book.toml
├── public/
│   ├── screenshots/                 # WebP + PNG fallback
│   ├── docs/                        # mdBook build output (gitignored)
│   └── favicon, icons
├── scripts/build-docs.sh            # mdBook build + copy
├── astro.config.mjs
├── tsconfig.json
└── package.json
```

## Design

| Aspect | Detail |
|--------|--------|
| Colors | 3 only — Blue accent (`#2563EB` / `#60A5FA`) + neutrals + white/black |
| Typography | Bricolage Grotesque (headlines) + Inter (body) + JetBrains Mono (code) |
| Contrast | WCAG AAA — 7:1+ all text/bg pairs |
| Dark mode | Class-based (`html.dark`) + CSS custom properties |
| Motion | All animations gated behind `prefers-reduced-motion` |
| Lighthouse | 98 / 100 / 100 / 100 |

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

## Development Workflow

This project was developed using a structured AI-assisted workflow system for Claude Code.

- **Spec-driven:** Full requirements specification before implementation
- **Phase-based:** Systematic build from scaffold to production-ready
- **Constitution:** Auto-generated tech stack document via `/constitution` scan
- **All phases complete** — Lighthouse 98/100/100/100

Workflow system: [github.com/carlos-andres/workflow-system](https://github.com/carlos-andres/workflow-system)

## Related

- **DotEdit App** — Native macOS app: [github.com/carlos-andres/DotEdit](https://github.com/carlos-andres/DotEdit)
