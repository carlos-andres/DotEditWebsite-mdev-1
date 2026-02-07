# Starting Prompt

Copy-paste this into a new Claude Code session from `/Users/calo/Combat/projects/DotEditWebsite/`:

---

Read CLAUDE.md and the full spec at `.devwork/feature/website-landing/spec.md`. Then execute the todo at `.devwork/feature/website-landing/todo.md` starting with Phase 1: Scaffold.

Initialize the Astro 5 project with Tailwind CSS 4, set up the color system (CSS custom properties for light/dark mode), load the 3 fonts (Instrument Serif, Inter, JetBrains Mono), create BaseLayout.astro, and init mdBook in docs-src/ with the SUMMARY.md from the spec. Create the build-docs.sh script and .gitignore. Use /intake to set up the workspace, then proceed with implementation.

The demo .env files are already in src/assets/demo/. The DotEdit app source is at ../DotEdit/ — reference its .devwork/_scratch/phase0/ docs for feature content when writing documentation pages.

After scaffolding, proceed to Phase 2 (landing page components) following the spec section by section. Use agent-browser to verify each section visually against the spec after implementation. Run web-design-guidelines audit before each /deliver.

remember setup single time and keep alive the agent-browser to live view and please use right skills like /web-design-guidelines and best practices with /frontend-design
