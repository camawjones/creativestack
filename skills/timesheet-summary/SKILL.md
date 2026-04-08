---
name: timesheet-summary
description: Turn raw time tracking data into a creative-industry project health report. Surfaces what actually bleeds margin in studios and agencies — revision tax, craft-vs-admin ratio, focus fragmentation, seniority mix leaks, sustainability signals, waiting-time gaps, and scope creep — with narrative verdicts, archetype-tuned benchmarks, burn projections, and planned-vs-actual comparison. Accepts any tracker (Harvest, Toggl, Clockify, Float, Forecast, Runn, Productive, Everhour, spreadsheets). Chains into status-update, profitability, post-mortem, and resource skills.
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

# /creativestack:timesheet-summary

> Raw time data in, creative project health story out.

## Brain Files
- `profile.md` (for context and user type)
- `team.md` (for roles, rates, seniority)
- `clients.md` (for client behaviour history)
- `learnings.md` (for past project benchmarks)

## What This Skill Does

Turns raw time tracking data into a creative project health report. Surfaces the
metrics that actually decide whether a studio/agency project is healthy: craft vs
admin ratio, focus fragmentation, seniority leaks, revision tax, sustainability,
and client-side idle time. Output fits client updates, internal PM reviews, or a
frank Slack to the studio lead. Chains into `/creativestack:status-update`,
`/creativestack:project-profitability`, `/creativestack:post-mortem`, `/creativestack:resource-conflict` — data carries forward.

## Upstream Skill Synthesis

Check whether any of these ran earlier this session and carry the data forward:

| Skill | What to pull | Use |
|---|---|---|
| `/creativestack:timeline-generator` | Planned phases, budgeted hours | Planned vs Actual — skip budget question |
| `/creativestack:project-kickoff` | Team, phases, archetype | Pre-fills context |
| `/creativestack:creative-brief` | Archetype, scope | Tunes benchmarks, enables scope creep |
| `/creativestack:resource-conflict` | Utilisation context | Enriches Sustainability section |

Tell the user once when upstream data is detected, then don't re-ask those questions.

## Inputs
- Pasted time tracking data (any format)
- Optional: archetype, budgeted hours per phase, reporting period, billable rate, seniority map

## Data Parsing

Auto-detect before asking:

