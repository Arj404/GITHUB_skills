---
applyTo: "**/*.{html,css,scss,less,js,ts,jsx,tsx,vue,svelte}"
---

# Frontend and UI Standards

## Component Architecture

- Follow the single-responsibility principle: one component per file, focused on one concern.
- Organize components with co-located source, styles, tests, and stories/examples.
- Extract reusable UI elements into a shared component library (`src/shared/components/`).
- Prefer controlled components and unidirectional data flow.

## Accessibility (a11y)

- Use semantic HTML elements (`<nav>`, `<main>`, `<article>`, `<button>`) over generic `<div>`/`<span>`.
- Ensure full keyboard operability for all interactive elements.
- Provide visible focus indicators on all focusable elements.
- Meet WCAG 2.1 AA contrast ratios for text and interactive elements.
- Include `aria-*` attributes and `alt` text where semantic HTML is insufficient.
- Test with screen readers and automated a11y tools (axe-core, Lighthouse).

## Design System

- Use Material Design as the default visual language for spacing, elevation, motion, and component patterns unless another system is explicitly specified.
- Centralize design tokens (colors, typography, spacing, elevation, border-radius) in a single source of truth.
- Support light and dark themes using CSS custom properties or a theming framework.
- Maintain visual consistency across all views and components.

## Responsive Design

- Design mobile-first and progressively enhance for larger viewports.
- Use CSS Grid and Flexbox for layout; avoid fixed pixel widths for content containers.
- Test across common breakpoints: mobile (≤480px), tablet (≤768px), desktop (≥1024px).

## Performance

- Lazy-load non-critical assets (images, below-the-fold components, heavy libraries).
- Minimize DOM depth and re-renders; use memoization where appropriate.
- Bundle, minify, and tree-shake production assets.
- Set performance budgets: Largest Contentful Paint <2.5s, Cumulative Layout Shift <0.1.

## State Management

- Prefer component-local state for UI-only concerns.
- Use a well-defined store pattern (e.g., Redux, Zustand, Pinia) for shared application state.
- Avoid global mutable state and side effects outside designated effect handlers.

## References

- Follow [coding.javascript](coding.javascript.instructions.md) for JS/TS coding standards.
- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
