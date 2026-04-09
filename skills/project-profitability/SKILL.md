---
name: project-profitability
description: "Brain-first profitability analysis for creative work. Four modes — Analyse (single project or retainer with margin, scenarios, benchmarks), Setup rates (build a reusable rate card so you never re-enter rates), Aggregate (cross-project patterns: by client, by type, by team member, by trend), Backfill (bootstrap project history from past work). Persists rate-card.md, project-history.md, and retainer-history.md so every run gets sharper. Auto-detects project vs retainer mode."
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

# /project-profitability

> Hours + rates + fee in, margin truth out. Saves your rate card once. Learns every project.

## What This Skill Does

Most profitability tools are calculators you fill in fresh every time. This one
acts as a **profitability brain**:

1. **Reads your rates** from `rate-card.md` — never asks for day rates again
   after first setup
2. **Reads your project history** from `project-history.md` — compares this
   project against your own track record, not just industry averages
3. **Reads your retainer history** from `retainer-history.md` — enables real
   3+ month trajectory analysis
4. **Aggregates across projects** — answers questions like "which clients are
   most profitable" and "is brand work outperforming digital for us"
5. **Compounds value** — every analysis offers to save itself, building the
   brain over time

The first analysis takes 5 minutes to set up the rate card. Every analysis
after that takes 60 seconds and gets sharper as the history grows.

