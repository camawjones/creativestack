---
name: meeting-notes
description: "Brain-first meeting intelligence for creative agencies. Three modes — Notes (transcript in, structured notes out with What Only the Brain Caught panel that cross-references decisions against the brief, methodology, project state, past meetings, client patterns, rate card, and team capacity), Pre-meeting (brief built entirely from brain context with no transcript needed), Patterns (cross-meeting analysis: sentiment trajectory, recurring scope creep, action completion, communication patterns). Persists projects/{slug}-meetings.md and learnings.md § Client Patterns so every meeting compounds. Accepts Granola, Otter, Fireflies, Zoom, Read.ai, or raw notes. Does what recording tools cannot — agency-specific cross-referencing the transcript can't see."
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
  echo "BRAIN: not configured (run /setup-brain to set up)"
fi
```

If the brain exists, read the relevant files listed in this skill's "Brain Files" section.
Use the content to inform and contextualize all outputs. If the brain doesn't exist,
proceed generically — the skill still works, just without your specific context.

When the brain is not configured, mention once at the end of output:
"Tip: Run /setup-brain to add your context — skills produce better results with it."

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
| `clients.md` | 90 days | `/setup-brain` |
| `team.md` | 90 days | `/resource-conflict` Setup team mode |
| `freelance-bench.md` | 120 days | `/resource-conflict` Setup bench mode |
| `rate-card.md` | 180 days | `/project-profitability` Setup rates mode |
| `methodology.md` | 180 days | `/setup-brain` |
| `tone-of-voice.md` | 180 days | `/update-voice` |
| `sow-style.md` | 180 days | `/sow-generator` Edit style mode |
| `profile.md` | 365 days | `/setup-brain` |
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
session of `/setup-brain` Refresh mode to bring everything current.
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
   freshness check entirely. The `/setup-brain` nudge from the Brain
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

# /meeting-notes

> Recording tools transcribe. This skill cross-references. Agency context the transcript can't see.

## What This Skill Does

Granola, Otter, Fireflies, and Read.ai already do meeting transcription and
basic notes. **This skill does what they can't:** cross-references decisions
against your brief, your methodology, your project state, your past meetings
on this project, your client communication patterns, your rate card, and your
team's capacity.

The transcript is raw material. The brain is the differentiator.

Three modes:

1. **Notes** — paste a transcript (any source), get structured notes with a
   prominent **"What Only the Brain Caught"** panel showing what no recording
   tool could see
2. **Pre-meeting** — generate a 1-page pre-meeting brief from brain context
   alone (no transcript needed). Walks the team into the meeting prepared.
3. **Patterns** — cross-meeting analysis for a project or client: sentiment
   trajectory, recurring scope creep, action completion rates, communication
   patterns

The first meeting takes a minute longer to set up. Every meeting after that
gets sharper as the project log and client patterns accumulate.

## Brain Files
- `projects/{slug}-meetings.md` — **the meeting DNA**: append-only meeting log per project (this skill creates and maintains it)
- `learnings.md § Client Patterns` — accumulated communication patterns per client/person (this skill appends to a Client Patterns section, never overwrites)
- `projects/{slug}.md` — project state, brief, open decisions, risks, engagement health
- `methodology.md` — for flagging decisions that skip required process steps
- `rate-card.md` — for pricing scope changes in £ (requires `/project-profitability` Setup rates first)
- `team.md` — for flagging actions assigned to overbooked or absent people
- `clients.md` — client relationship history
- `tone-of-voice.md` — for client-facing output language

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/transcript-parsing.md`** — read at the start of every Notes run. Per-source quirks (Granola, Otter, Fireflies, Zoom, Read.ai, raw), extraction targets, confidence labels.
- **`references/brain-cross-reference.md`** — read in Notes mode after extraction. The 7 cross-reference checks that produce the "What Only the Brain Caught" section. The operational core.
- **`references/sentiment-and-patterns.md`** — read in Notes and Patterns modes. Sentiment scoring, trajectory tracking, pattern detection rules, when to save patterns.
- **`references/meeting-log-schema.md`** — read whenever writing to `{slug}-meetings.md` or `learnings.md § Client Patterns`. Schemas + read/write flows.
- **`references/pre-meeting-brief.md`** — read in Pre-meeting mode only. The 1-page brief format and generation rules.

