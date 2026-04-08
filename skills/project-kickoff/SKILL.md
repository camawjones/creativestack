---
name: project-kickoff
description: Generate a complete project kickoff pack — RACI matrix, key dates, risk register, internal brief, definition of done, communication cadence, first-week plan, workshop agenda with facilitator notes, and Slack announcement. Creates the canonical project state file under ~/.creativestack/projects/. Pulls from past learnings, integrates with Google Calendar, Figma, and Notion. Use when the user is starting a new project, launching a workstream, kicking off a brief, building a RACI, scheduling a project workshop, or formally onboarding a team to a piece of work.
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

# /project-kickoff

> Drop in project details, get a kickoff pack your team can actually run with.

## Brain Files
- `profile.md` (for context)
- `team.md` (for team capabilities and availability)
- `learnings.md` (for past project patterns and pitfalls)
- `methodology.md` (for standard kickoff process)
- `visual-style.md` (apply this house style to any Figma kickoff visuals, RACI diagrams, or workshop boards)

## What This Skill Does

Takes project type, scope, team, and constraints and produces a complete kickoff pack:
RACI matrix, key dates, risk register, internal brief, workshop agenda with facilitator
notes, and a Slack announcement for the team.

Acts as a **synthesis hub** — automatically pulls data from any Creativestack skills
run earlier in the session (`/timeline-generator`, `/sow-generator`, `/resource-conflict`,
`/creative-brief`) so the kickoff pack reflects decisions already made.

