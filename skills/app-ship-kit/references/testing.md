# Testing — minimum viable checks

Pair with [philosophy.md](philosophy.md): YAGNI applies to tests too. Prefer one
check that fails when the logic breaks over a suite nobody maintains.

---

## When to add a check

| Change | Minimum |
|--------|---------|
| Pure function (score, parse, format) | One unit test or `assert` self-check |
| Mutation / RPC | Happy path + one auth failure (unauthorized) |
| UI-only polish | Manual/sim smoke ([verify.md](verify.md)) — no snapshot farm |
| RLS / policy | SQL or integration: owner can, other user cannot |
| Offline queue | Enqueue → flush → server matches |

Skip tests for trivial one-line renames and copy tweaks.

---

## Shape

- **Colocate** small tests next to the module when the project already does.
- **No new framework** unless the repo already has one (Vitest/Jest/Detox…).
- Name the invariant in the test title: `winner score stays above loser after vote`.
- Prefer deterministic fixtures over network when possible.

---

## Agent habit

After non-trivial logic:

1. Write or update **one** check.
2. Run it (project's `npm test` / `npx vitest run path` / `deno test` — detect from `package.json`).
3. If red, fix before claiming done.

If the project has no test runner, leave a `__main__`/`demo()` assert or document the manual smoke steps in the PR — don't invent a full harness.