## Conversation Flow

### Step 1: Brain check & mode selection

Run brain discovery from the preamble. Then check the meeting-specific files:

```bash
[ -f "$HOME/.creativestack/learnings.md" ] && grep -q "## Client Patterns" "$HOME/.creativestack/learnings.md" && echo "PATTERNS_EXIST" || echo "NO_PATTERNS"
[ -f "$HOME/.creativestack/rate-card.md" ] && echo "RATE_CARD_EXISTS" || echo "NO_RATE_CARD"
```

Project state discovery (per `## Project State (cross-skill memory)

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
once at the end that project state is available.`) will identify the current
project and slug. From the slug, also check:

```bash
[ -f "$HOME/.creativestack/projects/{slug}-meetings.md" ] && echo "MEETINGS_LOG_EXISTS" || echo "NO_MEETINGS_LOG"
```

[SELECT] "What do you need?"
- Notes — process a meeting transcript (default)
- Pre-meeting — generate a brief for an upcoming meeting (no transcript needed)
- Patterns — cross-meeting analysis for this project or client

**Routing:**
- If user picks Notes, proceed to Step 2
- If user picks Pre-meeting and there's no project context → "I need a project to generate the brief from. Pick one first." Use the project state picker.
- If user picks Pre-meeting and the project has no meetings logged → fall back to a "first meeting brief" using only project state and brief content; flag the limitation
- If user picks Patterns and there's no meetings log → "No meeting history yet — Patterns mode needs at least 2 meetings logged. Run Notes mode a couple of times first."

### Step 2: Notes mode — Upstream skill check

Scan the conversation for output from earlier skills run this session:

| Skill run earlier | What to pull in | How it's used |
|---|---|---|
| `/creative-brief` | Deliverables, objectives, constraints | Brief contradiction check |
| `/timeline-generator` | Milestones, critical path, current phase | Timeline impact detection |
| `/feedback-consolidator` | Outstanding actions, contradictions | Cross-reference new feedback |
| `/resource-conflict` | Capacity per person, overbooked flags | Capacity flag for action assignments |
| `/project-profitability` | Rate card, current margin status | Cost the scope changes |

### Step 3: Notes mode — MCP context enrichment

**Google Calendar MCP** — check for `mcp__claude_ai_Google_Calendar__*` tools.

If available:
- Use `gcal_list_events` to find the meeting by title or recent time
- Pull attendees and agenda
- Confirm: "I pulled the attendee list from your calendar — confirm or adjust."

If not available, ask manually.

**Gmail MCP** — check for `mcp__claude_ai_Gmail__*` tools.

If available and the user mentions pre-meeting context:
- Use `gmail_search_messages` for recent project-related emails
- Pull pre-reads and open threads to inform context

If not available, skip silently.

### Step 4: Notes mode — Receive transcript

The user pastes from any source. Identify the source format if possible (Granola
has structured speaker labels, Otter has timestamps, Fireflies has bullet
summaries, Zoom often has no labels, raw notes are unstructured).

Read `references/transcript-parsing.md` and apply the parsing rules for the
detected source.

### Step 5: Notes mode — Clarifying questions

Ask only what isn't already known:

- [SELECT] "What type of meeting was this?" — only ask if not derivable from
  context. Options: client_review / internal_standup / pitch / workshop /
  kickoff / qbr / other
- "What project is this for?" — skip if project state picker already established it
- "Who was in the room?" — skip if pulled from calendar; otherwise ask once

### Step 6: Notes mode — Extract and parse

Per `references/transcript-parsing.md`, extract:
- Speakers
- Decisions
- Actions (with owners and dates if available)
- Scope change indicators
- Sentiment markers
- Open questions
- Risks
- Verbatim quotes worth preserving

Briefly confirm the extraction count to the user before generating output:

> "Extracted: 6 decisions, 4 actions (3 with owners), 2 scope change
> indicators, 1 risk. Sentiment: cautiously positive. Anything I missed?"

