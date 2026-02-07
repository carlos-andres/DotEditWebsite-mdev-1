# Todo: website-landing

## Phase 1: Scaffold
- [x] Init Astro 5 project
- [x] Install Tailwind CSS 4
- [x] Configure color system (CSS custom properties)
- [x] Configure dark mode (class strategy + prefers-color-scheme)
- [x] Load fonts (Instrument Serif, Inter, JetBrains Mono)
- [x] Create BaseLayout.astro (HTML shell, meta, OG tags)
- [x] Init mdBook in docs-src/
- [x] Create build-docs.sh script
- [x] Add .gitignore (node_modules, dist, public/docs, .devwork)

## Phase 2: Landing Page Components
- [x] Nav (sticky, blur, dark mode toggle, responsive)
- [x] Hero (headline, subtext, CTAs, Homebrew copy button)
- [x] Hero Screenshot (parallax, shadow, scroll reveal)
- [x] Features Strip (3 cards, staggered reveal)
- [x] Second Screenshot + Caption
- [x] Trust Strip
- [x] Download CTA (repeated)
- [x] Footer

## Phase 3: Micro-Interactions
- [x] Custom cursor (dot, scale on hover, blend mode)
- [x] Scroll-triggered reveals (IntersectionObserver)
- [x] Background gradient shift (section colors)
- [x] Screenshot parallax + shadow mouse tracking
- [x] Copy dot sparkle animation
- [x] prefers-reduced-motion fallbacks for all above

## Phase 4: Accessibility Audit
- [x] AAA contrast verification (all color pairs)
- [x] Semantic HTML landmarks
- [x] Keyboard navigation (tab order, focus-visible)
- [x] Screen reader testing (ARIA labels, live regions)
- [x] Skip-to-content link
- [x] Agent-skills web-design-guidelines audit

## Phase 5: Documentation
- [x] Write all 22 mdBook pages (from DotEdit phase0 docs)
- [x] SUMMARY.md table of contents
- [x] book.toml configuration
- [x] Build and integrate into public/docs/

## Phase 6: Screenshots & Assets
- [x] Create demo .env files in DotEdit app
- [x] Capture screenshots (6 windowed + 5 transparent)
- [x] Pick hero: 2-search-t.png (sequential diff + search)
- [x] Pick second: 5-reorganize-modal-t.png (reorg workflow)
- [x] Copy app icon SVG + generate favicon
- [x] Optimize to WebP with PNG fallback

## Phase 7: Polish & Ship
- [x] Responsive testing (mobile, tablet, desktop)
- [x] Performance audit (Lighthouse 98/100/100/100)
- [x] OG/meta tags for social sharing
- [x] Favicon + apple-touch-icon
- [ ] Final build → dist/ → upload to Siteground
