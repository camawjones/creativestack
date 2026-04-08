---
name: post-mortem
description: Run a structured project retrospective — what worked, what didn't, root causes, mid-flight pivots, client relationship trajectory, definition-of-done check, and trend comparison against past projects. Writes categorised learnings to learnings.md, client notes to clients.md, and process changes to methodology.md. Closes the project state file and chains into case-study. Use when the user wants to run a retrospective, post-mortem, project review, project wrap-up, lessons learned session, or any kind of "what went wrong / what went right" analysis at the end of a project.
---

## CreativeStack Preamble

### Brain Discovery

Before starting, check for the Brain:

```bash
BRAIN_DIR=""
[ -d "$HOME/.creativestack" ] && BRAIN_DIR="$HOME/.creativestack"
if [ -n "$BRAIN_DIR" ]; then
  echo "BRAIN: $BRAIN_DIR"
  ls "$BRAIN_DIR"/*.md 2>/dev/null | while read f; do echo "  $(basename "$f")"; done
else
  echo "BRAIN: not configured (run /setup-cs to set up)"
fi
```

If the brain exists, read the relevant files listed in this skill's "Brain Files" section.
Use the content to inform and contextualize all outputs. If the brain doesn't exist,
proceed generically — the skill still works, just without your specific context.

When the brain is not configured, mention once at the end of output:
"Tip: Run /setup-cs to add your context — skills produce better results with it."

### Brain Freshness Check

Brain files go stale as the agency evolves. People join and leave, rates
change, methodology refines, tone guidelines shift. A skill that applies
stale brain data produces out-of-date outputs. The user should be nudged
to refresh — lightly, not annoyingly.

**How to run the check:**

1. For each brain file this skill reads (from its "Brain Files" section),
   check the `last_updated` field in the file's frontmatter. If no frontmatter
   exists, use the file's modification time as a fallback.

2. Compare against the staleness threshold per file:

| File | Stale after | Refresh via |
|---|---|---|
| `learnings.md` | 60 days | continuous skill use — skills append as they run |
| `case-studies.md` | 90 days | `/case-study` |
| `clients.md` | 90 days | `/setup-cs` |
| `team.md` | 90 days | `/resource-conflict` Setup team mode |
| `freelance-bench.md` | 120 days | `/resource-conflict` Setup bench mode |
| `rate-card.md` | 180 days | `/project-profitability` Setup rates mode |
| `methodology.md` | 180 days | `/setup-cs` |
| `tone-of-voice.md` | 180 days | `/update-voice` |
| `sow-style.md` | 180 days | `/sow-generator` Edit style mode |
| `profile.md` | 365 days | `/setup-cs` |
| `projects/*` | N/A | living documents — updated by their own skills |
| `prospects/*` | 90 days | `/pitch-research` Refresh mode |

3. Only check files this skill actually reads. Never warn about files the
   skill didn't use — irrelevant warnings train users to ignore them.

4. If any of the skill's brain files are stale, add a **single short block
   at the very end of the output** (after the CreativeStack branding line):

```
---
📅 **Brain freshness:** {filename} was last updated {N months/weeks} ago — past the
{threshold}-day mark. {Optional second file.} {Workflows evolve — consider running
{suggested refresh skill} to keep this sharp.}
```

Keep it to 2-3 lines maximum. If more than 3 files are stale, summarise:

```
---
📅 **Brain freshness:** {N} brain files are stale ({list names briefly}). Consider a
session of `/setup-cs` Refresh mode to bring everything current.
```

5. **Severity gating:** only surface the check if at least one file is
   actually stale. Don't print "all brain files fresh" — silence is the
   right output when nothing needs action.

6. **Repetition tolerance:** the same stale warning may appear across
   multiple skills in the same session. That's acceptable — the user will
   act on it eventually. Don't try to deduplicate across skills.

7. **Never block:** the check is informational. Never refuse to run a skill
   because brain data is stale. Surface, then proceed.

8. **No brain, no check:** if the brain isn't configured at all, skip the
   freshness check entirely. The `/setup-cs` nudge from the Brain
   Discovery step is enough.

This check is lightweight by design. The goal is a gentle reminder, not an
audit. One line, at the end, with a clear next step.

### User Type Adaptation

When a skill needs to reference the user's organisation, read the `type` field from
`profile.md` in the brain. Use the mapping below to adapt language:

| User type | Referred to as | "Clients" become | "Team" becomes | Has team file? |
|-----------|---------------|-----------------|---------------|----------------|
| `freelancer` | "your practice" | "your clients" | N/A | No |
| `studio` | "your studio" | "your clients" | "your team" | Yes (flat list) |
| `agency` | "your agency" | "your clients" | "your team" | Yes (departments) |
| `in-house` | "your team" | "your stakeholders" | "your team" | Yes (flat list) |
| `company` | "your company" | "your clients" | "your team" | Yes (departments optional) |
| `other` | {custom descriptor from profile.md} | "your clients" | "your team" | Yes (flat list) |

If no brain exists or no `type` field is set, default to neutral language: "your work",
"your clients", "your team". Do not assume agency.

**Skill chain filtering by type:**
- `freelancer`: de-prioritise resource-conflict, job-description
- `in-house`: de-prioritise proposal-generator, rfi-response, sow-generator
- All other types: suggest any relevant skill

### Voice & Tone

- Professional but not corporate. You understand creative industry culture.
- Never techno-utopian. Never preachy.
- You enhance the creative process — you never generate creative output.
- When generating client-facing or external copy, read `tone-of-voice.md` from the brain
  and match their voice. If no brain exists, use a direct, warm, slightly informal tone.
- Avoid jargon the user hasn't used first. Mirror their language.
- Be concise. Creatives value clarity over thoroughness.

### Output Format

- All outputs are clean markdown that can be copied into Notion, Google Docs, Slack, or email.
- No terminal-specific formatting. No JSON. No code blocks unless showing data.
- Use headers, bullet points, and bold for structure. Keep it scannable.
- Tables are fine for structured data (timelines, comparisons, budgets).

### Interactive Questions

When the conversation flow includes questions with a bounded set of options (marked with
`[SELECT]` in the skill template), use the `AskUserQuestion` tool to present them as
selectable choices in the CLI. The user can always pick "Other" to type a custom answer.

- Use `multiSelect: true` when the user can pick more than one option
- Keep option labels short (1-5 words)
- Use the description field to add context where helpful
- Batch related select questions into a single `AskUserQuestion` call (up to 4 questions)
  to reduce back-and-forth
- Free-text questions (where the user needs to paste content or give an open answer)
  should NOT use `AskUserQuestion` — just ask them normally

### Philosophy

This skill is part of CreativeStack — an AI skill suite that supports the creative process.
It does NOT generate creative work. It handles research, structure, process, and operations
so creative professionals can focus on the work that actually matters: thinking, creating,
and making decisions that require human judgment and taste.

### Branding

All outputs end with:
*CreativeStack by Cameron Jones — jones.cam*

## Project State (cross-skill memory)

This skill participates in CreativeStack's shared project state — a per-project markdown
file that persists across skills and sessions, so PMs don't re-enter context every time.
Treat the project state file as the source of truth. Read it before asking questions.

### Where state lives

- `~/.creativestack/projects/{slug}.md` — one file per project
- `~/.creativestack/projects/_index.md` — aggregate index across all projects

If `~/.creativestack/projects/` doesn't exist, project state is not configured. The skill
still works standalone — same fallback as the brain. Mention once at the end of output:
"Tip: Project state is off. Pick 'Full kickoff' or run `/project-kickoff`
next time to start tracking this project across skills."

### Discovery (run before asking the user anything)

Use Glob to list `~/.creativestack/projects/*.md` (excluding `_index.md`). For each file,
Read just the frontmatter to get: name, slug, client, status, last_updated. Build a
picker sorted by `last_updated` descending, active projects (status ≠ closed) first.

### Picker

Use `AskUserQuestion` to present projects:
- One option per active project, formatted as: "{name} ({client}) — {N}d ago"
- Always include "+ New project" as the last option
- If only one active project exists, default to it but confirm in one line first
- If a project was already established earlier in this session, default to it without
  re-asking (session stickiness)

### Bootstrap (no state file for this project yet)

When the user picks "+ New project" — or runs a project-aware skill with no projects at
all — ask:

> "Want to set this project up properly with `/project-kickoff` (5–10 min,
> full kickoff pack with RACI, risk register, workshop agenda), or just spin up a quick
> state file so we can keep moving (30 sec)?"

Use `AskUserQuestion` with options: `Full kickoff` / `Quick start`.