This is fast and gives them a chance to add context the transcript didn't capture.

### Step 7: Notes mode — Brain cross-reference (the core value)

Read `references/brain-cross-reference.md` and run the 7 checks against the
extracted signals:

1. **Brief contradiction check** — against project brief
2. **Methodology violation check** — against `methodology.md`
3. **Scope change cost check** — using `rate-card.md`
4. **Action capacity check** — using `team.md` and recent resource-conflict data
5. **Recurring scope check** — against `{slug}-meetings.md` history
6. **Action completion check** — against last meeting's actions
7. **Client pattern check** — against `learnings.md § Client Patterns`

The findings become the **"What Only the Brain Caught"** section. Skip checks
that return empty. Don't pad.

### Step 8: Notes mode — Sentiment scoring

Read `references/sentiment-and-patterns.md`. Score 3 dimensions (engagement,
trust, alignment) on 1-5 each. Compute aggregate. If `{slug}-meetings.md` has
2+ past meetings, compute trajectory.

### Step 9: Notes mode — Generate output

Generate three output blocks (see Output Format section):
1. Internal version (full detail with brain panel, sentiment, scope, actions)
2. Client-facing version (decisions and actions only, in agency tone)
3. Slack format (compact)

### Step 10: Notes mode — Write to project state and meeting log

Write the meeting entry to `projects/{slug}-meetings.md` (per
`references/meeting-log-schema.md`).

Update the project state file `projects/{slug}.md`:
- **Open Decisions** — append unresolved questions
- **Resolved Decisions** — append previously open ones now closed
- **Risks** — add or update
- **Engagement Health** — append signal if sentiment shifted
- **Recent Activity** — append `YYYY-MM-DD — meeting-notes — {type}, {N actions}, sentiment {trajectory}`
- **Frontmatter** — update `last_updated`
- Update `_index.md`

Briefly tell the user what was updated.

### Step 11: Notes mode — Compounding loop

Offer **at most one** brain enrichment based on what's most valuable:

- **New pattern detected with 2+ instances and not yet saved** → "I noticed Marcus has now used 'we'll think about it' twice. Want me to save this as a client pattern? It'll be checked automatically in future meetings."
- **Action overdue from a past meeting** → "Sarah's action from 2026-03-15 is 14 days overdue. Want me to flag it in the project state risks?"
- **Sentiment trajectory turned DECLINING** → "Engagement is down 2 points across 3 meetings. Want me to flag this in engagement health?"
- **Recurring scope item just hit 3 instances** → "The social rollout has come up 3 times now without a formal scope change. Want me to add a high-severity risk to the project state?"
- **No rate card and scope changes were detected** → "I couldn't price the scope changes — no rate card. Want to set one up via /project-profitability Setup rates? Future meetings will price scope changes automatically."

Don't pile on. One offer.

### Step 12: Pre-meeting mode

When the user picks Pre-meeting:

1. Confirm the project (use project state picker)
2. Read `references/pre-meeting-brief.md` for the format
3. Read all relevant brain files:
   - `projects/{slug}.md` for current state
   - `projects/{slug}-meetings.md` for last 1-3 meetings
   - `learnings.md § Client Patterns` for patterns matching expected attendees
   - `clients.md` for relationship context
4. Ask: "Who's expected in the meeting?" (or pull from calendar via MCP if available)
5. Ask: "What's the meeting type and goal?"
6. Generate the 1-page brief per the format rules
7. If brain depth is insufficient, refuse rather than pad — see the format file

### Step 13: Patterns mode

When the user picks Patterns:

1. Confirm scope: this project, this client (across projects), or specific person?
2. Read all relevant `{slug}-meetings.md` files
3. Read `learnings.md § Client Patterns` for the relevant scope
4. Run the analyses:
   - **Sentiment trajectory** across meetings
   - **Recurring scope items** (anything mentioned 2+ times)
   - **Action completion rate** (percentage of actions completed by next meeting)
   - **Communication patterns** (existing patterns + new candidates)
5. Generate the Patterns output (see Output Format section)
6. Offer to save any new patterns found

