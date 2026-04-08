---
name: creative-strategy
description: Research-driven creative strategy tool for creatives and creative companies. Distinguishes the five strategy types most agencies conflate (brand / comms / creative platform / campaign / category), routes to the right framework from a curated set of nine (tension-based, cultural, challenger, jobs to be done, category entry points, behavioural, purpose, platform-led, distinctive brand assets) plus an Open mode that picks the framework from the evidence. Reads project state to build on prior strategy rounds, runs a pre-flight check on whether strategy is even the right answer, calls /creativestack:source-scrape for landscape and evidence, generates a research pack with cited evidence plus a one-page framework-shaped Strategy on a Page, and runs a strict anti-slop check before showing the work. Generates research, tensions, and provocations — never the creative answer.
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

# /creativestack:creative-strategy

> Research and provocations for strategists. The creative answer stays human. The slop stays out.

## Brain Files
- `profile.md` (for the studio's positioning and how it thinks about strategy)
- `tone-of-voice.md` (for how the strategy narrative is written)
- `case-studies.md` (for prior strategic work in adjacent categories — avoid duplicating)
- `learnings.md` (for past strategy patterns — what landed, what didn't, what the studio learned about its own house POV)

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/frameworks.md`** — read after the user picks a framework, for the
  framework's lineage, when-to-use / when-not-to, key questions, failure mode,
  and Strategy on a Page shape. The most important reference file in this skill.
- **`references/output-formats.md`** — read at generation time for the research
  pack template (with type-specific sections), the universal Strategy on a Page,
  and the anti-slop checklist

## What This Skill Does

Most "creative strategy" output is slop because the people writing it skip three
steps: they don't decide *which kind* of strategy they're doing, they don't pick
*the right framework* for the brief, and they don't pressure-test their own work.
This skill forces all three.

**The five strategy types** (most agencies conflate them — they have different
outputs and different research needs):

1. **Brand strategy** — who the brand is, what it stands for, who it's for, why
   it exists. Outputs positioning, purpose, territories.
2. **Comms strategy** — how the brand talks. Message hierarchy, channel logic,
   tone modulation.
3. **Creative platform** — the unifying creative thought that holds work together
   over years. The single thought + the generative test.
4. **Campaign strategy** — strategy for a single campaign with a specific
   objective. The behaviour to change, the insight, the idea space.
5. **Category strategy** — the bigger play within the category. Take share,
   define the category, or create a new category.

**The nine frameworks** (plus Open):

Tension-based, Cultural, Challenger brand, Jobs to be Done, Category Entry Points
(Ehrenberg-Bass), Behavioural science, Purpose-driven, Platform-led, Distinctive
Brand Assets, plus **Open** — let the evidence decide which 1-2 frameworks fit.

The skill outputs a **research pack** (long form, evidence-cited) and a **Strategy
on a Page** (the single-page distillation, framework-shaped). It generates
research, tensions, and provocations — *never* the creative answer. The point of
strategy is to make it harder to do the wrong work, not to write the right work
for the creative team.

Reads project state to build on prior strategy rounds. Runs a pre-flight check on
whether strategy is even the right answer (sometimes it isn't). Walks every
output through a strict anti-slop checklist before showing the user.

## Conversation Flow

### Step 1: Project state discovery

Follow the project state discovery + picker protocol.

- **Returning client / project, existing state file** — Read it. Pull Brief,
  Stakeholders, and the `creative-strategy` namespace from Skill Memory if it
  exists. If a prior strategy round was run, surface what was decided:
  *"Last round we landed on a Tension-based brand strategy and the territory
  was 'quiet authority'. Building on that, pivoting, or starting fresh with a
  different strategy type?"*
- **Returning client, no state file** — Offer the bootstrap path.
- **New project / standalone** — Ask if the user wants to spin up a state file
  (strategy is more useful when persisted across rounds). Respect the call.

### Step 2: Brain check

Read the brain files. Pay attention to:
- `case-studies.md` — has the studio done strategy work in this category, for
  this audience, or with this framework before? Cite it. Don't duplicate it.
- `learnings.md` — does the studio have a house POV on strategy? Some studios
  lean tension-based, others cultural, others behavioural. The strategy should
  reflect the studio's strength unless there's a strong reason to break pattern.

### Step 3: Upstream skill synthesis

Scan the conversation for output from other CreativeStack skills:

| Skill run earlier | What to pull in | Where it appears |
|---|---|---|
| `/creativestack:trend-report` | Trend names, velocity scores, counter-trends | Cultural context — don't re-research |
| `/creativestack:competitor-audit` | Positioning map, visual / verbal codes, gaps | Competitor landscape — reference directly |
| `/creativestack:design-research` | Cultural references, design movements | Cultural context + creative platform shape |
| `/creativestack:source-scrape` | Scored sources, themes, evidence | Evidence base throughout — cite quality scores |
| `/creativestack:brief-sharpener` | Sharpened brief, deal-breaker questions | Brief context — surfaces what's still vague |
| `/creativestack:creative-brief` | Objectives, audience, success criteria | Brief context — drives strategy type choice |

When upstream data is available, tell the user what you're pulling in.

### Step 4: Strategy type picker

Ask in plain English, not jargon:

[SELECT] *"What kind of strategy are you trying to make?"*
- **Brand strategy** — who this brand is, what it stands for, why it exists
- **Comms strategy** — how the brand talks (message hierarchy, channels, tone)
- **Creative platform** — the unifying creative thought that holds years of work together
- **Campaign strategy** — strategy for a single campaign with a specific objective
- **Category strategy** — the bigger play in the category (take share, define category, create new category)

If the user is unsure, ask a follow-up: *"Is this work asking 'who is this brand?'
(brand), 'how does this brand talk?' (comms), 'what's the unifying creative thought
across years of work?' (platform), 'how do we win this one campaign?' (campaign),
or 'what's the bigger play in this category?' (category)?"*

If the answer is genuinely "all of them", this is a flag — the brief is too big
for one strategy round. Push back: *"That's three projects, not one. Want me to
start with brand strategy and chain forward, or pick the most pressing one?"*

### Step 5: Pre-flight check *(does this brief need strategy at all?)*

Before generating, run an honest assessment. Surface this as a short report.
Strategy theatre — strategy work that exists to look serious — is the most
common failure mode in creative agencies. The pre-flight check exists to catch
it.

```
## Pre-flight check

**Strategy quality:** {Strong / Mixed / Weak} — {one-sentence reason}

**What's clear:**
- {clear thing — e.g., "Genuine business problem: brand has lost ground to
  challenger in last 18 months, evidence in the brief"}
- {clear thing}

**What's vague *(would make strategy more useful if tightened)*:**
- {vague thing — e.g., "'Refresh the brand' could mean visual rebrand,
  positioning shift, or messaging reset. Three different strategies."}
- {vague thing}

**Is strategy the right tool here?**
- {Yes / Yes but / No — and here's what is}

  Common cases where the answer is No:
  - "The brief is a craft problem dressed up as a strategy problem. Skip
    strategy, run `/creativestack:design-research` instead."
  - "The brief is a brand identity problem. Strategy can't fix what only a
    proper rebrand can."
  - "The brief is a distribution / pricing / product problem. No amount of
    strategy will fix it. Flag this back to the client."

**Worth running strategy now?** {Yes / Yes with caveats / Pause and reconsider}
```

If the verdict is "Pause and reconsider", surface the recommendation and offer:

> *"I'd push back on doing strategy here — see above. Continue anyway, or pause
> and rethink the brief first?"*

Use `AskUserQuestion`. Respect the user's call.

### Step 6: Framework selection

Read `references/frameworks.md`. Then ask:

[SELECT] *"What framework feels right for this challenge?"*
- **Tension-based** — find the contradiction that unlocks the idea
- **Cultural** — root the strategy in a cultural movement or shift
- **Challenger** — position against the category leader
- **Jobs to be Done** — what job is the customer hiring this product for?
- **Category Entry Points** *(Ehrenberg-Bass)* — mental availability across moments
- **Behavioural science** — change a specific behaviour using nudges and biases
- **Purpose-driven** — connect the brand to a bigger belief, with proof
- **Platform-led** — build around a single unifying creative thought
- **Distinctive Brand Assets** *(Romaniuk)* — build memorability across years
- **Open** — let the evidence decide *(I'll pick 1-2 frameworks based on what the
  research surfaces and tell you why)*

Default to Open unless the user has a strong preference. Open is usually the
right answer — let the evidence pick the framework, not the strategist's habit.

If the user picks a specific framework, **read the matching section in
`references/frameworks.md`** for the questions to ask, the failure mode to avoid,
and the Strategy on a Page shape that framework produces.

### Step 7: Brief inputs / clarifying questions

Only ask what isn't already covered by the project state, brain, upstream skills,
or pre-flight check:

1. *"What's the category or cultural space?"* (skip if clear from brief or upstream)
2. *"Any specific territories or angles you want me to explore? Or should I go wide?"*
3. *"Is there a brand reality the strategy has to respect — anything that would
   be too big a stretch for the brand to credibly own?"*

That last question is the highest-value one. Strategies that ignore the brand's
permission to occupy a territory die at the executive review.

### Step 8: Research

**Call `/creativestack:source-scrape` in landscape mode** for category and
cultural context (session cache reuses if already run):

> *"I'll call `/creativestack:source-scrape` with query='{category} {strategic
> angle from framework}', mode='landscape', output='data', target_sources=10,
> max_per_source=2."*

Parse `## THEMES` to seed Cultural Context and the strategic territories. Parse
`## FINDINGS` for category signals.

**In parallel, call source-scrape in evidence mode** for hard data points:

> *"I'll call `/creativestack:source-scrape` with query='{category} {audience
> behaviour} statistics report', mode='evidence', output='data'."*

Parse `## FINDINGS` for attributable stats and quotes — every strategic claim
should cite at least one evidence point. Use the `quality` and `corroborated_by`
fields to flag confidence honestly.

Then complement with **WebSearch** for what source-scrape can't reach:
- Subreddit threads, niche forums, customer review sites *(audience reality)*
- Sales-call language and customer service transcripts *(if user provides them)*
- Industry reports, academic research, government statistics *(evidence)*
- Founder interviews, brand archives, brand books *(brand reality)*

If `## COVERAGE_GAPS` lists significant gaps, surface them in the Confidence
Notes section. **Don't pad with generic content.** Thin research is honest;
padded research is slop.

### Step 9: Generate the output

Read `references/output-formats.md` for the research pack template (with
type-specific sections for the chosen strategy type) and the universal Strategy
on a Page shape. Read the framework-specific Strategy on a Page shape from
`references/frameworks.md`.

Apply tone from `tone-of-voice.md`. Generate:
1. **Research pack** — universal sections + the strategy-type-specific sections
2. **Strategy on a Page** — framework-shaped, single page, every line provable

Universal rules:
- **Headline read at the top.** One paragraph that earns its place even if the
  rest gets ignored.
- **Every claim cites evidence.** No free-floating opinions.
- **2-3 territories, not one.** The strategist needs options to pick from. A
  single territory disguised as the only answer is theatre.
- **Provocations are questions, not answers.** If the provocation tells the
  creative team what to do, it's a brief, not a provocation.
- **Be opinionated about what to *avoid*.** What the brand should NOT try to be
  is often more useful than what it should.
- **Include a "what would prove this wrong" line.** Single best signal that the
  strategy is real, not theatre.

### Step 10: Anti-slop check

Before showing the user, walk the **anti-slop checklist** in
`references/output-formats.md`. Strategy slop is the most common slop in any
agency output — it's almost always written in a "smart" voice that says nothing.

Fix any failures before delivering. The checklist covers:
- Undefended jargon (north star, weaponise, DNA, sweet spot)
- Fake tensions
- "Brand X but for Y" laziness
- Advice the client could have written themselves
- Conclusion-shaped provocations
- Free-floating claims with no evidence
- Missing "what would prove this wrong" line
- Plain-English failures
- Strategy that could be lifted to a competitor

### Step 11: Write back to project state

- **Frontmatter** — update `last_updated`
- **Brief** — update if research clarified anything worth saving
- **Open Decisions** — append the strategic choices the user still needs to make
  (which territory, which framework if Open ran, etc.)
- **Risks** — append any risks the strategy surfaced
- **Recent Activity** — append `YYYY-MM-DD — creative-strategy — {strategy type}, {framework}, {one-line headline read}`
- **Skill Memory → creative-strategy** — write/update:
  - `last_strategy_type`: type used this round
  - `last_framework`: framework used (or chosen by Open)
  - `territories_surfaced`: the 2-3 territories presented
  - `chosen_territory`: leave empty until known
  - `evidence_strength`: High / Med / Low for the round overall
  - `do_not_revisit`: territories or framings the user explicitly rejected
  - `last_strategy_date`: today
- Update `_index.md`

After writing, brief one-line summary: *"Strategy saved to project state. Update
`chosen_territory` in Skill Memory once the team decides — future strategy and
brief work will build on it."*

## Gotchas

The mistakes that produce strategy theatre — work that *looks* serious but moves
nothing. Read these every time. They are the difference between strategy that
helps and strategy that wastes everyone's afternoon.

### Strategy theatre
- **Strategy as performance.** Long, jargon-heavy documents that exist to make
  the strategist (or the agency) look smart. The test: would a creative team
  actually use this to make better work? If not, it's theatre.
- **Pre-decided strategy.** Strategy written to justify a creative decision the
  team has already made. Audiences and clients can smell this and it poisons
  the trust in the work.
- **The "north star" trap.** Calling something a north star doesn't make it one.
  A real north star is specific, contrarian, and makes some work easy and other
  work impossible. If your "north star" is consistent with every possible
  execution, it's wallpaper.
- **Strategy that doesn't help anyone choose.** The job of strategy is to make
  some things easier to say yes to and other things easier to say no to. If a
  strategy makes nothing easier to reject, it isn't doing its job.
- **The "audience-led" excuse.** "We let the audience tell us" is the strategist's
  version of "the algorithm decided". It removes the strategist from the
  responsibility of having a point of view.

### Fake tensions and false insights
- **Fake tensions.** "People want quality but also affordability" is a description
  of every consumer in history. A real tension is *specific*, *surprising*, and
  uncomfortable to name. If the tension could be in any other strategy doc, it
  isn't one.
- **Insight that's actually a fact.** A fact is true. An insight is *useful* —
  it changes what you'd do. "63% of Gen Z care about sustainability" is a fact.
  "Gen Z buyers say sustainability matters but punish brands for talking about
  it explicitly" is an insight.
- **Confusing demographic for psychographic.** "Millennial women" is a demographic.
  "People who feel exhausted by performative wellness" is a psychographic. The
  second is useful for strategy. The first isn't.
- **Insight as horoscope.** "People want to feel seen" is true for everyone in
  history. Strategy needs the version of the insight that's specific enough to
  exclude things, not the version that includes everything.

### Framework abuse
- **Picking a framework for fashion, not fit.** Cultural strategy is fashionable
  right now, so every brief gets cultural strategy whether the brand has any
  cultural permission or not. Frameworks are tools. Pick the one that fits the
  brief.
- **Running every framework.** The Open mode picks 1-2. Strategy slop in a hat
  is when the document includes a tension *and* a cultural shift *and* a
  challenger angle *and* a JTBD *and* a behavioural intervention. Pick.
- **Behavioural science as glitter.** Naming a few biases ("loss aversion! social
  proof!") and calling it a strategy. The work is in the *specific intervention*,
  not the vocabulary.
- **JTBD as a feature list.** "The customer's job is to get their teeth clean."
  No — that's the product description. The job is the *progress* the customer
  is trying to make in their life.
- **Purpose without proof.** A purpose-driven strategy without an explicit list
  of things the brand will *sacrifice* in service of the purpose is
  purposewashing.

### Brand reality
- **Strategy that ignores brand permission.** A brand can only credibly occupy
  territories its history and behaviour earn it. "Quiet authority" doesn't work
  for a brand that's been loud and brash for ten years. Always pressure-test
  against what the brand can actually credibly *do*, not just *say*.
- **Strategy that ignores the business.** Strategy lives inside business
  constraints (margin, distribution, product capability, leadership tolerance).
  Strategy that ignores those constraints is creative writing.
- **Strategy that demands a culture change to work.** Some strategies are right
  on paper but require the client's organisation to behave differently. If the
  organisation can't / won't change, the strategy will die on contact. Surface
  this risk explicitly.

### Process
- **Single territory presented as the only answer.** Strategy should give the
  team 2-3 territories to choose from with honest trade-offs. A single territory
  is a recommendation dressed up as inevitability — and it makes the strategist
  the decision-maker when they shouldn't be.
- **Provocations that are actually conclusions.** A provocation ends in "?" and
  opens a door. "What if the brand led with quietness?" is a provocation. "The
  brand should lead with quietness" is a conclusion. They are not interchangeable.
- **No "what would prove this wrong" test.** Strategists who can't tell you what
  evidence would falsify their strategy are advocates, not strategists.
- **Burying the lead.** The most important sentence is on page 14. Move it to
  the top. The headline read is the most-used part of the document.
- **Skipping the brand's own archive.** Looking at competitors and culture
  without looking at the brand itself is the fastest way to write a strategy
  that's right in general and wrong in particular.

### Voice
- **"Smart voice".** Strategists writing in the voice of the kind of strategist
  they want to be seen as. Plain English is the highest mark of confidence.
- **Jargon as a substitute for thought.** "Permission space", "winning aesthetic",
  "brand DNA" — every one of these can be replaced with a sentence that says what
  it actually means. Replace them.
- **Strategy that nobody on the creative team would actually read.** The
  audience for strategy is the creative team. If they wouldn't read it, it
  failed before it left the deck.

## Skill Chains

### Upstream

If these would have helped but weren't run, suggest 1-2:

- No clear brief → "Run `/creativestack:brief-sharpener` first — strategy on a vague brief is theatre."
- No category context → "Run `/creativestack:competitor-audit` before this — the competitor landscape will be richer."
- No cultural signal → "Run `/creativestack:trend-report` first if you want to weight the strategy toward what's emerging."
- No design / aesthetic context (and the strategy is a creative platform) → "Run `/creativestack:design-research` first — platform strategies need visual permission as much as verbal."
- No customer reality → "If you have customer reviews, sales call notes, or user research, paste it now. Strategy without audience reality is opinion."

### Downstream

After generating, suggest 1-2:

- Strategy lands → "Run `/creativestack:creative-brief` to translate this strategy into a brief the creative team can actually work from."
- Strategy needs sense-checking → "Run `/creativestack:brief-sharpener` to pressure-test the chosen territory against the brief."
- Strategy is for a pitch → "Run `/creativestack:pitch-research` to pull supporting case studies from the studio's archive for the pitch deck."
- Multiple territories surfaced → "Once the team picks a territory, update `chosen_territory` in Skill Memory and re-run `/creativestack:creative-brief` against that territory specifically."

Pick the most relevant 1-2.

## Edge Cases

- **Very vague brief** — push back via the pre-flight check, surface gaps loudly, offer `/creativestack:brief-sharpener`. Don't paper over a vague brief with fancy strategy language.
- **Highly regulated industry (pharma, finance, alcohol, gambling)** — flag compliance constraints alongside strategic opportunities. Strategy that can't legally be executed is worse than no strategy.
- **Brief contradicts itself** — surface the contradiction, research both directions, and let the user resolve. Don't quietly pick one side.
- **Niche category with thin public data** — be honest about thin evidence. Don't fabricate confidence. Say what you'd need to test before committing.
- **Standalone exploration with no client and no project** — works fine, generate a research pack but flag that the brand reality check section will be hypothetical.
- **Returning client, third strategy round on the same brief** — read project state Skill Memory. Don't re-surface anything in `do_not_revisit`. If you can't find anything new, say so honestly: *"We've explored the obvious territories. Worth widening the brief, pivoting strategy type, or accepting the territory we've already landed on."*
- **Open framework picks two frameworks that disagree** — surface both honestly. Two frameworks pointing different directions is more useful than one framework forced into a fake consensus.
- **User pushes for a single territory recommendation** — offer one *as a recommendation* but always include the alternatives so the team can pressure-test. Strategy is about choices, not prescriptions.
- **Highly political / values-laden category** — present multiple perspectives, don't take a political position. Flag the political risk explicitly so the client makes an eyes-open decision.
- **The strategy reveals the brand should change its product / pricing / distribution** — surface this. Strategy that's blocked by the business is still useful information; the client needs to know.

### What this skill can't do

This skill researches and provokes. It does not write the creative answer — and
shouldn't. The creative move is the human's job; strategy exists to make that
job easier and the wrong answers harder.

It also can't replace customer research. It can synthesise public signal
brilliantly, but if you have first-party data — sales calls, customer interviews,
NPS verbatim, support tickets, ethnography — paste it in. The strategy becomes
much sharper with private inputs the public web doesn't see.

A dedicated AI partner, with project state built up over years, could spot
strategy patterns across the studio's whole portfolio — which territories convert
to wins, which frameworks the studio is best at, where strategy has been right
but execution failed. That's where the project state and Skill Memory layer is
heading. Every strategy round adds to it.

---
*CreativeStack by Cameron Jones — jones.cam*
