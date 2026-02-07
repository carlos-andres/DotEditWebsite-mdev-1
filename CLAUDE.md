# CLAUDE.md

Read first: `.devwork/feature/website-landing/spec.md`

## Status

- **All phases complete.** Ready for production deploy.
- **Lighthouse:** 98 / 100 / 100 / 100
- **Todo tracker:** `.devwork/feature/website-landing/todo.md`
- **Status:** `.devwork/feature/website-landing/status.md`

## Quick Commands

```bash
# Dev server (Astro)
npm run dev

# Build docs (mdBook → public/docs/)
npm run build:docs

# Build everything (landing + docs → dist/)
npm run build

# Preview production build
npm run preview

# mdBook local preview
cd docs-src && mdbook serve --open
```

## Stack

- **Astro 5** — static site generator
- **Tailwind CSS 4** — utility-first styling
- **mdBook** — documentation (decoupled, `docs-src/`)
- **Vanilla JS** — micro-interactions only (no framework)

## Design Constraints

- **3 colors only:** Blue accent (`#2563EB` / `#60A5FA`) + Neutral grays + White/Black base
- **WCAG AAA:** All text/bg pairs at 7:1+ contrast ratio
- **Dark mode:** CSS custom properties, `class="dark"` on `<html>`, respects `prefers-color-scheme`
- **2 fonts:** Bricolage Grotesque (headlines) + Inter (body) + JetBrains Mono (code)
- **Reduced motion:** All animations gated behind `prefers-reduced-motion`
- **Semantic HTML:** Landmarks, ARIA labels, skip-to-content, focus-visible

## Key References

- Spec: `.devwork/feature/website-landing/spec.md`
- DotEdit app docs: `../DotEdit/.devwork/_scratch/phase0/`
- DotEdit decisions: `../DotEdit/.devwork/_scratch/phase0/03-decisions.md`
- Demo envs: `src/assets/demo/` (for screenshot generation)

## Git Flow

- Feature branches: `feature/<name>`
- Fix branches: `fix/<name>`
- Merge to `main` with `--no-ff`
- Conventional commits: `feat:`, `fix:`, `refactor:`, `chore:`, `docs:`
- NEVER auto-commit

---

## Development Workflow

### Terminal Setup (2 terminals)

#### Terminal 1: Claude Code Session
Primary development terminal. All edits, commands, and agent work happen here.

#### Terminal 2: Astro Dev Server (user starts manually)
```bash
cd /Users/calo/Combat/projects/DotEditWebsite
npm run dev
```
- Starts Vite-powered dev server with HMR (hot module replacement)
- Default URL: `http://localhost:4321`
- Automatically reflects file changes — no manual refresh needed
- **Keep this terminal running for the entire session**

### Browser-Based Development with Agent Browser

Use [agent-browser](https://github.com/vercel-labs/agent-browser) for live visual verification during development. This replaces the need to take screenshots or spawn separate browser tasks for checking changes.

```bash
# Install (one-time)
npm install -g agent-browser && agent-browser install

# Or via Homebrew
brew install agent-browser && agent-browser install
```

**How it integrates:**
- Agent browser connects to the running Astro dev server (`http://localhost:4321`)
- Use it to verify layout, colors, spacing, dark mode, and responsive behavior
- Astro HMR pushes changes live — agent browser sees updates without reload
- Captures accessibility snapshots (DOM tree with element refs) for semantic verification

**When to use agent browser:**
- After implementing a new section/component — verify visual result
- After changing colors/spacing — confirm against spec
- Dark mode toggle — verify both themes render correctly
- Responsive checks — resize and verify breakpoints
- Accessibility audit — snapshot the DOM tree, check landmarks and ARIA

**When NOT to use it:**
- For every single CSS tweak (trust HMR + review in IDE)
- During markdown/docs writing (no visual component)

### Browser Session Rules

**DO:**
- Open one browser connection when starting development
- Keep the same session throughout
- Let Astro HMR handle all live updates
- Use agent browser snapshots for semantic/accessibility checks

**DON'T:**
- Close and reopen browser connections repeatedly
- Open multiple sessions to the same localhost
- Manually refresh unless HMR fails
- Use browser automation for tasks better done via file editing

### Design Quality Verification

Use [agent-skills web-design-guidelines](https://github.com/vercel-labs/agent-skills) to audit UI code against 100+ best practice rules covering accessibility, focus states, animation, typography, dark mode, and performance.

```bash
# Install (one-time)
npx skills add vercel-labs/agent-skills --skill web-design-guidelines
```

**When to run audits:**
- After completing each major section (Hero, Features, Footer, etc.)
- Before any `/deliver` commit
- After dark mode implementation
- After responsive layout work

**Audit triggers:** "Review my UI", "Check accessibility", "Audit design"

---

## Project Structure

```
DotEditWebsite/
├── .devwork/feature/website-landing/   # Workspace (spec, status, plan, todo)
├── src/
│   ├── layouts/                        # BaseLayout.astro
│   ├── components/                     # Nav, Hero, Screenshot, Features, etc.
│   ├── pages/                          # index.astro (single page)
│   ├── styles/                         # global.css (Tailwind + custom props)
│   └── assets/                         # screenshots, demo envs, logo, icons
├── docs-src/                           # mdBook source (SUMMARY.md + chapters)
├── public/docs/                        # mdBook build output (gitignored)
├── scripts/build-docs.sh              # mdbook build + copy
├── astro.config.mjs
├── tailwind.config.mjs
└── package.json
```
