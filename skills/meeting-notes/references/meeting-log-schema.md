# Meeting Log Schemas

This skill creates and maintains:

1. `~/.creativestack/projects/{slug}-meetings.md` — append-only meeting log per project
2. `~/.creativestack/learnings.md § Client Patterns` — accumulated per-client communication patterns

The `{slug}-meetings.md` file pairs with the existing `{slug}.md` project state
file. They live in the same directory and are written to in tandem after every
meeting.

---

## 1. projects/{slug}-meetings.md

Append-only log. Newest meeting at the top. One entry per meeting.

```markdown
---
project: Nike Air Refresh
slug: nike-air-refresh
client: Nike
meeting_count: 7
last_updated: 2026-04-08
---

# Nike Air Refresh — Meeting Log

## 2026-04-08 — Client Review (Round 2)
**Attendees:** Sarah Chen, Mike Torres (us); Marcus Liu, Priya Shah (Nike)
**Duration:** 60 min
**Type:** client_review
**Source:** Granola transcript

### Sentiment scores
- Engagement: 3/5 (was 4 last meeting — declining)
- Trust: 4/5 (stable)
- Alignment: 3/5 (was 4 — slight decline)
- **Aggregate: 10/15** (down from 12)

### Key decisions
- Direction B confirmed as primary route
- Typography choice deferred to next meeting
- Launch date pushed from Mar 15 to Mar 22

### Actions logged
- Sarah: deliver concept refinements by 2026-04-15
- Mike: update timeline to reflect new launch date
- Marcus: share competitor research (5 days overdue from previous meeting)

### Scope changes flagged
- Social rollout discussed (not formally added) — 2nd meeting it's come up

### Notable quotes
- Marcus: "We'll think about it on the typography" — pattern match
- Priya: "I love where Direction B is going" — alignment signal

### Patterns matched this meeting
- Marcus's "we'll think about it" — instance #2 (medium confidence)

### What only the brain caught
- Brief contradiction: launch date push affects critical path per timeline-generator
- Capacity flag: Sarah at 92% per resource-conflict — refinements at risk
- Recurring scope: social rollout now 2 mentions, no formal scope change

---

## 2026-03-22 — Client Review (Round 1)
**Attendees:** Sarah, Mike (us); Marcus, Priya (Nike)
**Duration:** 90 min
**Type:** client_review
**Source:** Otter full transcript

### Sentiment scores
- Engagement: 4/5
- Trust: 4/5
- Alignment: 4/5
- **Aggregate: 12/15**

### Key decisions
{...}

---

## 2026-03-04 — Kickoff
**Attendees:** {...}

{...}
```

### Field reference

| Field | What it does |
|---|---|
| `meeting_count` | Frontmatter aggregate, updated on each append |
| `attendees` | For pattern matching (which clients said what) |
| `type` | `kickoff` / `client_review` / `internal_standup` / `pitch` / `workshop` / `qbr` / `other` — used for trajectory grouping |
| `source` | What recording tool was used — affects confidence labels |
| Sentiment scores | 3 dimensions, used for trajectory computation |
| Key decisions | Cross-referenced in future meetings |
| Actions logged | Cross-referenced in next meeting's action completion check |
| Scope changes flagged | Cross-referenced for recurring scope check |
| Patterns matched | Track which patterns confirmed in which meetings |
| What only the brain caught | Cumulative log of brain findings — useful for retros |

### Append flow

After every Notes mode run:

1. Read existing `{slug}-meetings.md` if it exists; else create with frontmatter
2. Generate the meeting entry from extracted signals + sentiment scoring + brain cross-references
3. Insert at the top, after the frontmatter and the H1
4. Update `meeting_count` and `last_updated` in frontmatter

### Read flow

Read the file in these scenarios:

- **Notes mode:** read to get past actions (for completion check), past scope items (for recurring scope check), past sentiment scores (for trajectory)
- **Patterns mode:** read for cross-meeting analysis
- **Pre-meeting brief mode:** read to get last meeting context, open actions, sentiment trajectory

