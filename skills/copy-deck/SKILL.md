---
name: copy-deck
description: Brain-first copy deck generation for creative agencies. Three modes — Deck (messy inputs → structured copy deck with atom-level scoring, versioned save), Check (audit existing copy against voice/sharpness/claims/SMT ladder without rewriting), Microcopy (dedicated mode for UX microcopy — buttons, errors, empty states, loading, success, confirmation, form helpers). Scores every copy atom on 4 dimensions — voice match, sharpness, claim/proof discipline, SMT ladder — sourced from the project brief, not generic tone guidance. Enforces platform character limits as hard checks. Applies per-client vocabulary from learnings.md § Feedback. Persists versioned decks to projects/{slug}-copy-deck-v{N}.md so revisions compound across sessions.
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

# /copy-deck

> Copy with teeth, not just copy with structure. Brand voice from the brief, not the house style.

## What This Skill Does

Most copy tools treat copy as a structure problem: paste messy notes,
get back tidy sections. The actual copy usually comes out on-voice but
flat — pleasant writing that nobody remembers.

This skill treats copy as a **craft problem** with four pressure points:

1. **Voice match** sourced from the brief's Brand Tone & Personality, not
   the agency's default tone-of-voice. Copy is for the brand, not the
   agency.
2. **Sharpness** — every atom checked for teeth. Flat-but-on-voice copy
   is flagged as aggressively as off-voice copy.
3. **Claim/proof discipline** — claims paired with reasons-to-believe
   from the brief. Unbacked claims flagged.
4. **SMT ladder** — every atom connected back to the brief's
   single-minded thought. Atoms that don't ladder are flagged.

Plus:

- **Atom-level scoring** — each headline, subhead, body, CTA, and
  microcopy type scored individually. A section can be "mostly good"
  while specific atoms fail.
- **Per-client vocabulary** — applied automatically from
  `learnings.md § Feedback`. When Marcus says "bold" means
  "brand-confident," that translation is baked into the copy generation.
- **Hard character-limit enforcement** — platform constraints are
  checked, not stated. Copy that exceeds limits is rewritten before
  the deck closes.
- **Version tracking across sessions** — every deck is saved to
  `projects/{slug}-copy-deck-v{N}.md`. Minor revisions and major
  rewrites both get version bumps. Previous versions are never
  overwritten.
- **Churn detection** — if a deck hits v1.4+ without sign-off, the skill
  surfaces it. Copy churn usually signals brief problems, not copy
  problems.
- **Microcopy as a first-class mode** — a dedicated flow for buttons,
  errors, empty states, loading, success, and form helpers, with a
  pattern library and a coverage checklist.