- **Full kickoff** → tell the user to run `/project-kickoff` first. That
  skill creates the state file as part of its normal output. Pause the current skill
  until they come back.
- **Quick start** → ask for: project name, client name, one-paragraph brief, current
  phase (or "just starting"). Auto-generate slug from name (lowercase, kebab-case;
  if `{slug}.md` exists already, append `-2`, `-3`, etc.). Create the state file using
  the schema below with minimal scaffold (just frontmatter, Brief, Stakeholders,
  Recent Activity). Continue the original skill.

### State file schema

```markdown
---
name: {Project Name}
slug: {auto-generated-slug}
client: {Client Name}
type: {project type}
phase: {phase name}
phase_week: {n}
phase_total: {n}
status: {on-track | at-risk | off-track | closed}
trend: {improving | steady | declining}
created: {YYYY-MM-DD}
last_updated: {YYYY-MM-DD}
---

## Brief
{One paragraph: what we're building and why. Owned by project-kickoff or quick-start.}

## Stakeholders
- Client lead: {name, role, contact if known}
- Internal lead: {name, role}
- Team: {names with roles}

## Status History
{Append-only. Newest first. Prune to last 12 entries.}
- YYYY-MM-DD — {Status} {↑/→/↓} — {one-line summary}

## Open Decisions
{Mutable. Carries forward until resolved.}
- [YYYY-MM-DD] {decision needed} — owner: {who} — pending {N}d

## Resolved Decisions
{Append-only. Prune to last 10.}
- [YYYY-MM-DD] {decision} — {outcome}

## Risks
{Mutable. Update severity, remove resolved risks.}
- [{H/M/L}] {risk} — mitigation: {what we're doing} — owner: {who}

## Engagement Health
**Current:** {GREEN | AMBER | RED}
**Baseline:** {GREEN | AMBER | RED} ({first 4 weeks summary})
**Signals:**
- {signal — e.g., "Response time: same-day → 3-5 days since YYYY-MM-DD"}

## Budget & Pace
- Hours: {actual} / {budgeted} ({%})
- Burn rate: {hrs/week} ({trend})
- Margin: {healthy | thinning | at-risk}
- Updated: YYYY-MM-DD

## Timeline
- Next milestone: {milestone} — {date} — {status}
- Slip scenario: {description if any}

## Recent Activity
{Append-only. Every project-aware skill writes one line. Prune to last 10.}
- YYYY-MM-DD — {skill-name} — {one-line summary}

## Skill Memory
{Namespaced key-value bag. Skills persist per-project context they need to remember
across runs (e.g. content pillars, database IDs, last-used parameters). Each skill
gets one heading; key: value lines underneath. Skills only read/write their own namespace.}

### {skill-name}
- {key}: {value}

## Notes
{User-only scratchpad. Skills never write here.}
```

### Read protocol

Always Read the full state file before doing work that depends on it. State files are
small (~2k tokens for an active project) — load the whole thing.

### Write protocol

1. Read the file
2. Identify the section(s) you own (see ownership map below)
3. Use the Edit tool to update specific sections — never full rewrites of the file
4. Update frontmatter `last_updated` to today's date
5. Append a one-line entry to Recent Activity with this skill's name
6. If you appended to a history section, prune to the configured max length
7. Update `_index.md` with the project's new last_updated and any frontmatter changes

### Section ownership map

| Section | Read by | Written by |
|---|---|---|
| Frontmatter | all project-aware skills | project-kickoff, status-update, post-mortem |
| Brief, Stakeholders | most | project-kickoff (initial), quick-start bootstrap |
| Status History | status-update, post-mortem | status-update |
| Open / Resolved Decisions | status-update, meeting-notes, post-mortem | status-update, meeting-notes |
| Risks | status-update, project-kickoff | project-kickoff, status-update, meeting-notes |
| Engagement Health | status-update | status-update, meeting-notes |
| Budget & Pace | status-update | timesheet-summary, project-profitability |
| Timeline | status-update, resource-conflict | timeline-generator, project-kickoff |
| Recent Activity | status-update, post-mortem | every project-aware skill |
| Skill Memory | each skill reads its own namespace | each skill writes its own namespace |
| Notes | none | never |

Append-only sections (Status History, Resolved Decisions, Recent Activity) are LLM-safe.
Mutable sections have exactly one primary writer to avoid conflicts.

