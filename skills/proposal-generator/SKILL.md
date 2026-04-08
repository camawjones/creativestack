---
name: proposal-generator
description: Turn a brief, RFP, or rough notes into a structured proposal — full version plus one-page summary — with strategic approach, scope, phased timeline, opinionated pricing guidance, team allocation, risks/assumptions, and competitive differentiation. Reads project state if pitching to a returning client (pulls past pricing patterns and outcomes), runs a pre-flight gut check on pitch quality before generating, and persists per-client pricing memory for next time. Optional Figma layout that respects the agency's house visual style.
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

# /proposal-generator

> Brief in, proposal out. No more blank-page paralysis — and no more underpricing.

## Brain Files
- `profile.md` (for positioning and capabilities)
- `tone-of-voice.md` (for proposal voice)
- `visual-style.md` (applied to any Figma proposal layout — see Visual Output below)
- `methodology.md` (for default phase structure)
- `case-studies.md` (portfolio index — for discovery and tagging)
- `case-studies/{slug}.md` (full case study files for the strongest 2-3 matches — long-form content, hero quote, metrics framings; from `/case-study`)
- `learnings.md § Pitching` (per-sector win/loss patterns from past pitches; from `/pitch-research` Log outcome mode)
- `team.md` (for team expertise, bios, and rates)
- `freelance-bench.md` (trusted freelance roster — used to credibly fill capacity gaps in scope/team sections; from `/resource-conflict` Setup bench)
- `clients.md` (for client relationship history)
- `learnings.md` (for what's worked or backfired in past pitches)

## What This Skill Does

Takes a client brief, RFP, or rough conversation notes and produces a structured
proposal with the commercial and operational scaffolding around the creative response.
The skill builds the *vehicle* for the creative pitch — exec summary, understanding,
approach, phases, deliverables, timeline, team, risks, pricing options, what's not
included, next steps. It does not write the creative concept. That stays human.

Two outputs every time: a **full proposal** (formal submission) and a **one-page
summary** (initial conversations, quick alignment). Optional Figma layout if the
Figma MCP is available.

Reads project state to recognise returning clients and pull their pricing history,
past outcomes, and any pitch learnings. Runs a **pre-flight gut check** on the brief
before generating — flags missing information, red flags, and pitches that probably
shouldn't happen. Persists per-client pricing patterns to Skill Memory so each
proposal builds on the last.

## Conversation Flow

### Step 1: Project state discovery

Follow the project state discovery + picker protocol. Three cases:

- **Returning client, existing project state file** — Read the full state file. Pull
  Stakeholders, Brief, Status History, and the `proposal-generator` namespace from
  Skill Memory if it exists.
- **Returning client, no state file** — Offer to bootstrap a quick state file (Quick
  Start path) using the new brief as the seed.
- **New prospect** — Create a quick state file with `status: pitched` in the
  frontmatter, populate Brief and Stakeholders from the new brief.

In all cases, the project state file becomes the canonical home for this proposal and
any future work that follows.

### Step 2: Brain check

Read the brain files listed above. Pay special attention to:
- `case-studies.md` — scan the portfolio index to find 2-3 case studies relevant to project type, industry, or deliverables. **Use the strongest, not the most. Two great > five mediocre.** Then read the full files at `case-studies/{slug}.md` for the chosen 2-3 — pull the hero quote, primary metric, and "what was hard" section into the proposal verbatim. Generic case study summaries persuade nobody; specific evidence does.
- `learnings.md § Pitching` — filter to this client's sector and project type. Apply as an overlay in the gut check and the Risks section. Examples: "You've pitched 4 sport brands in the last 18 months — 1 won, 3 lost, all citing 'too small' as the reason. Address scale upfront in this proposal." Or: "Past pitches in this category that lost cited 'we wanted strategy not deliverables' — lead with the strategic frame, not the scope list."
- `team.md` — pull team expertise that maps to the brief; note day rates if available
- `freelance-bench.md` — if the brief implies skills the in-house team is thin on (motion, illustration, specific tooling), name a bench freelancer with day rate and lead time so the proposal's team section is credible end-to-end
- `learnings.md` — scan for past pitch insights for this client or this project type
  ("rebrands always need 2 extra weeks of stakeholder management with this size of org")
- `clients.md` — note relationship history with this client if returning

### Step 3: User provides the brief

The user pastes the brief, RFP, conversation notes, or describes verbally.

Parse the paste actively. Extract:
- **Client name and project type** (rebrand, campaign, digital product, etc.)
- **Deliverables explicitly requested**
- **Budget signals** (hard number, range, "TBC", or no mention — note the difference)
- **Timeline signals** (deadline, launch date, "ASAP", or no mention)
- **Decision criteria** (mentioned in RFPs especially — score against them)
- **Constraints** (geography, languages, technical platforms, team requirements)
- **What's missing** — note explicit gaps for the gut check

If it's an RFP with format requirements or scoring criteria, **adapt the output to
match their template structure**. Don't force your default format onto their RFP.

### Step 4: Pre-flight gut check

Before generating anything, run an honest assessment of pitch quality. Surface this
to the user as a short report — not a wall of text, just the things worth knowing
before they spend hours on a pitch:

```
## Pre-flight check

**Pitch quality:** {Strong / Mixed / Weak} — {one-sentence reason}

**What's clear:**
- {clear thing 1}
- {clear thing 2}

**What's missing or vague:**
- {missing thing 1 — e.g., "No budget signal at all. Hard to scope."}
- {missing thing 2 — e.g., "Decision-maker not named. Risk of pitching to the wrong person."}

**Red flags:** {only if any}
- {flag — e.g., "Three rounds of revision implied but not stated. Lock this down."}
- {flag — e.g., "Client mentioned 'we have an internal team that could do this' — they're price-shopping."}

**Past pitch overlay:** {Only if `learnings.md § Pitching` has entries for this sector/type. Surface the recurring loss reasons or win patterns explicitly. e.g., "Past sport pitches: 1 won, 3 lost — losses cited 'too small' (×2) and 'wanted strategy not deliverables' (×1). Address both upfront."}

**Worth pitching?** {Yes / Yes with caveats / Probably not — here's why}
```

If the gut check returns "Probably not", **don't refuse to continue.** Make the
recommendation, then ask: "Continue anyway, or pause and gather more info first?"
Use `AskUserQuestion`. Respect the user's call.

### Step 5: Clarifying questions

Only ask what isn't already covered by the paste, project state, brain, or gut check.
Common ones to batch via `AskUserQuestion`:

1. [SELECT] "What type of project is this?" — `Rebrand` / `Campaign` / `Digital product` / `Identity system` / `Naming` / `Other`
2. [SELECT] "What pricing model fits this work?" — `Fixed fee` / `Day rate` / `Retainer` / `Hybrid (fixed + extras)` / `Phased (fee per phase + go/no-go)`
3. "Do you have a budget signal from the client, or should I propose based on scope?"
4. "Any constraints — timeline, team availability, deliverables they've specifically asked for?"

If `proposal-generator` Skill Memory exists for this client, default to the same
pricing model as last time and confirm rather than re-ask.

### Step 6: Pricing anchor (the part most skills skip)

This is where most creatives undercharge. Anchor pricing using all available signals,
in order of preference:

1. **Skill Memory for this client** — what they paid last time, and whether you felt
   it was right. "Last project for this client was £45k fixed fee for a similar-scope
   identity system. Client paid on time, no scope creep. Anchor here unless scope has
   grown materially."
2. **Brain `case-studies.md`** — fees for comparable past work (if documented)
3. **Brain `team.md`** — team rates × estimated days, with a markup floor (creatives
   should rarely sell at cost — explain why)
4. **Industry benchmarks** for the project type (use ranges, never single numbers)

For each pricing option, present:
- The headline number (range, not single point — single numbers anchor too tightly)
- What's included
- The biggest assumption underneath the number
- Where it could leak margin (revisions, scope ambiguity, third-party costs)

**Be opinionated.** If the project is high-leverage (rebrand, identity, naming —
work that defines a brand for years), nudge toward **value pricing** rather than
day-rate. If the project is high-uncertainty (discovery, R&D), nudge toward
**phased pricing with go/no-go gates** to protect both sides. Tell the user *why*
in one sentence.

### Step 7: Generate the proposal

Read `references/output-formats.md` for the full proposal template, the one-page
summary template, and the RFP-formatted variant.

Apply tone from `tone-of-voice.md`. Use the project state Brief and Stakeholders as
the spine of the Understanding section. Pull the strongest 2-3 case studies (not
all of them) for Competitive Differentiation. Use the gut check findings to inform
the Risks & Assumptions section — don't bury what you flagged.

Always include these sections — they're often missing from generated proposals and
that's where projects go wrong:

- **Risks & Assumptions** — make every load-bearing assumption explicit ("we assume
  the client provides existing brand assets, photography, and a single approver").
  This is the most important section in the whole proposal.
- **Revision rounds** — explicit number per phase. Vague revision policy is the #1
  source of scope creep.
- **What's not included** — list out-of-scope items by name. If the client thinks
  it's included and you don't, the project breaks.
- **Payment terms** — milestone-based, deposit %, late payment terms, kill fee if
  appropriate. Don't leave this for the SOW.
- **IP and usage rights** — who owns the work, where it can be used, for how long.
  Critical for brand, illustration, motion, photography work.

### Step 8: Visual output (Figma — optional)

Check whether Figma tools are available (look for tools prefixed with
`mcp__claude_ai_Figma__` or `mcp__plugin_figma_figma__`).

**If Figma MCP IS available** → offer: "Want me to lay this out as a designed
proposal in Figma?"

If yes, **before building anything**, read `~/.creativestack/visual-style.md` — the
agency's house visual style. Apply its typography, color palette, spacing rules, and
anti-slop checklist to every frame. If `visual-style.md` doesn't exist, fall back to
the Editorial Modern defaults and tell the user at the end: "Run
`/setup-cs` to configure your house visual style for sharper proposal
layouts."

Build the layout with these spreads:
- Cover page (project name, client, date, agency mark)
- Executive summary (single spread, generous whitespace)
- Understanding + Approach (one or two spreads)
- Phases + Timeline (visual phase ribbon)
- Team (with bios and relevant work)
- Pricing (clean table — no decoration)
- Risks & Assumptions (explicit, not buried)
- Case studies (2-3, image + 1-line outcome)
- Next steps + sign-off

After generating, walk through the anti-slop checklist in `visual-style.md`. Fix
anything that fails before showing the user.

**If Figma MCP is NOT available** → the markdown output is the complete deliverable.
Add: "Want a designed proposal layout? Install the Figma MCP server to generate
polished proposal documents directly in Figma."

### Step 9: Write back to project state

- **Frontmatter** — set/keep `status: pitched`, update `last_updated`
- **Brief** — update if the new brief is more detailed than what was there
- **Stakeholders** — add any new stakeholders mentioned in the brief
- **Risks** — append the assumptions and red flags from the gut check + proposal
- **Recent Activity** — append `YYYY-MM-DD — proposal-generator — {project type}, {pricing model}, {fee range}`
- **Skill Memory → proposal-generator** — write/update:
  - `pricing_model`: last used model
  - `last_fee_range`: the range you proposed
  - `last_proposal_date`: today
  - `pitch_outcome`: leave empty until known (user updates manually or via post-mortem)
  - `caveats`: recurring assumptions worth remembering for next pitch to this client
- Update `_index.md`

After writing, brief one-line summary: *"Proposal saved to project state. Update
`pitch_outcome` in Skill Memory when you hear back so future pitches learn from this."*

## Gotchas

The mistakes that actually lose pitches or burn margin on the ones you win. Read
these every time — most are silent until they bite.

### Pricing
- **Generated pricing is anchored to nothing.** If you didn't read past project margins,
  case study fees, or team day rates, the number you produced is a guess dressed as
  expertise. Always anchor.
- **Single-point pricing destroys negotiating room.** Always present a range, or
  options (lean / standard / extended). Never one number for the whole thing.
- **Day rate for fixed-output work is a margin hole.** If the deliverable is defined,
  the client wants a fixed fee — they're outsourcing the risk to you. Price the risk in.
- **Fixed fee for ambiguous discovery is suicide.** If the scope can't be pinned down,
  use phased pricing with go/no-go gates. Phase 1 is paid discovery.
- **Underpricing because the client "can't afford it".** That's a qualification problem,
  not a pricing problem. Don't subsidise your client's business plan.
- **Forgetting third-party costs.** Photography, talent, licensing, dev infrastructure,
  hosting, print production. These leak budget if not itemised.
- **Currency and VAT.** International clients — be explicit. UK clients — VAT in or out?
  US clients — sales tax considerations?
- **Late payment terms not stated.** Statutory interest exists (UK: 8% + base rate).
  Mention it. It changes behaviour.

### Scope
- **Vague revision policy is the #1 cause of scope creep.** State the number of
  revision rounds per phase explicitly. "Two rounds of revisions per phase. Additional
  rounds at day rate."
- **Listing "what's included" without "what's not included".** The "what's not"
  list prevents 80% of mid-project conflicts. Be explicit.
- **Hidden assumptions about who provides what.** Brand assets, photography, copy,
  sign-off chains, content. If you assume the client provides it and they don't, your
  margin walks. Make every assumption visible in Risks & Assumptions.
- **Implying future phases are guaranteed.** If the client only signs Phase 1, Phase 2
  is hopeful, not committed. Don't bake Phase 2 fee into your projections.
- **Promising aggressive timelines to look responsive.** You'll deliver tired work and
  burn the team. Quote a realistic timeline; if they need faster, charge for it.

### Strategic / pitch quality
- **Generic exec summaries that say nothing.** "We are a passionate team of creators
  who deliver world-class…" — every pitch sounds like this. Cut it. Say something
  specific to *this* brief in the first sentence.
- **Listing every relevant case study instead of the strongest 2-3.** Five mediocre
  case studies dilute three great ones. Pick the strongest. Be ruthless.
- **Differentiation that could be any agency's.** "Strategic thinking, creative
  excellence, collaborative process" — every agency claims this. The differentiation
  has to be specific and provable, not aspirational.
- **Pitching when the gut check says don't.** Sometimes the right move is "not this
  one." Saying no protects the energy you have for pitches you can win.
- **No decision-maker named.** If you don't know who's deciding, you're pitching into
  a void. Find out before you commit hours.
- **Price-shopping clients.** If the brief mentions "we're getting quotes from a few
  agencies" without context, you're pricing pressure for someone else's negotiation.
  Decide if you want to play that game or set a floor.

### IP and rights
- **No IP clause for brand work.** Who owns the logo, the system, the guidelines?
  When does ownership transfer? Tied to final payment?
- **Usage rights for photography, illustration, music, talent.** Limited license vs
  unlimited, regional vs worldwide, time-limited vs perpetual. The client thinks
  they bought "the photo" — you might have only licensed it for a campaign.
- **Source files vs final assets.** Do they get the editable Figma file, or only
  the exported PDFs? State it. Default to "final exports only" unless paid for.

### Operational
- **RFP format requirements ignored.** Formal RFPs often have hard requirements
  (page count, font, section order, scoring criteria). Ignoring these gets you
  disqualified before anyone reads the content. Adapt the output to their template.
- **Generated content with the wrong agency name.** Trivial but devastating. Always
  verify the agency name in `profile.md` matches what's in the proposal.
- **Sending without a human read.** This skill produces the scaffolding. The human
  must read every line before it goes out. It will say things you didn't mean if you
  don't catch them.

## Skill Chains

### Upstream

- No project state for a returning client → "Run `/project-kickoff` to formalise the relationship history first."
- No timeline → "Run `/timeline-generator` to build phase structure with dependencies — proposals reference it directly."
- No competitive context → "Run `/pitch-research` to strengthen the 'why us' section."
- No creative brief signal → "Run `/creative-brief` to nail down objectives — proposals are stronger when the brief is solid."

### Downstream

- Client accepts → "Run `/sow-generator` to formalise this into a Statement of Work, then `/project-kickoff` to start delivery."
- Need a more detailed timeline before sending → "Run `/timeline-generator` to build the full timeline with slip scenarios."
- Pitch lost or won → "Update `pitch_outcome` in Skill Memory and run `/post-mortem` on the pitch — losses teach more than wins."

Pick the most relevant 1-2.

## Edge Cases
- Very vague brief → run the gut check, flag the gaps, ask for clarification before generating. Don't paper over missing information with assumptions.
- RFP with strict format requirements → adapt output to their template; flag if any of their requirements force you to skip a standard section
- No budget provided → generate two options (lean and standard) with clear trade-offs, never three (analysis paralysis)
- Multi-phase or retainer project → structure as phases with go/no-go gates; the first phase should be paid discovery
- No case studies in brain → omit the section, never fabricate. Tell the user to populate `case-studies.md` for next time.
- User has already run upstream skills → skip the questions those answered
- Returning client — losing pattern → if Skill Memory shows multiple lost pitches with this client, raise it: "You've pitched this client 3 times without winning. Consider whether this is the right client for you, or whether the offering needs to change."

### What this skill can't do

This skill generates one proposal at a time. With more pitch history in project state,
it could surface win-rate trends across project types, identify which case studies
actually convert, and learn pricing patterns that worked vs didn't. Every time you
update `pitch_outcome` in Skill Memory after a decision, the system gets sharper.

It also cannot tell you whether to walk away from a client or a category. The gut
check surfaces signals; the call is yours.

---
*CreativeStack by Cameron Jones — jones.cam*
