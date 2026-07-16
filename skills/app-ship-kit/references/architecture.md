# Architecture — Structure & Code Judo

Mission: **restructure so complexity disappears**, without changing behavior. "Works but wrong shape" is a real verdict.

## Eight questions (per meaningful change)

1. Simpler reframing possible?
2. Complexity added where an abstraction should exist (or vice versa)?
3. File size or coupling worse?
4. Repeated conditionals signaling a missing model?
5. Logic in the right layer?
6. Canonical helper reused (not a second slightly-different copy)?
7. Types explicit (no `any` / cast soup)?
8. Independent async work parallelized; multi-row writes atomic?

## File-size ratchet

- **New files:** under **1000 lines**.
- **Existing over-cap files:** must not grow. Diff that adds net lines → extract component/hook/lib instead.
- Check: `find . -name '*.ts' -o -name '*.tsx' | xargs wc -l | awk '$1 > 1000' | sort -rn` (adjust roots).

## Layer discipline (map to your folders)

| Layer | Owns | Never |
|-------|------|-------|
| Screens / routes | Composition, navigation | Domain math, query definitions, formatters |
| Data hooks | Fetch/mutate, cache invalidation | Duplicated key strings if a factory exists |
| Domain / `lib` | Pure functions | React imports, JSX |
| Client store | Ephemeral UI state | Server state the query cache already holds |
| Shared UI kit | Buttons, empty states, banners | Feature business rules |

**Smell:** `Platform.OS === 'web'` sprinkled in shared components → prefer `.web.tsx` / platform files or one lib helper.

**Smell:** Route-param booleans forking screen behavior → dedicated route or explicit props.

**Smell:** Feature flags / gates re-implemented inline → one owning helper.

## Aggressive flags

- Net growth in a file already over 1000 lines
- Thin pass-through wrappers (hook that only calls another hook)
- Copy-pasted formatters / optimistic-update boilerplate
- Sequential `await` on independent I/O → `Promise.all`
- Multi-row writes without a transaction/RPC
- Temporary branches with no removal path
- Zustand (or similar): destructure whole store → use individual selectors (React 19 `useSyncExternalStore`)

## Preferred remedies (order)

1. Delete the indirection
2. Reframe state so conditionals disappear
3. Move logic to owning layer
4. Make the special case the default
5. Extract pure helpers / subcomponents
6. Discriminated unions over boolean soup
7. Parallelize / batch writes

## Finding format

```
[BLOCKER|SHOULD|CONSIDER] file:line — <what's structurally wrong>
Judo: <what disappears; where logic moves>
```

Approve only with no structural regression, no missed simplification, no ratchet violation, no layer leak.