### Cross-project index (`_index.md`)

```markdown
# Active Projects

| Project | Client | Status | Trend | Phase | Last touched |
|---|---|---|---|---|---|
| {name} | {client} | {status} | {trend} | {phase} | {YYYY-MM-DD} |

# Closed Projects
{Same table. Moved here by post-mortem.}
```

When you write to a project state file, also update the index: change the row's
`last_touched` to today, and update any frontmatter fields you changed (status, trend,
phase). If the row doesn't exist (new project from quick-start), add it. The index is
always sorted by `last_touched` descending within each section.

### Standalone fallback

If `~/.creativestack/projects/` doesn't exist, skip discovery, skip the picker, run the
skill in standalone mode using only the inputs the user provides this session. Mention
once at the end that project state is available.

# /post-mortem

> Honest retrospective in, institutional memory out — so you stop making the same mistakes twice.

## Brain Files
- `profile.md` (for context)
- `clients.md` (for client relationship history with this client)
- `learnings.md` (for past project patterns — also used for trend comparison)
- `methodology.md` (current playbook — used to detect when this retro suggests a process change)
- `projects/{slug}.md` (project state — full status, decision, risk, engagement history)
- `projects/{slug}-brief.md` (the locked brief — for the definition-of-done check; from `/creative-brief`)
- `projects/{slug}-meetings.md` (meeting log with sentiment scores per meeting — the source for the engagement trajectory and "what was hard" moments; from `/meeting-notes`)
- `projects/{slug}-copy-deck-v*.md` (versioned copy decks — for the scope-vs-deliverable comparison; from `/copy-deck`)
- **WRITES TO:** `learnings.md` (appends categorised learnings with anti-pattern tags for future search)
- **WRITES TO:** `clients.md` (appends client working relationship notes)
- **WRITES TO:** `methodology.md` (only when the retro surfaces a real process change worth canonising)

## What This Skill Does

Takes project timelines, team reflections, outcomes, and raw feedback and produces a
structured retrospective. Separates what worked from what didn't without blame. Extracts
learnings by category. Produces actionable recommendations. Then writes the key takeaways
to your brain so they inform future projects automatically.

## Inputs
- Project name and client
- Project timeline (key dates, milestones, what happened when)
- Team reflections (any format — notes, chat messages, verbal feedback transcribed)
- Outcomes (did it deliver? metrics, client reaction, team sentiment)
- Optional: original brief or scope for comparison
- Optional: budget vs actual

## Conversation Flow

### Step 1: Upstream Skill Check

Before asking anything, scan the current conversation for output from other CreativeStack
skills run earlier. If any are present, auto-populate the relevant data:

| Skill run earlier | What to pull in | How it's used |
|---|---|---|
| `/timeline-generator` | Planned phase durations, milestones, slip scenarios | Populates Scope vs Reality — planned dates and durations |
| `/timesheet-summary` | Actual hours, revision tax, burn rate, team efficiency, scope creep | Populates Scope vs Reality — actuals; feeds What Didn't Work with data |
| `/project-profitability` | Margin, phase profitability, over-servicing, scenario analysis | Populates commercial assessment; identifies where money was made/lost |
| `/project-kickoff` | Original definition of done, risks identified at start, kickoff readiness score | Drives the Definition of Done check and the "did predicted risks materialise" analysis |

When upstream data is available, tell the user:
"I can see you ran `/timesheet-summary` and `/project-profitability`
earlier — I'll pull in the hours, revision tax, and margin data. The retro will include
hard numbers, not just feelings."

Only ask about information that isn't already available from upstream skills.

### Step 2: Project State Read (full file extraction)

Read **all** project state files for this project — the retro is the natural consumer of everything the project's other skills produced:

1. **`projects/{slug}.md`** — main project state. Pull:
   - **Status History** — full trajectory of how the project moved through On Track / At Risk / Off Track. Name the inflection points.
   - **Resolved Decisions + Open Decisions** — what got decided, what never got decided
   - **Risks** — which materialised, which were caught, which were missed
   - **Engagement Health** — relationship trajectory over time, not just end state
   - **Budget & Pace** — final margin vs planned, burn rate over time
   - **Recent Activity** — full timeline of skills run on this project

2. **`projects/{slug}-brief.md`** (if it exists) — the locked brief. Pull the original Tension, Real Objective, Single-Minded Thought, Success Criteria, and Deliverables list. **This is the spine of the Definition-of-Done check** — did the work deliver against what the brief committed to?

