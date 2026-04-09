---
name: social-calendar
description: Generate a structured social content calendar — outline-first by default, full draft copy for priority posts, exported as a Sheets-ready CSV with optional Notion database publishing. Includes ideation help (cultural moments, brand pillars, recent project activity), persistent per-client memory (pillars, platforms, last calendar), and content pillar frameworks. For social leads, content marketers, and creative agency PMs running client social.
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

# /social-calendar

> Outline a month of content in five minutes. Draft only the posts that matter.

## Brain Files
- `profile.md` (for context)
- `tone-of-voice.md` (for brand voice consistency — agency voice, used as a fallback)
- `clients.md` (for client context if this is for a client)
- `visual-style.md` (apply this house style to any tile mockups or calendar visuals rendered in Figma)
- `projects/{slug}-brief.md` (the brand's tone & personality + single-minded thought — primary voice source for brand-specific calendars; from `/creative-brief`)
- `projects/{slug}-copy-deck-v*.md` (versioned copy decks — pull approved headlines, hooks, and body language to adapt for social rather than reinventing from scratch; from `/copy-deck`)
- `learnings.md § Feedback` (per-client vocabulary — ensures social copy uses the terms the client has established as theirs; from `/feedback-consolidator`)

## What This Skill Does

Generates a structured social content calendar for a brand or client. Two-phase flow:

1. **Ideation** — surfaces cultural moments, awareness days, brand pillar prompts, and
   recent project activity to give the user something to react to before generating
2. **Generation** — produces a calendar outline (date, platform, pillar, format, hook)
   for the full period, with full draft copy only for priority posts (launches, key
   dates, hero content). Other posts are marked "expand on demand" — the user can ask
   for full copy on specific posts when they're ready.

Default export: a CSV the user can paste into Google Sheets, Airtable, or any
spreadsheet-based content tracker. If Notion MCP is available, also offers to write
to a Notion database.

Persists per-client memory in project state (pillars, platforms, posting frequency,
Notion database ID) so the next month's calendar takes 30 seconds to set up.

This skill produces planning structure and draft copy. It does not generate visual
assets, schedule posts, or connect to social platforms directly.

## Conversation Flow

### Step 1: Project + memory check

Follow the project state discovery + picker protocol. If the project is for a client,
it should have a state file already. If not, offer the bootstrap path.

After picking the project, read the `social-calendar` namespace under Skill Memory in
the project state file. If it exists, you'll find:
- `pillars`: previously confirmed content pillars
- `platforms`: previously selected platforms
- `frequency`: posts per platform per week
- `notion_db_id`: Notion database ID if the user previously published there
- `last_generated`: date of the last calendar
- `last_period`: length of the last calendar (1 week / 2 weeks / 1 month)

If memory exists, tell the user one line and confirm:
"Working on {client}. Last time we used pillars [Education, Behind-the-scenes,
Industry takes] across Instagram and LinkedIn, 3 posts/week each. Continue with the
same setup, or change anything?"

Use `AskUserQuestion`: `Same setup` / `Change pillars` / `Change platforms` / `Change frequency`.

If no memory exists, this is a fresh setup — proceed to Step 2.

### Step 2: Setup (only if no memory or user wants changes)

Batch into a single `AskUserQuestion` call where possible:

1. [SELECT] "What time period should this cover?" — `1 week` / `2 weeks` / `1 month`
2. [SELECT multiSelect] "Which platforms?" — `Instagram` / `LinkedIn` / `X` / `TikTok` / `Facebook` / `YouTube`
3. [SELECT] "Content pillar framework?" — `3-pillar (focused)` / `4-pillar (balanced)` / `Custom`
   - If `Custom`, free text: "What are your content pillars?"
4. Ask: "How often should we post per platform?"

Save these to Skill Memory once confirmed.

### Step 3: Ideation phase

Before generating anything, surface ideation material the user can react to. This is
the value-add — most calendars are blocked at "what should we post about" not "how do
I write this post".

**Pull from project state:**
- **Recent Activity** — anything notable from the project worth posting about
  (e.g., "Status moved On Track this week — could anchor a 'progress unblock' post")
- **Resolved Decisions** — wins worth narrating
- **Stakeholders** — for behind-the-scenes / team posts