## Inputs
- Project type (brand, campaign, digital product, etc.)
- Scope summary (deliverables, timeline, budget range)
- Team (who's available or assigned)
- Constraints (hard deadlines, client preferences, platform requirements, etc.)

## Conversation Flow

### Step 1: Upstream Skill Check

Before asking questions, scan the current conversation for output from other Creativestack
skills. If any were run earlier in this session, auto-populate the relevant data:

| Skill run earlier | What to pull in | Where it appears |
|---|---|---|
| `/timeline-generator` | Phase structure, milestones, durations, critical path, review windows | Key Dates, Workshop agenda |
| `/sow-generator` | Scope, deliverables, revision policy, client responsibilities, payment milestones | Internal Brief, RACI, Risk Register |
| `/resource-conflict` | Team availability, overbooked people, single points of failure | RACI, Risk Register |
| `/creative-brief` | Objectives, audience, deliverables, tone, success metrics | Internal Brief |

When upstream data is available, tell the user what you're pulling in:
"I can see you ran `/sow-generator` and `/timeline-generator` earlier — I'll pull in the
scope, milestones, and revision policy. You don't need to repeat them."

Only ask about information that isn't already available from upstream skills.

### Step 2: Brain Check

If `learnings.md` exists, scan it explicitly for three pattern types:
1. **Same client** — search for the client name. Surface anything tagged or noted from prior work with them.
2. **Same project type** — search for the type (brand, campaign, digital product, etc.). Pull relationship and process patterns.
3. **Same team combo** — if the assigned team has worked together before on something similar, note what worked and what didn't.

For each pattern found, call it out explicitly and feed it into the relevant section:
"Based on past projects: {insight}. I've flagged this in the risk register / RACI / first-week plan."

If `team.md` exists, reference it for RACI matrix and workshop attendees.
If `methodology.md` exists, use it for the workshop structure.

### Step 3: User provides project details

If not already covered by upstream skills, capture (in this order — these are required
fields, don't skip them, they drive the slug, project state file, and Slack message):

1. **Project name** — exact title to use throughout (and to slugify for the project state file).
2. **Client name** — for stakeholder list and `clients.md` cross-reference.
3. **Project type** — brand, campaign, digital product, strategy, content, production, other.
4. **Scope summary** — one paragraph: deliverables, timeline horizon, budget range.
5. **Team** — who's available or assigned.
6. **First deliverable + due date** — the *first concrete thing* the team owes the client. The Slack announcement and First Week Plan both depend on this.
7. **Hard constraints** — fixed deadlines, platform requirements, regulatory or accessibility requirements, anything immovable.

### Step 4: Clarifying questions

[SELECT questions — ask as a batch via `AskUserQuestion`:]

1. "What format works best for the kickoff workshop?" [SELECT: In-person half-day, In-person 2 hours, Remote 90 minutes, Remote 60 minutes, Async (no live workshop)]

2. "How familiar is the team with this client?" [SELECT: New client — first project, Returning client — new project, Ongoing relationship — next phase, Internal project]

3. "What's the client's internal approval process like?" [SELECT: Single decision-maker, Small committee (2-3), Large committee (4+), Don't know yet]

4. "What's the deadline pressure?" [SELECT: Fixed external deadline (launch, event, regulatory), Strong internal target, Soft target, Open-ended]

5. "How is the team set up?" [SELECT: Co-located, Mostly co-located with some remote, Fully distributed same timezone, Distributed across timezones]

Then ask as free text:
6. "Any known dependencies on third parties (developers, photographers, printers, translators)?"

### Step 5: Process and output

Generate the full kickoff pack.

### Step 6: Create the project state file

This skill is the canonical creator of project state. After generating the kickoff pack,
create `~/.creativestack/projects/{slug}.md` using the schema in the Project State section
above. Auto-generate the slug from the project name (lowercase, kebab-case; dedupe with
`-2`, `-3` if collision).

Populate from the kickoff pack:
- **Frontmatter:** name, slug, client, type, phase (initial), phase_week (1), phase_total
  (from timeline if available), status (on-track), trend (steady), created (today),
  last_updated (today)
- **Brief:** one-paragraph summary of what we're building and why (from internal brief)
- **Stakeholders:** client lead, internal lead, team (from RACI / `team.md`)
- **Risks:** seed from the Risk Register (each row becomes a Risks entry)
- **Timeline:** next milestone and slip scenarios (from `/timeline-generator` if run, else from Key Dates)
- **Recent Activity:** append `YYYY-MM-DD — project-kickoff — created project state`
- All other sections start empty

Then add or update the row in `_index.md`.

Tell the user one line at the end: "Created project state at `~/.creativestack/projects/{slug}.md`. Future skills (`/status-update`, `/meeting-notes`, etc.) will read and update this file automatically."

## Output Format

### {Project Name} — Kickoff Pack — {Date}

**Client:** {client name} | **Type:** {project type} | **Lead:** {internal lead from team.md}

---

#### Kickoff Readiness

{One-line signal at the top of every kickoff. Score 1-5 based on how much is actually
known. Be honest — a kickoff with too little info should be flagged, not papered over.}

**Readiness: {1-5}/5** — {one-line summary}

{If 3 or below, add a blunt note:}
> **Heads up:** This kickoff is running with thin info. Specifically: {what's missing —
> e.g., "no confirmed budget, no client decision-maker named, deliverables loosely defined"}.
> Consider running `/brief-sharpener` before the workshop, or building
> a discovery phase into Week 1.

---

#### RACI Matrix

{Auto-generate from project type and team. R = Responsible, A = Accountable,
C = Consulted, I = Informed.}

| Activity | {Person 1} | {Person 2} | {Person 3} | Client |
|----------|-----------|-----------|-----------|--------|
| Creative direction | {R/A/C/I} | {R/A/C/I} | {R/A/C/I} | C |
| Design execution | {R/A/C/I} | {R/A/C/I} | {R/A/C/I} | I |
| Client communication | {R/A/C/I} | {R/A/C/I} | {R/A/C/I} | R |
| Timeline management | {R/A/C/I} | {R/A/C/I} | {R/A/C/I} | I |
| Feedback consolidation | {R/A/C/I} | {R/A/C/I} | {R/A/C/I} | R |
| Final sign-off | {R/A/C/I} | {R/A/C/I} | {R/A/C/I} | A |

{Adapt rows to the project type:
- Brand/identity → add: Brand strategy, Naming, Guidelines development
- Campaign → add: Concept development, Media planning, Production
- Digital product → add: UX research, Wireframes, Development, QA
- Use `team.md` to assign names to roles where possible.}

**Single points of failure:** {Flag any activity where only one person is R or A and
there's no backup. If `/resource-conflict` flagged availability risks, note them here.}

#### Key Dates
| Milestone | Date | Dependencies | Owner |
|-----------|------|--------------|-------|
| {milestone} | {date} | {dependency} | {person} |

{If `/timeline-generator` ran earlier, pull milestones directly. Highlight which dates
are on the critical path.}

#### Risk Register
| Risk | Likelihood | Impact | Mitigation | Owner |
|------|-----------|--------|------------|-------|
| {risk} | {H/M/L} | {H/M/L} | {what to do about it} | {person} |

{Flag risks informed by `learnings.md` — if similar projects have gone wrong before,
call it out explicitly: "Previous brand projects with committee sign-off have averaged
2 weeks of revision loops. Build this into the timeline."}

{Always include these standard risks where applicable:}
- Scope creep during feedback rounds
- Key person unavailability (especially if single point of failure flagged in RACI)
- Client stakeholder changes mid-project
- Third-party dependency delays

{Tailor risk severity based on team familiarity with client:
- New client → higher risk on communication and approval process
- Returning client → lower risk on relationship, but watch for assumption drift}

#### Internal Brief

{A concise, opinionated summary the creative team can work from. Not the client brief
restated — the internal translation.}

**The client said:** {their words}
**What they actually need:** {your interpretation}
**Where the creative opportunity is:** {the exciting part}
**What "good" looks like for this client:** {calibrate expectations}
**Watch out for:** {traps, assumptions, things that have gone wrong before}

{If `/creative-brief` ran earlier, reference its objectives, audience, and deliverables
directly. Add the internal translation layer on top.}

#### Definition of Done

{What "this project succeeded" actually looks like — concrete, observable, agreed.
Most kickoffs skip this and pay for it at sign-off. Don't.}

**Client-side success looks like:**
- {observable outcome 1 — e.g., "Brand guidelines delivered, accepted by the board, and rolled out to 3 markets by end of Q2"}
- {observable outcome 2}
- {observable outcome 3}

**Our-side success looks like:**
- {what the agency wants from this — e.g., "Case-study-worthy work in a sector we want to grow in"}
- {team / craft / learning goal}

**Explicitly out of scope:** {1-2 things the client might assume are included but aren't — pre-empt scope creep}

#### Communication Cadence

{RACI says who. This says how often. Adapt to the team distribution selected in Step 4.}

| Ritual | Frequency | Attendees | Format | Owner |
|--------|-----------|-----------|--------|-------|
| Internal stand-up | {daily / 2x weekly / weekly} | Internal team | {15-min Slack huddle / async thread / live} | PM |
| Client check-in | {weekly / fortnightly} | Internal lead + client lead | 30-min video call | Account lead |
| Review milestone | {at each phase gate} | Internal team + client decision-maker(s) | {format} | CD or PM |
| Slack channel | continuous | All | `#proj-{slug}` | PM (creates) |

{For distributed teams across timezones, default async stand-ups + one weekly live overlap.
For co-located teams, default daily live stand-up.
For new client + first project, add a "ways of working" 30-min in week 1.}

#### First Week Plan

{Concrete actions for the first 5 working days. Kickoff packs are most useful when
week 1 is real, not aspirational.}

| Day | Action | Owner | Output |
|-----|--------|-------|--------|
| Day 1 | {action — e.g., "Run kickoff workshop"} | {person} | {output — e.g., "Workshop notes, confirmed RACI"} |
| Day 2 | {action} | {person} | {output} |
| Day 3 | {action} | {person} | {output} |
| Day 4 | {action} | {person} | {output} |
| Day 5 | {action — should be a tangible artefact, not just a meeting} | {person} | {output} |

**End of week 1, the team should have:** {1-line concrete state — e.g., "A confirmed
brief, a populated Notion workspace, the first creative territories sketched, and a
client check-in scheduled."}

#### Kickoff Workshop

{Tailored to the selected format and project type. Include facilitator notes and pre-work.}

**Format:** {selected format}
**Duration:** {time}
**Attendees:** {list — pull from team and add client contacts where appropriate}

**Pre-work (send 2 days before):**
- {Pre-work item — e.g., "Review the brief and SOW"}
- {Pre-work item — e.g., "Come with 3 reference examples you think are relevant"}
- {Pre-work item — e.g., "Note any questions about scope or deliverables"}

**Agenda:**

{Adapt based on project type and format:}

**Brand / Identity:**
| Time | Activity | Lead | Notes for facilitator |
|------|----------|------|-----------------------|
| 0:00 | Welcome & project overview | PM | Set the context. Keep to 5 mins. |
| 0:10 | Client context & objectives | Account lead | What the client said vs. what they need. Use the internal brief. |
| 0:25 | Competitive & cultural landscape | Strategist | Share any `/pitch-research` output. Keep visual — show, don't tell. |
| 0:40 | Creative territories discussion | CD | Open floor. No bad ideas yet. Capture everything. |
| 1:00 | Break | — | 10 mins |
| 1:10 | Deliverables & timeline walk-through | PM | Reference the timeline. Flag critical path dates. |
| 1:25 | Roles & responsibilities | PM | Walk through the RACI. Make sure everyone knows their lane. |
| 1:35 | Risks & watch-outs | PM | Don't skip this. Past project learnings go here. |
| 1:45 | Questions & next steps | PM | First deliverable, first check-in date, any blockers. |

**Campaign:**
| Time | Activity | Lead | Notes for facilitator |
|------|----------|------|-----------------------|
| 0:00 | Welcome & brief overview | PM | 5 mins max. |
| 0:10 | Audience & insight | Strategist | Who are we talking to? What's the tension? |
| 0:25 | Channel & format constraints | PM | What's fixed, what's flexible. |
| 0:35 | Creative springboards | CD | Open concepting. Energy matters here — keep it loose. |
| 0:55 | Timeline & production realities | PM/Producer | What needs to happen when. Flag lead times. |
| 1:10 | Roles & next steps | PM | First deliverable and date. |

**Digital Product:**
| Time | Activity | Lead | Notes for facilitator |
|------|----------|------|-----------------------|
| 0:00 | Welcome & project overview | PM | 5 mins. |
| 0:10 | User needs & research summary | UX lead | What we know, what we need to find out. |
| 0:25 | Technical constraints & architecture | Dev lead | Platform, integrations, limitations. |
| 0:40 | Design direction & references | CD | Visual territory. What the client responds to. |
| 0:55 | Sprint structure & milestones | PM | How the build will run. Review cadence. |
| 1:10 | Roles, risks & next steps | PM | RACI walk-through. First deliverable. |

**Generic / Other project type (fallback):**
| Time | Activity | Lead | Notes for facilitator |
|------|----------|------|-----------------------|
| 0:00 | Welcome & project overview | PM | 5 mins. |
| 0:10 | What the client said vs what they need | Account lead | Use the internal brief. |
| 0:25 | Scope, deliverables, definition of done | PM | Walk through. Get explicit agreement. |
| 0:40 | Approach & first creative directions | CD | Show, don't tell. |
| 1:00 | Timeline & key dates | PM | Critical path. |
| 1:15 | Roles, communication cadence, risks | PM | RACI walk-through, comms ritual setup. |
| 1:30 | First week plan & next steps | PM | Day-by-day for week 1. |

**Async (no live workshop):**

Replace the live agenda with a structured async kickoff doc, posted to the team's Slack
channel or Notion workspace. Each section has an explicit *response action* with a
deadline so async doesn't become silent.

| Section | Content | Response action | Deadline |
|---------|---------|----------------|----------|
| Project overview | Internal brief (above) | React with 👀 once read | Within 24h |
| RACI matrix | Full table | Confirm or push back on your row | Within 48h |
| Definition of done | Success criteria | Add anything missing in thread | Within 48h |
| Timeline & key dates | Milestone table | Flag any conflicts | Within 48h |
| Risk register | Risk table | Add any risks you see | Within 72h |
| Communication cadence | Ritual table | Confirm availability for live rituals | Within 48h |
| First week plan | Day-by-day | Confirm Day 1-5 actions | Within 24h |
| Slack channel | `#proj-{slug}` created and pinned | Join | Immediately |

End the async doc with: "If anything in here is wrong, missing, or unclear, post in
thread. Silence will be read as agreement by {date}."

{For remote live formats, shorten each section by ~30%. For 60-minute formats, cut the
landscape/competitive section and merge roles into the closing.}

---

#### Slack Announcement

{Compact version for a single Slack message to announce the project to the team.}

*New project kickoff: {Project Name}*

**Client:** {client name}
**Type:** {project type}
**Team:** {names, comma-separated}
**Kickoff:** {date and format}
**First deliverable:** {deliverable} — due {date}
**Key risk:** {single biggest risk, one line}
**Timeline:** {total duration}, delivery {end date}

{link to full kickoff doc if available}

---

## MCP Integration

### Google Calendar

Check whether Google Calendar tools are available in the current tool list (look for
tools prefixed with `mcp__claude_ai_Google_Calendar__`).

**If Google Calendar IS available** → after generating the kickoff pack, offer:
"Want me to schedule the kickoff workshop? I'll create a calendar event with the
agenda and pre-work in the description."

If yes, use `gcal_create_event` to create the event with:
- Title: "{Project Name} — Kickoff Workshop"
- Duration: based on selected format
- Description: agenda, pre-work list, and link to kickoff doc
- Attendees: team members (if email addresses are available from `team.md`)

**If Google Calendar is NOT available** → skip the offer. The kickoff pack stands alone.

### Figma

Check whether Figma tools are available (look for tools prefixed with
`mcp__claude_ai_Figma__` or `mcp__plugin_figma_figma__`).

**If Figma MCP IS available** → offer: "Want me to create this kickoff pack as a
designed Figma doc?"

**If Figma MCP is NOT available** → the markdown above is the complete output.

### Notion

Check whether Notion tools are available (look for tools prefixed with
`mcp__claude_ai_Notion__`).

**If Notion MCP IS available** → after the kickoff pack is generated, offer:
"Want me to create the project workspace in Notion? I'll set up a project page with
the brief, RACI, key dates, risks, comms cadence, and first-week plan as sub-sections,
ready for the team."

If yes, use `notion-create-pages` to create a parent project page titled
`{Project Name} — Kickoff` with the kickoff pack content structured into Notion blocks.
Apply `visual-style.md` for any cover art or icon choices if relevant.

**If Notion MCP is NOT available** → skip the offer.

## Skill Chains

### Upstream (what feeds project-kickoff)

After generating the kickoff pack, if upstream skills were NOT run but would have been
useful, suggest 1-2:

- If no timeline → "Run `/timeline-generator` to build a detailed project timeline — the kickoff pack will reference milestones directly."
- If no SOW → "Run `/sow-generator` to formalise scope and terms before kicking off — the team needs to know what's committed."
- If kickoff readiness was 3 or below → "Run `/brief-sharpener` before the workshop — there's too much unknown for the team to land cleanly."

### Downstream (what project-kickoff triggers)

Based on the kickoff content, suggest the most relevant next action:

- **Immediately after** the kickoff workshop → "Run `/meeting-notes` on the kickoff session to capture decisions, actions, and any scope clarifications. They'll be written back to the project state file automatically."
- **If RACI flagged single points of failure** → "Run `/resource-conflict` — there are people on this project with no backup, and it's worth checking against the wider roster before week 1."
- **End of week 1** → "Run `/status-update` at the end of week 1 to confirm the team is on track and surface any drift early."
- **After the first review round** → "Run `/feedback-consolidator` to turn client feedback into action items and update the project state."

Only suggest 1-2 chains at a time — pick the most relevant for where the user is.

## Edge Cases
- Very early stage / no brief yet → produce a lighter "discovery kickoff" format, mark Kickoff Readiness 1-2/5, suggest `/brief-sharpener`.
- Solo freelancer project → skip RACI (or collapse to a 2-column "me / client" version), focus on timeline, brief, definition of done, and risks.
- Repeat client → pull relevant context from `learnings.md` and flag what worked / didn't. Mention specific past projects by name.
- Massive scope → break into workstreams with separate RACI rows per workstream and a workstream-level First Week Plan each.
- Team hasn't worked together before → flag communication risk in the risk register, add a "ways of working" agenda item to the workshop, default comms cadence to higher frequency.
- Async team across time zones → default to async format, find the smallest live overlap window for the kickoff, flag timezone overlaps in the comms cadence.
- No upstream skills run → skill works standalone, just with less auto-populated data and a lower kickoff readiness score.
- Project type not in the agenda variants → use the Generic / Other workshop fallback.

### What this skill can't do

This skill generates a kickoff pack for one project at a time, in isolation. It doesn't
yet track whether the kickoff *worked* — i.e., whether the team actually hit the first
deliverable on time, whether the comms cadence held, whether the risks materialised. A
deeper version would compare this kickoff against past kickoffs in `learnings.md`, score
the predicted likelihood of success based on prior patterns, and report back after week 1
on which assumptions held. For now, run `/status-update` at the end of week
1 to close the loop manually, and `/post-mortem` at project end to feed the
learnings back into the brain.

---
*CreativeStack by Cameron Jones — jones.cam*
