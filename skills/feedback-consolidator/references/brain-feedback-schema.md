# Brain Feedback Schema

This skill appends to the existing `learnings.md` under a `## Feedback` section
with three subsections:

1. **Vocabulary** — per-client translations for vague phrases
2. **Archetypes** — per-client history of detected archetypes
3. **Stakeholder Memory** — per-stakeholder feedback style and influence patterns

All three are append-only. Never overwrite existing entries. Group by client.

---

## Section structure

```markdown
## Feedback

### Nike — Vocabulary
- **"bold"** (Marcus Liu, CMO) → "brand-confident", not "louder"
  - Instances: 2026-03-15, 2026-04-08, 2026-04-22 (3 — Medium confidence)
  - Last updated: 2026-04-22
- **"clean"** (Priya Shah, Brand Director) → "minimal but premium", not "low-contrast"
  - Instances: 2026-02-18, 2026-03-08, 2026-04-22 (3 — Medium confidence)
  - Last updated: 2026-04-22

### Nike — Archetypes
- **Committee** — exhibited in 3 of 4 projects (2025-Q4 brand refresh, 2026-Q1 Air pitch, 2026-Q2 campaign)
  - Confidence: High
  - Playbook: Ask for a single decision-maker in the first client call. Marcus is usually that person but needs to be named.
  - Last seen: 2026-04-22
- **Safe Retreat** — exhibited in 1 project (2026-Q1 Air pitch)
  - Confidence: Low (1 instance)
  - Trigger: External board review prompted the retreat
  - Last seen: 2026-04-02

### Nike — Stakeholder Memory

#### Marcus Liu — CMO
- **Influence:** Decision maker (confirmed across 4 projects)
- **Feedback style:** Brief, directive. One-line notes with strong preferences.
- **Usual concerns:** Brand consistency, competitor positioning, what the board will say
- **Comms style:** Craft-literate despite finance background — takes feedback seriously when framed in craft terms
- **Watch for:** "We'll think about it" → soft no (3 of 3 past instances preceded a decline)
- **Last updated:** 2026-04-22

#### Priya Shah — Brand Director
- **Influence:** Strong influencer (Marcus defers to her on taste)
- **Feedback style:** Detailed, design-literate, uses industry vocabulary precisely
- **Usual concerns:** Typography, colour system, digital execution
- **Watch for:** Asks about KPIs in first 5 minutes of any review. Open with metrics.
- **Last updated:** 2026-04-22

### Tate Modern — Vocabulary
- **"museum-grade"** → "rigorous, authoritative, non-commercial", not "beige or safe"
  - Instances: 2025-11-02, 2026-01-14, 2026-03-12 (3 — Medium confidence)
  - Last updated: 2026-03-12

### Tate Modern — Archetypes
- **Committee (soft)** — 2 of 3 projects, but resolved themselves internally within 48h
  - Confidence: Medium
  - Playbook: Don't rush them. Give 48h before asking for a decision-maker.

{...more clients...}
```

---

## Subsection 1: Vocabulary

### Fields

| Field | What it does |
|---|---|
| Phrase | The vague word/phrase the client uses (in quotes) |
| Speaker | Who said it (name + role) — vocabulary is often person-specific within a client team |
| Translation | What they actually mean |
| Not | What the generic meaning would be, that doesn't apply here |
| Instances | Dates of observation |
| Confidence | Low (2) / Medium (3-4) / High (5+) |

### When to add

**Trigger:** A client-specific meaning becomes clear through a clarifying
conversation, or a pattern is obvious across 2+ instances of the same phrase.

**Rule:** Never add after a single instance. Always require 2+ before saving.

### When to update

On every future consolidation where this client uses the phrase:
1. Check if the meaning matches the saved entry
2. If yes: increment instance count, update `Last updated`, update confidence
   threshold if crossed
3. If no: note the discrepancy in the consolidation output, ask the user
   whether to update the entry or save a new one

### When to remove

Don't auto-remove. If an entry becomes stale or incorrect, surface it:

> "The saved vocab entry for Nike says Marcus uses 'bold' to mean
> 'brand-confident'. This round's feedback suggests he means something
> different. Want to update the entry or create a new one?"

Let the user decide.

---

## Subsection 2: Archetypes

### Fields

| Field | What it does |
|---|---|
| Archetype name | From the 8 defined in `archetypes.md` |
| Project count | How many of this client's projects showed this archetype |
| Project references | List of specific projects |
| Confidence | Low (1-2) / Medium (3-4) / High (5+) |
| Playbook | Client-specific adaptation of the archetype playbook based on what's worked before |
| Trigger (optional) | If the archetype has a recurring trigger (e.g. "after board meetings") |