### Slugging

The slug is the same as the project state file slug. Both files share the
project directory and slug. If the project doesn't have a state file yet,
the user should be routed to `/project-kickoff` first.

If the project state file exists but the meetings file doesn't, create the
meetings file on first run.

---

## 2. learnings.md § Client Patterns

Appended to the existing `learnings.md` (created by `/setup-cs`)
under a `## Client Patterns` heading. Never overwrite existing entries.

```markdown
## Client Patterns

### Marcus Liu (Nike) — "we'll think about it"
- **Pattern:** Says "we'll think about it" or "let me come back on that"
- **Followed by:** Soft no
- **Instances:** 2026-03-15, 2026-04-08
- **Confidence:** Medium (2 instances)
- **Action:** Treat as soft no, follow up within a week to confirm
- **Last updated:** 2026-04-08

### Priya Shah (Nike) — KPI early
- **Pattern:** Asks about KPIs in the first 5 minutes of any pitch or review
- **Followed by:** Receptive when KPIs are pre-emptively addressed
- **Instances:** 2026-02-08, 2026-02-22, 2026-03-15, 2026-04-08
- **Confidence:** High (4 instances)
- **Action:** Open meetings with KPI framing before creative work
- **Last updated:** 2026-04-08

### Tate Modern client team — silence on B/C routes
- **Pattern:** Goes silent on creative routes B and C, only engages with A
- **Followed by:** They want A but don't want to seem decisive too early
- **Instances:** 2025-11, 2026-01, 2026-03
- **Confidence:** Medium (3 instances, different projects)
- **Action:** Don't push for explicit B/C feedback. Treat A as the de facto choice.
- **Last updated:** 2026-03-12
```

### Field reference

| Field | What it does |
|---|---|
| **Heading** | `### {Person/Team} ({Client}) — {short pattern label}` |
| `Pattern` | Specific phrase or behaviour |
| `Followed by` | The observed outcome that follows the pattern |
| `Instances` | Dates the pattern was observed (YYYY-MM or YYYY-MM-DD) |
| `Confidence` | Low (2) / Medium (3-4) / High (5+) |
| `Action` | What the team should do when the pattern is detected next |
| `Last updated` | Date the entry was last touched |

### Append flow

When a new pattern is detected and confirmed (2+ instances) and the user opts
to save:

1. Read existing `learnings.md`
2. Find or create the `## Client Patterns` section
3. Append the new entry alphabetically by person name within the section
4. Save

### Update flow

When an existing pattern is matched again:

1. Read existing entry
2. Append the new instance date
3. Update confidence if it crosses a threshold (Low → Medium at 3 instances; Medium → High at 5)
4. Update `last_updated`
5. Confirm to the user: "Pattern confirmed — now {N} instances, confidence {level}"

### Read flow

Read this section at the start of every Notes mode run, after identifying the
people in the meeting. Filter to patterns associated with anyone present.

### Pattern decay

If a pattern hasn't been seen in 6+ months, flag it as stale on the next
match attempt. Don't auto-delete — surface and ask the user to confirm or
remove.

### Search by name

Patterns are organised by person, so the lookup is:

```
"Find patterns where the heading contains '{name}' OR '{client}'"
```

For meetings with multiple people, run the search for each attendee.

---

## Cross-file consistency

- Both files share the same project slug
- Dates are ISO (YYYY-MM-DD)
- Pattern entries reference instances by date — those dates should match meeting
  dates in `{slug}-meetings.md` for traceability
- Never overwrite. Always append.

---

## What NOT to write

### In meetings log
- Verbatim full transcript (the recording tool already has this)
- Personal observations about attendees that aren't behavioural
- Speculation framed as fact
- Internal venting that wouldn't be appropriate if forwarded
- Sensitive information shared in confidence (financial, legal, HR)

### In Client Patterns
- Personality judgements ("difficult", "passive aggressive", "manipulative")
- Specific physical descriptions
- Anything outside meeting/work context
- Patterns about people who left the client side (mark as archived instead)
