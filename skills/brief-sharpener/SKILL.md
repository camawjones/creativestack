---
name: brief-sharpener
description: Sharpen an incoming brief before it reaches the creative team. Four modes — Triage (2-min go/no-go before you commit), Sharpen (full 10-dimension audit aligned with creative-brief, deal-breaker ranked questions, red flag detection, client clarification message drafted ready to send, fee/team/timeline sanity checks), Re-brief diff (compare a revised brief against the prior version), Internal brief (sharpen an internally-authored brief without client-facing output). Extracts the real ask hiding behind the stated ask using the 5-whys ladder, scores against the same rubric as creative-brief so the two compound, cross-references past client patterns from learnings.md, and writes the sharpened brief back to projects/{slug}.md so downstream skills inherit the work. The triage mode alone saves hours — bad briefs get flagged before the team wastes time. Use when a client brief arrives and the team needs to know what's missing, what to ask, and whether to start work.
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

# /brief-sharpener

> A brief arrives. Tell me what's missing, what to ask, and what to send back.

## What This Skill Does

Most incoming briefs are half-finished. They're written by clients who
know their business but not how to write for creatives, or by internal
stakeholders who confused a spec document with a brief. Starting creative
work from an unsharpened brief is how projects fail in round 3.

This skill audits an incoming brief and gives the creative team everything
they need to *not start work yet*:

1. **Extracts the real ask** using the 5-whys ladder — the hidden business
   outcome behind the stated deliverable
2. **Scores across 10 dimensions** using the same rubric as `creative-brief`
   so the two skills speak the same language and compound
3. **Detects red flags** from a pattern library covering budget, scope,
   timeline, audience, tone, process, and document-shape issues
4. **Generates deal-breaker ranked questions** (max 10 total), each tied
   to a specific dimension or red flag so the client understands why
5. **Drafts a client clarification message** ready to send — warm, direct,
   per the user's tone of voice from the brain
6. **Runs fee / team / timeline sanity checks** against `rate-card.md`,
   `team.md`, and typical durations for the project type
7. **Cross-references client patterns** from `learnings.md § Feedback` —
   this client's known vocabulary, archetypes, and past brief failures
8. **Writes to project state** so downstream skills (creative-brief,
   creative-strategy, timeline-generator) inherit the sharpening work
9. **Compounds into the brain** — new red flag patterns or client quirks
   get saved to `learnings.md § Client Patterns` for the next brief

The first brief sharpened takes a few minutes longer because it's more
rigorous. Every brief after that compounds — the brain learns this
client's brief patterns, common failure modes get added to the red
flag library, and triage mode gets faster.

## Modes