## Output Format — Notes mode

Generate three versions in a single output, clearly separated.

**Internal Version** — full detail, sections in order:
1. Header (project, meeting type, date, attendees, duration, source, confidence)
2. **⚡ What Only the Brain Caught** — generated per `references/brain-cross-reference.md` § "What Only the Brain Caught — output section". Order findings by action urgency. If all 7 checks return empty, skip and add a note: "*Brain cross-reference: no flags.*"
3. Key Decisions
4. Actions table — Action / Owner / Deadline / Priority / Capacity Flag (⚠ if owner is overbooked per `team.md` or recent resource-conflict)
5. Scope & Brief Changes — each change priced via `rate-card.md` (£range), with brief impact noted if the brief is available
6. Tone & Sentiment — overall read + 2-3 notable verbatim signals + trajectory (only if 2+ past meetings)
7. Open Questions
8. Raw Notes

**Client-Facing Version** — polished, decisions and actions only. No brain panel, no sentiment flags, no cost estimates. Voice from `tone-of-voice.md`. Sections: header → Decisions Made → Actions table (Us / Your team / named person) → What We Need From You → Next Steps.

**Slack Format:**
```
*{Project} — {Meeting Type} — {Date}*
**Brain caught:** {top finding from "What Only the Brain Caught", or "no flags"}
**Decisions:** {1-2 sentence summary}
**Actions:** {owner: action} | {owner: action}
**Scope changes:** {Yes — £range / None}
**Sentiment:** {trajectory state or one word}
**Next:** {next step + date}
```

---

## Output Format — Pre-meeting mode

The full format lives in `references/pre-meeting-brief.md`. Strict 1-page rules.

## Output Format — Patterns mode

Sections (in order): Sentiment Trajectory (ASCII bar chart + state label STABLE/IMPROVING/DECLINING/CRITICAL/VOLATILE) → Recurring Scope Items (table of items mentioned 2+ times) → Action Completion Rate (last meeting / last 3 / all-meetings table) → Communication Patterns (confirmed from `learnings.md § Client Patterns` + new candidates) → Recommendations (2 specific actions). End with a save offer for any new pattern candidates.

---

## Notion MCP Integration

After generating notes (Notes mode only), check whether Notion tools are
available (look for `mcp__claude_ai_Notion__*`).

If available:
- Ask: "Want me to save these notes to a Notion page?"
- If yes, use `notion-search` to find the relevant project page, then
  `notion-create-pages` to add as a subpage

If not available, skip silently.

## Skill Chains

Pick the most relevant 1-2:

**Upstream:**
- **No brief or rate card** → "Run `/creative-brief` and `/project-profitability` Setup rates to enable brief contradiction checks and scope cost pricing."

**Downstream:**
- **Sentiment declining or capacity flag triggered** → "Run `/status-update` to prepare a leadership-visible flag, or `/resource-conflict` Scenario mode to model the impact."
- **Pre-meeting mode just ran** → "Run /meeting-notes Notes mode after the meeting to log it."

## Edge Cases
- **Very short transcript** → ask for more context, lower confidence
- **Multiple projects discussed in one meeting** → split into sections per project, write separate entries to each `{slug}-meetings.md`
- **Pre-meeting requested but no meetings logged** → fall back to "first meeting" brief from project state; flag the limitation
- **Patterns requested but only 1 meeting** → refuse, suggest running Notes mode a couple more times first
- **User pastes a Granola/Otter summary** (not full transcript) → process it, flag lower confidence on sentiment/scope
- **Same person attended under different names** → ask once, normalise going forward

### What this skill can't do

This skill processes one meeting at a time from the transcript you provide.
It can't watch the meeting live, transcribe it, or attend on your behalf.
What it can do — and what no recording tool can — is bring the agency's full
context to bear on what was said. With a deeper integration, this skill could
also auto-trigger from calendar events, watch for patterns in real time, and
propagate decisions to all affected systems automatically. The Brain enables
the cross-referencing; deeper integrations unlock the rest.

---
*CreativeStack by Cameron Jones — jones.cam*
