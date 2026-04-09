---
name: creative-brief
description: Brain-first creative brief generation for creative agencies. Three modes — From inputs (messy pasted content → structured brief), From scratch (blank-page interview for verbal conversations), From pitch (convert a won prospect dossier into a real project brief). Enforces industry-standard brief structure with tension, real objectives, audience depth, insight, and a single-minded thought. Scores briefs against a 10-dimension rubric and blocks any brief with Red dimensions from going to the team. Creates projects/{slug}.md and projects/{slug}-brief.md so downstream skills have context from day one. Runs fee, team, and timeline sanity checks against rate-card.md and team.md. Applies per-client vocabulary and feedback patterns from learnings.md. Closes the gap between pitch-research and creative work.
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

# /creative-brief

> The creative team deserves a brief, not a spec. Tension in, work-ready brief out.

## What This Skill Does

Most brief templates are generic scaffolds that produce generic briefs. This
skill enforces the industry-standard structure that separates **a brief** from
**a spec document**, and does it with the agency's own brain:

1. **Extracts or builds the tension** — the gap between where the brand is
   and where it needs to be. No tension, no brief.
2. **Separates real objectives from stated deliverables** — "redesign the
   website" is a deliverable; the objective is what the redesign is *for*.
3. **Enforces audience depth** — "millennials" fails the 4-layer check
   (behaviour, relationship, context, desire). Demographics alone don't pass.
4. **Requires a single-minded thought** — one sentence the creative team
   can rally around. Pressure-tested before the brief closes.
5. **Scores across 10 dimensions** — any Red blocks the brief from being
   ready, regardless of total score.
6. **Creates the project state file** — this is often the first skill on a
   project, so downstream skills inherit context from day one.
7. **Runs sanity checks** — fee (using `rate-card.md`), team (using
   `team.md` extended schema), timeline — flags issues before they become
   problems.
8. **Applies per-client brain overlays** — known vocabulary, feedback
   archetypes, stakeholder patterns, past brief gaps for this client.
9. **Closes the pitch → project gap** — the From pitch mode converts a
   prospect dossier from `pitch-research` into a real brief, pulling the
   killer hook forward as the candidate single-minded thought.

The first brief takes a few minutes longer because it's more rigorous. Every
brief after that compounds — the brain learns this client's brief patterns,
the rate card sharpens the fee check, the meeting log feeds kickoff decisions.

## Brain Files
- `profile.md` — agency positioning and specialisms
- `methodology.md` — for structuring briefs around the agency's phases
- `tone-of-voice.md` — for the brief's writing voice (not the brand's voice)
- `clients.md` — client relationship history and context
- `case-studies.md` — relevant past work for inspiration or reference
- `learnings.md § Feedback` — client vocabulary, archetypes, stakeholder memory (from `/feedback-consolidator`)
- `learnings.md § Pitching` — past pitch learnings if the brief came from a pitch (from `/pitch-research`)
- `prospects/{slug}.md` — prospect dossier for From pitch mode (from `/pitch-research`)
- `projects/{slug}.md` + `projects/{slug}-meetings.md` — existing project state and kickoff meeting decisions
- `rate-card.md` — for the fee sanity check (from `/project-profitability`)
- `team.md` — for the team sanity check with extended schema (from `/resource-conflict`)
- `sow-style.md` — if a SOW exists, pull scope from it (from `/sow-generator`)

