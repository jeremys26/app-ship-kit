# UI Pipeline

```
DESIGN.md (constraints)
    → critique (prioritize)
    → polish (mechanical)
    → de-slopify (copy)
    → verify (sim / device)
```

Read the project's design brief first. If missing, fill [design-brief-template.md](../assets/design-brief-template.md). Do not invent a second palette or install Tailwind/shadcn unless the project already uses them.

For React Native / iOS specifics (lists, Pressable, Reduce Motion, VoiceOver), also read [mobile-ui.md](mobile-ui.md). Depth via [ecosystem.md](ecosystem.md) (`expo-native-ui`, Callstack, axiom-ios-accessibility).

---

## 1. Design critique (prioritize, don't implement)

### Context block (fill every time)

| Field | |
|-------|--|
| Problem | |
| User | |
| Constraints | |
| Stage | Early / Mid / High-fidelity |
| Scope | Named screens/files |
| Ask | One question |
| Out of scope | |

### Stage guardrails

| Stage | Focus | Defer |
|-------|-------|-------|
| Early | Problem, IA | Pixel polish |
| Mid | Flows, interaction patterns | Visual nitpicks |
| High-fidelity | Consistency, a11y, edge cases | Conceptual pivots |

### Feedback format

```
Observation: <measurable>
Impact: <user effect>
Suggestion: <concrete change>
```

End with **I Like / I Wish / What If** (max 5 bullets each).

### Pro Max lens (optional second pass)

| Lens | Question |
|------|----------|
| Contrast | Secondary text below WCAG AA on canvas? |
| Motion | Decorative motion without Reduce Motion gate? |
| Async | Submit with no loading/disabled state? |
| Status | Errors/offline clear in grayscale? |
| Layout shift | Skeleton height ≠ final content? |

---

## 2. Mechanical polish

Many small passes beat one redesign. **Do not change business logic.**

### Mobile (iOS/Android) checklist

- [ ] Primary controls ≥ **44×44** pt
- [ ] Icon-only controls have `accessibilityLabel`
- [ ] Dismiss control is a **separate** hit target (not nested inside card Pressable)
- [ ] Body `lineHeight` ≥ 1.4× font size; native floor often **11pt**
- [ ] Press feedback: spring scale (~0.97) or opacity
- [ ] Haptics on consequential actions (when platform supports)
- [ ] Safe area insets — no hard-coded notch offsets
- [ ] Primary CTA in thumb zone on tall forms
- [ ] Decorative motion gated by Reduce Motion
- [ ] Async primary CTA shows loading spinner
- [ ] One primary accent CTA per viewport
- [ ] Empty / loading / error states name the next action

### Web / admin checklist

- [ ] Hover + keyboard focus rings
- [ ] Do not compromise shared RN layout for web — use platform splits

### Primitive reuse

Prefer the project's shared chrome (buttons, empty states, banners, tip cards). Inventing a one-off button is a smell.

### Iteration protocol

1. Screenshot before  
2. A11y tree / describe UI if tooling exists  
3. 3–5 tweaks max per pass  
4. Screenshot after + tap primary CTA  
5. Next screen  

---

## 3. De-slopify (user-facing copy)

Sound like the product's voice, not a product blog.

| Kill | Prefer |
|------|--------|
| Em-dash bullet templates (`**Label** — body`) | Short sentences |
| "Here's why" / "Let's dive in" | Say the thing |
| "Not X, it's Y" contrast | State what it is |
| Hedging ("It's worth noting") | Imperative / factual |
| "Solutions", "leverage", "unlock potential" | Concrete verbs |

**Manual review** — context matters; some dashes are fine. Skip code comments and placeholder UI glyphs unless user-visible.

Ship order: store listing → landing → help → in-app nudges → push notification strings.

---

## 4. Landing / marketing (if applicable)

One composition in the first viewport: brand, one headline, one supporting line, one CTA group, one dominant visual. No card soup in the hero. See also project landing skill if present.

---

## One-pass prompts

**Critique**
```
Critique [SCREEN] with app-ship-kit ui.md: fill context block, Observation→Impact→Suggestion,
I Like/I Wish/What If. Evaluate against DESIGN.md. Do not implement.
```

**Polish**
```
Polish [SCREEN]: spacing, type hierarchy, 44pt targets, press feedback, haptics,
empty/loading, reduce-motion, loading CTAs. Reuse project primitives. No business logic changes.
```

**Copy**
```
De-slopify [FILE/SURFACE]: every user-facing string. Kill LLM tropes and templated em dashes.
Keep product voice. No route/logic changes.
```
