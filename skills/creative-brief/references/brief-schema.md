# Brief Schema, Sanity Checks & Handoff

This file defines:
1. Schema for `~/.creativestack/projects/{slug}-brief.md`
2. Sanity check logic (fee, team, timeline) using brain data
3. Project state write flow (creating or updating `projects/{slug}.md`)
4. Handoff rules to downstream skills

Creative-brief sits at the centre of the project's skill chain — most
downstream skills read what this skill writes. Getting the schema and
handoff right is worth more than any single output improvement.

---

## 1. projects/{slug}-brief.md — The full brief

One file per project. Lives alongside `projects/{slug}.md` (living state)
and `projects/{slug}-meetings.md` (meeting log). The brief file is the
**locked-at-kickoff** artifact — it's written once, updated sparingly.

```markdown
---
project: Nike Air Refresh
slug: nike-air-refresh
client: Nike
type: brand_refresh
status: draft
completeness: 7.8
blockers: 0
created: 2026-04-15
last_updated: 2026-04-15
prepared_by: Sarah Chen
source_mode: from_inputs
---

# Nike Air Refresh — Creative Brief

## Brief Completeness

**Overall: 7.8/10 — Ready with one follow-up**

{Full rubric table from completeness-rubric.md}

## The Tension

{Single sentence tension — the gap that drives the work}

> "Nike Air was built for performance but lives in a culture that cares more
> about meaning than specs — performance authority is no longer enough."

## Project Overview

{1-2 paragraph summary of what this project is and why it exists}

## Background

{Business context, relevant history, what led to this project. Pulls from
upstream skills and prospect dossier if available.}

## Category Context

{Only if trend/competitor data is available. 2-3 most relevant trends and
competitive insights.}

## Objectives

### Real objective
{The "why" behind the work, 3+ "whys" deep}

### Stated objective
{What the client asked for — usually the deliverable}

### Success criteria
{Measurable or agreed-subjective measure per objective}

## Target Audience

**Primary:**
- **Who:** {Layer 1 — behavioural description, not demographics}
- **Relationship to brand:** {Layer 2 — users, lapsed, prospective, etc.}
- **Context:** {Layer 3 — where and when the work will reach them}
- **What they want:** {Layer 4 — desire, not feature}

**Insight:** {Non-obvious truth about the audience that unlocks the creative}

**Secondary:** {if applicable, same 4 layers}

## The Single-Minded Thought

> **"{One sentence — 15-25 words — the thing the team rallies around}"**

{If this thought needs client validation, flag it here:}
**Status:** Candidate — needs client alignment before the team commits.

## Desired Response

{What we want the audience to think, feel, do, believe after encountering
the work. Specific to this project, not generic brand purpose.}

- **Think:** "{specific thought}"
- **Feel:** "{specific feeling}"
- **Do:** "{specific action}"
- **Believe:** "{specific new belief}"

## Reasons to Believe

{Why should the audience believe the thought? Proof points, not claims.}

- **{Proof point}** — {source or evidence}

## Brand Tone & Personality

{How the brand should sound and feel in this work. Different from the
AGENCY's tone of voice — this is the BRAND's voice for this project.}

- **Tone:** {3-5 adjectives}
- **Personality:** {brand-as-a-person description}
- **If the brand were a person, they would:** {specific behaviours}
- **They would never:** {specific anti-behaviours}

## Deliverables

| Deliverable | Format/Spec | Priority | Estimated hours |
|---|---|---|---|
| {deliverable} | {format} | Must-have / Nice-to-have | {range} |

## Constraints & Mandatories

- **Budget:** {range or "TBD — open question"}
- **Timeline:** {key dates, with launch date bolded}
- **Brand guidelines:** {link or description}
- **Technical:** {platform, format, technical}
- **Legal / compliance:** {restrictions}
- **Accessibility:** {requirements}
- **Cultural:** {market-specific considerations}

## Stakeholders & Approvals

| Name | Role | Involvement | Watch for |
|---|---|---|---|
| {name} | {role} | Decision maker / Approver / Reviewer / FYI | {from learnings.md § Feedback if available} |

## What This Is NOT

{The negative space. Things the team should actively NOT do, because
they're the obvious moves that would miss the point.}

- Not a {thing}
- Not about {topic}
- Not for {audience}

## The Creative Question (optional)

{A provocation for the team, if one adds value. One sentence.}

> "{Provocative question}"

## Open Questions

{Things the brief inputs didn't answer that need resolving before creative
begins. Prioritised by impact on creative direction.}

1. **{Question}** — _Why it matters: {impact}_ — **Blocks:** {deliverable or phase}
2. **{Question}** — _Why it matters: {impact}_

## Brain Overlays Applied

{What the skill pulled from the brain to inform this brief. Makes the
provenance explicit.}

- **From `learnings.md § Feedback`:** Nike uses "bold" to mean "brand-confident" — applied to the tone section
- **From `prospects/{slug}.md`:** Pitch hook carried forward as the candidate single-minded thought
- **From `methodology.md`:** Brief structured around Discover/Define/Design/Deliver phases
- **From `rate-card.md`:** Fee sanity check applied (see sanity checks below)
- **From upstream `/competitor-audit`:** Competitive context in section {X}

## Source Material Summary

{Brief note on what inputs were used — paste content, upstream outputs,
brain data — so future readers know the provenance.}

## Sanity Checks

{Results of the sanity checks below. Include in every brief.}
```

