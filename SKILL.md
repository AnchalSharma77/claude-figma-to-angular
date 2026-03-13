---
name: figma-to-angular
description: >
  Use this skill whenever the user runs /figma-to-angular or asks to convert a Figma URL component
  into Angular components. Triggers on: "/figma-to-angular", "convert this Figma to Angular",
  "turn this Figma component into Angular", "generate Angular component from Figma", or any request
  to scaffold Angular components from a Figma design URL. Always use this skill when Angular 13
  component generation from Figma is involved — even if the user just pastes a Figma URL and mentions Angular.
---

# /figma-to-angular Skill

Convert a Figma URL component into Angular 13 components that **exactly match the user's existing Angular project architecture**.

---

## Step 1 — Understand the project structure

Before generating anything, Claude MUST read the user's actual Angular project to understand their conventions. Ask the user to provide the root path of their Angular project (or key folders), then:

```bash
# Explore the project structure
find <project-root>/src -type f -name "*.ts" | head -40
find <project-root>/src -type f -name "*.html" | head -20
find <project-root>/src -type f -name "*.css" -o -name "*.scss" | head -20
cat <project-root>/src/styles.css   # or styles.scss
```

Look for and read **at least 2 existing components** to learn the patterns:
- How are `@Component` decorators structured?
- Do they use `OnInit`, `OnDestroy`, other lifecycle hooks?
- Are services injected via constructor or `inject()`?
- What CSS methodology is used (BEM, utility, custom)?
- Are there shared base classes or mixins?
- What naming conventions are used (kebab-case folders, PascalCase classes)?

Also read:
- `angular.json` — to understand stylePreprocessorOptions, budgets, path aliases
- `tsconfig.json` — for path aliases (`@app/`, `@shared/`, etc.)
- `src/styles.css` (or `.scss`) — the global stylesheet

---

## Step 2 — Fetch and parse the Figma design

Use the Figma URL provided by the user. Extract the component's:
- Visual structure (sections, containers, text, images, icons, buttons)
- Colors, font sizes, spacing values, border-radius, shadows
- Interactive states if visible (hover, active, disabled)
- Responsive hints (if Figma frames suggest breakpoints)

If web access is available, fetch the Figma URL directly. Otherwise, ask the user to paste the Figma component's design details or a screenshot.

---

## Step 3 — Generate the Angular component files

Generate **3 files** per component, strictly following the user's existing patterns from Step 1.

### 3a. `component-name.component.ts`

Follow the user's exact patterns:
- Match their `@Component` decorator style (inline template vs templateUrl, encapsulation settings)
- Use `templateUrl: './component-name.component.html'`
- Use `styleUrls: ['./component-name.component.css']`
- Match their import order, lifecycle hooks, and class structure
- Angular 13: use standard constructor injection (NOT `inject()` function unless user already uses it)
- Add `@Input()` props for any data that varies by usage
- Keep the component standalone-free (Angular 13 uses NgModules)

```typescript
// Example shape — adapt to user's actual conventions
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-component-name',
  templateUrl: './component-name.component.html',
  styleUrls: ['./component-name.component.css']
})
export class ComponentNameComponent implements OnInit {
  @Input() title: string = '';

  constructor() {}

  ngOnInit(): void {}
}
```

### 3b. `component-name.component.html`

- Semantic HTML that matches the Figma layout
- Use Angular directives: `*ngIf`, `*ngFor`, `[ngClass]`, `(click)`, etc.
- No inline styles — all styling goes via CSS classes
- Follow the user's existing template patterns (e.g., if they wrap in a `<div class="container">`, do the same)

### 3c. `component-name.component.css`

- Write **component-scoped** CSS for this component
- Mirror the exact colors, spacing, typography, and layout from Figma
- Use CSS variables if the user's existing styles.css defines them
- If the user uses SCSS, output `.scss` instead and use nesting/variables as they do

### 3d. Update `src/styles.css` (global)

- Identify any new global tokens (colors, font sizes, shadows) introduced by this Figma component
- Append them as CSS custom properties (`:root { --new-var: value; }`) to the user's `styles.css`
- Do NOT duplicate variables that already exist
- Do NOT remove or alter existing global styles
- Show a diff of what will be added and ask for confirmation before writing

---

## Step 4 — Module registration

In Angular 13, components must be declared in an NgModule. Identify the appropriate module:
- If the component belongs to a feature module, add it there
- If it's shared, add to `SharedModule`
- Show the user which module to update and what to add to `declarations` and `exports`

Provide the exact lines to add — do NOT rewrite the whole module file unless asked.

---

## Step 5 — Output summary

After generating all files, present:
1. The folder path where files should be created (matching user's structure)
2. All 3 generated files
3. The `styles.css` additions (as a diff)
4. The module declaration snippet
5. Any assumptions made (ask the user to confirm or correct)

---

## Key rules

- **Never invent conventions** — always mirror what exists in the user's project
- **Never use Angular 14+ standalone components** — user is on Angular 13
- **CSS only, no inline styles** in templates
- **Always read the project first** before generating anything
- If the Figma URL is inaccessible, ask the user to paste the design details or a screenshot
- If unsure about a convention, ask — don't guess