**Triage** — 2-minute first-pass read. Scores the brief, flags any
project-killers, gives a Go / Conditional Go / No-Go verdict. Use when
deciding whether to engage at all (pitch committee, SOW review, "should
we take this?"). No clarification message, no deep audit.

**Sharpen** (default) — Full 10-dimension audit, deal-breaker questions,
client clarification message drafted, sanity checks, project state
write-back. Use when a real brief has arrived and the team is about to
start work.

**Re-brief diff** — Compare a revised brief against a prior version
from `projects/{slug}-brief.md`. Focuses on what changed, what got
better, what got worse, and what new questions the changes raised.
Don't re-ask old questions.

**Internal brief** — Sharpen a brief authored internally (no external
client). Skips the client-facing clarification message; instead produces
"questions for the internal stakeholder" in the same shape.

## Brain Files
- `profile.md` — your practice context
- `tone-of-voice.md` — for the clarification message voice
- `clients.md` — relationship history, past stakeholder memory, known communication preferences
- `learnings.md § Feedback` — this client's vocabulary, archetypes, stakeholder patterns (from `/feedback-consolidator`)
- `learnings.md § Client Patterns` — recurring brief failure modes across clients (written by this skill)
- `learnings.md § Pitching` — if the brief is pitch-related (from `/pitch-research`)
- `methodology.md` — for structural framing expectations
- `rate-card.md` — for the fee sanity check (from `/project-profitability`)
- `team.md` — for the team sanity check (from `/resource-conflict`)
- `projects/{slug}.md` + `projects/{slug}-brief.md` — existing project state and prior brief versions
- `prospects/{slug}.md` — if the brief arrived with a prospect dossier

**This skill creates and writes:**
- `projects/{slug}.md` — updates the brief status and recent activity
- `projects/{slug}-brief.md` — writes the sharpened brief output (if the project exists)
- `learnings.md § Client Patterns` — appends new red flag patterns or client quirks

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/sharpener-rubric.md`** — read every time. The 10-dimension scoring rubric aligned with creative-brief, traffic-light scoring, blocker rules, readiness states, per-client weighting overlay, and the rubric → creative-brief alignment map.
- **`references/red-flags.md`** — read every time. Pattern library of budget, scope, timeline, audience, tone, process, and document-shape red flags. Each pattern has what it looks like, why it matters, and how to surface it without accusing the client.
- **`references/question-laddering.md`** — read when generating the question list. Three-tier structure, question generation sources, the 5-whys ladder for extracting the real ask, phrasing rules, per-question output structure, the "what I won't ask" rule, and the 10-question ceiling.
- **`references/clarification-message.md`** — read in Sharpen mode when drafting the client-facing message. Tone calibration, structure, opener/framing/questions/offer/close patterns, format variants (email / Slack / call notes), and what NOT to include in the message.

## Conversation Flow

### Step 1: Brain check & mode selection

Run brain discovery. Check specifically:

```bash
[ -f "$HOME/.creativestack/rate-card.md" ] && echo "RATE_CARD_EXISTS" || echo "NO_RATE_CARD"
[ -f "$HOME/.creativestack/team.md" ] && echo "TEAM_EXISTS" || echo "NO_TEAM"
[ -f "$HOME/.creativestack/tone-of-voice.md" ] && echo "TONE_EXISTS" || echo "NO_TONE"
[ -f "$HOME/.creativestack/learnings.md" ] && grep -q "## Client Patterns" "$HOME/.creativestack/learnings.md" && echo "CLIENT_PATTERNS" || echo "NO_CLIENT_PATTERNS"
```

[SELECT] "What do you need?"
- Sharpen — full audit + client clarification message (default)
- Triage — 2-min go/no-go verdict before committing
- Re-brief diff — a revised brief arrived, compare against the prior version
- Internal brief — sharpen a brief authored internally, no client-facing output

**Routing:**
- **Sharpen** → Step 2
- **Triage** → Step 2, but skip Steps 8 (clarification message), 9 (deep sanity checks beyond red flags), and 11 (compounding loop beyond the minimum)
- **Re-brief diff** → Check that `projects/{slug}-brief.md` exists. If not, fall back to Sharpen with a note. If yes, load the prior brief first (Step 4), then receive the new version in Step 5.
- **Internal brief** → Full flow but swap the clarification message for "questions for the internal stakeholder"

### Step 2: Upstream skill synthesis

Scan the conversation for output from earlier skills:

| Skill run earlier | What to pull in | Where it lands |
|---|---|---|
| `/source-scrape` | Category evidence, freshness-scored sources | Evidence for gap and assumption flags |
| `/competitor-audit` | Competitive gaps, positioning map, visual identity scores | Dimension 9 (Category & Competitive), cross-reference with brief's positioning claims |
| `/trend-report` | Trend velocity, counter-trends, fading trends | Dimension 9, flag trend-blind assumptions |
| `/pitch-research` | Prospect dossier, killer hook, past pitch learnings | Dimensions 1 (Tension), 2 (Real Ask), 7 (Stakeholders) |
| `/meeting-notes` | Kickoff decisions, stated vs real asks, stakeholder dynamics | Dimensions 2, 7, contradictions |
| `/sow-generator` | SOW scope, deliverables, fee, timeline | Dimensions 5 (Deliverables), 6 (Constraints), fee sanity check |
| `/feedback-consolidator` | Prior feedback patterns for this client | Per-client rubric weighting |

When upstream data is available, tell the user what's being pulled in:
> "I can see `/competitor-audit` and `/trend-report` ran earlier — I'll cross-reference the brief's positioning claims against the competitive reality and flag any trend-blind assumptions."

### Step 3: Brain context loading

Read the brain files listed above in this order:

1. `profile.md` — your context
2. `clients.md` — does this client exist? Load history and past brief patterns
3. `learnings.md § Feedback` — filter to this client's vocabulary, archetypes, stakeholder memory
4. `learnings.md § Client Patterns` — load known red flags that have appeared across clients
5. `learnings.md § Pitching` — only if pitch-related
6. `methodology.md` — for structural expectations
7. `tone-of-voice.md` — for the clarification message (Sharpen / Re-brief / Internal modes)
8. `rate-card.md` — for the fee sanity check
9. `team.md` — for the team sanity check
10. `projects/{slug}.md` and `projects/{slug}-brief.md` — if the project exists

Report brain depth:

> "Brain depth: Rich — I have your rate card, team data, 3 past projects
> with this client including their known 'bold = brand-confident' vocab,
> and your tone of voice. The clarification message will apply all of
> it."

Or thin:

> "Brain depth: Minimal — no past projects with this client, no tone
> of voice on file. I'll sharpen generically. Consider
> `/setup-cs` or `/update-voice` to get more
> personalised output next time."

### Step 4: Prior brief load (Re-brief diff only)

In Re-brief diff mode, read `projects/{slug}-brief.md` fully and
extract:
- Prior scores per dimension
- Prior Tier 1 and Tier 2 questions
- Prior red flags surfaced
- Prior clarification message sent (if logged)

These become the diff baseline. Any question that was already asked
and answered should not be re-asked in this round.

### Step 5: Receive the brief

User pastes the brief. Accept any format — PDF text, email thread,
Slack paste, call transcript, Notion export, 2-sentence scribble.
Don't force structure.

[SELECT] "What type of project is this?"
- Rebrand
- Brand refresh
- Campaign
- Digital product
- Identity system
- Naming
- Packaging
- Retainer
- Pitch brief
- Phase brief (continuing a multi-phase project)
- Research / strategy
- Content / editorial
- Infer from content
- Not sure — it might be an RFP

If the user picks "Not sure — it might be an RFP", check for RFP
markers (deadline, "response required", team/case study requests,
pricing section). If RFP-shaped, redirect to
`/rfi-response` or `/proposal-generator`
before going further.

### Step 6: Score against the rubric

Read `references/sharpener-rubric.md` and score all 10 dimensions
1-10. Apply the scoring discipline rules:
- Don't grade generously (most client briefs score 5-7)
- Don't grade harshly (a missing section is 4-6, not 1)
- Write one specific note per dimension, not "too vague"
- Add a Low confidence label if the brief is under ~100 words

Apply per-client weighting from `learnings.md § Feedback` if
available — note which dimension matters most for this specific
client based on past project patterns.

Check for blockers. Any Red dimension (1-3) makes the brief
"Blocked" regardless of average.

### Step 7: Detect red flags

Read `references/red-flags.md` and scan the brief for every pattern
in the library:
- Budget & commercial
- Scope & timeline
- Audience & strategy
- Tone & contradiction
- Process & relationship
- Brief-as-document

For each match, note the pattern name, the specific evidence from
the brief, and tie it to one of the tier-ranked questions in the
next step. Also check `learnings.md § Client Patterns` for any
client-specific flags that have appeared before.

### Step 8: Generate the question list

Read `references/question-laddering.md` and generate:

1. **Tier 1 (project killers)** — 1-3 max. Source from Red
   dimensions and severe red flags. Every Tier 1 includes
   "why it matters" and "surfaced by".
2. **Tier 2 (direction changers)** — 3-6 typical. Source from
   Amber dimensions and moderate red flags.
3. **Tier 3 (refinements)** — keep the list short; de-emphasise
   in output.

Apply the 5-whys ladder if the brief is at the deliverable level —
surface one "real ask" question per the template in
`question-laddering.md`.

Apply the 10-question ceiling. If more than 10 total, compress
multi-questions, cut Tier 3s, or recommend a discovery conversation
instead of a question list.

Also build the "what I won't ask" list — things the brief omits
but the sharpener deliberately isn't asking about, so the client
knows the list is curated.

### Step 9: Draft the clarification message

_Skip in Triage mode. Rewrite as internal questions in Internal brief mode._

Read `references/clarification-message.md` and draft the client-facing
message using:
- `tone-of-voice.md` from the brain if it exists
- Client-specific communication tone from `clients.md` if logged
- Default warm-direct voice otherwise

Pick the format (Email default, Slack if the user indicated channel,
call notes if a kickoff call is imminent).

The message includes top 3-5 questions only — Tier 1 first, one or
two Tier 2. Never more than 5 in the message; the rest live in the
internal output for kickoff.

### Step 10: Sanity checks

Run three checks, skipping any whose brain dependency is missing:

1. **Fee sanity** — using `rate-card.md`, estimate the fee implied
   by scope and compare against stated budget. Flag gaps.
2. **Team sanity** — using `team.md`, check whether the roles
   needed are available and capacity is realistic. Flag conflicts.
3. **Timeline sanity** — compare stated timeline against typical
   durations for this project type. Flag impossibilities.

Report what was checked, what was skipped, and why.

### Step 11: Write to project state

If a project already exists (`projects/{slug}.md`) OR the user wants
to create one via quick-start:

1. Write the sharpened brief to `projects/{slug}-brief.md` (update
   or create). In Re-brief diff mode, append as a new version with
   a date header rather than overwriting.
2. Update `projects/{slug}.md` Recent Activity with one line
3. Update `projects/{slug}.md` Open Decisions with any Tier 1
   questions that blocked the brief
4. Update `_index.md`

If no project exists and the user isn't ready to create one, just
output to the conversation and note that project state write was
skipped.

### Step 12: Compounding loop

Offer **at most one** brain enrichment. Pick the most valuable:

- **New red flag pattern not in `red-flags.md`** → "I noticed {pattern} in this brief that isn't in my red flag library. Want me to save it to `learnings.md § Client Patterns` so future sharpener runs catch it?"
- **Client-specific quirk** → "This client's brief uses '{word}' where others would say '{meaning}' — that's a vocab note worth saving to `learnings.md § Feedback` for future briefs with this client. Save it?"
- **Fee gap surfaced** → "The scope implies £{X} against the stated £{Y} budget. Worth a conversation before the team starts — want me to draft specific talking points?"
- **Score below 5.0** → "This isn't a brief yet — it needs a discovery conversation, not another round. Want me to draft the 20-minute discovery agenda?"
- **Triage verdict = No-Go** → "This didn't pass triage. Want me to draft a polite decline / redirect message?"

One offer. Don't pile on.

## Output Format

# Brief Sharpener: {Project / Client Name}
**Mode:** {Triage / Sharpen / Re-brief diff / Internal brief}
**Project type:** {type}
**Brain depth:** {Rich / Partial / Minimal}
**Upstream data used:** {list skills or "None — standalone"}
**Date:** {today}

---

## Brief Score

{Full 10-dimension rubric table from `references/sharpener-rubric.md` — overall score, per-dimension scores, 🟢🟡🔴 status, one-line notes per dimension}

**Overall: {average}/10** — {readiness state}

{If any Red:}
**🚨 Blocker: Dimension {N} ({name}) scores {score}/10.** Creative
work will stall without this. Resolve before briefing the team.

{If per-client weighting applies:}
**Client context:** Past briefs with this client have failed most
often on {dimension}. Current score: {score}. Treating this as
priority.

---

## The Real Ask

{Stated ask from the brief, in one sentence}

**What the client asked for:** "{quote or paraphrase}"

**What I think they actually need:** "{extracted via 5-whys ladder}"

{If confident: flag as "Recommend confirming with the client".}
{If uncertain: flag as "Candidate — needs client validation" and make it a Tier 1 question.}

---

## Red Flags Detected

{One line per flag matched from `references/red-flags.md`. Format:}

- **{Pattern name}** — {specific evidence from the brief}. _Why it matters: {one line}._

{If no flags:} "No pattern matches against the red flag library — unusual, suggests the brief is stronger than most."

---

## Gaps & Assumptions

1. **{Gap}** — {why it matters, what could go wrong}
2. **{Assumption}** — {what the brief takes for granted}

## Contradictions

1. **[CONTRADICTION]** {contradiction description} — {how to resolve via question}

## Trend-Blind / Competitive-Blind Spots
{Only if `/trend-report` or `/competitor-audit` ran earlier}

1. **{Blind spot}** — {cite the upstream finding that contradicts the brief}

---

## Questions Ranked by Deal-Breaker Risk

### Tier 1: Project Killers
_Must be resolved before creative work begins. Maximum 3._

1. **{Question}**
   - **Why it matters:** {one sentence}
   - **Surfaced by:** {dimension / red flag}

### Tier 2: Direction Changers
_Won't kill the project but will redirect the work. Should be resolved before concepting._

1. **{Question}**
   - **Why it matters:** {one sentence}
   - **Surfaced by:** {dimension / red flag}

### Tier 3: Refinements
_Nice-to-know. Can be resolved during the work._

1. **{Question}** — {short reason}

### What I'm deliberately not asking
- {Thing the brief omits that isn't worth asking about — with one-line reason}

---

## Client Clarification Message
_Skip in Triage mode. Internal version in Internal brief mode._

**Format:** {Email / Slack / Call notes}
**Voice:** {from tone-of-voice.md if available, or default warm-direct}

> {Full drafted message per `references/clarification-message.md`, ready to copy-paste}

---

## Sanity Checks

| Check | Result | Action |
|---|---|---|
| **Fee** | {estimated £range vs stated budget} | {assessment} |
| **Team** | {roles available / gaps / capacity} | {assessment} |
| **Timeline** | {realistic / aggressive / impossible / unknown} | {assessment} |

{One paragraph of detail per check. Skip any check whose brain dependency is missing and note what was skipped.}

---

## Sharpened Brief

{The original brief, reorganized and annotated with:
- [GAP] markers where information is missing
- [ASSUMPTION] markers where something is taken for granted
- [CONTRADICTION] markers where the brief argues with itself
- [RED FLAG] markers tied to the pattern library
- [TREND-BLIND] / [COMPETITIVE-BLIND] markers if upstream data surfaced them
- Suggested additions in italics}

---

## Triage Verdict
_Triage mode only. Skip in other modes._

**Verdict:** {Go / Conditional Go / No-Go}

**Reasoning:** {2-3 sentences}

**If Conditional Go:** {what must be resolved before committing}

**If No-Go:** {why, and what would make it a Go}

---

## Brain Overlays Applied

- **From `learnings.md § Feedback`:** {specific applications, or "no feedback history for this client"}
- **From `learnings.md § Client Patterns`:** {specific flags matched, or "none matched"}
- **From `clients.md`:** {relationship notes applied, or "client not on file"}
- **From `tone-of-voice.md`:** {applied to clarification message / default voice used}
- **From upstream skills:** {list of session-run skills whose outputs fed the sharpening}

---

## Written to brain
_Skip section if no project state exists._

- ✓ `projects/{slug}-brief.md` — {created / updated / new version appended}
- ✓ `projects/{slug}.md` — Recent Activity + Open Decisions updated
- ✓ `projects/_index.md` — updated

---

## Slack Format

*Brief: {Project / Client Name}* — sharpened
**Score: {X}/10** {🟢🟡🔴} {readiness state}
**Real ask:** {one sentence}
**Tier 1 questions:** {count}
**Red flags:** {count} ({list names briefly})
**Sanity checks:** {fee state} / {team state} / {timeline state}
**Clarification message:** drafted and ready to send

---

## Gotchas

The mistakes that make sharpener output feel like noise or, worse,
damage the client relationship. Read every time.

### Sharpening slop
- **Don't rewrite the client's brief.** The [GAP] / [ASSUMPTION] /
  [CONTRADICTION] annotations are the output — not a full rewrite.
  The client wrote their brief; your job is to surface, not replace.
  Rewrites signal disrespect and usually get ignored anyway.
- **Don't score a 2-sentence brief confidently.** If the input is
  thin, the scores are directional only. Label as Low confidence
  and recommend a longer input or From scratch mode in `creative-brief`.
- **Don't mistake an RFP for a brief.** RFPs have deadlines, response
  requirements, team/case study requests, and pricing sections. They
  belong to `/rfi-response`, not here.
- **Don't treat a transcript as a brief.** Meeting transcripts need
  `/meeting-notes` first to extract decisions; raw
  transcripts aren't briefable.
- **Don't skip the red flag library.** It's not optional — the patterns
  you don't notice are the ones that cause problems.

### Question-list slop
- **Don't ask more than 10 questions total.** If you have more, you
  haven't ranked. The correct response to "too many questions" is
  either consolidation or a recommendation to have a discovery
  conversation instead of sending a question list.
- **Don't bundle multi-questions.** "What's the budget, timeline,
  and approval process?" is three questions wearing one hat. Split
  them or the client will answer the easiest one and ignore the rest.
- **Don't ask without tiering.** Every question needs a tier and a
  "why it matters". Ungrouped questions look like a questionnaire,
  which trains clients to delegate the response to an assistant.
- **Don't ask generic questions.** "What's the target audience?"
  is useless. "When you picture the single person this needs to
  work hardest for, who are they and what are they doing?" is
  useful. If you couldn't reasonably answer a question yourself
  from the brief context, the client can't either.

### Clarification message slop
- **Don't criticise the brief in the message.** "The brief is
  missing several things..." makes the client feel bad and will
  poison the relationship. Frame questions around protecting the
  team's time and the client's outcomes.
- **Don't use "reaching out" or "hope this finds you well".** AI
  slop signals. Real creatives don't start emails this way.
- **Don't send more than 5 questions in the message.** The rest
  belong in the internal output for the kickoff call. Long message
  = long delay in response.
- **Don't use formal sign-offs with warm tone framings** — "Dear
  Marcus" with a casual closer is a tonal car crash. Match top to
  bottom.
- **Don't use "we require" or "in order to proceed".** Bureaucratic
  framings signal a skill-generated message.

### Rubric slop
- **Don't score every brief at 7/10.** If everything scores 7, the
  rubric isn't doing its job. Most incoming briefs are 5-7 with at
  least one Red or low Amber.
- **Don't ignore Red dimensions because the average is okay.** A
  brief averaging 7.2 with a Red on Stakeholders is still Blocked.
  The blocker overrides the average.
- **Don't score dimensions the brief didn't try to cover.** If the
  brief is explicitly scoped to exclude Success Criteria ("we'll
  figure out metrics later"), note it and score accordingly — don't
  penalise something the brief deliberately deferred.

### Brain slop
- **Don't over-apply client vocabulary.** If `learnings.md` says
  Marcus uses "bold" to mean "brand-confident", apply it to the
  tone interpretation — don't find-and-replace every word in the
  brief.
- **Don't rewrite the voice if tone-of-voice.md is thin.** If the
  brain has two tone notes and nothing else, default to the warm-
  direct voice rather than forcing a half-rendered voice match.
- **Don't assume the brain is right over the brief.** If the brain
  says the client is "budget-sensitive" and this brief says £500k,
  the brief is the newer signal. Flag the tension; don't silently
  override.

---

## Edge Cases

- **Very short brief (1-2 sentences)** → Don't score confidently.
  Add Low confidence label and recommend `/creative-brief`
  From scratch mode to walk through the questions instead.
- **Brief is an RFP** → Redirect to `/rfi-response` or
  `/proposal-generator`. Don't sharpen — the rubric
  doesn't fit.
- **Brief is a transcript** → Redirect to `/meeting-notes`
  first to extract decisions, then come back with the structured notes.
- **Brief scores very high (8.5+)** → Acknowledge it's strong.
  Focus output on the one or two weak areas only. Don't invent
  problems for the sake of an audit.
- **Upstream data contradicts the brief** → Flag clearly but don't
  override. The brief may have information the upstream skills
  don't. Surface the conflict as a question.
- **Re-brief diff mode but prior brief isn't in project state** →
  Fall back to Sharpen with a note: "No prior version on file, so
  treating this as a fresh brief."
- **Internal brief but no internal stakeholder is named** → Ask who
  the questions will go to before drafting the internal questions
  section.
- **Client has sent a 40-slide pitch deck as the brief** → Extract
  the brief-shaped content, flag the rest as context, ask the
  client to confirm priorities. Don't try to score the deck as a
  whole.
- **Multiple briefs arrive for the same project in one session**
  (e.g. an email + an attached PDF) → Merge, flag
  contradictions between the two sources, then sharpen the merged version.
- **Scope is genuinely open-ended by design** (retainer, ongoing
  creative partnership) → Skip Deliverables scoring, note the
  different shape, focus on Stakeholders, Success Criteria, and
  Constraints.
- **User wants to skip the rubric and just get the questions** →
  Honour the request. Run Steps 6-9 only, skip the rest, note
  that scoring was skipped.

## Skill Chains

### Upstream (what feeds brief-sharpener)

- **No prospect context and the brief is from a pitch** → "Run `/pitch-research` for context on the prospect first — it'll help identify the real ask and decision-maker dynamics."
- **No competitive context and Dimension 9 scored low** → "Run `/competitor-audit` before sharpening next time — category blind spots are harder to catch without it."
- **No category awareness** → "Run `/trend-report` for a fast read on what's shifting in the category."
- **Working from a transcript** → "Run `/meeting-notes` to extract structured decisions, then bring them here."
- **No rate card** → "Run `/project-profitability` Setup rates to enable fee sanity checks on future briefs."
- **No tone of voice on file** → "Run `/update-voice` to get client clarification messages drafted in your actual voice."

### Downstream (what brief-sharpener triggers)

Score + mode-based suggestions:

- **Score 8.0+, no blockers** → "Brief is strong. Run `/creative-brief` From inputs mode to format it, then `/timeline-generator`."
- **Score 6.5-7.9** → "Send the Tier 1 questions back to the client first, then run `/creative-brief` once answers land."
- **Score 5.0-6.4** → "Brief needs real tightening. Send the clarification message, then come back for Re-brief diff mode once you have answers."
- **Score <5.0** → "This isn't a brief yet — it needs a discovery conversation. Run `/project-kickoff` or schedule a workshop rather than another brief round."
- **Any Red dimension** → "Blocker on {dimension}. Resolve with the client conversation first — another skill run won't fix this."
- **Fee sanity check surfaced a gap** → "Run `/project-profitability` Scenario mode to model the implications before committing."
- **Brief needs a SOW** → "Run `/sow-generator` using the sharpened brief as input."
- **Brief needs a proposal** → "Run `/proposal-generator` wrapping the sharpened brief."
- **Triage verdict = No-Go** → "Draft a polite decline / redirect — want me to do that now?"

Only suggest 1-2 chains. Pick the most urgent.

### What this skill can't do

This skill sharpens one brief from public patterns and your brain.
A dedicated AI partner could cross-reference this brief against every
brief this client has ever sent, recognise their writing patterns,
pre-flag the gaps they consistently leave, and track which sharpening
moves have unlocked their best projects in the past. The brain enables
some of this; deeper per-client pattern learning is the remaining
frontier.

---
*CreativeStack by Cameron Jones — jones.cam*
