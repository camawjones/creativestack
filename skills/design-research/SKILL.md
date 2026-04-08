---
name: design-research
description: Research accelerator for designers — covers six distinct research modes (brand deep-dive, visual landscape, cultural territories, craft deep-dive, UI pattern research, audience visual diet) so the skill matches what designers actually mean by "research". Reads project state to build on prior research rounds, runs a pre-flight specificity check before generating, leans on serious designer sources (Are.na, Brand New, Fonts in Use, Mobbin, museum archives) instead of Pinterest soup, calls /source-scrape for visual evidence, surfaces counter-references (what to avoid) alongside inspiration, persists research themes per project, and offers an optional FigJam board styled with the agency's house visual style.
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

# /design-research

> Feed in a brief, get back research your designers would take a week to find. With a point of view, not a Pinterest dump.

## Brain Files
- `profile.md` (for context and the studio's design specialisms)
- `tone-of-voice.md` (for how the research narrative is written)
- `visual-style.md` (applied to any FigJam board layout — see Visual Output below)
- `case-studies.md` (for prior research the studio's already done — avoid duplicating)
- `learnings.md` (for what's worked or backfired in past research rounds)

## Reference Files

This skill loads detail on demand from `references/` — keeps SKILL.md lean and the
context window honest. Read each only when relevant:

- **`references/research-modes.md`** — read after the user picks a mode, for the
  research approach, curated sources by mode, and the right rhythm for that mode.
  This is the most important reference file in the skill.
- **`references/output-formats.md`** — read at generation time for the per-mode
  output template + the FigJam layout guide

## What This Skill Does

Designers mean six very different things when they say "design research". This skill
asks which one *first*, then routes to a tailored approach with the right sources,
the right output, and the right depth.

**The six modes:**

1. **Brand deep-dive** — research a specific brand inside-out (often a client). Their
   own archive, history, system, content posture, strengths, gaps, and what you'd
   push if you worked on them.
2. **Visual landscape** — see the visual conventions of a category before designing
   for it. Field map, conventions, outliers, white space.
3. **Cultural & creative territories** *(default)* — the original strength of this
   skill. Themed research boards built around distinct creative territories, dual
   audience output (creative team / client), counter-references included.
4. **Craft deep-dive** — go deep on a single craft (typography, illustration, motion,
   etc.). Canon, lineage, contemporary edge, failure modes.
5. **Pattern research** — UI/UX patterns for digital product work. Conventions,
   deviations worth stealing, affordances, accessibility.
6. **Audience visual diet** — what the *audience* actually looks at, not what
   designers think they should. In-group signals, no-go signals, what they make
   vs what they consume.

The skill reads project state to build on prior research rounds, calls
`/source-scrape` for visual evidence, leans on serious designer
sources (Are.na, Brand New, Fonts in Use, Mobbin, museum collections) instead of
the same five pages everyone uses, and surfaces counter-references — what to *avoid*
— alongside inspiration. Optional FigJam board styled with the agency's house
visual style.

## Conversation Flow

### Step 1: Project state discovery

Follow the project state discovery + picker protocol. Three cases:

- **Returning client / project, existing state file** — Read the full state file.
  Pull Brief, Stakeholders, and the `design-research` namespace from Skill Memory if
  it exists. If prior research themes are saved, mention them: *"Last round you
  explored 'Quiet Authority' and 'Controlled Chaos' as territories. Building on
  those, going wider, or starting fresh?"*
- **Returning client, no state file** — Offer the bootstrap path.
- **New project / standalone exploration** — Ask if the user wants to spin up a
  state file (research is more useful when persisted) or run standalone. Respect
  the call.

### Step 2: Brain check

Read the brain files listed above. Pay attention to:
- `case-studies.md` — has the studio researched this category, audience, or craft
  before? If so, don't duplicate. Reference the prior round and go deeper or
  sideways instead.
- `learnings.md` — any past research patterns worth knowing? "Our last fintech
  research round leaned too hard on Stripe and missed the European banking
  aesthetic" — that kind of learning shapes this round.

### Step 3: Upstream skill synthesis

Scan the current conversation for output from other CreativeStack skills:

| Skill run earlier | What to pull in | Where it appears |
|---|---|---|
| `/source-scrape` | Annotated visual captures, scored sources | Visual evidence, board references |
| `/trend-report` | Visual trends, velocity scores, brand examples | Cultural territories, design movements |
| `/competitor-audit` | Visual identity scores, category conventions | Visual landscape mode, adjacent examples |
| `/creative-brief` | Objectives, audience, success criteria | Brief context — sharpens the research focus |
| `/brief-sharpener` | Sharpened brief, deal-breaker questions | Brief context — surfaces what's still vague |

When upstream data is available, tell the user what you're pulling in:
*"I can see you ran `/source-scrape` and `/trend-report`
earlier — building on those captures and trend signals."*

### Step 4: Mode picker

Read `references/research-modes.md` for the full list and approach per mode. Then
ask the user in plain English (not jargon):

[SELECT] *"What kind of research do you need?"*
- **Brand deep-dive** — a specific brand inside-out (often a client)
- **Visual landscape** — the visual conventions of a category before designing for it
- **Cultural & creative territories** *(default)* — open exploration, themed boards
- **Craft deep-dive** — go deep on a single craft (type, illustration, motion, etc.)
- **Pattern research** — UI/UX patterns for digital product work
- **Audience visual diet** — what the audience actually looks at

Combinations are fine — `Brand deep-dive + Visual landscape` is the standard pairing
for a rebrand pitch. If the user picks more than one mode, run them sequentially and
share sources where relevant.

### Step 5: Pre-flight specificity check

Before generating, run an honest assessment of how specific the brief is and how
likely it is to produce useful research. Surface this as a short report:

```
## Pre-flight check

**Specificity:** {Strong / Mixed / Weak} — {one-sentence reason}

**What's clear:**
- {clear thing — e.g., "Audience is well defined: UK independent skincare buyers,
  30-45, premium-curious"}
- {clear thing}

**What's vague *(and would make research more useful if tightened)*:**
- {vague thing — e.g., "'Modern' is doing a lot of work here. Five different
  designers will define modern five different ways."}
- {vague thing — e.g., "No reference brands the client likes or hates. We'll
  research blind."}

**Risks of generic output:**
- {risk — e.g., "Without a category constraint, this could surface the same 50
  references every brand brief gets. Want to narrow before I dig in?"}

**Worth researching now?** {Yes / Yes with caveats / Tighten the brief first}
```

If the answer is "Tighten the brief first", offer:
> *"I'd push back and tighten the brief before researching — see above. Continue
> anyway, or run `/brief-sharpener` first?"*

Use `AskUserQuestion`. Respect the user's call.

### Step 6: Depth + focus

[SELECT] *"How deep should we go?"*
- **Quick scan** — 30-min equivalent. Top-level, 2-3 boards or sections, key sources only. Good for early exploration.
- **Standard** — 2-hour equivalent. Default. Full output, 3-4 boards or sections, balanced sources.
- **Deep dive** — half-day equivalent. Thorough, 4+ boards or sections, historical context, unexpected connections, multiple source-scrape passes. Good for major projects or pitch research.
- **Visual-heavy** — screenshot-first. Prioritises captured visual evidence over written analysis. Requires browse daemon.

[Optional, free text] *"Any specific worlds to lean into or steer away from? (e.g.,
'lean into Japanese editorial design and 70s Italian, avoid US tech minimalism')"*

This single optional question is the highest-leverage input the user can give. The
more constrained the territory, the less generic the research. If the user has no
opinion, that's fine — the mode + brief will carry the weight.

### Step 7: Research and synthesise

**Call `/source-scrape` in visual mode** (any mode except Pattern
research, where Mobbin etc. are richer than scrape coverage):

> *"I'll call `/source-scrape` with query='{key terms from the brief
> + mode-specific framing}', mode='visual', output='data', target_sources=8,
> max_per_source=4."*

Parse `## VISUAL_CAPTURES` and use the `visual_pattern` field to seed groupings —
captures sharing a `visual_pattern` likely belong on the same board or section.
Use `subject`, `visual_qualities`, and `mood` fields directly as reference
descriptions.

For **Deep dive** depth, also call source-scrape in landscape mode to widen
context:

> *"I'll call `/source-scrape` with query='{topic} cultural context
> design movement', mode='landscape', output='data'."*

Then complement with **WebSearch** for references that fall outside design press —
fashion, music, film, architecture, subcultures, museum collections, archives. The
best references rarely come from design press alone.

**Source priority by mode** *(read `references/research-modes.md` for the full
curated source list per mode)*:
- Mode A (Brand) — the brand's own assets first, then Brand New, Are.na, Fonts in
  Use, Wayback Machine
- Mode B (Visual landscape) — the brands' sites + Brand New + Land-book + Httpster
  + godly.website + Are.na
- Mode C (Cultural) — Are.na (non-negotiable), It's Nice That, Brand New, Wallpaper*,
  Apartamento, museum collections, plus adjacent worlds (fashion, music, film)
- Mode D (Craft) — craft-specific archives (Fonts in Use for type, Motionographer
  for motion, etc.), studio archives, the named canon
- Mode E (Pattern) — Mobbin (non-negotiable), Page Flows, Land-book, godly.website,
  HIG / Material / Polaris / Atlassian
- Mode F (Audience) — the audience's own platforms + niche communities, not
  designer-curated sources

If `## COVERAGE_GAPS` lists significant gaps in visual evidence, lean more on
written analysis sections — don't pad output with weak references.

### Step 8: Generate the output

Read `references/output-formats.md` for the template matching the chosen mode(s).
Apply tone from `tone-of-voice.md`.

Universal rules across modes:
- **Every reference earns its place.** State the *specific quality* that connects
  it to the brief. Aesthetic similarity isn't enough.
- **Include counter-references.** What's been overdone? What would land flat? What
  has this aesthetic become a cliché of? *(Mode C has a dedicated section; for
  other modes, weave it into the implications.)*
- **Lead with the research summary.** Designers scan first, read second. The
  opening paragraph should give them the headline before they decide whether to
  read the rest.
- **Be opinionated.** Generic research is worse than no research because it makes
  the designer feel like they've already explored.
- **Cite sources inline.** Not at the end as a dead list — next to each reference
  so the designer can dig deeper without hunting.

### Step 9: Visual output (FigJam — optional)

Check whether Figma tools are available (look for tools prefixed with
`mcp__claude_ai_Figma__` or `mcp__plugin_figma_figma__`).

**If Figma MCP IS available** → offer: *"Want me to lay this out as a research
board in FigJam?"*

If yes, **before building anything**, read `~/.creativestack/visual-style.md` —
the agency's house visual style. Apply its typography, colour palette, spacing
rules, and anti-slop checklist to every frame. If `visual-style.md` doesn't
exist, fall back to the Editorial Modern defaults and tell the user at the end:
*"Run `/setup-cs` to configure your house visual style for sharper
research board layouts."*

Use the per-mode FigJam layout in `references/output-formats.md`. After
generating, walk through the anti-slop checklist in `visual-style.md`. Fix
anything that fails before showing the user.

**If Figma MCP is NOT available** → the markdown output is the complete
deliverable. Add: *"Want a visual research board? Install the Figma MCP server
to generate FigJam boards directly from research output."*

### Step 10: Write back to project state

- **Frontmatter** — update `last_updated`
- **Brief** — update if research surfaced clarifications worth saving
- **Recent Activity** — append `YYYY-MM-DD — design-research — {mode}, {depth}, {short headline of what surfaced}`
- **Skill Memory → design-research** — write/update:
  - `last_mode`: mode used this round
  - `last_depth`: depth used
  - `themes_explored`: list of themes / territories surfaced (so future rounds can
    build or pivot)
  - `sources_used`: distinctive sources worth returning to next round
  - `do_not_repeat`: references the user has explicitly rejected (so future rounds
    don't surface them again — high-value memory)
  - `last_research_date`: today
- Update `_index.md`

After writing, brief one-line summary: *"Research saved to project state. Future
rounds will build on `themes_explored` and skip anything in `do_not_repeat`."*

## Gotchas

The mistakes that produce generic, recycled, or actively misleading research. Read
these every time — most are silent until the work that came out of the research
hits the wall.

### Source quality
- **Pinterest soup.** Pinterest is image search with a recommendation layer. It
  surfaces what already gets clicked, not what's interesting. Real designer
  research lives on Are.na, Brand New, Fonts in Use, Mobbin, museum archives, cosmos.so —
  not Pinterest.
- **Same five pages everyone uses.** It's Nice That, Dezeen, Awwwards, Behance,
  Fast Co Design. These are fine but they're the *first* layer — every designer
  in the world is already seeing them. Real differentiation comes from going one
  layer deeper (Are.na boards, Vimeo deep cuts, museum collections, archive
  publications, designer personal sites, cosmos.so).
- **Skipping the brand's own archive.** When researching a brand, the most
  valuable source is almost always *their own current and historical work*. Most
  designers go straight to the press coverage and skip the actual artefacts.
  Look at the brand first, the discourse second.
- **Western-only references.** Defaulting to UK / US / Northern European
  references is the single most common research mistake. Japanese editorial,
  Korean type design, Latin American identity work, African vernacular design,
  Indian poster traditions — all routinely missing from "design research" output.
  Force yourself to include at least one non-Western reference per board.
- **Recency bias.** The freshest reference is rarely the best one. A 2003 Hjalti
  Karlsson identity is often more useful than another 2025 wordmark. The canon
  matters because clients and creatives both have short memories.

### Reference quality
- **Aesthetic similarity ≠ relevance.** "It looks similar" is the weakest possible
  reason for a reference. The reason should be a *specific quality*: "they used
  the negative space to imply movement", "the typography makes the brand feel
  older than it is", "the photography is documentary in style which builds trust
  for a category that usually faces accusations of greenwashing".
- **Wishful references.** Putting a Berlin nightclub on the moodboard for a
  high-street bank because "it would be cool". The client will not buy it. Either
  build a bridge (Mode C — "For the Client" section) or cut it.
- **The unicorn-status reference.** Apple, Aesop, Stripe, Hermès, Mubi, Glossier,
  Linear. These are the references everyone reaches for and they've become
  meaningless from overuse. Use them only with a *very* specific, non-obvious
  reason — and ideally as a counter-example.
- **References without sources.** "I once saw a thing that did this" is not
  research. Every reference needs a verifiable source the designer can dig into.
  No source, cut the reference.

### Process
- **Confusing mood-boarding with research.** Mood boards capture a feeling.
  Research gives a designer a head start on the *thinking*. The two have very
  different outputs and the user usually wants the second one even when they say
  the first.
- **Researching aesthetics before understanding the problem.** If you don't know
  what the brief is actually trying to solve, the research will be decorative.
  Run `/brief-sharpener` first when the brief is vague.
- **No counter-references.** The work that doesn't get made is shaped by what you
  decided to *avoid*. Researchers who only surface "good" examples leave the
  designer to discover the failure modes alone, on the job. Counter-references
  are the most under-included element in research output.
- **Single-pass research that never gets revisited.** A research round that lives
  only in one Slack message and is never opened again is wasted work. Persist to
  project state so the next round builds on it instead of starting over. (This
  skill does that automatically — but only if you let it create / update the
  project state file.)
- **"Inspiration" that's actually plagiarism territory.** A reference that's so
  close to a finished piece of work that the designer would basically be copying
  it isn't a reference, it's a trap. Flag it explicitly: *"This is too close to
  copy — useful as a reference for the lineage, dangerous as a starting point."*

### Bias
- **Researcher's taste leaking into the research.** The skill should serve the
  brief, not the researcher's personal aesthetic. If you find yourself
  surfacing the same 5 references you always like, that's a tell. Push against
  it.
- **Cherry-picking to prove a thesis.** Research that already knows what it
  wants to find isn't research, it's confirmation. If a board only contains
  references that point one direction, ask whether the *other* direction has been
  honestly explored.
- **Missing the audience.** Designer research often skips Mode F entirely —
  what the audience actually looks at. The result is work that feels good in the
  studio and lands flat with the people it's meant to reach.

## Skill Chains

### Upstream

- No clear brief → "Run `/brief-sharpener` first — the research will be 5x sharper with a tightened brief."
- No category context → "Run `/competitor-audit` before this — the visual landscape mode will build on it."
- No trend signal → "Run `/trend-report` first if you want to weight the research toward what's emerging."
- No visual evidence yet → "This skill calls `/source-scrape` automatically, but you can run it standalone first if you want to inspect the captures."

### Downstream

- Strategic direction emerging → "Run `/creative-strategy` to formalise the strategic territory these references point toward."
- Brief still feels off → "Run `/brief-sharpener` to pressure-test the brief against this research context."
- Ready to brief the team → "Run `/creative-brief` to translate the research into a brief the creative team can actually work from."
- Pitching this work → "Run `/pitch-research` to pull in case studies that match the territories this research surfaced."

Pick the most relevant 1-2.

## Edge Cases

- **Very vague brief** — push back via the pre-flight check, surface the gaps, offer to run `/brief-sharpener` first. Don't paper over a vague brief with broad research.
- **Highly regulated industry (pharma, finance, alcohol, gambling)** — flag compliance considerations alongside inspiration. A great identity that can't legally ship is wasted research.
- **Brief contradicts itself** — call out the tension and research both directions. Then flag it in the summary so the next conversation resolves it instead of carrying it forward.
- **Niche audience** — go deeper on cultural specificity (Mode F) rather than broader. The narrower the audience, the riskier generic research becomes.
- **Quick scan requested but upstream data is rich** — use upstream data to punch above the depth level. Tell the user what you're doing.
- **Visual-heavy requested but no browse daemon** — fall back to Standard depth with text descriptions, note the limitation.
- **Returning client, third research round on the same brief** — read project state Skill Memory, *don't* re-surface anything in `themes_explored` or `do_not_repeat`. Push the user laterally instead. If you can't find anything new, say so honestly: "We've exhausted the obvious territories. Worth widening the brief or pivoting the research target."
- **Highly specific craft research (Mode D) for a niche craft** — if the craft is very narrow (e.g., "risograph type for South American zines"), the canon might be small. That's fine — surface it with confidence rather than padding.
- **Mode F when audience is broad ("everyone")** — push back: "Audience is too broad to research a visual diet. Want to narrow first, or skip Mode F?"

### What this skill can't do

This skill researches one brief at a time. A dedicated AI partner could build a
living research library across all of the studio's projects — spotting trends
before they peak, tracking which references the team keeps returning to, building
institutional creative knowledge over time, and noticing when a "new" brief is
actually research-adjacent to one you've done before. That's where the project
state and Skill Memory layer is heading — every research round adds to it. The
more rounds you run, the smarter it gets.

It also can't replace looking at things with your eyes for an hour. The best
designers research with the skill *and* with their own attention. One isn't a
substitute for the other.

---
*CreativeStack by Cameron Jones — jones.cam*