### Frontmatter field reference

| Field | What it does |
|---|---|
| `project` | Human-readable project name |
| `slug` | URL-safe project identifier (used for file references) |
| `client` | Client name (matches clients.md) |
| `type` | One of the 11 project types from brief-templates.md |
| `status` | `draft` / `approved` / `signed_off` / `archived` |
| `completeness` | Aggregate score from the rubric |
| `blockers` | Count of Red dimensions |
| `created` / `last_updated` | ISO dates |
| `prepared_by` | Name of person who generated the brief |
| `source_mode` | `from_inputs` / `from_scratch` / `from_pitch` |

---

## 2. Sanity checks

After drafting the brief, run three sanity checks using brain data. These
are light checks — they flag concerns, they don't block the brief.

### Fee sanity check

**Requires:** `rate-card.md` exists

**Logic:**
1. For each deliverable in the brief, estimate hours by role
2. Multiply hours × internal cost rate from rate-card.md
3. Add a 20% range on either side for uncertainty
4. Compare to stated budget (if brief mentions one)

**Output format:**

```markdown
### Fee sanity check

**Estimated internal cost:** £{low}–{high}
**Estimated billing range (at card rates):** £{low}–{high}
**Stated budget:** {from brief or "not stated"}

**Assessment:** {In range / Below stated budget / Above stated budget / No budget stated — open question}

{If below stated budget: "Room for scope expansion or higher margin."}
{If above: "The deliverables list implies more scope than the budget allows. Flag as an Open Question."}
{If no budget: "Budget is an Open Question — resolve before creative begins."}
```

If `rate-card.md` doesn't exist, skip the check and note:

> "Fee sanity check skipped — no rate card. Run `/creativestack:project-profitability` Setup rates to enable."

### Team sanity check

**Requires:** `team.md` with extended schema (from resource-conflict upgrade)

**Logic:**
1. Identify the roles needed to deliver the brief (from deliverables + project type)
2. Check `team.md` — do we have those roles?
3. Check `learnings.md § Capacity` or recent resource-conflict data — are those people available?

**Output format:**

```markdown
### Team sanity check

**Roles needed:** {list based on deliverables}
**Roles available in team.md:** {matches}
**Roles missing:** {gaps — e.g., "No motion designer in team.md; this brief implies motion work"}
**Capacity concerns:** {from learnings.md § Capacity or recent resource-conflict output}

**Assessment:** {All roles available and free / Roles available but stretched / Missing roles — freelance needed / Missing roles — scope concern}

{If missing roles: "Recommend running /creativestack:resource-conflict Setup bench to plan freelance cover."}
```

If `team.md` doesn't have extended fields, skip and note:

> "Team sanity check skipped — team.md is minimal. Run `/creativestack:resource-conflict` Setup team to enable."

### Timeline sanity check

**Requires:** Brief contains a timeline; `team.md` exists

**Logic:**
1. From the brief's deliverables and launch date, work backwards to implied phase durations
2. Compare to the agency's typical durations for this project type (from `learnings.md` if available, or generic benchmarks)
3. Flag if the timeline is aggressive (<70% of typical) or generous (>130%)

**Output format:**

```markdown
### Timeline sanity check

**Stated launch:** {date}
**Implied phase breakdown:** {Discover: {weeks}, Define: {weeks}, Design: {weeks}, Deliver: {weeks}}
**Typical duration for this project type:** {weeks}
**Gap:** {-20% aggressive / on pace / +15% generous}

**Assessment:** {Realistic / Aggressive — flag risks / Generous — opportunity for ambition / Unknown — no launch date stated}

{If aggressive: "Recommend running /creativestack:timeline-generator to stress-test the schedule. Key risks: {specific phases that will feel the crunch}."}
```

If no timeline is stated, flag as an Open Question and skip the check.

### Sanity check aggregate

Combine all three into a single section in the brief output:

```markdown
## Sanity Checks

| Check | Result | Action |
|---|---|---|
| Fee | {result} | {action} |
| Team | {result} | {action} |
| Timeline | {result} | {action} |
```

---

## 3. Project state write flow

Creative-brief is often the **first** skill run on a project. This means
it creates the project state file, rather than updating an existing one.

### When `projects/{slug}.md` doesn't exist

1. Create `projects/{slug}.md` with the standard project state structure
   (whatever `{{PROJECT_STATE}}` template defines)