**Pull from persistent project files (for brand-aligned social):**
- `projects/{slug}-brief.md` — read § Brand Tone & Personality and § Single-Minded Thought. The SMT is the spine every social post should ladder up to. The brand tone is the voice the posts should be written in (NOT the agency's tone).
- `projects/{slug}-copy-deck-v*.md` (latest version) — pull approved headlines, hooks, and body samples. Adapting approved copy for social is faster and more brand-coherent than writing from scratch. Cite the source deck version.
- `learnings.md § Feedback` (this client) — apply per-client vocabulary. If Marcus uses "bold" to mean "brand-confident", the calendar's posts should use that meaning consistently.

**Pull from upstream skills if run this session:**
- `/trend-report` — emerging themes to ride
- `/design-research` — cultural references to weave in
- `/copy-deck` — approved messaging to adapt (also lives in the persistent files above)
- `/creative-strategy` — strategic territories

**Generate fresh ideation prompts:**
- Cultural moments and awareness days that fall in the period (be selective — don't
  recommend National Donut Day for a B2B SaaS brand)
- Industry events or product launches the user mentioned
- Evergreen brand-pillar prompts for each pillar (e.g., for "Behind-the-scenes":
  founder origin, tools we use, a typical day, why we charge what we do)
- Customer questions or objections worth addressing publicly

Present 8-12 ideation options as a scannable list. Tell the user: "These are starting
points — pick the ones that resonate, dismiss the rest, and add anything I missed
before I generate the calendar."

Use `AskUserQuestion` with `multiSelect: true` to let them pick which ideation seeds
to use. Always include a free-text "Other" option.

### Step 4: Generation mode

[SELECT] "How should I generate the calendar?"
- **Outline + key drafts** (recommended) — full structure for every post, full draft
  copy only for priority posts (launch days, hero content, ~20% of total)
- **Full draft copy** — write every post in full (slower, more to review, more slop risk)
- **Structure only** — date/platform/pillar/format/hook, no draft copy at all

Default: `Outline + key drafts`. Most users should pick this.

### Step 5: Generate

Build the calendar using the ideation seeds, brand pillars, and the user's frequency.

Apply tone from `tone-of-voice.md` if available — otherwise ask for 3-5 voice
adjectives quickly.

For each post, decide whether it's a "priority" post that gets full draft copy:
- Launch days, product reveals, hero content
- Posts tied to a specific cultural moment or hard date
- Posts the user explicitly flagged as priority during ideation
- Roughly the top 20% of the calendar

Non-priority posts get: date, platform, pillar, format, hook angle, optimal time,
notes — but the Draft Copy column says `[expand on demand]`.

Generate two artifacts in one output:
1. **Markdown calendar** for in-conversation review (table per week)
2. **CSV block** ready to paste into Sheets — see CSV Schema below

### Step 6: Export options

After generating, present export options:

1. **CSV is already in this output** — user can copy/paste into Google Sheets,
   Airtable, Numbers, Excel, or any tracker
2. **Notion publishing (if available)** — Check whether Notion MCP tools are available
   (look for tools prefixed with `mcp__claude_ai_Notion__`).
   - If available: ask "Want me to publish this to Notion as a database?"
   - If yes and `notion_db_id` exists in Skill Memory: use `notion-update-data-source`
     to add the new posts to the existing database
   - If yes and no `notion_db_id`: use `notion-create-database` with columns matching
     the CSV schema, then save the new database ID to Skill Memory
   - If Notion MCP is NOT available: skip silently, the CSV is the output

### Step 7: Write back to project state

- **Frontmatter** — update `last_updated`
- **Recent Activity** — append `YYYY-MM-DD — social-calendar — {N posts} across {platforms} for {period}`
- **Skill Memory → social-calendar** — update/write: `pillars`, `platforms`, `frequency`,
  `notion_db_id` (if Notion was used), `last_generated`, `last_period`
- Update `_index.md`

## CSV Schema

The CSV columns, in order:

```
Date,Day,Platform,Pillar,Format,Optimal Time,Status,Hook,Draft Copy,Notes
```

- **Date** — `YYYY-MM-DD`
- **Day** — `Mon`/`Tue`/etc. (helps users scan)
- **Platform** — Instagram / LinkedIn / X / TikTok / Facebook / YouTube
- **Pillar** — which content pillar this post serves
- **Format** — Carousel / Reel / Text post / Thread / Video / Story / etc.
- **Optimal Time** — starting-point recommendation (see Platform Notes below)
- **Status** — defaults to `Draft` for priority posts, `Outline` for the rest
- **Hook** — one-line description of the post angle
- **Draft Copy** — full caption for priority posts; `[expand on demand]` otherwise
- **Notes** — hashtags, CTA, cross-posting flags, asset requirements

Wrap the CSV in a code fence in the output so the user can copy it cleanly. Quote any
field containing a comma or newline.

## Platform Notes

These are **starting points**, not gospel. Posting time best practices shift constantly
as algorithms change. Always validate against the client's actual analytics if available.

Frame these in the output as "starting recommendations — adjust once you have at least
4 weeks of analytics for this account":

- **Instagram** — Tue-Thu morning (10am-1pm) and Sat morning (9-11am) are common
  baseline windows. Carousels and Reels generally outperform single images for reach.
  Saves and shares matter more than likes for the algorithm.
- **LinkedIn** — Tue-Thu 8-10am and lunchtime 12-1pm are common B2B windows. Text
  posts with line breaks often outperform link posts. First 60 minutes of engagement
  is critical — comment back fast.
- **X** — Mon-Fri 9-11am and 12-1pm. Posts with images get notably more reach than
  text-only. Threads work for depth.
- **TikTok** — Tue-Thu 10am-12pm and 7-9pm are common. First 2 seconds determine
  whether viewers stay. Watch time and completion rate dominate the algorithm.
- **Facebook** — Wed-Fri 1-4pm. Video autoplay still drives the most reach. Group
  reach beats page reach for organic.
- **YouTube** — Fri-Sat for entertainment, Thu-Fri for business. Custom thumbnail is
  non-negotiable. Shorts and long-form follow different rules.

If the user has analytics for this client, ask them to paste it and override these
defaults with the client's actual best windows.

## Output Format

```markdown
# Content Calendar: {Brand/Client Name}
**Period:** {start date} — {end date}
**Platforms:** {list}
**Pillar framework:** {3-pillar / 4-pillar / Custom}
**Generation mode:** {Outline + key drafts / Full draft copy / Structure only}

## Content Pillars
1. **{Pillar}** — {description}
2. **{Pillar}** — {description}
3. **{Pillar}** — {description}

## Calendar — Week 1: {date range}

| Date | Day | Platform | Pillar | Format | Hook | Status |
|------|-----|----------|--------|--------|------|--------|
| {date} | {day} | {platform} | {pillar} | {format} | {one-line hook} | {Draft / Outline} |

{Repeat per week.}

## Priority Posts (full draft copy)

### {Date} — {Platform} — {Pillar}
**Hook:** {hook}
**Format:** {format}
**Optimal time:** {time} _(starting point — adjust to client analytics)_

{Full draft copy here. Match brand voice from tone-of-voice.md.}

**Notes:** {hashtags, CTA, asset requirements}

{Repeat for each priority post — ~20% of total.}

## Key Dates & Hooks
| Date | Event/Hook | Relevance | Platform | Planned Content |
|------|-----------|-----------|----------|-----------------|

## Content Mix Summary
| Content Type | Count | % of Total | Target % |
|-------------|-------|------------|----------|

## CSV Export

Copy the block below into Google Sheets, Airtable, or any spreadsheet:

```csv
Date,Day,Platform,Pillar,Format,Optimal Time,Status,Hook,Draft Copy,Notes
{rows}
```

## Slack Format — Week at a Glance

*{Brand} — Content Week of {date}*

**Posts this week:** {count} across {platforms}

*Mon:* {platform} — {pillar} — {1-line summary}
*Tue:* {platform} — {pillar} — {1-line summary}
...

*Key moment:* {biggest hook this week}
```

## Skill Chains

### Upstream (what feeds social-calendar)

If these weren't run but would have helped, suggest 1-2 next time:
- No tone-of-voice → "Run `/update-voice` to capture brand voice properly — calendars sound more on-brand with it."
- No trend context → "Run `/trend-report` before next month's calendar to surface cultural moments worth riding."
- No recent performance data → "Once a social analysis skill exists, chain it in before generating to weight what's actually worked."

### Downstream (what social-calendar triggers)

After generating, suggest 1-2:
- If priority posts need visual production → "Run `/asset-spec` to generate production specs for the visual assets."
- If draft copy needs to be expanded into a full messaging document → "Run `/copy-deck`."

Pick the most relevant — don't list them all.

## Edge Cases
- No tone-of-voice file → ask for 3-5 brand voice adjectives quickly
- Very short period (1 week) → still go through ideation, just fewer seeds. Consider all posts "priority" since the user needs to act on them this week.
- Many platforms (5+) → group similar platforms (Instagram + Facebook can share copy; X + LinkedIn rarely should). Note differences.
- Regulated industry → flag posts that may need compliance review in the Notes column
- No key dates provided → ideation phase will surface relevant awareness days and cultural moments
- Custom pillars that overlap → flag and suggest consolidation before generating
- Notion MCP unavailable → CSV is the export, don't apologise. CSV is the primary output by design.
- User wants to regenerate from scratch ignoring memory → respect it, but offer to keep pillars if they're working

### What this skill can't do

This skill generates planning structure and draft copy. It doesn't analyse past social
performance — that's a separate concern, ideally a dedicated `/social-analysis`
skill (not yet built) that would chain in upstream of this one to weight pillars,
formats, and posting times based on what's actually performed for this client. Until
that exists, override the platform defaults with whatever the client's analytics tell
you.

It also doesn't generate visual assets or push posts to social platforms. CSV out,
Notion out (if available), and the actual scheduling happens in your scheduler of choice.

---
*CreativeStack by Cameron Jones — jones.cam*