### When to add

**Trigger:** An archetype is detected in a feedback round AND:
- It's the first time detected for this client (save with Low confidence), OR
- It's been detected before and the instance count is increasing

**Rule:** Don't wait for 2 instances like vocabulary. Archetypes are valuable
even at 1 instance because the playbook is reusable.

### When to update

On every future detection:
1. Increment project count
2. Append project reference
3. Update confidence threshold if crossed
4. Update the playbook if the team learned something new from handling it

### The playbook field

This is the highest-value field. It starts as the generic playbook from
`archetypes.md` but gets refined per client based on what's worked:

> "Committee archetype — Nike. Generic playbook says ask for a decision-maker.
> Client-specific: ask early (first call, not mid-project), and specifically
> name Marcus as the default unless he defers. Tried asking the group in
> 2026-Q1 and the group deferred to Marcus, so starting with him works."

Client-specific playbooks compound value over time. They're the difference
between "handling" a pattern and "anticipating" it.

---

## Subsection 3: Stakeholder Memory

### Fields

| Field | What it does |
|---|---|
| Name | Full name + role |
| Influence | Decision maker / Strong influencer / Passive reviewer / Along for the ride |
| Feedback style | One-line characterisation |
| Usual concerns | The recurring themes in their feedback |
| Comms style | How they communicate — matches the meeting-notes decision-maker profiles |
| Watch for | Specific phrases or patterns that mean something different from the surface reading |
| Last updated | Date |

### Cross-reference with meeting-notes

This subsection overlaps with `learnings.md § Client Patterns` (from
meeting-notes). The distinction:

- **Client Patterns** = general communication patterns across any meeting type
- **Stakeholder Memory** = feedback-specific patterns for people who give
  creative feedback

In practice, the same person may have entries in both sections. Don't
deduplicate — the feedback context is different from the general meeting
context. But cross-reference: if a pattern is saved in both, the confidence
is higher.

### When to add

**Trigger:** A stakeholder's feedback style becomes clear through 2+ rounds
of observation, OR the user explicitly identifies them as a key stakeholder
worth profiling.

**Rule:** Don't profile everyone. Limit to 3-5 stakeholders per client — the
people who actually drive decisions.

### When to update

On every consolidation:
1. If a stakeholder has an existing entry, confirm it still holds
2. Update `Last updated` and any new observations
3. If their influence level changed (e.g. promotion, role change), flag it
   for the user to confirm

---

## Read flow

When the skill starts a Consolidate run:

1. Identify the client from project state or user input
2. Read `learnings.md § Feedback` and filter to the client
3. Load Vocabulary, Archetypes, and Stakeholder Memory for this client
4. Apply during translation, archetype detection, and stakeholder mapping

When the skill starts a Translate run:

1. Identify the client and speaker
2. Read Vocabulary for the client/speaker match
3. Apply saved translations first, fall back to generic patterns

---

## Write flow

After every Consolidate run, offer **at most one** brain enrichment. Pick the
most valuable:

- **New vocab term detected (2+ instances)** → "Save {client}'s meaning of '{phrase}' as a vocab entry?"
- **Archetype repeated** → "This is {client}'s 3rd {archetype} — refine the playbook?"
- **Stakeholder pattern emerging** → "{Person}'s feedback style is now clear across 3 rounds — save a profile?"

Don't pile on. One offer.

After every Translate run:

- If a single vocab term was clarified with confidence, offer to save it
- Otherwise, no enrichment offer — Translate runs are usually lightweight

---

## Privacy

Feedback learnings are sensitive:
- **Don't characterise stakeholders in judgemental terms.** "Difficult",
  "passive-aggressive", "controlling" — out. "Detailed", "directive",
  "deferring" — in.
- **Don't store specific personal information** beyond role and name.
- **Don't log the verbatim feedback** in learnings.md. Log the pattern
  abstracted from it. Raw feedback lives in the project's meeting log.
- **Assume anyone with brain access can read these entries.** Write
  accordingly.

---

## Migration from minimal schema

If a user has an older `learnings.md` without the `## Feedback` section,
create it on first use. Don't touch other sections.

If the `## Feedback` section exists but without per-client grouping (old
format), offer to migrate on first new entry:

> "Your learnings.md has existing feedback notes but they're not grouped
> by client. Want me to reorganise them? I won't delete anything — just
> restructure so future lookups are faster."

Never migrate silently.
