# Brain Copy Schema, Versioning & Handoffs

This file defines:
1. The versioning schema for `projects/{slug}-copy-deck-v{N}.md`
2. The brand voice source hierarchy (where copy's voice comes from)
3. Project state write flow
4. Handoff rules to downstream skills

Copy decks are often revised many times. A copy skill without persistent
version history is a copy skill that loses the team's work every session.
This file makes the versioning explicit.

---

## 1. Copy deck file schema

Every saved copy deck lives at:

```
~/.creativestack/projects/{slug}-copy-deck-v{N}.md
```

Where `{N}` is the version number. v1.0 is the first deck, v1.1 is a minor
revision, v2.0 is a major rewrite. The slug matches the project's slug.

```markdown
---
project: Nike Air Refresh
slug: nike-air-refresh
client: Nike
version: 1.2
previous_version: 1.1
status: draft
type: campaign
atoms_total: 18
atoms_red_flagged: 2
overall_score: 4.1
created: 2026-04-15
last_updated: 2026-04-15
prepared_by: Sarah Chen
brand_voice_source: projects/nike-air-refresh-brief.md
brand_voice_fallback_used: false
smt_from_brief: "To runners training for their first ultra, Nike Air is the shoe brand that honours their ambition without asking them to prove it yet."
---

# Copy Deck — Nike Air Refresh — v1.2

## Summary
{2-3 lines — what this deck covers, what changed since last version}

## Version changes (if v1.1+)
{What changed from the previous version, by atom}

## Messaging hierarchy (from the brief)
{Single-minded thought + supporting messages + desired response}

## Copy atoms
{Full atom list with scoring — see output format below}

## Platform variants
{Only if generated}

## Brain overlays applied
{What was pulled from the brain}

## Open questions
{Anything blocked on client input}
```

### Frontmatter fields

| Field | What it does |
|---|---|
| `project` | Human-readable name |
| `slug` | Matches project slug |
| `client` | Client name |
| `version` | Semver-style: major.minor |
| `previous_version` | The version this one evolved from |
| `status` | `draft` / `in_review` / `approved` / `signed_off` / `archived` |
| `type` | Copy type: `campaign` / `website` / `product` / `email` / `social` / `packaging` / `microcopy` / `mixed` |
| `atoms_total` | Count of all atoms in the deck |
| `atoms_red_flagged` | Count of atoms scoring 1-2 on any dimension |
| `overall_score` | Weighted average across all atoms |
| `brand_voice_source` | Which brain file supplied the voice |
| `brand_voice_fallback_used` | `true` if no brief-based voice and fell back to tone-of-voice.md |
| `smt_from_brief` | The single-minded thought the deck ladders to |
| `prepared_by` | Name of the person who generated the deck |

### Version numbering rules

- **v1.0** — first deck for this project
- **v1.1, v1.2, ...** — minor revisions (edit passes, section rewrites, small additions)
- **v2.0** — major rewrite (new direction, significant scope change, new brief)
- **v3.0+** — same rule as v2.0
- Never overwrite v1.0 or any previous version
- Keep all versions in the projects directory indefinitely until the project is archived

### Reading previous versions

When the user runs copy-deck on a project that already has saved decks:

1. **List existing versions** in the index read step: "I see copy-deck v1.0 (2026-03-15), v1.1 (2026-03-22), v1.2 (2026-04-02)."
2. **Ask what they want:** new version (major or minor), audit the latest, or start fresh
3. **For a new version:** read the latest previous version for vocabulary, cadence, approved phrases, and the evolution history. Use it as a reference for consistency.
4. **For audit (Check mode):** read the latest version and score it against the current brief without rewriting

### Version comparison output

When generating a new version, include a diff against the previous:

```markdown
## Version changes (v1.1 → v1.2)

### Atoms changed
| Key | Previous | Current | Reason |
|---|---|---|---|
| H1 | "Run your first ultra, on the right shoes." | "Run your first ultra without the shoes you have to coach." | Sharpened — added "coach" for specificity |
| BODY | {truncated} | {truncated} | Rewrote for sharper claim/proof pairing |

### Atoms added
- BTN_FITTING — "Book a fitting" (new — CTA for new secondary path)

### Atoms removed
- CTA_SECONDARY_EMAIL — "Sign up for updates" (removed — too passive for this version)

### Overall score: 3.8 → 4.1 (+0.3)
```

---

## 2. Brand voice source hierarchy

This is the most important rule in the whole skill: **the brand's voice
is not the agency's voice**.

### Read order

For every copy-deck run, the skill reads brand voice in this order. The
first source that exists wins.

1. **`projects/{slug}-brief.md § Brand Tone & Personality`**
   If a creative brief exists for this project, this is the authoritative
   source. Read:
   - Tone adjectives
   - Personality description
   - "They would / they would never" lines
   - Any client vocabulary notes

2. **`learnings.md § Feedback` — Vocabulary (filtered to this client)**
   Per-client translation table. Words this client uses differently from
   generic meanings. Applied on top of whatever voice source is primary.

3. **Previous `projects/{slug}-copy-deck-v*.md` — latest version**
   The most recently-signed-off deck for this client is the practical
   example of their voice in production. Use its vocabulary, rhythms,
   and approved phrases as a reference point for consistency.

4. **`clients.md` — client-specific voice notes**
   If the agency has logged brand voice notes per client in clients.md,
   apply them.

5. **`tone-of-voice.md` (FALLBACK ONLY)**
   Only used if none of the above exist. This is the agency's default
   voice, applied as a fallback to keep the skill functional.

   **When the fallback is used, the skill flags it:**

   > "⚠️ No brand voice source found — no brief, no previous deck, no
   > client voice notes. Using the agency's default tone-of-voice.md as a
   > fallback. The deck will be on the agency's voice but may not be
   > distinctive to this client. Consider running /creative-brief
   > first to establish the brand voice."

### Voice source tracking

Every deck records which voice source was used in its frontmatter:

```yaml
brand_voice_source: projects/nike-air-refresh-brief.md
brand_voice_fallback_used: false
```

If multiple sources were blended (brief + previous deck), record the primary:

```yaml
brand_voice_source: projects/nike-air-refresh-brief.md
brand_voice_blended_with: projects/nike-air-refresh-copy-deck-v1.1.md
brand_voice_fallback_used: false
```

### The "brand vs agency" rule

Every atom the skill generates is written in the BRAND's voice, not the
agency's. The skill's own language — section headers, rationale, edit
suggestions, scoring notes — is written in the AGENCY's voice from
`tone-of-voice.md`.

This is a subtle but critical distinction:

- **Atoms (the copy itself):** brand voice
- **Deck commentary (the skill's own writing):** agency voice

If the skill gets this wrong, the deck reads as "the agency's voice
describing the brand's content," which feels distant. The right feel is
"the brand's voice, documented in the agency's structure."

---

## 3. Project state write flow

### Deck-level state updates

After every copy-deck run in Deck mode or Microcopy mode, update
`projects/{slug}.md`:

- **Recent Activity:** append `YYYY-MM-DD — copy-deck — v{N}, {atoms_total} atoms, {status}, score {score}/5`
- **Frontmatter:** update `last_updated`
- **Open Decisions:** append any open questions from the deck
- **If the deck has been through 3+ versions without sign-off:** add a
  risk entry "Copy deck churn — 3+ versions without sign-off"

### New file creation

Write the new deck to `projects/{slug}-copy-deck-v{N}.md`. Never overwrite
previous versions.

### Index update

Update `projects/_index.md` if the deck version change is significant
(v2.0 or above, status change, major score shift).

### Check mode

Check mode does NOT write a new deck file. It only outputs the scoring
report. However, it should append to `projects/{slug}.md` Recent Activity:

> "2026-04-15 — copy-deck — Check mode audit of v1.2, score 4.1/5, 2 red flags"

So the audit is recorded even if no new file is written.

---

## 4. Handoff rules to downstream skills

After a deck is generated, the skill suggests downstream moves based on
the deck's state and content.

### Score-based suggestions

| Overall score | Red flags | Suggested next step |
|---|---|---|
| 4.5+ | 0 | Ship it. Run `/asset-spec` for production specs if the deck is for specific assets. |
| 4.0-4.4 | 0-1 | Ship with minor edits. Worth one more self-review pass before client. |
| 3.5-3.9 | 0-2 | Rewrite the flagged atoms. Consider a CD review before client sends. |
| <3.5 or 3+ red flags | Any | Not ready. Rewrite the weakest atoms — or rebrief. Consider `/creative-brief` review if the brief's SMT or audience is unclear. |

### Content-based suggestions

- **Copy for social** → `/social-calendar` to plan when and where to post
- **Copy references deliverables** → `/asset-spec` to generate production specs
- **Client vocabulary drift** → `/feedback-consolidator` Respond mode to draft client clarification
- **Brand voice seems unclear** → `/update-voice` to refine the tone-of-voice for this client
- **Brief-level issues surfaced** → `/brief-sharpener` on the underlying brief

Suggest 1-2 chains at most.

### What to explicitly not suggest

- Don't suggest `/creative-brief` if the brief already exists
- Don't suggest variants that the user didn't ask for
- Don't suggest re-running copy-deck unless the current run is incomplete

---

## 5. Copy deck lifecycle

Typical lifecycle for a project:

1. **v1.0 (initial)** — first draft, probably rough, usually low score, many flags
2. **v1.1-1.3 (iteration)** — revisions after internal review or first client feedback
3. **v2.0 (rewrite)** — if the direction changes significantly
4. **v2.1+ (refinement)** — polishing toward sign-off
5. **Approved** — status changes to `approved`, no further revisions without new version bump
6. **Signed off** — status changes to `signed_off`, deck locks
7. **Archived** — project closes, deck remains for reference

The skill should:
- Warn if v1.5+ is requested without a major rewrite trigger
- Warn if v2.0 is requested without a documented direction change
- Warn if any version stays in `draft` for >30 days (copy deck churn)

### Churn detection

After 3+ minor versions (v1.3+) without sign-off, the skill should surface:

> "⚠️ **Copy deck churn detected.** This deck is on v1.4 without sign-off.
> This usually indicates brief-level ambiguity rather than copy-level
> issues. Worth running /brief-sharpener on the underlying
> brief, or a client conversation about what's blocking sign-off."

Copy deck churn is a symptom of brief problems, not a copy problem.
Flagging it saves the team from endless rewriting.

---

## 6. Cross-version consistency

When generating a new version, the skill enforces consistency with the
previous version:

1. **Approved atoms don't change unless explicitly revisited.** If an
   atom was approved in v1.0 and the user is now generating v1.1, don't
   silently rewrite approved atoms.

2. **Voice stays consistent across versions.** The voice source doesn't
   change between versions unless the brief itself changed.

3. **Claim/proof pairing is preserved.** If a claim had a proof in v1.0,
   that proof should still exist in v1.1 unless explicitly removed.

4. **Vocabulary compounds.** Each version should add to the learnings.md
   § Feedback vocabulary, not contradict previous entries.

---

## 7. Privacy

Copy decks contain:
- Pre-release product claims
- Brand voice positioning
- Internal stakeholder notes
- Sometimes unreleased pricing or features

Apply the same privacy rules as other brain files:

- Don't log verbatim client edits that could embarrass them
- Don't include off-the-record commercial info
- Don't include anything that would be sensitive if forwarded to a
  competitor
- Treat the deck as if the client might read it — the scoring notes
  especially

Sanitised internal commentary (sharpness flags, rewrite suggestions) is
fine because it's about the copy, not about anyone personally.
