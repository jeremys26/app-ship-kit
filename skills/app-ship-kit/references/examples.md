# Examples — Gather → Act → Verify

Concrete prompts and expected agent behavior. Use these when onboarding peers or testing the skill.

---

## A. Feature / bugfix

**User:** "Follow buttons don't update the count until refresh."

**Gather:** Find follow mutation + cache invalidation; list callers.  
**Act:** One fix at the shared invalidation/query-key site (philosophy ladder).  
**Verify:** Toggle follow → count updates without refresh; error path unchanged.  
**Output:** `[done] → skipped: optimistic rollback polish, add when users report flicker.`

---

## B. UI surface

**User:** "Polish the empty state on Lists."

**Gather:** Read DESIGN.md; open empty-state component; screenshot if tooling exists.  
**Act:** Critique (Observation→Impact→Suggestion) → 3–5 polish tweaks → de-slopify copy.  
**Verify:** 44pt CTA, labeled icon, loading/empty copy names next action.  
**Do not:** Redesign IA or invent a new button component.

---

## C. Backend / schema

**User:** "Add a bookmarks table."

**Gather:** Existing RLS patterns; similar table.  
**Act:** Migration with RLS + owner policies; `auth.uid()` for writes; types regen.  
**Verify:** Advisors clean; client can't read another user's rows.  
**Output:** Point at migration file + policy names.

---

## D. Pre-merge review

**User:** "Review this PR for structure and bloat."

**Gather:** `git diff` / PR files; note files near 1000 lines.  
**Act:** Correctness → architecture (BLOCKER/SHOULD + Judo) → deletion one-liners → security if trust boundary.  
**Verify:** Verdict `approve` or blockers-first. **Do not implement** unless asked.

---

## E. Ship

**User:** "Ready for TestFlight?"

**Gather:** Recent migrations; prod profile env; store listing / placeholder copy.  
**Act:** de-slopify ship surfaces → security stack rules → sim smoke → ship.md checklist.  
**Verify:** Explicit `SHIP: yes|no` with blockers. Remind: human device QA required.

---

## Bootstrap (new repo)

**User:** "Set up agent skills for this new Expo app."

**Act:**
1. Confirm kit installed (`npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y` if missing).
2. Prefer `setup.sh --init` when a local clone exists; else copy design-brief → `.claude/DESIGN.md` and offer AGENTS snippet.
3. Suggest one stack pack once (`expo-supabase` for Expo + Supabase apps).
4. Tell them to fill DESIGN.md before UI work.

---

## Anti-examples (agent should refuse drift)

| Ask | Wrong | Right |
|-----|-------|-------|
| "Fix the bug" | New abstraction layer + config | Root-cause one-liner + smoke |
| "Make it pretty" | New palette / font pack | DESIGN.md tokens + polish checklist |
| "Add auth" | Service role in client | Session-derived authZ + RLS |
| "Ship today" | Skip device QA | `SHIP: no` until human QA or list blockers |