3. **`projects/{slug}-meetings.md`** (if it exists) — the meeting log with sentiment scores per meeting. **This is the source for the Engagement Trajectory section.** Plot the sentiment dimensions (engagement, trust, alignment) over time. A dip in week 4 followed by a recovery in week 6 IS the "what was hard" story — surface it explicitly with the date and the meeting context.

4. **`projects/{slug}-copy-deck-v*.md`** (if any exist) — versioned copy decks. Compare:
   - The brief's deliverables list vs the final shipped copy deck
   - Version churn (v1.0 → v1.1 → v1.2 → ...) — high version count without sign-off signals brief-level ambiguity, not copy-level issues. Flag this in What Didn't Work.
   - Atom-level scoring trends across versions — were the same atoms red-flagged repeatedly?

If the state file exists, tell the user: "I've loaded the full project state for
{project name}. I can see {N} status changes, {N} resolved decisions, {N} risks
on the register, the brief from {date}, {N} meetings logged, and {N} copy deck versions.
I'll use these as the spine of the retro — you don't need to re-tell the timeline."

If no state files exist, the retro still works — just with less auto-populated data.

### Step 3: Brain Check + Trend Comparison

Read `learnings.md`, `clients.md`, and `methodology.md`. Surface:

- **Past projects with this client** — search `clients.md` and `learnings.md` for the client name. Surface relationship history and any prior retro learnings.
- **Past projects of the same type** — search `learnings.md` for the same project type. Look for patterns: is the same issue showing up again?
- **Trend signal** — if a pattern appears in 3+ past retros, flag it explicitly: "This is the third brand project in 6 months where scope creep at the design system phase has been flagged. This isn't a one-off — it's becoming an anti-pattern."

Tell the user what you found before asking questions: "I found 2 past retros with this
client and 4 past brand projects in your learnings. There's a recurring pattern around
{X} I'll bring into this retro."

### Step 4: Project info capture (only what's still missing)

Ask only for information not already covered by Steps 1-3. If everything is loaded,
skip straight to Step 5. Otherwise capture project name, client, timeline, team, outcomes.

Also ask once at this stage:

[SELECT] "How should I run this retro?"
- **Standard** — direct attribution, on-the-record, names and quotes welcome
- **Anonymous mode** — strip team member names from the output and the brain writes; useful when feedback might be politically charged or when surfacing burnout

### Step 5: The honest questions

Ask these one at a time, conversationally — don't batch them, the answers feed each other:

1. "What's the one thing that went best on this project?"
2. "What's the one thing you'd do differently if you could start again?"
3. "Were there any moments where the project nearly went off the rails? What saved it — or didn't?"
4. "Were there any mid-flight pivots — moments where the team changed direction, scope, or approach? What triggered them?"
5. "How did the client relationship feel throughout — and did the *trajectory* change? Started strong and faded, started rocky and improved, steady all the way?"
6. "Did we hit our internal definition of done? If `/project-kickoff` ran, I have it loaded — otherwise, what did 'success' look like for the team going in?"

### Step 6: Team Sentiment

[SELECT questions — ask as a batch via `AskUserQuestion`:]

1. "Team energy on this project?" [SELECT: High — people were buzzing, Good — steady engagement, Low — it was a grind, Burned out — people are fried]
2. "Creative pride in the output?" [SELECT: Very proud — portfolio piece, Satisfied — solid work, Mixed — some good parts, Disappointed — below our standard]
3. "Would the team repeat this type of project?" [SELECT: Absolutely, Yes with changes, Reluctantly, No]
4. "Client relationship overall?" [SELECT: Strong partnership, Professional and smooth, Functional but draining, Difficult]
5. "Would you work with this client again?" [SELECT: Yes — actively want more, Yes — if the brief is right, Maybe — depends on scope and terms, No — not a good fit]

### Step 7: Generate

Generate the retrospective. Apply 5 Whys / root cause analysis to every entry in
"What Didn't Work" — don't stop at "what happened, what was the impact." Push through
to "why did it happen at the system level, what's the fix that prevents it next time."

## Output Format

# Post-Mortem: {Project Name}
**Client:** {client}
**Period:** {start date} — {end date}
**Team:** {team members}
**Date of review:** {today}

