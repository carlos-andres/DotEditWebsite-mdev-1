# Todo: website-landing

## Phase 1: Scaffold
- [ ] Init Astro 5 project
- [ ] Install Tailwind CSS 4
- [ ] Configure color system (CSS custom properties)
- [ ] Configure dark mode (class strategy + prefers-color-scheme)
- [ ] Load fonts (Instrument Serif, Inter, JetBrains Mono)
- [ ] Create BaseLayout.astro (HTML shell, meta, OG tags)
- [ ] Init mdBook in docs-src/
- [ ] Create build-docs.sh script
- [ ] Add .gitignore (node_modules, dist, public/docs, .devwork)

## Phase 2: Landing Page Components
- [ ] Nav (sticky, blur, dark mode toggle, responsive)
- [ ] Hero (headline, subtext, CTAs, Homebrew copy button)
- [ ] Hero Screenshot (parallax, shadow, scroll reveal)
- [ ] Features Strip (3 cards, staggered reveal)
- [ ] Second Screenshot + Caption
- [ ] Trust Strip
- [ ] Download CTA (repeated)
- [ ] Footer

## Phase 3: Micro-Interactions
- [ ] Custom cursor (dot, scale on hover, blend mode)
- [ ] Scroll-triggered reveals (IntersectionObserver)
- [ ] Background gradient shift (section colors)
- [ ] Screenshot parallax + shadow mouse tracking
- [ ] Copy dot sparkle animation
- [ ] prefers-reduced-motion fallbacks for all above

## Phase 4: Accessibility Audit
- [ ] AAA contrast verification (all color pairs)
- [ ] Semantic HTML landmarks
- [ ] Keyboard navigation (tab order, focus-visible)
- [ ] Screen reader testing (ARIA labels, live regions)
- [ ] Skip-to-content link
- [ ] Agent-skills web-design-guidelines audit

## Phase 5: Documentation
- [ ] Write all 22 mdBook pages (from DotEdit phase0 docs)
- [ ] SUMMARY.md table of contents
- [ ] book.toml configuration
- [ ] Build and integrate into public/docs/

## Phase 6: Screenshots
- [ ] Create demo .env files in DotEdit app
- [ ] Capture screenshot 1: side-by-side diff (light mode)
- [ ] Capture screenshot 2: reorg/transfer (light mode)
- [ ] Optimize to WebP with PNG fallback
- [ ] (Optional) Dark mode variant

## Phase 7: Polish & Ship
- [ ] Responsive testing (mobile, tablet, desktop)
- [ ] Performance audit (Lighthouse 95+)
- [ ] OG/meta tags for social sharing
- [ ] Favicon + apple-touch-icon
- [ ] Final build → dist/ → upload to Siteground