## Brain Files
- `rate-card.md` — **the rate DNA**: internal cost rates + billing rates by role and person (this skill creates and maintains it)
- `project-history.md` — append-only log of every analysed project (this skill creates and maintains it)
- `retainer-history.md` — monthly data points per retainer for trajectory analysis (this skill creates and maintains it)
- `team.md` — fallback source for person-level day rates if not in rate-card
- `freelance-bench.md` — trusted freelance roster with day rates and lead times (used in scenario modelling and cost-out comparisons; from `/resource-conflict` Setup bench)
- `profile.md` — agency name, currency, default target margin
- `learnings.md` — prose lessons (this skill appends to a § Profitability section, never overwrites)

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/rate-card-schema.md`** — read in **Setup rates** mode, or whenever creating/updating any of the three brain files. Full schemas + setup flows.
- **`references/benchmarks.md`** — read in **Analyse** mode when generating benchmark comparison. Industry numbers by type with override guidance.
- **`references/scenarios.md`** — read in **Analyse** project mode when generating scenario modelling. Six scenario patterns with selection guidance.
- **`references/retainer-analysis.md`** — read in **Analyse** retainer mode. Trajectory rules, over/under-servicing detection, talking points framework, health score.
- **`references/aggregation.md`** — read in **Aggregate** mode. Cross-project view patterns and insight prioritisation.

## Conversation Flow

### Step 1: Brain check & mode selection

Run brain discovery from the preamble. Check specifically for the files this
skill cares about:

```bash
[ -f "$HOME/.creativestack/rate-card.md" ] && echo "RATES_EXIST" || echo "NO_RATES"
[ -f "$HOME/.creativestack/project-history.md" ] && echo "HISTORY_EXISTS" || echo "NO_HISTORY"
[ -f "$HOME/.creativestack/retainer-history.md" ] && echo "RETAINER_HISTORY_EXISTS" || echo "NO_RETAINER_HISTORY"
```

[SELECT] "What do you need?"
- Analyse — single project or retainer (default)
- Setup rates — build or update your rate card
- Aggregate — cross-project patterns from history (needs 3+ projects in history)
- Backfill — quickly log past projects to bootstrap aggregation

**Routing:**
- If user picks Analyse and no rate-card exists → offer: "I don't have your rates saved. Want to do a 5-minute Setup rates first? Otherwise I'll ask for rates this once."
- If user picks Aggregate and history has <3 entries → "Aggregate needs 3+ projects. You have {N}. Want to Backfill some past projects first?"
- If user picks Aggregate with sufficient data → proceed straight to aggregation

### Step 2: Analyse mode — Upstream skill check

Before asking the user anything, scan the conversation for upstream skill output:

| Skill run earlier | What to pull in | How it's used |
|---|---|---|
| `/timesheet-summary` | Logged hours, burn rate, revision tax, scope creep | Pre-fills hours data — skip the question |
| `/timeline-generator` | Phase structure, planned durations | Maps phases to budget allocation |
| `/sow-generator` | Fee, payment milestones, revision limits | Pre-fills fee and contractual terms |

When upstream data is available:
"I have the timesheet data from earlier — {X hours} across {Y team members},
with a revision tax of {Z%}. Should I use that?"

### Step 3: Analyse mode — Detect project vs retainer

Auto-detect from the input:
- Fixed total fee + finite duration → **project mode**
- Monthly hours allocation + monthly fee → **retainer mode**
- Ambiguous → ask: [SELECT] "Project or retainer?"

### Step 4: Analyse mode — Gather what's not in the brain

Ask only what isn't already known:

- **Fee:** ask if not pre-filled from `/sow-generator` or upstream
- **Hours:** ask if not pre-filled from `/timesheet-summary`
- **Rates:** if `rate-card.md` exists, use it. Otherwise ask once and offer to save to rate card at the end.
- **OOP costs:** ask once. "Any out-of-pocket costs? (freelance, stock, print, travel)" — if freelance is mentioned and `freelance-bench.md` exists, look up the bench rates rather than asking again.
- **Target margin:** if `default_target_margin` in rate-card.md frontmatter, skip. Otherwise ask, or fall back to industry benchmark for the project type.
- **Project type:** ask once if not obvious from name/SOW. Use the stable vocabulary from `references/rate-card-schema.md`.

### Step 5: Compute and generate

For project mode:
- Compute total cost using rate-card lookup order (see `references/rate-card-schema.md` § "Read order in Analyse mode")
- Compute margin, variance, phase breakdown
- Read `references/benchmarks.md` to get industry comparison; layer in user's own averages from `project-history.md` if 3+ same-type projects exist
- Read `references/scenarios.md` to choose and run the 3 most informative scenarios. For team-mix scenarios that involve freelance substitution, read `freelance-bench.md` to use named freelancers with real rates rather than placeholder roles.
- Generate output

For retainer mode:
- Compute current month's metrics
- Read `references/retainer-analysis.md`
- If `retainer-history.md` has 3+ months for this retainer, generate trajectory section. Otherwise snapshot only.
- Generate output

### Step 6: Compounding loop — offer to save

After producing the report, offer **at most one** brain enrichment based on what
will deliver the most value. Do not pile on:

- **No rate-card and the user manually entered rates** → "Want me to save these rates to a rate card? Future runs won't need to ask."
- **Project mode, history exists** → "Save this project to history? You're now at {N} projects — aggregate mode unlocks at 3."
- **Project mode, no history yet** → "Save this project as the first entry in your project history? After 3, you can run aggregate."
- **Retainer mode, no entry for this month** → "Save this month to retainer history? With {N+1} months you'll {unlock trajectory / get a stronger trajectory}."
- **Aggregate mode just ran** → offer no enrichment; suggest a downstream skill instead.

## Output Format — Project mode

# Project Profitability Analysis
**Project:** {project name}
**Client:** {client name}
**Type:** {project type from stable vocabulary}
**Fee:** {total fee, in rate-card currency}
**Date:** {today}

## Verdict
**{One-line verdict in bold. Lead with brain-aware framing where possible.}**

Examples:
- *"32% margin — your worst on a brand identity project this year, and 13 points below your average of 45%."* (brain-aware)
- *"47% margin — slightly above your 45% target, in line with your historical average for brand refresh work."* (brain-aware)
- *"32% margin — below your 45% target. (No history yet — save this as your first entry to enable comparisons.)"* (no history)

## Summary

| Metric | Value |
|--------|-------|
| Total fee | {amount} |
| Total cost (time) | {amount} |
| Total cost (OOP) | {amount} |
| **Gross profit** | **{amount}** |
| **Gross margin** | **{percentage}** |
| Target margin | {percentage} |
| Variance vs target | {+/- percentage points} |
| Your average ({type}, n={N}) | {percentage} |
| Variance vs your average | {+/- percentage points} |

{Drop the last two rows if no history available.}

## Phase Breakdown
| Phase | Fee Allocation | Hours | Cost | Margin | Status |
|-------|---------------|-------|------|--------|--------|
| {phase} | {amount} | {hours} | {amount} | {%} | Profitable / Break-even / Loss |

**Most profitable phase:** {phase} at {margin}%
**Least profitable phase:** {phase} at {margin}%

## By Team Member / Role
| Person / Role | Hours | Cost Rate | Cost | % of Total Cost |
|--------------|-------|-----------|------|----------------|
| {name/role} | {hours} | {rate from card} | {cost} | {%} |

{If a person's rate came from rate-card vs team.md vs ad-hoc, note source in
parentheses on first occurrence.}

## Where the Margin Went
{2-4 narrative bullets — specific factors, with numbers}
- **{Factor}** — {specific change with cost impact}
- **{Factor}** — {specific change with cost impact}

## Benchmark Comparison

{Generate using `references/benchmarks.md`. Always include "your average" column
when history has 3+ projects of this type.}

| Metric | This Project | Your Avg ({type}, n={N}) | Industry Range | Assessment |
|--------|-------------|---------------------------|----------------|------------|
| Gross margin | {%} | {%} | {range} | {below/in/above} |
| Revision cost % | {%} | {%} | 10-15% | {assessment} |
| OOP as % of fee | {%} | {%} | 5-15% | {assessment} |

## Scenarios

{Run 3 scenarios chosen by `references/scenarios.md` § "How to choose scenarios for the output". Use real numbers from this project.}

### {Scenario name}
{4 lines: change → numbers → new margin → verdict}

### {Scenario name}
{...}

### {Scenario name}
{...}

## Recommendations
1. {Specific to this project's biggest leak}
2. {Pricing or scoping adjustment for similar future work}
3. {Process improvement that addresses the structural issue (if any)}

---

## Output Format — Retainer mode

# Retainer Profitability — {Retainer Name}
**Client:** {client}
**Terms:** {hours/month, scope summary, fee}
**Period analysed:** {month or quarter}
**Months of history:** {N} ({"trajectory available" if N≥3 else "snapshot only"})

## Trajectory
**{STABLE / IMPROVING / DECLINING / CRITICAL / AT RISK / SNAPSHOT — too few months}**

{One-paragraph trajectory call. If <3 months, say so plainly and tell the user
when trajectory becomes available.}

## This Month's Snapshot

| Metric | This Month | Allocated | Variance |
|---|---|---|---|
| Hours used | {hours} | {hours} | {±} |
| Margin | {%} | n/a | n/a |
| Over-servicing | {hours} | n/a | n/a |
| Scope additions | {count} | n/a | n/a |

## Trajectory (3+ months)
{Only if retainer-history.md has 3+ months for this retainer. Otherwise skip.
Use the trajectory table from references/retainer-analysis.md.}

| Metric | 3 Months Ago | 2 Months Ago | Last Month | This Month | Trend |
|---|---|---|---|---|---|
| Utilisation | {%} | {%} | {%} | {%} | {arrow} |
| Margin | {%} | {%} | {%} | {%} | {arrow} |
| Over-servicing | {hrs} | {hrs} | {hrs} | {hrs} | {arrow} |
| Scope additions | {count} | {count} | {count} | {count} | {arrow} |

## Over-servicing Analysis
{Use the patterns from references/retainer-analysis.md § "Over-servicing detection".
Quantify the cost.}

## Under-utilisation Analysis
{Same — only include if relevant.}

## Scope Creep
{List net-new workstreams added since the retainer started, if any. Flag pattern
if 3+ in a quarter.}

## Talking Points for Client Review

### Value delivered
{2-4 lines, lead with this. Quantify equivalent project rate value if possible.}

### Areas to discuss
{Constructive framing. Scope expansion, over-servicing, process friction.}

### Recommendations
{Specific, time-boxed, with math behind each.}

## Health Score

| Dimension | Score | Notes |
|---|---|---|
| Utilisation balance | {1-5} | {one line} |
| Scope alignment | {1-5} | {one line} |
| Margin health | {1-5} | {one line} |
| Client engagement | {1-5} | {one line} |
| Trajectory | {1-5} | {one line} |
| **Overall** | **{1-5}** | **{summary}** |

---

## Output Format — Setup rates mode

When the user picks Setup rates, read `references/rate-card-schema.md` § "Setup
rates flow" and walk through the questions. Write `~/.creativestack/rate-card.md`
in the schema format. Confirm at the end:

> "Rate card saved with {N} roles{ + M person overrides}. Future profitability
> runs will use these automatically."

## Output Format — Aggregate mode

Read `references/aggregation.md`. Run the views the user selected (or all by
default). **Lead with the top 3 insights**, then show the supporting tables.
Finish with 1-2 specific recommendations and a downstream skill suggestion.

## Output Format — Backfill mode

Goal: quickly log past projects to bootstrap `project-history.md`.

Flow:
1. "How many past projects are we logging? (Even 5 gets aggregate working)"
2. For each project, ask the minimum:
   - Name + client + type (from stable vocabulary)
   - Fee
   - Approximate margin (if they don't know cost, ask: "rough margin estimate is fine")
   - Year/quarter
3. Optional fields can be skipped — fill with "unknown"
4. Batch the questions: "Ready for the next project?" pattern
5. Append to `project-history.md` in chronological order
6. Confirm: "Logged {N} projects. Aggregate mode is now {available / will be available with {N more}}."

---

## Slack Format

*{Project Name} — Profitability*
**Margin: {%}** ({verdict in 8 words}) — {one-line factor}

For retainer:
*{Retainer Name} — {Month}*
**Trajectory: {STATE}** — {one-line context}

---

## Skill Chains

Pick the most relevant 1-2:

- **Project mode, low margin or structural pricing issue** → "Run `/post-mortem` to capture what drove the margin loss, then reference these scenarios in your next `/proposal-generator` to price differently."
- **Retainer mode, declining or at-risk trajectory** → "Run `/status-update` to prepare the next QBR conversation."

## Project State Participation

If the analysis is tied to a project (followed the project state discovery + picker
above), update the state file:

- **Budget & Pace** — update the `Margin: {healthy | thinning | at-risk}` line and the
  `Updated: YYYY-MM-DD` line. Don't overwrite hours/burn rate fields owned by
  `/timesheet-summary` unless they're empty.
- **Recent Activity** — append `YYYY-MM-DD — project-profitability — margin {%}, {verdict}`
- **Frontmatter** — update `last_updated`
- Update `_index.md`

## Edge Cases
- **No rate-card** → Run with ad-hoc rates this once, offer Setup rates at the end
- **No history** → Skip the "your average" column, lean on industry benchmarks
- **Project still in progress** → Flag as interim, project final figures based on current trajectory
- **Multiple currencies** → Ask which currency to report in. Convert OOP at current rates. Flag the assumption.
- **Retainer with 1-2 months only** → Snapshot only, no trajectory. Tell the user explicitly.
- **Heavily under-utilised retainer** → Frame as cancellation risk, not margin win. See `references/retainer-analysis.md`.
- **Aggregate mode with <3 history entries** → Refuse and route to Backfill mode
- **Project type not in stable vocabulary** → Use "other" and prompt user to map it next time
- **history.md has contradictory project entries (e.g. same project twice)** → Use the most recent, note in output

### What this skill can't do

This skill analyses what you give it. With a deeper integration, it could pull
time and cost data automatically from your systems, update history without you
asking, and surface profitability anomalies before you finish a project.
That's what the Brain enables.

---
*CreativeStack by Cameron Jones — jones.cam*
