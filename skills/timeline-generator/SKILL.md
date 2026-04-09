---
name: timeline-generator
description: Generate realistic project timelines with milestones, dependencies, parallel workstreams, revision modelling, and slip scenarios — with optional Figma output.
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

# /timeline-generator

> Tell me about your project, get a timeline your PM can actually use.

## Brain Files
- `profile.md` (for context)
- `methodology.md` (to reference how you run projects)
- `learnings.md` (to apply past project insights)
- `learnings.md § Capacity` (planned-vs-actual deltas and recurring slip patterns; from `/resource-conflict` Calibrate mode)
- `team.md` (for team capabilities and availability)
- `freelance-bench.md` (trusted freelance roster with day rates and lead times — used to plan freelance backstops in slip scenarios; from `/resource-conflict` Setup bench)
- `projects/{slug}-brief.md` (the locked creative brief — pull deliverables, scope, and constraints directly instead of asking again; from `/creative-brief`)
- `projects/{slug}.md` (project state — current phase, stakeholders, recent activity)
- `visual-style.md` (the agency's house visual style — applied to any Figma output)

## What This Skill Does

Conversational flow that builds a realistic project timeline. Asks about project type,
scope, team, and milestones. Generates a timeline with dependencies, parallel workstreams,
explicit client review windows, risk flags, buffer recommendations, and slip scenario
modelling based on creative agency patterns.

Produces two versions: an **internal timeline** (full detail, risks, buffers visible) and
a **client-facing timeline** (simplified, milestone-focused, no internal risk flags).

Always generates a visual Mermaid Gantt chart alongside the markdown. If the Figma MCP is
available, offers a more polished visual — either a FigJam diagram or a designed Figma file.

## Inputs
- Answers to questions about the project (conversational)

## Phase Templates

When the user selects a project type, start with the default phase skeleton below. Let the
user adjust, add, remove, or rename phases — these are starting points, not prescriptions.

If `methodology.md` exists in the brain, use your own phase structure instead of
these defaults. Only fall back to these templates when no methodology is defined.

**Rebrand:**
1. Discovery & Audit (1–2 weeks)
2. Strategy & Positioning (2–3 weeks)
3. Identity Development (3–4 weeks)
4. Client Review & Refinement (1–2 weeks per round)
5. Applications & Collateral (2–4 weeks)
6. Guidelines & Documentation (1–2 weeks)
7. Rollout & Handoff (1–2 weeks)

**Campaign:**
1. Brief & Alignment (1 week)
2. Research & Insight (1–2 weeks)
3. Concepting (2–3 weeks)
4. Client Review & Refinement (1–2 weeks per round)
5. Production (2–4 weeks)
6. Delivery & Trafficking (1 week)
7. Launch (1 week)

**Digital Product:**
1. Discovery & User Research (2–3 weeks)
2. UX & Wireframes (2–3 weeks)
3. Visual Design (2–3 weeks)
4. Client Review & Refinement (1–2 weeks per round)
5. Build & Development (4–8 weeks)
6. QA & Testing (1–2 weeks)
7. Launch & Handoff (1 week)

**Identity System:**
1. Landscape & Audit (1–2 weeks)
2. Strategy & Territories (2–3 weeks)
3. Identity Exploration (3–4 weeks)
4. Client Review & Refinement (1–2 weeks per round)
5. Identity Refinement & System Build (3–4 weeks)
6. Guidelines & Toolkit (2–3 weeks)
7. Rollout Support (1–2 weeks)

**Naming:**
1. Landscape Audit (1 week)
2. Territory Development (1–2 weeks)
3. Name Generation (2–3 weeks)
4. Client Review & Shortlisting (1–2 weeks per round)
5. Legal Screening (2–4 weeks — often external dependency)
6. Refinement & Recommendation (1 week)
7. Sign-off & Handoff (1 week)

**Other:** Ask the user to describe the phases or suggest a skeleton based on their description.

## Conversation Flow

**Brief check first:** if `projects/{slug}-brief.md` exists for this project, read it and pre-populate everything possible. Use it to skip questions 1, 3, and 5 below — the brief already has project type, deliverables, and timeline. Confirm what was extracted and ask only about gaps.

1. "What type of project is this?" [SELECT: Rebrand, Campaign, Digital Product, Identity System, Naming, Other] *(skip if brief has it)*

2. Present the default phase skeleton for the selected type:
   "Here's a typical phase structure for a {type} project. Does this look right, or do you
   want to adjust any phases?"
   Let the user modify before continuing.

3. "What's the scope? What are the key deliverables?" *(skip if brief has Deliverables section)*

4. "How big is the team on this? Any specific roles assigned?"
   If `team.md` exists in the brain, reference it: "I can see your team roster — who's on this one?"
   If recent `/resource-conflict` output exists in the session, cross-reference it: "Per the last resource-conflict run, {person} is at {N}% utilisation — flag any conflicts before locking the timeline."

5. "When does it need to be done? Any fixed dates (launch, event, board meeting)?" *(skip if brief Constraints section has launch date)*

6. "How many rounds of client feedback do you typically need?" [SELECT: 1 round, 2 rounds, 3 rounds, 4+ rounds]

7. "What's the client's review process like?" [SELECT: Single decision-maker, Small committee (2-3), Large committee (4+), Don't know yet]

8. "Any known risks or constraints? (e.g., key person on holiday, client approval is slow, third-party dependencies)"

9. "Are there parallel workstreams? For example, does copywriting run alongside visual design,
   or does development start before design sign-off?"

10. "Do you run internal crits before showing work to the client?" [SELECT: Yes — every round, Yes — at key milestones only, No, Don't know]
    Internal crits are where creative work gets pressure-tested by the team before the
    client sees it. They are NOT the same as client reviews. If the user runs crits,
    model them as their own short blocks (typically 0.5–1 day) sitting just before each
    client review window. They protect quality and absorb a lot of would-be Round 2 pain.

11. "Are there any 'lock' moments — points where a creative decision gets frozen and
    everything downstream depends on it? (e.g., concept lock, design system lock,
    copy lock, art-direction lock)"
    Lock moments are critical for creative projects. Render them as named milestone
    diamonds on the critical path, not as generic phase boundaries. A "Concept Lock"
    after Round 1 is the single most important milestone in most creative projects —
    if it slips, everything downstream slips with it.

If `methodology.md` exists in the brain, reference it for phase structure instead of defaults.
If `learnings.md` exists, apply relevant past insights and call them out explicitly:
"Based on past projects: {insight}. I've adjusted the timeline accordingly."

**Apply `learnings.md § Capacity` overlay:** if past projects of this type or for this client have logged planned-vs-actual deltas, factor them into the buffers. e.g., "Past Capacity learnings show this client's revision cycles average 2 weeks not 1 — I've doubled Round 2 windows accordingly." Generic buffers are guesses; learning-driven buffers compound over time.

## Output Format

Generate both versions in a single output, clearly separated.

---

## Internal Timeline

# Project Timeline: {Project Name}
**Type:** {project type}
**Duration:** {total weeks} (includes {buffer weeks} weeks buffer)
**Team:** {team size}
**Review rounds:** {n} rounds modelled
**Generated:** {date}

### Phases & Workstreams

{If parallel workstreams exist, show them as parallel tracks with dependency links between them.}

#### Track A: {Workstream Name} (e.g., Design)

##### Phase 1: {Phase Name} — {duration}
**Dates:** {start} → {end}
- [ ] {Deliverable/milestone}
- [ ] {Deliverable/milestone}
**Dependencies:** {what needs to happen before this phase starts}
**Risk flags:** {any risks specific to this phase}

##### Phase 2: {Phase Name} — {duration}
...

#### Track B: {Workstream Name} (e.g., Development)

##### Phase 1: {Phase Name} — {duration}
**Dates:** {start} → {end}
**Depends on Track A:** {specific deliverable from Track A, e.g., "Hero section design comp signed off"}
...

{If no parallel workstreams, use a single sequential track.}

### Internal Crits & Client Review Windows

Model each review round as an explicit block in the timeline, not hidden inside phases.
If the user runs internal crits, add a short crit block (0.5–1 day) immediately before
each client review window — this is where creative quality gets defended before the
client sees it.

| Type | After Phase | Duration | Dates | Owner | Risk Level |
|------|------------|----------|-------|-------|------------|
| Internal crit (pre-R1) | {phase} | 0.5d | {date} | Creative lead | Low |
| Round 1 (client) | {phase} | {duration} | {dates} | Account lead | {Low/Med/High — based on committee size and past patterns} |
| Internal crit (pre-R2) | {phase} | 1d | {date} | Creative lead | Low |
| Round 2 (client) | {phase} | {duration} | {dates} | Account lead | {typically higher — this is where scope creep happens} |
| Round 3 (client) | {phase} | {duration} | {dates} | Account lead | {if applicable} |

### Creative Lock Milestones

List the named lock moments for this project. These are the points where a creative
decision gets frozen and everything downstream depends on it. Each lock should appear as
a milestone diamond on the critical path in the visual output.

| Lock | Date | What it freezes | Cost of slipping |
|------|------|-----------------|------------------|
| Concept Lock | {date} | Creative direction, narrative, key visual approach | Every downstream phase rebuilds from scratch |
| Design System Lock | {date} | Type, color, grid, component logic | Production reworks all applications |
| Copy Lock | {date} | All written content | Layout reflows, translations restart |
| Art Direction Lock | {date} | Photography/illustration brief | Production assets go in the bin |

{Only include locks that apply to this specific project — don't list all four if only
two are relevant.}

{Adjust review window duration based on:
- Single decision-maker → 3-5 business days
- Small committee → 5-7 business days
- Large committee → 7-10 business days
- If user said "client approval is slow" → add 50% to each window
- If review window spans a holiday period → add 1 week}

### Key Milestones
| Milestone | Date | Owner | Status | On Critical Path? |
|-----------|------|-------|--------|-------------------|
| {milestone} | {date} | {person/role} | Upcoming | {Yes/No} |

### Critical Path

Identify the longest sequence of dependent tasks from start to delivery. Highlight which
milestones are on the critical path — these are the dates that, if delayed, push the final
delivery date.

"The critical path runs through: {Phase A} → {Review Round 1} → {Phase C} → {Review Round 2} → {Final Delivery}.
Any delay on this path pushes the launch date 1:1."

### Buffer Recommendations

{Parametric buffers based on the conversation — not generic advice.}

Generate buffer recommendations that reference specific details from the conversation:

- If client review process is committee-based → "Committee sign-off adds unpredictability.
  I've added {n} extra days to each review window."
- If team size is 1-2 → "Small team = single point of failure on {role}. Consider who covers
  if {person} is unavailable for a week."
- If user mentioned slow client approvals → "You flagged slow client approvals. I've added
  50% buffer to every review window and recommend scheduling pre-alignment calls before
  each formal review."
- If duration > 3 months → "For projects this long, schedule a mid-project realignment
  checkpoint at the {midpoint date} mark. Scope, priorities, and team availability will
  have shifted."
- If project spans a holiday period → "Phase {n} spans {holiday period}. I've added {n} days
  to account for reduced availability."
- If `learnings.md` contains relevant insight → "Based on past projects: {specific learning}.
  I've adjusted {specific phase} accordingly."

### Risk Register
| Risk | Likelihood | Impact | Mitigation | Affected Phase |
|------|-----------|--------|------------|----------------|
| {risk} | {H/M/L} | {H/M/L} | {what to do} | {which phase} |

{Always include these standard creative agency risks where applicable:}
- Scope creep at Round 2 feedback (Likelihood: H, Impact: H)
- Key person unavailability (Likelihood: M, Impact: H)
- Client stakeholder changes mid-project (Likelihood: M, Impact: H)
- Third-party dependency delays (Likelihood: M, Impact: M)

### Slip Scenarios

Model 2-3 realistic slip scenarios based on the project's specific risks. For each scenario,
show the knock-on effect on every downstream phase and the final delivery date.

**Scenario 1: {Most likely slip — e.g., "Round 2 review takes 2 weeks instead of 1"}**
- {Phase X} pushed from {date} to {date}
- {Phase Y} pushed from {date} to {date}
- **Final delivery moves from {date} to {date}** (+{n} weeks)
- **Mitigation:** {what the PM can do now to prevent this}

**Scenario 2: {Second most likely — e.g., "Key designer unavailable for 1 week in Phase 3"}**
- {Impact on phases}
- **Final delivery moves from {date} to {date}** (+{n} weeks)
- **Mitigation:** {action — if `freelance-bench.md` exists, name a specific freelancer who could backstop with lead time and day rate, e.g., "Alex Rivera (mid designer, £425/day, 3-day lead) could cover Days 4-8 of Phase 3"}

**Scenario 3: {Worst case — e.g., "Client requests strategic pivot after Round 1"}**
- {Impact on phases}
- **Final delivery moves from {date} to {date}** (+{n} weeks)
- **Mitigation:** {action}

---

## Client-Facing Timeline

{Simplified version — no internal risk flags, no buffer details, no slip scenarios.
Milestone-focused. Confident but honest. Uses tone from `tone-of-voice.md` if available.}

# {Project Name} — Project Timeline

**Duration:** {total weeks}
**Key delivery date:** {final date}

### Phases

#### {Phase Name} — {dates}
{1-2 sentence description of what happens in this phase.}
**Key deliverable:** {what the client receives at the end}
**Your input needed:** {what the client needs to provide and by when}

#### {Phase Name} — {dates}
...

### Key Dates
| Milestone | Date | Your Action Needed? |
|-----------|------|---------------------|
| {milestone} | {date} | {Yes — describe / No} |

### Review Windows
{Frame review rounds as collaborative checkpoints, not blockers:}
- **Review 1 ({dates}):** We'll share {deliverable} for your feedback. Please allow {n} business days for your team to review.
- **Review 2 ({dates}):** Refined direction based on your Round 1 feedback. {n} business days for review.

---

## Tracking This Timeline

After generating the timeline, include this section:

"This timeline is a living document. To keep it useful:
- Run `/status-update` each week to track progress against these milestones
- Run `/timesheet-summary` to compare actual hours against budgeted hours per phase
- If a scope change comes in, run `/timeline-generator` again with the updated scope
- When the project closes, run `/post-mortem` to compare planned vs. actual — the
  learnings feed back into future timelines via your brain"

## Skill Chains

After generating the timeline, suggest the most relevant next step based on context:

- If user hasn't written a proposal yet → "Run `/proposal-generator` to wrap this timeline into a client proposal."
- If user needs to formalise scope → "Run `/sow-generator` to turn this timeline into a Statement of Work."
- If user is about to kick off → "Run `/project-kickoff` to build a kickoff pack around this timeline."
- If user mentioned team capacity concerns → "Run `/resource-conflict` to check team availability against this timeline."
- If the timeline came from a meeting or brief → "Run `/creative-brief` first to nail down scope, then re-run this with the brief's deliverables."

Only suggest 1-2 chains — pick the most relevant, don't list them all.

## Visual Output

Every timeline gets a visual diagram. The format depends on what's available.

### Step 1: Check for Figma MCP

Check whether Figma tools are available in the current tool list (look for tools prefixed
with `mcp__claude_ai_Figma__` or `mcp__plugin_figma_figma__`).

### Step 2: Route to the right visual format

**If Figma MCP IS available** → Figma is the default. Ask the user which format they want:

[SELECT: FigJam diagram, Figma design]

- **FigJam diagram** — Fast, collaborative, editable. Uses `generate_diagram` to create a
  timeline with swimlanes, milestones, and dependency links. Good for internal use and
  team planning sessions. Generate this using the FigJam `generate_diagram` tool with a
  structured description of the timeline including:
  - Swimlane rows for each workstream/track
  - Phase blocks with dates and durations
  - Milestone diamonds on the critical path
  - Connector arrows for dependencies between phases
  - Colour coding: one colour per workstream, a highlight colour for review windows
  - Section callout for risk flags

- **Figma design** — Polished, client-presentable. Uses `use_figma` (via the `/figma-use`
  skill) to create a designed timeline suitable for sharing in a proposal or deck.

  **Before building the Figma file, READ TWO files in this order:**

  1. **`~/.creativestack/visual-style.md`** — the agency's global house visual style.
     Defines the active typography pairing, color palette, spacing system, aesthetic
     principles, and the universal anti-AI-slop checklist. Apply these rules to every
     visual element you generate. If this file does not exist, fall back to the
     defaults: Pairing A (Fraunces / Inter Tight / JetBrains Mono) and Palette 1
     (Paper & Ink), and tell the user at the end: "Run `/setup-brain` to
     configure your house visual style."

  2. **`references/figma-editorial-style.md`** (in this skill directory) — the
     Gantt-specific application of that global style. Defines the grid construction
     math, the internal-vs-client frame composition, milestone and lock rendering,
     and timeline-specific anti-slop additions.

  Read both files in full before issuing any `use_figma` calls. Do not improvise the
  visual style. Do not skim. The grid math in particular is fragile — auto-layout drift
  is the single most common reason a generated timeline looks wrong.

  After generating the Figma file, walk through both anti-slop checklists (the global
  one in `visual-style.md` and the timeline-specific one at the bottom of
  `references/figma-editorial-style.md`). If any item fails, fix it before showing
  the user.

After the user selects, generate the Figma visual. Also include the Mermaid chart in the
markdown output as a portable fallback.

**If Figma MCP is NOT available** → Generate the Mermaid Gantt chart (see below) as the
default visual. Add this note at the end of the output:

"Want a more polished, client-presentable version of this timeline? Install the Figma MCP
server to generate designed timeline diagrams directly in Figma or FigJam."

### Mermaid Gantt Chart

Always include a Mermaid Gantt chart in the markdown output regardless of whether Figma is
used. This ensures the timeline is visual in any tool that renders Mermaid (Notion, GitHub,
GitLab, Obsidian, etc.).

Generate the chart using this structure:

```
gantt
    title {Project Name} — Timeline
    dateFormat YYYY-MM-DD
    axisFormat %d %b

    section {Track A Name}
    {Phase 1 name}           :{active/done/crit}, {id}, {start}, {duration or end}
    {Phase 2 name}           :{status}, {id}, after {dependency}, {duration}

    section {Track B Name}
    {Phase 1 name}           :{status}, {id}, {start}, {duration}

    section Client Review
    Round 1                  :milestone, {id}, {date}, 0d
    Review window            :crit, {id}, {start}, {duration}
    Round 2                  :milestone, {id}, {date}, 0d
    Review window            :crit, {id}, {start}, {duration}

    section Milestones
    {Milestone name}         :milestone, {id}, {date}, 0d
```

Rules for the Mermaid chart:
- Use `crit` for phases and milestones on the critical path
- Use `active` for the current/next phase
- Use a separate `section` for each parallel workstream/track
- Add a `Client Review` section for review windows — makes them visually distinct
- Add a `Milestones` section for key dates
- Keep phase names short (truncate if needed) so the chart renders cleanly
- Use `after {id}` for dependencies rather than hardcoded dates where possible
- Dates in `YYYY-MM-DD` format

## Project State Participation

If the timeline is for an existing project (followed the project state discovery + picker
above), update the state file:

- **Timeline** (this skill owns this section) — write the next milestone with date and
  status, plus any slip scenarios
- **Frontmatter** — update `phase`, `phase_week`, `phase_total` if the project's current
  phase position is now known. Also update `last_updated`.
- **Recent Activity** — append `YYYY-MM-DD — timeline-generator — {N phases}, delivery {date}`
- Update `_index.md`

If you're regenerating a timeline mid-project (e.g., after a slip), keep the old slip
scenario context in mind — the user may want to compare what was planned vs what's
shifting now.

## Edge Cases
- User doesn't know the scope yet → generate a rough framework with TBD placeholders, use phase template as structure
- Very short project (1-2 weeks) → simplify, skip phase structure and parallel tracks, single sequential list
- Very long project (6+ months) → break into macro phases with detail on the first 2-3, add quarterly realignment checkpoints
- Multiple workstreams → create parallel tracks with dependency links (this is the default for most projects)
- User has already run `/creative-brief` → reference the brief's deliverables directly, don't re-ask scope questions
- User provides a timeline from a previous `/timeline-generator` run → treat it as an update, highlight what changed
- Fixed deadline with too much scope → flag it honestly: "This scope doesn't fit this deadline. Here's what fits, and here's what would need to be cut or phased."

### What this skill can't do

This generates one timeline from your description. With an Brain, it could reference
actual timelines from your past projects — what was planned vs. what actually happened —
and adjust estimates based on real data. It could also auto-update when meeting notes flag
a scope change, and track accuracy across projects to get better over time.

---
*CreativeStack by Cameron Jones — jones.cam*
