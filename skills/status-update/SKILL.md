---
name: status-update
description: Generate project status updates for any combination of three audiences — client, leadership, creative team — from a paste of raw inputs (Slack, emails, meeting notes, voice memo transcripts, or quick prose). Reads persistent project state for trends, decisions, engagement health, budget, and timeline so PMs don't re-enter context every week. For creative agency PMs and account managers.
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
  echo "BRAIN: not configured (run /creativestack:setup to set up)"
fi
```

If the brain exists, read the relevant files listed in this skill's "Brain Files" section.
Use the content to inform and contextualize all outputs. If the brain doesn't exist,
proceed generically — the skill still works, just without your specific context.

When the brain is not configured, mention once at the end of output:
"Tip: Run /creativestack:setup to add your context — skills produce better results with it."

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
| `case-studies.md` | 90 days | `/creativestack:case-study` |
| `clients.md` | 90 days | `/creativestack:setup` |
| `team.md` | 90 days | `/creativestack:resource-conflict` Setup team mode |
| `freelance-bench.md` | 120 days | `/creativestack:resource-conflict` Setup bench mode |
| `rate-card.md` | 180 days | `/creativestack:project-profitability` Setup rates mode |
| `methodology.md` | 180 days | `/creativestack:setup` |
| `tone-of-voice.md` | 180 days | `/creativestack:update-voice` |
| `sow-style.md` | 180 days | `/creativestack:sow-generator` Edit style mode |
| `profile.md` | 365 days | `/creativestack:setup` |
| `projects/*` | N/A | living documents — updated by their own skills |
| `prospects/*` | 90 days | `/creativestack:pitch-research` Refresh mode |

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
session of `/creativestack:setup` Refresh mode to bring everything current.
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
   freshness check entirely. The `/creativestack:setup` nudge from the Brain
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
"Tip: Project state is off. Pick 'Full kickoff' or run `/creativestack:project-kickoff`
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

> "Want to set this project up properly with `/creativestack:project-kickoff` (5–10 min,
> full kickoff pack with RACI, risk register, workshop agenda), or just spin up a quick
> state file so we can keep moving (30 sec)?"

Use `AskUserQuestion` with options: `Full kickoff` / `Quick start`.

- **Full kickoff** → tell the user to run `/creativestack:project-kickoff` first. That
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

# /creativestack:status-update

> Paste anything you've got from this week. I'll handle the rest.

## Brain Files
- `profile.md` (for context)
- `tone-of-voice.md` (for client-facing language)
- `clients.md` (for client relationship context)
- `learnings.md` (for past project patterns that inform risk assessment)
- `learnings.md § Client Patterns` (per-stakeholder communication patterns; from `/creativestack:meeting-notes`)
- `projects/{slug}.md` (project state — primary spine, no need to re-ask context)
- `projects/{slug}-meetings.md` (meeting log with sentiment scores per meeting — used to compute the engagement trajectory across the last 4 meetings; from `/creativestack:meeting-notes`)

## What This Skill Does

Takes raw inputs from a PM's week (Slack threads, emails, meeting notes, voice memo
transcripts, or just a few lines of prose) and produces tailored status updates for
the audiences the PM picks: client (polished), leadership (honest, flags risks),
creative team (what they need to know), and Slack (compact).

Reads the project state file for everything that doesn't need to be re-asked: trend
direction, open decisions, engagement signals, budget, timeline. Writes back the new
status, updated decisions, engagement signals, and a Recent Activity entry — so next
week's update has everything from this week available automatically.

## Conversation Flow

### Step 1: Project discovery

Follow the project state discovery + picker protocol above. If no state file exists for
the project, follow the bootstrap protocol (full kickoff vs quick start).

### Step 2: Load context

Read the full project state file. From it, derive:
- Last status and trend (for week-over-week comparison — no need to ask)
- Open decisions still pending (carry forward)
- Engagement Health baseline + current signals
- Budget & Pace (if present — written by `/creativestack:timesheet-summary` or `/creativestack:project-profitability`)
- Timeline status (if present — written by `/creativestack:timeline-generator` or `/creativestack:project-kickoff`)
- Risks (carried into Flags section unless resolved)

**Sentiment trajectory from meetings:** if `projects/{slug}-meetings.md` exists with 2+ meetings logged, read the sentiment scores (engagement, trust, alignment) from each meeting and compute the trajectory. The trajectory is the most valuable input to the leadership version's risk assessment — a project at "On Track" status with engagement scores trending 4 → 4 → 3 → 2 over the last 4 meetings is actually in trouble. Surface this in the leadership version explicitly: "Status is On Track but sentiment is declining — engagement down 2 points across the last 4 meetings. Worth a check-in conversation outside the regular cadence."

**Client communication patterns:** if `learnings.md § Client Patterns` exists, filter to the stakeholders on this project. Apply to the client version's framing and the leadership version's "watch for" notes. Example: "Marcus has used 'we'll think about it' twice in the last month — per Client Patterns this preceded a no in 3 of 3 past instances. Treat the deferred typography decision as a soft no in the leadership version."

If `learnings.md` is in the brain, scan for client-specific or project-type-specific
patterns that should inform risk framing. Mention them inline when used:
"Based on past projects: {insight}. Flagged this as a risk."

### Step 3: Audience selection

Use `AskUserQuestion` (multiSelect) to ask which audiences are needed today:
- Client-facing
- Leadership
- Creative team
- Slack format

Default selection: Client. Most days a PM only needs one or two — don't generate four
versions by default.

### Step 4: Get the inputs

Single open prompt:

> "Paste anything from this week — Slack threads, client emails, meeting notes, voice
> memo transcripts, or just a few lines about what happened. Type 'quiet' if it was
> a steady week with nothing significant to report."

Accept whatever the user gives. Extract structure from the paste:
- What happened (progress, decisions made, deliveries)
- New blockers or risks
- Anything client-side that signals engagement change
- Open questions / decisions raised but not resolved
- Wins worth surfacing

Don't ask follow-up questions for things already covered by the paste or the state file.
Only ask about things genuinely missing AND important — typically zero or one question.
A common useful one: "Anything internal that shouldn't go in the client version?"

### Step 5: Generate the requested versions

Read `references/output-formats.md` to get the templates for the audiences the user
selected. Generate only the requested versions.

Apply tone from `tone-of-voice.md` to the client version. Apply learnings from
`learnings.md` as risk context in the leadership version. Use the project state's
Engagement Health signals to flag GREEN/AMBER/RED in the leadership version.

### Step 6: Write back to project state

Update the state file (using the write protocol above):

1. **Frontmatter** — set new `status`, `trend`, `last_updated`, `phase_week` if changed
2. **Status History** — prepend a new line for this week (prune to last 12)
3. **Open Decisions** — add any new decisions from the paste; remove resolved ones
4. **Resolved Decisions** — append any decisions that were resolved this week
5. **Risks** — add new risks; update severity on existing ones; remove resolved
6. **Engagement Health** — update signals if behaviour shifted this week
7. **Recent Activity** — append: `YYYY-MM-DD — status-update — {audiences generated}`
8. **Index** — update `_index.md` with the project's new last_touched and any changed
   frontmatter (status, trend, phase)

After writing, briefly tell the user what was updated in state — one or two lines.
"Updated state: status now At Risk (↓), 1 new decision logged (CMS direction), engagement
shifted to AMBER."

## Steady State Mode

If the user says "quiet", "nothing happened", "business as usual", or similar, don't
skip the update. Generate a brief "steady state" version of each requested audience
straight from the project state file:

- **Client-facing:** Proactive and reassuring. "Everything's moving as planned." Pull
  next milestone from Timeline section.
- **Leadership:** "On track, no escalation needed." Pull current phase + next milestone.
- **Creative team:** "No changes to direction or deadlines. Here's what's on deck."

Keep each version to 3-4 lines maximum. Still update Status History (mark trend as → )
and Recent Activity. Silence is the worst thing a PM can do — the point is maintaining
communication rhythm, not filling space.

## Skill Chains

After generating the update, suggest 1-2 next actions based on what's in the state:

- Status moved to Off Track or Risks section grew → "Run `/creativestack:timeline-generator` to model the slip impact."
- Capacity risks surfaced → "Run `/creativestack:resource-conflict` to check team availability."
- Budget & Pace section is empty or stale (>14 days) → "Run `/creativestack:timesheet-summary` to refresh burn rate and projections."
- Engagement Health is AMBER or RED → "Consider `/creativestack:meeting-notes` on this week's client calls to capture sentiment automatically."
- Project is wrapping up → "Run `/creativestack:post-mortem` when this closes — it reads the full state history."

Pick the most relevant 1-2. Don't list them all.

## Edge Cases
- No blockers → still include the section with "No current blockers" rather than omitting
- Sensitive internal issue → ensure it only appears in leadership version
- Client relationship tension → flag in leadership, soften in client version, translate impact for creative team
- Nothing happened this week → use Steady State Mode (see above)
- Engagement Health section is empty → omit from leadership version, don't force it
- Multiple projects for same client → check `_index.md` for cross-project patterns (e.g., disengaging from project A but active on project B may signal reprioritisation, not churn)
- User explicitly skips state writeback ("don't save this") → generate the update, skip steps 6 in the flow, mention that state wasn't updated

### What this skill can't do

This skill generates status updates for one project at a time. A dedicated AI partner
could draft all your status updates across every active project on a Friday afternoon,
detect engagement drift weeks before you notice it, auto-schedule client check-ins when
trajectories decline, and learn which framings get the strongest client responses.
That's what the Brain becomes when you use CreativeStack across a quarter.

---
*CreativeStack by Cameron Jones — jones.cam*