**This skill creates and writes:**
- `projects/{slug}.md` — project state file (created if missing, updated if existing)
- `projects/{slug}-brief.md` — the full locked brief

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/brief-templates.md`** — read when starting a brief for any of the 11 project types (rebrand, campaign, digital product, identity, naming, packaging, retainer, pitch brief, phase brief, research/strategy, content). Deliverables, constraints, common gaps, pressure tests, and starter tension patterns per type.
- **`references/tension-and-insight.md`** — read for every brief. Methodology for identifying the tension, separating real objectives from stated ones, running the 4-layer audience check, and drafting the single-minded thought. This is the operational heart of the skill.
- **`references/completeness-rubric.md`** — read after drafting the brief to score it across 10 dimensions. Traffic-light scoring, blocker rules, readiness states.
- **`references/brief-schema.md`** — read whenever writing files (project state, brief file) or running sanity checks. Schemas, sanity check logic, project state write flow, handoff rules.

## Conversation Flow

### Step 1: Brain check & mode selection

Run brain discovery. Check specifically:

```bash
[ -f "$HOME/.creativestack/rate-card.md" ] && echo "RATE_CARD_EXISTS" || echo "NO_RATE_CARD"
[ -d "$HOME/.creativestack/prospects" ] && echo "PROSPECTS_DIR_EXISTS" || echo "NO_PROSPECTS_DIR"
[ -f "$HOME/.creativestack/learnings.md" ] && grep -q "## Feedback" "$HOME/.creativestack/learnings.md" && echo "FEEDBACK_LEARNINGS" || echo "NO_FEEDBACK_LEARNINGS"
```

[SELECT] "What do you need?"
- From inputs — you have messy content to turn into a brief (default)
- From scratch — blank page, walk me through the questions
- From pitch — convert a won prospect dossier into a brief

**Routing:**
- **From inputs** → Step 2
- **From scratch** → Step 5 (Interview mode)
- **From pitch** → Check that `prospects/{slug}.md` exists for the named prospect. If not, "No dossier found. Run `/pitch-research` first to create one." If yes, continue to Step 4 (pre-populated).

### Step 2: Upstream skill check

Scan the conversation for output from earlier skills:

| Skill run earlier | What to pull in | Where it lands in the brief |
|---|---|---|
| `/source-scrape` | Brand positioning, messaging, visual style | Background, Constraints |
| `/competitor-audit` | Competitive landscape, white space | Category Context, Tension |
| `/trend-report` | Category trends, cultural shifts | Category Context, Tension |
| `/pitch-research` | Prospect dossier | Full From pitch mode handoff |
| `/brief-sharpener` | Prior brief analysis for an earlier draft | Gap identification |
| `/meeting-notes` | Kickoff decisions | Objectives, stakeholders, decisions |
| `/sow-generator` | SOW scope, deliverables, fee, timeline | Deliverables, Constraints |
| `/feedback-consolidator` | Round-1 feedback if this is a rebrief | Open Questions, contradictions |

When upstream data is available, tell the user what's being pulled in.

### Step 3: Brain context loading

Read the brain files listed above in this order:

1. `profile.md` — for agency context
2. `clients.md` — check if this client exists; load history
3. `learnings.md § Feedback` — filter to this client's vocabulary, archetypes, stakeholder memory
4. `learnings.md § Pitching` — filter to this client if the brief came from a pitch
5. `methodology.md` — for structural framing
6. `tone-of-voice.md` — for writing voice
7. `rate-card.md` — for fee sanity check
8. `team.md` — for team sanity check
9. `case-studies.md` — only scan headings for relevance
10. `projects/{slug}.md` and `projects/{slug}-meetings.md` — if the project already exists, read current state

Tell the user what brain depth you have:

> "Brain depth: Rich — I have your rate card, team data, vocabulary for
> this client from 4 past projects, and the prospect dossier from the
> pitch. This brief will apply all of it."

Or if thin:

> "Brain depth: Minimal — no past projects with this client, no rate card
> yet. The brief will work but without client-specific overlays or fee
> sanity checks. Consider running `/setup-brain` or
> `/project-profitability` Setup rates for future briefs."

### Step 4: Project type selection

[SELECT] "What type of project is this?"
- Rebrand
- Brand refresh (lighter touch than rebrand)
- Campaign
- Digital product
- Identity system
- Naming
- Packaging
- Retainer
- Pitch brief (agency-initiated)
- Phase brief (continuing a multi-phase project)
- Research / strategy
- Content / editorial
- Infer from content

Read `references/brief-templates.md` § "{selected type}" to load the template
defaults (deliverables, constraints, common gaps, pressure tests, starter
tension patterns).

If the user picks "Infer from content", use the heuristics in the
templates reference to infer, then confirm with the user before proceeding.

### Step 5: Receive inputs OR run interview

**From inputs mode:** User pastes the messy content. Accept any format —
email chains, Slack threads, meeting notes, scribbled bullets, call
transcripts. Don't force structure.

**From scratch mode:** Walk the user through structured interview questions,
one dimension at a time, using the 10-dimension rubric from
`references/completeness-rubric.md`:

For each dimension:
1. Show what "good" looks like (from the rubric criteria)
2. Provide a candidate answer pre-filled from brain data if available
3. Let the user accept, edit, or override
4. Move to the next dimension

After the interview, the skill has enough material to generate the brief
as if it came from inputs.

**From pitch mode:** The skill has already loaded `prospects/{slug}.md`.
Pre-populate:
- **Background** ← prospect dossier "Brand Snapshot"
- **Category Context** ← prospect dossier "Competitor Landscape" + "Trend Position"
- **Audience** ← prospect dossier "Decision-Maker Profiles"
- **Candidate single-minded thought** ← prospect dossier "Killer Hook" (flagged as needing client validation)
- **Past pitch learnings overlay** ← prospect dossier "Past Pitch Learnings"

If a SOW also exists (via `sow-style.md` output or project state), pull:
- **Deliverables** ← SOW scope
- **Budget / Timeline** ← SOW fee / timeline

Ask the user only about gaps. Usually: real audience (vs pitch audience),
success criteria, stakeholders beyond the pitch contacts.

### Step 6: Draft the brief

Read `references/tension-and-insight.md` and apply all four pressure points:

1. **Identify the tension** — from the inputs, upstream skills, brain, or
   inferred gap. Single sentence, 15-30 words, two sides.
2. **Separate real vs stated objective** — ask "why" 3+ times until you
   reach something that isn't a deliverable.
3. **Run the 4-layer audience check** — behaviour, relationship, context,
   desire. Flag if any layer is thin.
4. **Draft the single-minded thought** — try 2-3 template approaches, pick
   the sharpest, run the 4 pressure tests. If the thought needs client
   validation, flag it explicitly as "candidate".

Apply `learnings.md § Feedback` Vocabulary for this client — when writing
the tone and personality section, use terms that match this client's known
meanings (e.g. "brand-confident" instead of "bold" if that's how Marcus
uses the word).

Use `methodology.md` to structure the brief around the agency's phases if
defined.

Apply the selected project type template from `brief-templates.md` as a
scaffold — don't override it, let the real content fill in.

### Step 7: Score the brief

Read `references/completeness-rubric.md` and score all 10 dimensions. Apply
client-specific weighting if `learnings.md` shows past brief failures on
specific dimensions.

Check for blockers. Any Red dimension makes the brief "Blocked" regardless
of total score.

### Step 8: Run sanity checks

Read `references/brief-schema.md` § "Sanity checks" and run all three:

1. **Fee sanity check** — using `rate-card.md`
2. **Team sanity check** — using `team.md` extended schema
3. **Timeline sanity check** — using typical durations for this project type

Skip any check whose brain dependency is missing; surface what was skipped.

### Step 9: Generate output

Assemble the full output per the Output Format section below, including
the rubric, the brief, and the sanity checks.

### Step 10: Write to project state

Read `references/brief-schema.md` § "Project state write flow" and:

1. Create or update `projects/{slug}.md`
2. Create or update `projects/{slug}-brief.md`
3. Update `projects/_index.md`
4. If From pitch mode, archive the prospect dossier to "Active Project" status and update `prospects/_index.md`
5. Tell the user what was written

### Step 11: Compounding loop

Offer **at most one** brain enrichment. Pick the most valuable:

- **From pitch mode just ran AND the killer hook made it into the brief** → "The killer hook carried into the brief as the candidate single-minded thought. Once the client validates it, want me to save that as a win pattern in `learnings.md § Pitching`?"
- **Score is below 6.5** → "This brief scored {X} — want me to hand off to `/brief-sharpener` automatically to tighten the weak dimensions before the team sees it?"
- **Any Red dimension** → "Blocker on {dimension}. The brief isn't ready for the team. Want me to draft the specific questions to ask the client to unblock it?"
- **First brief for this client and the vocabulary / archetype / stakeholder data captured something new** → "I noticed {specific observation}. Want me to save this to `learnings.md § Feedback` for future briefs with this client?"
- **Fee sanity check showed a gap** → "The fee implied by scope is £{X}, vs stated budget £{Y}. Worth a conversation before the team starts. Want me to draft talking points?"

One offer. Don't pile on.

## Output Format

# Creative Brief: {Project / Client Name}
**Date:** {today}
**Prepared by:** {from profile.md}
**Project type:** {type}
**Status:** Draft — requires client sign-off
**Source mode:** {From inputs / From scratch / From pitch}
**Brain depth:** {Rich / Partial / Minimal}

## Brief Completeness Score

{Full rubric table from references/completeness-rubric.md § "Output format for the rubric"}

**🚨 Blocker:** {if any Red dimension, called out in bold}

**Readiness:** {state from rubric: Ready for creative / Ready with one follow-up / Needs tightening / Blocked / Not a brief yet}

---

## Brief structure

The full brief structure (sections in order) lives in `references/brief-schema.md` § "1. projects/{slug}-brief.md — The full brief". The skill produces the brief in that exact structure. Required sections, in order:

1. **The Tension** — single sentence, 15-30 words, two sides (the spine — the brief is built around this)
2. **Project Overview** — 1-2 paragraphs
3. **Background** — pulled from upstream skills and prospect dossier
4. **Category Context** — only if competitor/trend data is available
5. **Objectives** — Real objective + Stated objective + Success criteria (kept separate per `references/tension-and-insight.md`)
6. **Target Audience** — 4 layers (behaviour / relationship / context / desire) + Insight. Flag if insight is missing.
7. **The Single-Minded Thought** — one sentence; flag as candidate if it needs client validation
8. **Desired Response** — think / feel / do / believe
9. **Reasons to Believe** — proof points
10. **Brand Tone & Personality** — tone adjectives, personality, "they would / they would never". Apply client vocab from `learnings.md § Feedback` where relevant.
11. **Deliverables** — table with format, priority, estimated hours
12. **Constraints & Mandatories** — budget, timeline, brand guidelines, technical, legal, accessibility, cultural
13. **Stakeholders & Approvals** — table with watch-for notes from `learnings.md § Client Patterns`
14. **What This Is NOT** — negative space
15. **The Creative Question (optional)** — provocative sentence if it adds value
16. **Open Questions** — prioritised by impact, blocking ones first
17. **Sanity Checks** — fee / team / timeline (per `references/brief-schema.md` § "Sanity checks")

---

## Brain Overlays Applied

- **From `learnings.md § Feedback`:** {specific applications, or "no feedback history for this client"}
- **From `learnings.md § Pitching`:** {specific applications, or "n/a — not from a pitch"}
- **From `prospects/{slug}.md`:** {if From pitch mode}
- **From `methodology.md`:** {structural framing applied}
- **From `rate-card.md`:** {sanity check ran / skipped}
- **From upstream skills:** {list of session-run skills whose outputs fed the brief}

## Source Material Summary

{Brief note on inputs: paste content, upstream outputs, brain data}

---

## Written to brain

- ✓ `projects/{slug}.md` — {created / updated}
- ✓ `projects/{slug}-brief.md` — {created / updated}
- ✓ `projects/_index.md` — updated
- {✓ `prospects/_index.md` — archived dossier to Active Project status (if From pitch mode)}

---

## Slack Format

*Brief: {Project / Client Name}*
**Score: {X}/10** {🟢🟡🔴} {readiness state}
**Type:** {project type}
**Tension:** {1 sentence}
**Thought:** "{single-minded thought}"
**Open Qs:** {count} ({blocking} blocking)
**Sanity checks:** {fee state} / {team state} / {timeline state}

---

## Skill Chains

Pick the most relevant 1-2. Full handoff rules in `references/brief-schema.md` § "Handoff rules".

**Upstream:**
- **No competitor context or trend data** → "Run `/competitor-audit` and/or `/trend-report` to strengthen Category Context and Tension."
- **From a transcript** → "Run `/meeting-notes` first to extract decisions, then feed the structured notes in here."

**Downstream (score-driven):**
- **Score 8.0+** → "Run `/timeline-generator` to build the project timeline from this brief's deliverables."
- **Score 5.0-7.9 or any Red dimension** → "Run `/brief-sharpener` before briefing the team — Red dimensions need a client conversation first."

## Edge Cases
- **Very short input** → ask for more context OR offer From scratch mode. Flag Low confidence on the rubric.
- **Input is a transcript** → route to `/meeting-notes` first; this skill isn't for parsing raw transcripts.
- **Client has sent an existing brief** → route to `/brief-sharpener` — that skill is built for improving existing briefs.
- **From pitch mode but dossier is stale** (>90 days) → refuse, route to `/pitch-research` Refresh mode first.
- **Client vocab from `learnings.md § Feedback` contradicts the brief input** → flag the discrepancy explicitly. Never silently override.
- **No brain at all** → degraded output, flag what's missing and suggest next-time moves.

### What this skill can't do

This skill works from the inputs and brain you have. A dedicated AI partner
could cross-reference this brief against every past brief for similar
projects, pre-flag gaps based on which brief dimensions most often caused
problems downstream, and track which brief patterns predict the most
successful creative work. The brain enables a lot of this; deeper pattern
learning across projects is the remaining frontier.

---
*CreativeStack by Cameron Jones — jones.cam*
