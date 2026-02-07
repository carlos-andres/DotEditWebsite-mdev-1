# Constitution: DotEditWebsite
> Generated: 2026-02-07 | `/constitution update` to refresh

---

## Stack

| Layer | Tech | Version |
|-------|------|---------|
| Framework | Astro | 5.17.1 |
| CSS | Tailwind CSS | 4.1.18 |
| Language | TypeScript | 5.9.3 (strict) |
| Docs | mdBook | 0.5.2 |
| Fonts | Google Fonts CDN | Bricolage Grotesque, Inter, JetBrains Mono |
| Output | Static HTML/CSS/JS | Zero runtime |
| Deploy | SFTP → Siteground | `dist/` → `public_html/` |

---

## Architecture

| Aspect | Detection |
|--------|-----------|
| Pattern | Single-page marketing site + decoupled docs |
| API Style | N/A (100% static) |
| Client JS | Vanilla only (inline in Astro components) |
| Dark Mode | Class-based (`html.dark`) + CSS custom properties |
| Accessibility | WCAG AAA (7:1+ contrast all text/bg pairs) |

### Active Patterns
- **Astro Components** — 10 `.astro` files in `src/components/`
- **CSS Custom Properties** — Color system in `:root` / `.dark`
- **CSS Layers** — `@layer base`, `@layer components`
- **Logical Properties** — `inset-block`, `padding-block`, etc.
- **Scroll Observers** — `IntersectionObserver` for reveals, parallax
- **Motion Gating** — All animations behind `prefers-reduced-motion`

### Project Structure
```
DotEditWebsite/
├── src/
│   ├── layouts/BaseLayout.astro
│   ├── components/          # Nav, Hero, Screenshot, Features, etc. (10 files)
│   ├── pages/               # index.astro, 404.astro
│   ├── styles/global.css    # Color system, animations, cursor
│   └── assets/              # screenshots, demo envs, logo
├── docs-src/                # mdBook source (22 pages, ~2,392 lines)
├── public/                  # Static assets, favicons, docs build output
├── scripts/build-docs.sh    # mdBook build + copy
├── astro.config.mjs
├── tsconfig.json
└── package.json
```

### Key Dependencies
- **Zero production dependencies** — only `astro` in `dependencies`
- **Dev only:** `@astrojs/check`, `@tailwindcss/vite`, `tailwindcss`, `typescript`
- **External:** Google Fonts CDN (non-blocking preload)

---

## Code Rules

### Types & Safety
| Rule | Value |
|------|-------|
| TypeScript strict | Yes (`astro/tsconfigs/strict`) |
| `any` usage | Forbidden |
| Null handling | Strict null checks |
| Client JS | Vanilla only, no frameworks |

### Naming
| Element | Convention |
|---------|------------|
| Components | PascalCase (`.astro` files) |
| CSS properties | `--kebab-case` |
| CSS classes | Tailwind utilities + BEM for custom |
| Files | PascalCase (components), kebab-case (assets) |
| Functions | camelCase |
| Constants | camelCase |

### Formatting
| Rule | Value |
|------|-------|
| Indentation | 2 spaces |
| Trailing commas | Yes |
| Quotes | Double (HTML), single (JS) |
| Semicolons | Yes (JS) |

### Error Handling
| Scenario | Pattern |
|----------|---------|
| Missing assets | Astro build-time error (caught at build) |
| No JS fallback | `<noscript>` blocks for font loading |
| Motion preferences | `prefers-reduced-motion` disables all animations |
| Color scheme | `prefers-color-scheme` respected, toggle override |

### Docs & Comments
| Rule | Value |
|------|-------|
| Philosophy | Self-documenting |
| When to document | Non-obvious accessibility decisions, animation math |
| Inline comments | Why-only |
| TODO format | `// TODO:` |

### Comment Rules
```
✓ DO:
- Explain WHY (accessibility decisions, contrast ratios)
- Document animation timing/easing choices
- Mark motion-gated sections clearly

✗ AVOID:
- Restating Tailwind class meanings
- Commenting obvious HTML structure
- Redundant descriptions of component props
```

---

## Patterns

### Astro Component
```astro
<!-- From: src/components/Features.astro -->
---
// No props — static content components
---
<section id="features" aria-labelledby="features-heading" class="...">
  <h2 id="features-heading">...</h2>
  <!-- Semantic HTML + Tailwind utilities -->
</section>
```

