# Review Pipeline

Run passes in order on meaningful diffs. Do not mix concerns in one pass.

```
1. Correctness   → bugs, regressions, missing edge cases
2. Structure     → architecture.md (code judo, layers, ratchet)
3. Deletion      → over-engineering only (this file)
4. Security      → security.md if trust boundaries touched; optional upstream in ecosystem.md
```

Do **not** implement fixes in a review-only request unless asked.

---

## Pass 1 — Correctness (sketch)

- Happy path + empty / offline / error / auth-missing
- Race conditions on double-submit
- Cache invalidation after mutations
- Partial failure on multi-step writes
- Breaking API / schema contracts

Format findings however the project prefers (PR comments, severity tags).

---

## Pass 2 — Structure

Follow [architecture.md](architecture.md). Verdict: approve or blockers-first with judo remedies.

For deep security diffs on auth/RLS PRs, prefer installed `differential-review` (see [ecosystem.md](ecosystem.md)) after this kit's stack rules.

---

## Pass 3 — Deletion (ponytail-style)

Hunt only unnecessary complexity. One line per finding.

Format: `L<line>: <tag> <what>. <replacement>.`

| Tag | Meaning |
|-----|---------|
| `delete:` | Dead code, unused flexibility. Replacement: nothing. |
| `stdlib:` | Hand-rolled thing stdlib ships. Name the function. |
| `native:` | Platform already does it. Name the feature. |
| `yagni:` | One implementation, config nobody sets, single caller. |
| `shrink:` | Same logic, fewer lines. Show the shorter form. |

End with: `net: -<N> lines possible.`  
If nothing to cut: `Lean already. Ship.`

**Out of scope for this pass:** correctness bugs, security holes, perf. Route those elsewhere.  
Do **not** flag the one smoke assert/self-check as bloat.

---

## Pass 4 — Security

If the diff touches auth, RLS, edge functions, uploads, redirects, or env: run [security.md](security.md) stack rules.

---

## One-pass prompt (full pre-merge)

```
Review [diff|PR] with app-ship-kit:
1) Correctness findings
2) Structure per architecture.md (BLOCKER/SHOULD/CONSIDER + Judo)
3) Deletion pass (one-liners + net lines)
4) Security stack rules if trust boundary touched
Do not implement fixes.
```