1. **Tracker format** — Harvest, Toggl, Clockify, Float, Forecast, Runn, Productive, Scoro, Resource Guru, Everhour, TMetric, spreadsheet exports. Confirm the guess.
2. **Reporting period** — infer from date range, confirm.
3. **Project/client name** — infer from data, confirm.
4. **Multi-project** — if present, offer single-project deep-dive or portfolio roll-up (don't silently merge).
5. **Signal scan** — before asking:
   - Hour-of-day timestamps → unlock Focus Time + After-Hours
   - Task names with "revision/rev/r1/amends/feedback" → Revision Tax
   - Task names with "meeting/call/status/review/email/admin/internal" → Craft vs Admin
   - 2+ working days with zero activity on an active project → Waiting Time
   - Team member + task description + `team.md` roles → Seniority Mix

Only ask what the data doesn't tell you.

## Conversation Flow

1. User pastes data.
2. Auto-detect + confirm.
3. [SELECT] Archetype (skip if kickoff/brief set it): Identity / Campaign / Website / Motion / Content / Packaging / Product / Other.
4. [SELECT] Client update (polished) or Internal review (flags everything).
5. Ask for budgeted hours per phase (skip if timeline-generator has it).
6. Ask about financial summary + rate (offer blended rates from `team.md` if present).
7. Generate.

## Archetype Benchmarks

Reference line for Revision Tax and Craft Ratio. Frame as "typical", not "correct".

| Archetype | Revision Tax | Craft Ratio | High-burn phase |
|---|---|---|---|
| Identity / brand system | 18-25% | 65-75% | Concept & iteration |
| Campaign | 15-20% | 60-70% | Concept + production |
| Website / digital product | 10-15% | 70-80% | Build & QA |
| Motion / film | 12-18% | 60-70% | Post / animation |
| Content / editorial | 8-15% | 70-80% | Writing & review |
| Packaging / print | 12-18% | 65-75% | Artwork & repro |
| Product / UX | 10-15% | 70-80% | Design & prototyping |

Unknown archetype → 15% Revision Tax, 70% Craft Ratio.

## Output Format

# Timesheet Summary: {Project/Client Name}
**Period:** {reporting period}
**Archetype:** {archetype}
**Date:** {today}
**Prepared by:** {agency/studio name from brain}

## The Vibe Check
{One short paragraph — plain creative-industry language, no corporate hedging.
Tone example: "Running hot. Concept came in lean but production is eating the savings
— senior designer is carrying 40% of hours into Friday evenings. Reshape the next
two weeks or we're landing 20 hours over and the team will feel it."}

## Project Health: {ON TRACK / AT RISK / OVER BUDGET / BURNING OUT}

**Burn projection:** {At current pace, budget exhausted by [date] with [estimated %]
of deliverables remaining. OR: "On pace to complete within budget with [X hours] margin."}

## Overview
| Metric | Value |
|--------|-------|
| Total hours logged | {hours} |
| Budgeted hours | {hours or N/A} |
| Variance | {+/- hours} ({%}) |
| Burn rate | {hours/week — trend: accelerating / stable / decelerating} |
| Team members | {count} |
| Workstreams | {count} |

## Planned vs Actual — Phase Comparison

{If timeline-generator was run or the user provided budgeted hours per phase, generate
this. Otherwise skip and note: "Run `/creativestack:timeline-generator` first for automatic
planned-vs-actual tracking."}

| Phase | Planned | Actual | Variance | % Used | Status |
|-------|---------|--------|----------|--------|--------|
| {phase} | {planned} | {actual} | {+/-} | {%} | On Track / Over / Under |

**Biggest overrun:** {phase} at {+X hrs} ({%} over)
**Biggest saving:** {phase} at {-X hrs} ({%} under)

{Narrative: e.g., "Strategy came in at 60% of budget, but the savings are being eaten
by Production which is already at 110% with deliverables still outstanding."}

## Creative Craft Ratio

*The single most useful metric for a creative team: time on actual craft vs meetings,
admin, email, and internal overhead.*

| Category | Hours | % |
|---|---|---|
| Creative craft (design, writing, concept, production) | {hrs} | {%} |
| Client meetings & calls | {hrs} | {%} |
| Internal meetings & reviews | {hrs} | {%} |
| Email, Slack, admin | {hrs} | {%} |
| Other / unclassified | {hrs} | {%} |

**Craft Ratio: {%}** — archetype benchmark {X%} — **{Healthy / Squeezed / Critical}**

**Assessment:** {e.g., "52% vs 70% benchmark. Half the team's time is in meetings —
that's the margin. Biggest offenders: weekly status calls (12 hrs), internal reviews (8 hrs)."}

{If task names don't allow classification, note the gap and recommend tagging
tasks as 'design:', 'meeting:', 'admin:'.}

## Revision Tax

*The #1 hidden margin killer in creative work. Always include this section.*

| Metric | Value | Archetype Benchmark | Assessment |
|---|---|---|---|
| Revision hours | {hrs} | — | — |
| Revisions as % of total | {%} | {archetype benchmark}% | {above/in/below range} |
| Revision rounds tracked | {count} | 2-3 typical | {above/in/below} |
| **Revision Tax** | **{%}** | **{archetype benchmark}%** | **{Healthy / Elevated / Critical}** |

**Assessment:** {e.g., "32% on identity work — above the 18-25% range. At blended
rate that's {amount} in rework. Revisions stack after Round 2 — stakeholder likely
not in the room until late."}

**Trend:** {Compare to `learnings.md` if available; otherwise recommend `/creativestack:post-mortem`.}

**Client behaviour signal:** {If revisions cluster after specific review dates, flag:
"60% of revision hours land in the 48 hours after the Tuesday client review —
client-driven rework, not craft iteration. Raise at next WIP."}

{If revision data isn't tagged, note the gap and recommend tagging revision time.}

## Focus Time vs Fragmentation

*Only runs if hour-of-day timestamps are present. Creative work needs contiguous blocks.*

| Metric | Value |
|---|---|
| Avg contiguous block | {hrs} (healthy: 2+, fragmented: <1) |
| Deep-work days (4+ hr block) | {count} |
| Context-switch days (3+ projects/person/day) | {count} |
| Most fragmented | {name} — {avg block} |

**Assessment:** {e.g., "Team averaged 42-minute blocks. Designers need 90-minute
minimums for anything with taste. Most fragmented: {name} at 28 min, bouncing
between {N} projects per day."}

{Skip and note once if no timestamps.}

## Seniority Mix

*Where margin quietly leaks: senior hours on junior tasks, junior hours on work
needing senior judgment. Requires `team.md` roles or a quick role map.*

| Team Member | Role | Hours | Senior-on-Junior | Junior-on-Senior |
|---|---|---|---|---|
| {name} | {role} | {hrs} | {hrs} | {hrs} |

**Senior hours on junior tasks:** {hrs} — **margin leak: {£ at rate delta}**
**Junior hours on senior tasks:** {hrs} — **quality risk, flag for review**

**Assessment:** {e.g., "CD logged 14 hrs on artwork amends — £1,680 leak vs a mid
designer rate. Junior designer spent 8 hrs on concept direction — QA pass before
it goes out."}

{Skip and note if no role map available.}

## Sustainability Signals

*Burnout is a project risk.*

| Signal | Value | Flag |
|---|---|---|
| Evening hours (outside 9-6) | {hrs} ({%}) | >15% elevated |
| Weekend hours | {hrs} ({%}) | any = flag |
| Highest weekly load | {name} — {hrs} | >45 = flag |
| Concentration (top person) | {%} | >40% = risk |
| Consecutive high-load weeks | {count} | 3+ = burnout watch |

**Assessment:** {e.g., "Senior designer: 11 weekend hrs, carrying 42% across three
48+ hr weeks. Burnout profile + single-point-of-failure for this project. Conversation now, not later."}

{Skip after-hours portions if no timestamps — concentration and weekly load still work.}

## Waiting Time / Idle Gaps

*Dead periods on an active project usually mean the client is the blocker.*

| Gap | Working days | Context |
|---|---|---|
| {start} → {end} | {N} | {last task before, first task after} |

**Total idle days:** {days}

**Assessment:** {e.g., "7 days between 12-20 March, bookended by 'sent decks for
approval' and 'kickoff revisions'. Client-side lag silently compressing runway."}

{Skip if no gaps.}

## By Phase / Workstream

For each phase, show a brief block:

**{Phase}** — Status: {On Track / Over / Under} — {actual}/{budget} hrs ({%})
Top tasks: {task 1 — hrs}, {task 2 — hrs}. Flags: {e.g., "3x estimate", "unbudgeted"}.

## Scope Creep Detection

| Task | Hours | In Scope? | Notes |
|---|---|---|---|
| {task} | {hrs} | Y/N/? | {context} |

**Total unscoped:** {hrs} ({%})

{Skip with note if no scope baseline — recommend `/creativestack:creative-brief`.}

## By Team Member
| Member | Hours | Phases | Avg/Day | Utilisation |
|---|---|---|---|---|
| {name} | {hrs} | {phases} | {avg} | {high/normal/low} |

## Team Efficiency Patterns

*Patterns meaningful over multiple projects — note first-run caveat if needed.*

| Member | Strongest Phase | vs Team Avg | Notes |
|---|---|---|---|
| {name} | {phase} | {X% faster/slower} | {e.g., "assign identity work here"} |

**Observations:** 2-3 specific, actionable bullets.

## Budget Comparison
| Phase | Budget | Actual | Remaining | % | Projection |
|---|---|---|---|---|---|
| {phase} | {b} | {a} | {r} | {%} | On track/At risk/Over |

**Overall:** {used}/{budget} hrs ({%}). Remaining {hrs}. Projected total {hrs}. Projected completion {date}.

## Financial Summary
{Only if billable rate provided. Prefer blended rates from `team.md` when available.}

| Metric | Value |
|---|---|
| Billable hours | {hrs} |
| Rate (blended or flat) | {rate} |
| Revenue (this period) | {amount} |
| Revenue (project to date) | {amount} |
| Budget remaining (£) | {amount} |
| Effective hourly rate (actual) | {fee ÷ actual hrs — if project fee known} |
| **Margin leak — Revision Tax cost** | {revision hrs × blended rate} |
| **Margin leak — Senior-on-junior work** | {delta hrs × rate delta} |

## Flags & Alerts

*Ranked by impact × confidence. Top 3-5 only.*

1. **{Flag}** — {e.g., "Design at 85% budget, 60% deliverables done — will exceed by ~15 hrs."}
2. **{Flag}** — {e.g., "Revision Tax 32% vs 18-25% — cap at 2 more rounds."}
3. **{Flag}** — {e.g., "Craft Ratio 52% — trim the Thursday review."}

## Recommendations

*Specific and actionable — PM can take each into their next WIP.*

1. {e.g., "Reallocate 10 hrs from strategy to production."}
2. {e.g., "Formalise the Round 3 revision gate with the client."}
3. {e.g., "Move CD off artwork amends to recover ~£1,600 margin."}

---

## Slack Format

*Compact single-message version for PMs to paste.*

*{Project} — Timesheet — {Period}*
**Health: {ON TRACK / AT RISK / OVER BUDGET / BURNING OUT}**
*Vibe:* {one-liner}
*Hours:* {actual}/{budgeted} ({%})
*Burn:* {hrs/wk} — {accelerating/steady/decelerating}
*Craft Ratio:* {%} {🟢/🟡/🔴 vs archetype}
*Revision Tax:* {%} {🟢/🟡/🔴 vs archetype}
*Sustainability:* {OK / Watch / Burnout risk}
*Remaining:* {hrs} (~{weeks} wks)
*Top flags:* {1-2 or "None"}

---

## Skill Chains

Pick 1-2, not all:

- Margin concern → `/creativestack:project-profitability` (data carries forward)
- Project wrapping → `/creativestack:post-mortem` (revision tax, craft ratio feed in)
- Communicate upward → `/creativestack:status-update` (vibe, burn, flags carry forward)
- Burnout signals → `/creativestack:resource-conflict`
- Revisions look client-driven → `/creativestack:feedback-consolidator` before next review

## Project State Participation

If this analysis is tied to a project (followed the project state discovery + picker
above), update the state file:

- **Budget & Pace** (this skill owns this section) — write hours actual/budgeted, burn
  rate, trend direction, and the date. If a margin estimate exists, include it.
- **Recent Activity** — append `YYYY-MM-DD — timesheet-summary — burn {hrs/wk}, {%} used, {trend}`
- **Frontmatter** — update `last_updated`
- Update `_index.md`

If the burn rate or scope creep is severe enough that the status should change, don't
update `status` in frontmatter directly — that's `/creativestack:status-update`'s job.
Instead, surface it as a recommendation to the user: "Burn rate is accelerating sharply
— next status update should probably move this to At Risk."

## Edge Cases
- **Unfamiliar tracker** → ask user to describe columns.
- **No budget** → skip Budget/Planned-vs-Actual/projection. Keep Craft Ratio, Revision Tax, Sustainability.
- **1-day period** → daily summary, skip trends and sustainability.
- **Mixed projects** → offer deep-dive or roll-up, don't silently merge.
- **No timestamps** → skip Focus Time + after-hours. Keep concentration/weekly load.
- **No role map** → skip Seniority Mix, note the gap.
- **No scope** → skip Scope Creep, recommend `/creativestack:creative-brief`.
- **Revision not tagged** → note, recommend tagging, estimate from task names.
- **Solo/freelancer** → skip Seniority + Team Efficiency, soften Concentration. Keep Craft Ratio + Sustainability (solos burn out faster).

### What this skill can't do

Manual paste today. With a connected Brain, it could pull from your tracker, compare
against historical burn curves, predict overruns, alert in real time, and generate
weekly summaries on a schedule.

---
*CreativeStack by Cameron Jones — jones.cam*