## Brain Files
- `projects/{slug}-brief.md` — **primary voice source**: Brand Tone & Personality, Single-Minded Thought, Desired Response, Reasons to Believe, Audience (from `/creative-brief`)
- `projects/{slug}.md` — project state, open decisions
- `projects/{slug}-copy-deck-v*.md` — previous versions of this project's decks (this skill creates and maintains them)
- `learnings.md § Feedback` — client vocabulary (from `/feedback-consolidator`)
- `clients.md` — client relationship context and any logged brand voice notes
- `case-studies.md` — previous copy work for reference (optional)
- `tone-of-voice.md` — **fallback only**: used when no brief-based brand voice exists. Also used for the skill's OWN writing voice (headers, commentary, rationale) — distinct from the brand voice of the copy itself.

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/copy-atoms.md`** — read at the start of every Deck run. Defines the 13 atom types, quality criteria per atom, which atoms matter per project type, the atom naming convention.
- **`references/voice-sharpness-claims.md`** — read during scoring. The operational heart: brand voice source hierarchy, voice scoring rules, sharpness detection signals, claim/proof discipline, SMT ladder checks, atom-level scoring methodology. Also read in Check mode.
- **`references/platform-variants.md`** — read only when the user asks for platform variants. Per-platform hard limits, soft conventions, enforcement rules for web, email, LinkedIn, Instagram, X, TikTok, presentation, print, packaging.
- **`references/microcopy-patterns.md`** — read in Microcopy mode only. Patterns for buttons, errors, empty states, loading, success, form helpers, notifications, onboarding. Voice calibration per atom type. Microcopy coverage checklist.
- **`references/brain-copy-schema.md`** — read whenever writing files or running version logic. Versioning rules, brand voice source hierarchy, project state write flow, handoff rules, churn detection.

## Conversation Flow

### Step 1: Brain check & mode selection

Run brain discovery. Check specifically:

```bash
[ -d "$HOME/.creativestack/projects" ] && echo "PROJECTS_DIR_EXISTS" || echo "NO_PROJECTS_DIR"
[ -f "$HOME/.creativestack/learnings.md" ] && grep -q "## Feedback" "$HOME/.creativestack/learnings.md" && echo "FEEDBACK_LEARNINGS" || echo "NO_FEEDBACK_LEARNINGS"
```

[SELECT] "What do you need?"
- Deck — create a copy deck from messy inputs (default)
- Check — audit copy the team has written (score, don't rewrite)
- Microcopy — UX microcopy specifically (buttons, errors, empty states, etc.)

**Routing:**
- Deck → Step 2
- Check → Step 2 (same context loading, then skip generation)
- Microcopy → Step 2 (same context loading, then switch to microcopy flow)

### Step 2: Project and version check

Use the project state picker (from `## Project State (cross-skill memory)

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
once at the end that project state is available.`) to establish which
project this is for.

Once the project slug is known, check for existing copy deck versions:

```bash
ls "$HOME/.creativestack/projects/{slug}-copy-deck-v"*.md 2>/dev/null
```

If previous versions exist:

> "I found copy deck versions for this project: v1.0 (2026-03-15),
> v1.1 (2026-03-22), v1.2 (2026-04-02). What do you need?"

[SELECT] (if previous versions exist):
- New minor version (v1.3) — refinement of the current direction
- New major version (v2.0) — direction change
- Audit the latest version (Check mode)
- Start fresh (archive previous, start at v1.0)

Read the latest previous version for vocabulary, rhythms, and approved
phrases. Treat it as a reference, not a constraint.

Check for **churn detection**: if current version is v1.4+ without sign-off:

> "⚠️ **Copy deck churn detected.** This deck is on v{N} without sign-off.
> Usually means brief-level ambiguity, not copy-level issues. Want me to
> pause and run `/brief-sharpener` on the underlying brief
> first? Or proceed anyway?"

### Step 3: Brand voice source hierarchy

Read `references/brain-copy-schema.md` § "Brand voice source hierarchy"
and identify the voice source, in order:

1. `projects/{slug}-brief.md § Brand Tone & Personality` (primary)
2. `learnings.md § Feedback` Vocabulary for this client (overlay)
3. Previous `projects/{slug}-copy-deck-v*.md` (reference for consistency)
4. `clients.md` voice notes (if logged)
5. `tone-of-voice.md` (fallback only — flag explicitly if used)

Tell the user what voice source was found:

> "Brand voice sourced from: the creative brief's Brand Tone & Personality
> section + 3 vocabulary entries for this client from learnings.md. The
> previous deck (v1.2) will be used as a consistency reference."

Or, if the fallback is used:

> "⚠️ No brand voice source found — no brief, no previous deck, no client
> voice notes. Using the agency's default tone-of-voice.md as a fallback.
> The deck will be on the agency's voice but may not be distinctive to
> this client. Consider running /creative-brief first to
> establish the brand voice."

### Step 4: Upstream skill check

Scan the conversation for output from earlier skills:

| Skill run earlier | What to pull in | How it's used |
|---|---|---|
| `/creative-brief` | SMT, audience, tone, desired response, reasons to believe | Primary voice and content source |
| `/brief-sharpener` | Refined brief output | Same as creative-brief |
| `/creative-strategy` | Strategic territories, positioning | Voice and messaging direction |
| `/feedback-consolidator` | Round feedback on previous copy version | Direct input for revisions |
| `/competitor-audit` | Competitive messaging context | Sharpness calibration |
| `/source-scrape` evidence mode | Hard data for proof points | Claim/proof pairing |

### Step 5: Receive inputs (Deck mode) or copy to audit (Check mode)

**Deck mode:** User pastes messy content — email threads, notes,
marketing requirements, scribbled ideas. Accept any format.

**Check mode:** User pastes copy the team has already written, organised
or unorganised. The skill will score without rewriting.

**Microcopy mode:** Ask "What product and what surface?" Then read
`references/microcopy-patterns.md` § "Microcopy checklist per product"
and walk the user through the coverage checklist. For each category, ask
for existing copy or note as a gap.

### Step 6: Project type and atom scope

[SELECT] "What type of copy is this?"
- Campaign
- Website
- Digital product
- Brand / identity
- Email
- Social
- Print / OOH
- Presentation
- Packaging
- Microcopy (routes to Microcopy mode)
- Mixed

Read `references/copy-atoms.md` § "Choosing which atoms to include" to
determine which atoms matter for this project type. Pre-populate the
primary atoms list. Ask once about secondary atoms.

### Step 7: Generate atoms (Deck mode)

For each required atom:

1. Read the atom's criteria from `references/copy-atoms.md`
2. Generate 1-3 candidates, informed by:
   - The brief's SMT, audience, desired response, reasons to believe
   - The brand voice from the source hierarchy
   - Client vocabulary from `learnings.md § Feedback`
   - Previous version vocabulary and rhythms (if a prior version exists)
3. Write atoms in the BRAND's voice, not the agency's

**Critical:** the atoms themselves (the copy) are in brand voice. The
skill's own writing — section headers, rationale, scoring notes — is in
agency voice from `tone-of-voice.md`.

### Step 8: Score every atom

Read `references/voice-sharpness-claims.md`. For every atom, score on 4
dimensions 1-5:

1. **Voice match** — does it match the brand's voice from the brief?
2. **Sharpness** — is it specific and earned, or flat and generic?
3. **Claim/proof** — are claims paired with reasons-to-believe?
4. **SMT ladder** — does it connect to the brief's single-minded thought?

Apply scoring discipline:
- Don't grade generously — great copy is rare
- Score at atom level, not section level
- Concrete rewrites > vague critiques
- Flag red atoms (1-2 on any dimension) even if overall score is high

### Step 9: Platform variants (optional, Deck mode only)

If the user asked for variants in Step 6, read `references/platform-variants.md`
and generate variants for each selected platform. **Enforce hard character
limits** as pass/fail checks. Any variant that exceeds a limit must be
rewritten before the deck closes.

Do NOT generate variants the user didn't ask for.

### Step 10: Microcopy coverage (Microcopy mode only)

Work through the microcopy checklist from `references/microcopy-patterns.md`:
- Buttons (primary, secondary, destructive)
- Error states
- Empty states
- Loading states
- Success / confirmation
- Form helpers, labels, placeholders
- Tooltips
- Onboarding
- Notifications

For each category, generate atoms or note gaps. Apply voice calibration
per atom type (high-latitude for empty states and loading, low-latitude
for buttons and form labels).

### Step 11: Check mode — audit without rewriting

In Check mode, the skill reads the submitted copy and runs it through
all 4 scoring dimensions without generating new atoms. Output is the
scoring rubric + optional rewrite suggestions flagged as "optional."

Check mode is for sign-off gates and QA passes. It doesn't replace the
writer's judgment — it surfaces what the 4-dimension scoring catches.

### Step 12: Assemble output

Generate the full output per the Output Format section below. Lead with
the overall score and red flags; then the messaging hierarchy; then the
atoms; then (if requested) platform variants.

### Step 13: Write files

For Deck mode and Microcopy mode:
1. Write `projects/{slug}-copy-deck-v{N}.md` with the schema from
   `references/brain-copy-schema.md`
2. Update `projects/{slug}.md` Recent Activity
3. Update `projects/_index.md` if status or version warrants
4. Confirm what was written

For Check mode:
1. No new file written
2. Append to Recent Activity: "copy-deck Check mode audit of v{N}, score {X}/5, {red flags} red flags"

### Step 14: Compounding loop

Offer **at most one** brain enrichment. Pick the most valuable:

- **New client vocabulary term surfaced during generation** → "I noticed this client uses '{term}' to mean {meaning}. Want me to save it to `learnings.md § Feedback`? Future decks will apply it automatically."
- **Copy deck churn detected (v1.4+)** → "This deck is on v{N} without sign-off. Want me to run `/brief-sharpener` on the brief to identify what's blocking?"
- **Fallback voice source used** → "No brief-based brand voice for this project. Want to run `/creative-brief` to establish one? Future decks for this project will get sharper voice scoring."
- **Red flags persist across versions** → "The same atoms have been red-flagged in v1.0 and v1.1. The issue isn't the copy — it's probably the brief. Want me to pause and review?"
- **Check mode passed with ≥4.5 score** → "This copy is ready to ship. Want me to run `/asset-spec` for production specs?"

One offer. Don't pile on.

## Output Format — Deck mode

The output structure (in order):

1. **Header** — Project, client, date, type, status, version, prepared by, brand voice source
2. **Summary** — 2-3 lines on what the deck covers
3. **Overall Deck Score** — average/5 + readiness state, plus per-dimension averages (Voice / Sharpness / Claim-proof / SMT ladder), plus red-flagged atom count
4. **Messaging Hierarchy (from the brief)** — quote the SMT verbatim, list audience + desired response + reasons to believe pulled from `projects/{slug}-brief.md`
5. **Copy Atoms** — for each atom in scope: the copy in brand voice, the 4-dimension scores with specific notes, 1-2 alternates with hypotheses, and (if v1.1+) the previous version's text and what changed. Use the atom naming convention from `references/copy-atoms.md`.
6. **Platform Variants** (if requested) — per platform from `references/platform-variants.md`, with character count verification (✓/✗)
7. **Claim/Proof Pairing** — table showing each claim, its proof source from the brief, and Backed/Unbacked status
8. **Brand Voice Check** — voice source used, fallback flag, per-section drift, client vocabulary applied
9. **Sharpness Check** — deck-level average + sharpest atoms + flattest atoms flagged for rewrite
10. **SMT Ladder Check** — strong / weak / contradicting groupings
11. **Missing Atoms** — expected for this project type but not provided
12. **Open Questions** — anything blocked on client clarification
13. **Version Changes** (if v1.1+) — changed/added/removed atoms with reasons, score change
14. **Brain Overlays Applied** — what was pulled from each brain source
15. **Written to Brain** — what files were created/updated

For full detail on each section's content and the scoring rubrics, see `references/voice-sharpness-claims.md` and `references/copy-atoms.md`.

## Written to Brain

- ✓ `projects/{slug}-copy-deck-v{N}.md` — {new deck}
- ✓ `projects/{slug}.md` — Recent Activity updated
- ✓ `projects/_index.md` — updated

---

## Output Format — Check mode

Same as Deck mode but:
- No new file written
- No new atoms generated — only the scoring rubric against existing copy
- "Optional rewrite suggestions" appear as a separate section at the end
  (the writer decides whether to apply them)
- Append to project state Recent Activity: "copy-deck Check mode audit"

## Output Format — Microcopy mode

Same scoring approach, but the atom list follows the microcopy checklist:

# Microcopy Deck — {Project} — v{version}

## Coverage checklist
{From references/microcopy-patterns.md § "Microcopy checklist per product"}

## Buttons
{Atoms + scores by category: primary, secondary, destructive}

## Error states
{Atoms + scores by category: form validation, auth, network, payment, permission, not found}

## Empty states
{Atoms + scores}

## Loading states
{Atoms + scores}

## Success / confirmation
{Atoms + scores}

## Form helpers
{Labels + placeholders + helper text + tooltips}

## Notifications
{If applicable}

## Gaps
{Checklist items with no copy yet — flag for later coverage}

---

## Slack Format

For Deck mode:

*Copy Deck — {Project} — v{version}*
**Score: {X}/5** {readiness state}
**Atoms:** {count} ({red flags} red)
**SMT ladder:** {avg}/5
**Voice source:** {brief / fallback}
**Next:** {one-line next step from skill chains}

For Check mode:

*Copy Check — {Project} — audit of v{version}*
**Score: {X}/5**
**Red flags:** {count}
**Top issue:** {one-line summary of biggest problem}

---

## Skill Chains

Pick the most relevant 1-2:

**Upstream:**
- **No brief for this project** → "Run `/creative-brief` first — the deck sources brand voice from the brief instead of falling back to the agency default."

**Downstream:**
- **Score ≥ 4.5, ready to ship** → "Run `/asset-spec` for production specs if deliverables are defined."
- **Churn detected (v1.4+) or score < 3.5** → "The issue is usually the brief, not the copy. Run `/brief-sharpener` on the underlying brief."

## Edge Cases
- **Very short input** → ask for more context. Don't pad a deck from a few bullets.
- **No `projects/{slug}-brief.md`** → fall back to previous deck or tone-of-voice.md. Flag the fallback explicitly.
- **No brain at all** → scoring runs against generic standards, flag this as degraded.
- **Client vocab contradicts the brief** → flag the discrepancy and ask which to trust. Never silently override.
- **The brief has no SMT** → SMT ladder check skipped with a note; suggest `/creative-brief`.
- **Copy exceeds character limits** → rewrite in-deck before finalising. Never ship variants that exceed hard limits.

### What this skill can't do

This skill scores copy against the brief and the brain. With deeper
integration it could also test copy against real audience response data,
track which phrasings perform best across campaigns for this client, and
auto-flag copy that contradicts previously-approved communications. The
brain enables the scoring and versioning; performance data is the
remaining frontier.

---
*CreativeStack by Cameron Jones — jones.cam*