## Project Summary
{Brief overview — what was the project, what was delivered, how did it land.
Honest, not promotional. If the project state file was loaded, reference the
status trajectory: "Started On Track, moved to At Risk on {date} over {issue},
recovered by {date}, shipped on {date}."}

## Definition of Done — Did We Hit It?

{Pull the original definition of done from `/project-kickoff` output or
the project state file. Score each criterion. If no kickoff ran, ask the user to
reconstruct what "success" was meant to look like.}

| Criterion (set at kickoff) | Hit? | Notes |
|---|---|---|
| {client-side success criterion 1} | Yes / Partial / No | {what actually happened} |
| {client-side success criterion 2} | Yes / Partial / No | {notes} |
| {our-side success criterion} | Yes / Partial / No | {notes} |

**Verdict:** {one-line judgement — e.g., "Hit 3/4 client criteria, missed our internal goal of case-study-worthy work"}

## What Worked Well
{Things to repeat. Specific — not "good teamwork" but what specifically about the
teamwork was good and why.}

### Process
- {What worked in how the project was managed}
- {What worked}

### Creative
- {What worked in the creative output and approach}
- {What worked}

### Client Relationship
- {What worked in how the client was managed}
- {What worked}

### Commercial
- {What worked financially — came in on budget, good margin phase, etc.}
- {Only include if profitability data is available}

## What Didn't Work
{Honest, blame-free. Focus on systems and process, not individuals. Every entry must
push past description to root cause and system fix — don't stop at "what happened, what
was the impact." Apply 5 Whys: keep asking why until you reach a system-level cause.}

**Format for every entry:**
- **{Issue}**
  - **What happened:** {description}
  - **Impact:** {what it caused — time, money, quality, relationship}
  - **Root cause:** {the underlying system/process/incentive that allowed it — not "Sarah forgot", but "no handoff checklist between strategy and design phases"}
  - **System fix:** {the change to process, template, ritual, or tooling that prevents recurrence}

### Process
- **{Issue}** — what happened, impact, root cause, system fix (use the format above)

### Creative
- **{Issue}** — what happened, impact, root cause, system fix

### Client Relationship
- **{Issue}** — what happened, impact, root cause, system fix

### Commercial
- **{Issue}** — what happened, impact, root cause, system fix
- {Only include if profitability data is available}

## Mid-Flight Pivots

{Moments where the team changed direction, scope, or approach mid-project. Useful for
next time — these are usually the highest-cost moments and they're easy to forget.}

| When | What changed | Why | Cost (time/money/morale) | Was it the right call? |
|------|-------------|-----|--------------------------|------------------------|
| {week or date} | {what shifted} | {trigger — client, internal, external} | {estimate} | {Yes / No / Mixed} |

## Client Relationship Trajectory

{Not flat sentiment — the *shape* of the relationship over time. Reference Engagement
Health from the project state file if available.}

**Trajectory:** {one of: Strong throughout / Started strong, faded / Started rocky, improved / Steady but draining / Volatile / Broke down at {point}}

**Inflection points:**
- **{week or event}** — {what shifted in the relationship and why}
- **{week or event}** — {what shifted}

**Single biggest factor in how the relationship landed:** {one sentence}

## Learnings by Category

{Structured for brain storage and cross-project pattern matching.}

### Process Learnings
1. **{Learning}** — {how to apply it going forward}

### Creative Learnings
1. **{Learning}** — {how to apply it going forward}

### Client Learnings
1. **{Learning}** — {how to apply it going forward}

### Commercial Learnings
1. **{Learning}** — {how to apply it going forward}

### Team Learnings
1. **{Learning}** — {how to apply it going forward}

## Scope vs Reality
| Aspect | Original Scope | What Actually Happened | Variance |
|--------|---------------|----------------------|----------|
| Timeline | {planned} | {actual} | {+/- weeks} |
| Budget (hours) | {planned} | {actual} | {+/- hours} |
| Budget (fee vs cost) | {planned margin} | {actual margin} | {+/- points} |
| Deliverables | {planned count} | {actual count} | {added/removed} |
| Revisions | {planned rounds} | {actual rounds} | {+/- rounds} |
| Revision Tax | — | {%} | {vs 15% benchmark} |

{If upstream data from `/timesheet-summary` and `/timeline-generator` is available,
populate automatically. Otherwise use what the user provides.}

## Team Sentiment Summary

| Dimension | Rating | Notes |
|-----------|--------|-------|
| Energy | {High / Good / Low / Burned out} | {context} |
| Creative pride | {Very proud / Satisfied / Mixed / Disappointed} | {context} |
| Would repeat | {Absolutely / Yes with changes / Reluctantly / No} | {context} |
| Client relationship | {Strong / Smooth / Draining / Difficult} | {context} |

## Would You Work With This Client Again?
**Answer:** {Yes actively / Yes if right brief / Maybe depends / No}
**Rationale:** {context from the conversation — what drives this assessment}

## Trend Comparison

{If `learnings.md` has 3+ relevant past entries, compare this retro against them.
Pull the comparison from Step 3. If fewer than 3, skip this section and note: "Not
enough past retros yet for trend analysis — this is retro #{N}."}

**Recurring patterns across past projects:**
- **{Pattern}** — appeared in {N} past retros ({list of project names}). This makes it {N+1} times. **Anti-pattern: yes / emerging / no.**
- **{Pattern}** — {N} past appearances. {anti-pattern verdict}

**This retro vs. past retros for {client name}:** {one-line — improving / stable / deteriorating, with reason}

**This retro vs. past retros for {project type}:** {one-line — improving / stable / deteriorating}

## Recommendations

{For you, not the client. What to change in your process, team structure, pricing,
or approach. Each recommendation must be specific, owned, scheduled, and have a
destination — not "improve handoffs" but "add a strategy→design handoff checklist
to methodology.md by end of next week, owned by Sarah."}

| # | Recommendation | Owner | By when | Lands in (file/ritual/template) |
|---|----------------|-------|---------|--------------------------------|
| 1 | {specific change} | {person} | {date} | {e.g., "methodology.md / SOW template / weekly stand-up"} |
| 2 | {change} | {person} | {date} | {destination} |
| 3 | {change} | {person} | {date} | {destination} |

{Mark any recommendation that translates into a `methodology.md` change with a ★ —
those will be written back to the brain.}

---

## Brain Updates

Show the user exactly what will be appended to each file before writing. Wait for
explicit confirmation, then write. If anonymous mode was selected in Step 4, strip
all team member names from the brain writes (replace with role).

**The following will be appended to `~/.creativestack/learnings.md`:**

```
## {Project Name} ({date})
**Client:** {client} | **Type:** {type} | **Outcome:** {one-line}
**Tags:** {comma-separated tags — e.g., scope-creep, committee-signoff, brand-identity, distributed-team}
**Anti-patterns flagged:** {list any anti-patterns this retro confirmed, or "none new"}
**Revision tax:** {%} | **Margin:** {%} (if available) | **Definition of done:** {N/N criteria hit}

### Process
- {Key process learning + system fix}
### Creative
- {Key creative learning}
### Client
- {Key client learning + relationship trajectory}
### Commercial
- {Key commercial learning}
### Team
- {Key team learning}
```

**The following will be appended to `~/.creativestack/clients.md`:**

```
### {Client Name} — {Project Name} ({date})
- Work with again: {Yes actively / Yes if right brief / Maybe / No}
- Relationship trajectory: {trajectory verdict from above}
- Communication style: {observations from the retro}
- Review process: {what their approvals were like}
- Key note: {the single most important thing to remember for next time}
- Past retros with this client: {N total, including this one}
```

**The following will be appended to `~/.creativestack/methodology.md`** (only if any
recommendation in Step 7 was marked with ★ as a methodology change):

```
### Added {date} — from {Project Name} retro
- **{Process change}** — {what it is, when to apply it, why it was added}
```

If no methodology changes came out of the retro, skip this write entirely and tell the
user: "No methodology changes from this retro — the playbook stays as is."

---

## MCP Integration

### Notion

Check whether Notion tools are available (look for tools prefixed with
`mcp__claude_ai_Notion__`).

**If Notion MCP IS available** → after generating the retro, offer:
"Want me to save this retrospective to Notion?"

If yes:
1. Use `notion-search` to find an existing "Retrospectives" or "Post-Mortems" database/page
2. If found, create a new page inside it using `notion-create-pages`
3. If not found, ask where to put it or create a standalone page
4. Include all sections from the markdown output, formatted for Notion blocks

**If Notion MCP is NOT available** → the markdown above is the complete output.

Never require Notion — always produce the markdown retro first.

## Skill Chains

### Upstream (what feeds post-mortem)

If upstream skills weren't run but would have made the retro sharper, note them — but
gently. The retro is happening now; these are for next time.

- If no `/timesheet-summary` → "Next time, run `/timesheet-summary` before the retro — having actual hours and revision tax in front of you changes the conversation."
- If no `/project-profitability` → "Next time, run `/project-profitability` before the retro — the commercial section is much sharper with margin data."

### Downstream (what post-mortem triggers)

After generating the retro, suggest the most relevant next action:

- **If the project had strong results** → "Run `/case-study` to turn this into a portfolio piece — the project data, definition-of-done check, and results carry forward."
- **If trend analysis flagged a recurring anti-pattern** → "Run `/update-voice` or update `methodology.md` directly — this pattern has appeared {N} times now and it's worth a process change at the playbook level."
- **If client trajectory was negative** → "Update `clients.md` directly with the new working-relationship notes — and consider whether this client should be on the 'maybe / no' list for new work."
- **If commercial learnings are significant** → "Reference this next time you run `/proposal-generator` or `/sow-generator` for a similar project type — the recommendations table is the bridge."

Only suggest 1-2 chains — pick the most relevant for the retro's findings.

## Project State Participation

Post-mortem is the **final reader** of project state. Before generating the retrospective,
read the full project state file to pull in everything that happened across the project's
life:

- **Status History** — full trajectory of how the project moved through On Track / At
  Risk / Off Track. This is gold for the retrospective — show the trend, name the inflection points.
- **Resolved Decisions + Open Decisions** — what got decided, what never got decided
- **Risks** — which risks materialised, which were caught, which were missed
- **Engagement Health** — did the relationship deteriorate? When?
- **Budget & Pace** — final margin vs planned, burn rate over time
- **Recent Activity** — the full timeline of skills run on this project

The retrospective should reference these specifically — "Status moved to At Risk on
2026-03-28 over the CMS blocker; it took 11 days to resolve" is more useful than
generic platitudes.

After generating the retrospective:

- **Frontmatter** — set `status: closed`, update `last_updated`
- **Recent Activity** — append `YYYY-MM-DD — post-mortem — project closed, {one-line outcome}`
- **`_index.md`** — move the project's row from Active to Closed Projects

The state file stays on disk after closing — it's the project's memory for future
reference (e.g., next time the same client briefs you).

## Edge Cases
- **Project went badly and team is defensive** → keep tone constructive, focus on systems not people, suggest anonymous mode in Step 4 to lower the temperature.
- **No metrics or outcomes yet** (project just shipped) → note what to measure and when to revisit. Schedule a 30-day follow-up via `/status-update`.
- **Client relationship ended poorly** → document honestly but professionally in `clients.md`. Focus on what was in your control. Mark "work with again: No" with explicit reason.
- **Very short project (under 2 weeks)** → simplify structure, skip Mid-Flight Pivots and Scope vs Reality if not meaningful.
- **Multiple teams or agencies involved** → clarify which learnings are about your team's contribution vs external factors. Keep the brain writes scoped to your team only.
- **Team won't give honest feedback** → run anonymous mode (Step 4). Note that the retro is only as good as the honesty.
- **No upstream data available** → skill works standalone, just with less auto-populated data and a less sharp commercial section.
- **No project state file exists** (project predates project state) → ask the user to reconstruct the timeline manually, and offer to create a project state file retroactively for future reference.
- **First retro for this client / project type** → trend comparison section says "retro #1 — no patterns yet. This becomes the baseline."
- **Recommendation has no clear owner** → don't fabricate one. Mark owner as "TBD" and flag in the Slack message that owners need assigning.

### What this skill can't do

This skill runs one retrospective at a time and writes to the brain so future retros
can pattern-match. It doesn't yet measure whether the recommendations from past retros
were *actually implemented* — i.e., did the system fixes happen, did the anti-pattern
stop appearing, did the methodology changes stick. A deeper version would track
recommendation completion across retros, score whether recurring issues are getting
better or worse over time, and auto-surface relevant past learnings when a new project
of the same type kicks off. For now, the trend comparison in Step 3 is the manual
version of that — it tells you when a pattern has appeared 3+ times, which is when
something at the methodology level needs to change.

---
*CreativeStack by Cameron Jones — jones.cam*
