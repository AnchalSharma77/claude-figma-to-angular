# figma-to-angular

> A Claude skill that converts Figma URL components into Angular 13 components — matching **your exact project architecture**.

---

## What it does

Run `/figma-to-angular <figma-url>` and Claude will:

1. **Read your project first** — scans your `src/` folder and reads existing components to learn your exact conventions (naming, decorators, lifecycle hooks, CSS approach)
2. **Parse the Figma design** from the URL you provide
3. **Generate 3 files** per component — `.ts`, `.html`, `.css` — all mirroring your existing patterns
4. **Update `styles.css`** globally — appends new CSS variables/tokens only, shows a diff before writing
5. **Give you the NgModule snippet** to declare the component (Angular 13-safe, no standalone components)

---

## Installation

### Claude Code (CLI) — one-liner

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/figma-to-angular-skill/main/install.sh | bash
```

### Claude.ai (web/app) — manual upload

1. Download [`figma-to-angular.zip`](https://github.com/YOUR_USERNAME/figma-to-angular-skill/releases/latest/download/figma-to-angular.zip) from Releases
2. Go to **claude.ai → Settings → Features → Skills**
3. Click **Upload** and select the `.zip` file
4. Make sure **Code execution and file creation** is enabled in **Settings → Capabilities**

---

## Usage

```
/figma-to-angular https://www.figma.com/design/abc123/MyComponent
```

Claude will then ask:

> "What is the root path of your Angular project?"

Provide the path (e.g. `/Users/you/projects/my-app`) and Claude will explore your structure before generating any files.

### Example output

For a Figma card component, Claude generates:

```
src/app/components/product-card/
├── product-card.component.ts
├── product-card.component.html
└── product-card.component.css
```

Plus a diff of additions to your global `src/styles.css`.

---

## Requirements

- **Angular 13** (NgModule-based, not standalone)
- Claude Code CLI **or** Claude.ai with Skills enabled (Pro, Max, Team, or Enterprise plan)
- The Figma URL must be publicly accessible (or you must be logged into Figma in your browser)

---

## How it respects your architecture

The skill never invents conventions. Before generating anything, it reads:

- 2+ existing components to learn your `@Component` decorator style, lifecycle hooks, and class structure
- `angular.json` for path aliases and style config
- `tsconfig.json` for import path aliases (`@app/`, `@shared/`, etc.)
- `src/styles.css` / `src/styles.scss` for existing CSS variables

If your project uses SCSS, it generates `.scss`. If you use BEM, it uses BEM. It mirrors what you already have.

---

## Project structure

```
figma-to-angular-skill/
├── README.md
├── install.sh                        ← curl-installable for Claude Code
└── figma-to-angular/
    └── SKILL.md                      ← the skill instructions
```

---

## Contributing

PRs welcome! If you improve the skill for a different Angular version or CSS methodology, feel free to open a pull request.

---

## License

MIT