2. Populate the following sections from the brief:
   - **Brief Summary** — 2-3 sentence summary from the Project Overview
   - **Objectives** — list of real objectives
   - **Deliverables** — from the brief's deliverables table
   - **Stakeholders** — from the brief's stakeholders table
   - **Timeline** — key dates from constraints
   - **Budget** — from constraints (if stated)
   - **Open Decisions** — from the brief's Open Questions
   - **Risks** — any blockers from the rubric scoring
   - **Engagement Health** — `baseline` (first entry)
   - **Recent Activity** — append: `YYYY-MM-DD — creative-brief — brief created, completeness {score}/10`
3. Create `projects/{slug}-brief.md` with the full brief
4. Update `projects/_index.md` with the new project
5. Tell the user what was created:

> "Created `projects/{slug}.md` and `projects/{slug}-brief.md`. Downstream
> skills (timeline-generator, proposal-generator, meeting-notes, etc.) will
> now pick up this project automatically."

### When `projects/{slug}.md` exists

1. Update the existing state file with brief-relevant sections
2. Preserve any existing content not owned by this skill (Recent Activity,
   Engagement Health history, Resolved Decisions)
3. Write or overwrite `projects/{slug}-brief.md`
4. Append to Recent Activity
5. Tell the user what was updated

### When the project existed but had no brief file

This happens when a project was created by another skill (e.g.
`project-kickoff`) and `creative-brief` is being run to formalise the brief
later. In this case:

1. Read the existing project state
2. Pre-populate the brief with any available sections from the state file
3. Generate the brief normally
4. Write `projects/{slug}-brief.md`
5. Update the state file's Brief Summary and other affected fields

---

## 4. Handoff rules to downstream skills

After the brief is written, the skill chains section in SKILL.md suggests
downstream moves. The rules:

### Score-based suggestions

| Score | Blockers | Suggested next step |
|---|---|---|
| 8.0+ | None | `/creativestack:timeline-generator` — build the timeline from deliverables |
| 6.5-7.9 | None | Address the weakest dimension via `/creativestack:brief-sharpener` |
| 5.0-6.4 | None | `/creativestack:brief-sharpener` is mandatory before the team starts |
| Any | Yes (Red) | Resolve the Blocker — usually a conversation with the client, not another skill run |

### Content-based suggestions

Beyond the score, surface content-specific suggestions:

- **Brief needs SOW** → `/creativestack:sow-generator`
- **Brief needs proposal** → `/creativestack:proposal-generator`
- **Brief is a pitch brief** → `/creativestack:pitch-research` Refresh mode to update the dossier
- **Brief needs team planning** → `/creativestack:resource-conflict`
- **Brief needs profitability modelling** → `/creativestack:project-profitability` Scenario mode

Suggest **1-2 chains** at most. Pick the most urgent.

### What to explicitly not suggest

- Don't suggest running skills that have already run this session
- Don't suggest skills that require brain data the user doesn't have
- Don't suggest skills that would duplicate work the brief already captured

---

## 5. Mode-specific write behaviour

### From inputs mode

1. Parse the input for the 11 project type signals (see brief-templates.md)
2. If type is clear, use the template; if not, ask
3. Generate the brief from the input
4. Apply all brain overlays
5. Run sanity checks
6. Write files and update project state

### From scratch mode

1. Walk the user through the 10 rubric dimensions as interview questions,
   one at a time
2. For each dimension, provide context and a proposed answer based on
   available brain data; let the user accept, edit, or override
3. After the interview, generate the brief from the collected answers
4. Run sanity checks
5. Write files and update project state
6. The interview transcript is NOT saved — only the final brief

### From pitch mode

1. Read `prospects/{slug}.md` for the pitch dossier
2. Pre-populate:
   - **Background** ← prospect dossier "Brand Snapshot"
   - **Category context** ← prospect dossier "Competitor Landscape" + "Trend Position"
   - **Audience** ← prospect dossier "Decision-Maker Profiles"
   - **The single-minded thought** ← prospect dossier "Killer Hook" (flagged as candidate, needs client validation)
   - **Past pitch learnings** ← prospect dossier "Past Pitch Learnings"
3. If a won pitch also has a SOW (`sow-style.md` output or project state data), pull:
   - **Deliverables** ← SOW scope
   - **Constraints → Budget / Timeline** ← SOW fee / timeline
4. Ask the user only about gaps — things neither the dossier nor the SOW covered
5. Generate, run sanity checks, write files
6. **Archive the prospect dossier** — change its status from `Pitching` / `Won` to an "Archived - Active Project" state, linked to the new project slug
7. Update both `prospects/_index.md` and `projects/_index.md`

This mode closes the biggest gap in the skill chain — the handoff from
pitch research to real project work.

---

## 6. Privacy

The brief file is stored in the brain and can be read by anyone with brain
access. Treat it accordingly:

- **Don't log verbatim client conversations** in the brief — only the
  distilled decisions
- **Don't log sensitive commercial information** (competitor fees, internal
  politics, off-the-record comments)
- **Don't log anything that would embarrass the client** if they saw it —
  treat the brief as if the client might read it
- **Do log the agency's own strategic thinking** — this is internal
  intellectual property and belongs in the brain

Sanity checks, brain overlays, and internal-only commentary should be
clearly marked as internal sections of the file.
