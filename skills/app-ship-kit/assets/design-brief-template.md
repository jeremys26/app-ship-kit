# Design Brief Template

Copy into `.claude/DESIGN.md` (or `DESIGN.md`) and fill for **this** product. Agents must treat filled values as constraints — not taste suggestions.

---

# [Product] — Agent Design Brief

Executable design constraints for AI agents. **Token source of truth:** `[path to theme tokens]`. **Product names:** `[path to brand constants]`. Read before writing or changing any screen.

## 1. Visual theme & atmosphere

| Dimension | Intent |
|-----------|--------|
| Mood | |
| Identity | |
| Differentiation | |
| Motifs | |
| Avoid | (e.g. Inter/Roboto defaults, purple-on-white gradients, light mode if dark-only) |

## 2. Color palette & roles

Do not duplicate hex in random files — use the theme module.

| Role | Token / value | Use |
|------|---------------|-----|
| Canvas | | Screen root |
| Panel | | Cards, sheets |
| Border | | Hairlines |
| Text / muted / subtle | | Hierarchy |
| Primary CTA | | One per viewport |
| Status | | Success / danger |

**Rule:** Never introduce parallel palette files.

## 3. Typography

| Role | Font / scale | Use |
|------|--------------|-----|
| Display | | Heroes |
| Body | | Forms, long copy |
| Meta | | Captions |
| Minimum size | | Accessibility floor |

Dynamic Type / user font scaling: [how this app handles it].

## 4. Shared primitives

List canonical components and when to use them (primary button, empty state, dismiss control, modal shell, etc.). **Reuse — do not invent one-offs.**

| Pattern | Component | Notes |
|---------|-----------|-------|
| Primary CTA | | loading + disabled |
| Ghost / secondary | | |
| Empty state | | Name next action |
| Modal / sheet close | | Separate 44pt target |
| Screen shell | | Safe area |

## 5. Layout

| Rule | Value |
|------|-------|
| Screen horizontal padding | |
| Min touch target | 44pt (mobile) |
| List row min height | |
| Thumb zone | Primary CTAs bottom third on tall forms |

**Native-first / web-first:** [which wins in shared components].

## 6. Motion & elevation

- Animate **transform + opacity** only (avoid layout thrash).
- Gate decorative motion with Reduce Motion.
- Elevation: [flat / blur chrome / one glow max].

## 7. Do's and Don'ts

### Do
- …
- …

### Don't
- …
- …

## 8. Platforms

| Platform | Rules |
|----------|-------|
| Primary | |
| Secondary | |

## 9. State & data conventions (optional)

- Client store selector rules
- Query key factory location
- Offline / queue patterns

---

After filling: point `app-ship-kit` UI work at this file. Update tokens path when the theme module moves.