### Dark Mode Color System
```css
/* From: src/styles/global.css */
:root {
  --color-text: #111827;
  --color-accent: #2563EB;
  --color-bg: #FFFFFF;
}
.dark {
  --color-text: #F1F5F9;
  --color-accent: #60A5FA;
  --color-bg: #0F172A;
}
```

### Motion-Gated Animation
```css
/* From: src/styles/global.css */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

### Scroll Observer (Vanilla JS)
```javascript
// From: inline <script> in components
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('revealed');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.15 });
```

---

## Design System

### Colors (3 only)
| Token | Light | Dark | Contrast |
|-------|-------|------|----------|
| `--color-text` | `#111827` | `#F1F5F9` | 15.4:1 / 14.8:1 |
| `--color-text-secondary` | `#4B5563` | `#94A3B8` | 7.5:1 / 7.1:1 |
| `--color-accent` | `#2563EB` | `#60A5FA` | — / 8.1:1 |
| `--color-bg` | `#FFFFFF` | `#0F172A` | — |

### Typography
| Role | Font | Weight |
|------|------|--------|
| Headlines | Bricolage Grotesque | 700, 800 |
| Body | Inter | 400, 500, 600 |
| Code | JetBrains Mono | 400 |

### Micro-Interactions
| Effect | Trigger | Gate |
|--------|---------|------|
| Custom cursor (blue dot) | Mouse move | `pointer: fine` + reduced-motion |
| Scroll reveals | Viewport entry | `IntersectionObserver` + reduced-motion |
| Parallax (screenshot) | Scroll | `requestAnimationFrame` + reduced-motion |
| Copy sparkle | Button click | reduced-motion |
| Nav blur | Scroll > 16px | Always (visual only) |

---

## Testing

| Item | Value |
|------|-------|
| Type checking | `npm run check` (Astro + TypeScript) |
| Visual testing | Agent browser at `localhost:4321` |
| Accessibility | Agent browser snapshots + web-design-guidelines audit |
| Build validation | `npm run build` (catches broken refs, type errors) |
| Lighthouse | Target: 98/100/100/100 |

```bash
npm run check                    # TypeScript + Astro validation
npm run build                    # Full build (catches all errors)
npm run preview                  # Preview production build
```

---

## Quality

| Tool | Command | Config |
|------|---------|--------|
| TypeScript | `npm run check` | `tsconfig.json` (strict) |
| Astro Check | `npm run check` | Built-in |
| Lighthouse | Manual (browser) | Target 98/100/100/100 |

```bash
# Pre-commit
npm run check && npm run build
```

---

## Directories

| Purpose | Path |
|---------|------|
| Layouts | `src/layouts/` |
| Components | `src/components/` |
| Pages | `src/pages/` |
| Styles | `src/styles/` |
| Static assets | `public/` |
| Screenshots | `public/screenshots/`, `src/assets/screenshots/` |
| Logo | `src/assets/logo/` |
| Demo files | `src/assets/demo/` |
| Documentation source | `docs-src/` |
| Documentation build | `public/docs/` (gitignored) |
| Build output | `dist/` (gitignored) |
| Build scripts | `scripts/` |
| Workspace | `.devwork/` |

---

## Agent Skills

- Astro static site generation
- Tailwind CSS 4 (CSS-first config, custom variants)
- mdBook documentation
- Accessibility (WCAG AAA)
- CSS custom properties theming
- Vanilla JS micro-interactions

---

## Do NOT Touch
<!-- Preserved on update -->
- WCAG AAA contrast ratios — all text/bg pairs must maintain 7:1+
- 3-color palette constraint — blue accent + neutrals + base only
- Zero client-side dependencies — vanilla JS only
- `prefers-reduced-motion` gating on ALL animations
- Decoupled mdBook — separate build pipeline from Astro

## Manual Notes
<!-- Preserved on update -->
- Lighthouse score baseline: 98/100/100/100 — do not regress
- Screenshots are WebP with PNG fallback (hero: 746K→196K)
- Dark mode uses no-flash inline script in BaseLayout head
- Nav hamburger menu needs `aria-expanded`, `aria-controls`, `aria-label`
- Copy button uses `aria-live="polite"` for clipboard announcements
