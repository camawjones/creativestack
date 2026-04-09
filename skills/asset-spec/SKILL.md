---
name: asset-spec
description: Turn a campaign concept into a complete production-ready asset specification — platform-accurate specs, paid media variant matrix, localisation matrix, usage rights tracking, accessibility specs, source file packaging, handoff checklists, and a row-per-asset CSV production tracker that pastes directly into Sheets/Airtable/Notion. For creative producers, traffic managers, designers, motion leads, and account managers running digital/print/OOH/broadcast campaigns. Use when you need to translate a campaign brief or deliverables list into the exact artifact a production team needs to build everything right first time.
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

# /asset-spec

> Campaign concept in, full delivery spec out. No more "what size is that again?"
> No more surprise 4:5 variants. No more expired talent rights.

## Brain Files
- `profile.md` (for context)
- `tools.md` (production tool preferences, naming conventions, handoff systems)
- `visual-style.md` (default aesthetic baseline when the spec doesn't override it — and the style any spec sheets or visual references rendered in Figma should follow)
- `rate-card.md` (optional — when present, add time/cost estimates per asset)
- `clients.md` (optional — for client-specific delivery preferences and existing conventions)

## What This Skill Does

Takes a campaign concept, brief, or deliverables list and generates a complete
production-ready specification that covers:

1. **Asset list** with correct specs for every platform/placement
2. **Paid media variant matrix** (the biggest hidden time sink in digital campaigns)
3. **Localisation matrix** when multi-market
4. **Usage rights tracking** (talent, music, stock, archive)
5. **Source file packaging spec** (what ships beyond the finals)
6. **Accessibility specs** (WCAG 2.2 AA)
7. **Handoff checklists** per asset type
8. **Naming convention and file organisation**
9. **CSV production tracker** — row-per-asset, ready to paste into Sheets/Airtable/Notion
10. **Time/cost estimates** per asset (when `rate-card.md` is available)

This skill generates the document production teams actually need. It does NOT
generate creative, write copy, or make design decisions — the creative step stays human.

## Reference Files (load on demand)

Detailed platform specs live in `references/` and are loaded only when the campaign
actually touches that medium. **Load the ones relevant to the campaign, not all of them.**

| File | Load when |
|---|---|
| `references/social-platform-specs.md` | Campaign includes any social platform |
| `references/display-ad-specs.md` | Campaign includes programmatic, DSP, or display networks |
| `references/video-and-broadcast-specs.md` | Campaign includes video (online or broadcast) |
| `references/print-ooh-packaging-specs.md` | Campaign includes print, OOH, DOOH, or packaging |
| `references/paid-media-variant-matrix.md` | Campaign includes any paid media — **always load for paid** |
| `references/localisation-matrix.md` | Campaign runs in more than one market or language |
| `references/accessibility-specs.md` | **Always load** — accessibility applies to every digital asset |
| `references/usage-rights-tracking.md` | Campaign involves talent, music, stock, or archive |
| `references/production-tracker-csv.md` | **Always load** — the CSV is always part of the output |
| `references/naming-conventions.md` | **Always load** — naming is always part of the output |

## Upstream Skill Synthesis

Before asking questions, check whether any of these skills were run earlier in this session:

| Skill run earlier | What to pull in | How it's used |
|---|---|---|
| `/sow-generator` | Deliverables list, scope, revision limits | Pre-fills the asset list from contracted deliverables |
| `/proposal-generator` | Proposed deliverables, budget allocation | Pre-fills asset list and informs production complexity |
| `/social-calendar` | Platforms, post formats, content volume | Generates platform-specific social asset specs automatically |
| `/creative-brief` | Objectives, target audiences, markets | Informs audience/market axes of the variant matrix |
| `/creative-strategy` | Messaging routes, message variants | Pre-fills the message axis of the variant matrix |
| `/timeline-generator` | Milestones, delivery dates | Feeds the Due column of the production tracker |
| `/brand-guidelines` | Colour system, type system, accessible pairs | Informs contrast and accessibility checks |
| `/resource-conflict` | Team availability, bench | Feeds Owner column of the production tracker |

When upstream data is available, tell the user one line:
"I can see you ran `/social-calendar` earlier — I'll generate specs for every asset format in the calendar. You don't need to re-list the platforms."

## Inputs
- Campaign concept or project description
- Platforms / channels / placements
- Markets and languages (if multi-market)
- Paid media details (if any)
- Existing conventions, brand rules, rights constraints (if any)
- Optional: an existing asset list to adopt

## Conversation Flow

### Step 1: Project discovery

Follow the project state discovery + picker protocol. After picking the project (or
choosing standalone mode), Read the `asset-spec` namespace under Skill Memory if it
exists. If prior runs stored convention, placements, or rights context, reuse them —
say one line: "Continuing {project}. Last run used the `{client}_{campaign}_...` naming
convention and included Meta + TikTok. Same setup, or change anything?"

### Step 2: Campaign scope (batch into one AskUserQuestion call where possible)

1. Ask free-text: "What's the campaign or project? One paragraph is fine."
2. `[SELECT multiSelect]` "Which asset categories does this campaign need?"
   - Social
   - Paid display / programmatic
   - Video (online)
   - Broadcast TV / cinema
   - Print
   - OOH (static)
   - DOOH (digital out-of-home)
   - Packaging
   - Web
   - Email
   - Podcast / audio
3. `[SELECT]` "Is this a paid media campaign, organic, or mixed?"
   - Paid (includes paid social, programmatic, or broadcast)
   - Organic only
   - Mixed
4. `[SELECT]` "How many markets / languages?"
   - One market, one language
   - One market, multi-language
   - Multi-market, multi-language
5. `[SELECT]` "Roughly how many assets overall?"
   - Small (≤15)
   - Moderate (16-50)
   - High (51-150)
   - Heroic (150+)

### Step 3: Paid media details (only if paid)

If paid is in scope, load `references/paid-media-variant-matrix.md` and ask:

1. "How many creative concepts / routes?"
2. "How many message variants per concept? (Hooks, benefits, social proof, urgency)"
3. "Are you targeting different audiences with different creative? If yes, how many audiences?"
4. "Any specific placements or networks confirmed? (e.g., Meta, TikTok, YouTube, DV360, TTD)"

Use these to construct the variant matrix before generating specs. If the raw matrix
exceeds 50 variants, propose collapses per the reference file (master + templated
variants, drop low-impact placements, use dynamic creative, etc.).

### Step 4: Localisation (only if multi-market / multi-language)

Load `references/localisation-matrix.md` and ask:

1. "Which markets / languages exactly?"
2. "Is the master in {primary language}? Which languages need transcreation (not just translation)?"
3. "Are any assets market-specific (talent/imagery swap) or can visuals be reused across markets?"
4. "Any RTL languages (Arabic, Hebrew, Farsi, Urdu)?"

### Step 5: Production essentials (batch)

Use a single `AskUserQuestion` call to batch these:

1. `[SELECT]` "What source files should ship with the deliverables?"
   - Finals only
   - Finals + working files (PSD, AI, AEP, INDD, Figma)
   - Finals + working files + fonts + links packaged
2. `[SELECT]` "Any talent, music, stock, or archive content to track rights for?"
   - None
   - Talent only
   - Music only
   - Multiple (talent, music, stock, etc.)
3. `[SELECT]` "Does this client have an existing naming convention I should match?"
   - Yes — I'll paste / describe it
   - No — use the CreativeStack default
   - Check the brain for an agency-wide convention
4. `[SELECT]` "Delivery method?"
   - Google Drive / Dropbox / WeTransfer
   - DAM system (Bynder, Brandfolder, Frontify, etc.)
   - Direct to trafficking house (Adstream, Peach, IMD)
   - Client-specific system

### Step 6: Generate

Synthesise:

1. **Load the relevant references** for the categories in scope (see table above)
2. **Always load** `accessibility-specs.md`, `production-tracker-csv.md`, `naming-conventions.md`
3. **Cross-reference** `tools.md` and `visual-style.md` from the brain where relevant
4. **Cross-reference** upstream skill outputs (social-calendar, creative-brief, etc.)
5. **Generate the asset list** — one row per shipped asset, including all paid variants and localisation variants
6. **Generate the CSV production tracker** — the same list in copy-paste-ready CSV form
7. **Generate handoff checklists** only for the categories in scope
8. **Generate time estimates** per asset type if `rate-card.md` is present
9. **Flag spec drift** — include the verification footer from `social-platform-specs.md`
10. **Write back to project state** — append to Recent Activity, update Skill Memory

## Output Format

```markdown
# Asset Specification: {Campaign/Project Name}
**Client:** {client}
**Date:** {today}
**Prepared by:** {agency name from brain}
**Delivery window:** {start → end}
**Earliest rights expiry:** {date} (if any)

## Campaign Overview
{Brief description of the campaign and what's being produced.}

## Production Summary

| Metric | Value |
|---|---|
| Total shipped assets | {N} |
| Static / video / HTML5 split | {N / N / N} |
| Markets / languages | {N / N} |
| Paid variant count | {N} |
| Production complexity | {Simple / Moderate / High / Heroic} |
| Time estimate total | {N hours} (if rate-card present) |
| Earliest rights expiry | {date or —} |

## Asset List

{Group by category. Only include the categories in scope.}

### Social Media
{Pull exact specs from references/social-platform-specs.md. Include verification date.}

| Asset | Platform | Placement | Dimensions | Format | Aspect | Duration | Safe zones / notes |
|---|---|---|---|---|---|---|---|

### Paid Display / Programmatic
{Pull from references/display-ad-specs.md}

| Asset | Network | Unit | Dimensions | Format | Initial load | Polite load | Notes |
|---|---|---|---|---|---|---|---|

### Video (online & broadcast)
{Pull from references/video-and-broadcast-specs.md}

| Asset | Use | Dimensions | Duration | Codec | LUFS | Captions | Notes |
|---|---|---|---|---|---|---|---|

### Print
{Pull from references/print-ooh-packaging-specs.md}

| Asset | Trim | Bleed | Stock | Colour mode | Resolution | Format |
|---|---|---|---|---|---|---|

### OOH / DOOH
{Pull from references/print-ooh-packaging-specs.md}

| Asset | Operator | Format | Dimensions | Resolution | Format | Notes |
|---|---|---|---|---|---|---|

### Packaging
{Pull from references/print-ooh-packaging-specs.md — dieline, finishes, compliance}

### Web / Email / Other
{As needed}

---

## Paid Media Variant Matrix

{Only if paid is in scope. Full matrix per references/paid-media-variant-matrix.md.}

| ID | Concept | Message | Audience | Placement | Aspect | Duration | Lang |
|---|---|---|---|---|---|---|---|

**Total variants:** {N}
**Production approach:** {Hand-build / Master + manual variants / Master + templated / Dynamic creative}

---

## Localisation Matrix

{Only if multi-market. Full matrix per references/localisation-matrix.md.}

| Asset ID | Master lang | {lang 2} | {lang 3} | ... | Notes |
|---|---|---|---|---|---|

**Total translated words:** {N}
**Assets needing reflow:** {N}
**Image variants needed:** {list}
**RTL flips:** {N}

---

## Accessibility

{Always include. Per references/accessibility-specs.md.}

**Standard:** WCAG 2.2 AA

| Asset type | Alt text | Captions | AD | Contrast | Reduced motion | Other |
|---|---|---|---|---|---|---|

### Sign-off
- [ ] Contrast verified for all text and UI
- [ ] Alt text written for every informative image
- [ ] Captions delivered in correct format per platform
- [ ] AD recorded if required
- [ ] No flashing >3 per second
- [ ] Animation pause control where applicable

---

## Usage Rights & Clearance

{Only if talent/music/stock/archive is in scope. Per references/usage-rights-tracking.md.}

**Window:** {start → end}
**Earliest expiry:** {date} — {what expires}
**Calendar reminder:** Set for 30 days before each expiry

### Talent
| Talent | Role | Use start | Use end | Territory | Media | Renewal |

### Music
| Track | Type | Cleared | Term | Cost | Renewal |

### Stock & archive
| Asset | Source | License | Term | Cost |

### AI-generated content
| Asset | Model | Use case | Commercial rights confirmed | Disclosure required |

---

## Source File Packaging Spec

**What ships beyond the finals:**

- [ ] Source files ({PSD / AI / AEP / INDD / Figma / Sketch}) — {included / excluded}
- [ ] Linked assets (images, illustrations, logos) — packaged
- [ ] Fonts — {packaged / outlined / excluded per license}
- [ ] Colour profiles — {sRGB for digital, CMYK ICC profile for print}
- [ ] Proxy files for video (if .aep) — optional
- [ ] Read-me file with build notes and version history

Source files go in `/02-master-files/source` per the folder structure below.

---

## Naming Convention

{Per references/naming-conventions.md. If the brain or project state has an existing
convention, use that and reference its source. Otherwise use the default below.}

```
{client}_{campaign}_{asset-type}_{placement}_{aspect}_{lang}_{version}.{ext}
```

**Examples:**
- `acme_summer25_hero_metafeed_1x1_en_v1.jpg`
- `acme_summer25_hero_metastory_9x16_en_v1.mp4`
- `acme_summer25_tvc30_itv_16x9_en_v2-final.mxf`

### Version suffixes
| Suffix | Meaning |
|---|---|
| `_v1`, `_v2` | Major revision rounds |
| `_v1a`, `_v1b` | Minor amends within a round |
| `_v2-final` | Client-approved, signed off |
| `_v2-final-print` | Print-ready (CMYK, bleed) |
| `_wip` | Work in progress — not for review |

**Rules:** never overwrite; always increment; `final` means approved, if it changes it becomes `v3`.

---

## File Organisation

```
/{client}-{campaign}
  /00-brief-and-references
  /01-concepts-and-routes
  /02-master-files
    /source
    /fonts
    /stock-and-assets
  /03-deliverables
    /social
    /display
    /video
    /print
    /ooh
    /packaging
    /web
    /email
  /04-approved-final
  /05-archive
  /06-rights-and-clearances
```

---

## Handoff Checklists

{Generate only for the asset categories in scope.}

### Social Handoff Checklist
- [ ] All dimensions match current platform specs (verified {date})
- [ ] UI safe zones respected — text/logos clear of handle/caption UI
- [ ] Silent-first design — captions burned in or SRT provided
- [ ] Alt text written and provided per asset
- [ ] File sizes optimised and within platform limits
- [ ] Language/locale variants delivered if multi-market
- [ ] End-frame holds brand + CTA for ≥2s (video)

### Display / Programmatic Handoff Checklist
- [ ] All IAB unit dimensions exact
- [ ] File weights under network limits (initial AND polite)
- [ ] HTML5 clickTag implemented as variable
- [ ] Backup image included for every HTML5 banner
- [ ] Animation ≤15s, ≤3 loops
- [ ] No autoplay audio
- [ ] Border added if creative has white edges
- [ ] Tested on target browsers

### Video Handoff Checklist
- [ ] Codec, container, and bitrate correct for destination
- [ ] LUFS measured and within target ±0.5
- [ ] True peak ≤ -1 dBTP
- [ ] Captions delivered in correct format (SRT/VTT/SCC/STL)
- [ ] Audio description delivered if required
- [ ] Title safe respected (broadcast)
- [ ] UI safe zones respected (vertical/social)
- [ ] End-card holds ≥2s
- [ ] Talent rights confirmed against use window
- [ ] Music cue sheet completed (broadcast only)

### Print Handoff Checklist
- [ ] Colour mode CMYK; spot colours specified with Pantone year confirmed
- [ ] Resolution 300dpi at final print size
- [ ] Bleed set per printer spec
- [ ] Fonts outlined or packaged
- [ ] PDF/X-1a (or X-4) generated
- [ ] Proof requested before full run
- [ ] Paper stock confirmed

### OOH / DOOH Handoff Checklist
- [ ] Spec confirmed with operator in writing
- [ ] Resolution appropriate for viewing distance
- [ ] Bleed/safe per operator's sheet
- [ ] DOOH duration matches slot length
- [ ] No audio for DOOH
- [ ] Delivery method confirmed (FTP, direct upload, operator portal)

### Packaging Handoff Checklist
- [ ] Dieline matches structural sample
- [ ] All finishes (foil, UV, emboss, white ink) on separate marked layers
- [ ] Barcode at correct size and contrast
- [ ] Compliance marks at legal minimum size
- [ ] Print-ready PDF (PDF/X-1a or X-4)
- [ ] Source files packaged with fonts and links
- [ ] Printer proofing route confirmed

---

## Production Tracker (CSV)

Copy the block below into Google Sheets, Airtable, Notion, or your tracker of choice.
See `references/production-tracker-csv.md` for column definitions.

```csv
ID,Category,Asset Name,Concept,Message,Audience,Placement,Aspect,Dimensions,Format,Duration,Language,Variant,Weight Limit,Safe Zones,Deliverable,Source File,Naming,Rights,Owner,Status,Due,Notes
{one row per asset}
```

---

## Time Estimates (if `rate-card.md` present)

| Asset type | Unit count | Hours / unit | Total hours | Notes |
|---|---|---|---|---|
| {type} | {n} | {hrs} | {hrs} | — |

**Total production hours:** {N}
**Indicative cost at rate card:** £{N}

This is an estimate for scope conversations only. Not a quote. Actual time depends on
concepts, amends, and approvals.

---

## Spec Verification

- **Social platform specs** last verified: {date from references/social-platform-specs.md}
- **Display network specs** last verified: {date from references/display-ad-specs.md}
- **Broadcast / video specs** last verified: {date from references/video-and-broadcast-specs.md}
- Re-verify against the platform's live docs if the dates above are more than 90 days old.
- Trafficking house (Adstream, Peach, IMD) holds the authoritative broadcast sheet — always confirm with them before final delivery.

---

## Delivery Specs

- **Delivery method:** {Google Drive / Dropbox / DAM / Adstream / other}
- **Source files included:** {Yes/No — which formats}
- **Fonts packaged:** {Yes/No}
- **Colour profiles:** {sRGB for digital, CMYK profiles for print}
- **Archive copy:** {where the final set is archived for recall}

---

## Pre-Production Checklist

- [ ] All dimensions confirmed against current platform specs ({date})
- [ ] Variant matrix confirmed with client (total count, placements, languages)
- [ ] Naming convention confirmed with client and production team
- [ ] Delivery method confirmed
- [ ] Source file requirements confirmed
- [ ] Colour mode correct per output
- [ ] Rights window confirmed against campaign live dates
- [ ] Accessibility spec signed off
- [ ] Handoff checklist assigned to production lead
```

## Skill Chains

### Upstream (what feeds asset-spec)

If these weren't run but would have helped, suggest 1-2 for next time:
- No creative brief → "`/creative-brief` gives the objectives, audience, and messaging axes you need to size the variant matrix properly."
- No timeline → "`/timeline-generator` feeds the Due column of the production tracker."
- No resource plan → "`/resource-conflict` identifies who's free to own each asset."

### Downstream (what asset-spec triggers)

After generating the spec, suggest 1-2:
- If brand assets aren't formalised → "`/brand-guidelines` to lock in colour, type, and accessibility pairs before production kicks off."
- If SOW hasn't been written → "`/sow-generator` to include these specs and their revision limits in the contract."
- If team allocation isn't set → "`/resource-conflict` to match assets to owners and flag over-allocation."
- If this came from a social calendar → "Hand this spec to production alongside the `/social-calendar` — the IDs should line up."

Only suggest 1-2 chains — pick the most relevant.

## Write-back to project state

When project state exists, after generating:

- **Recent Activity** — append `YYYY-MM-DD — asset-spec — {N assets} across {categories} for {campaign}`
- **Skill Memory → asset-spec** — save:
  - `naming_convention`: the convention used
  - `placements`: the set of placements/platforms
  - `languages`: the set of languages
  - `total_assets`: count
  - `earliest_rights_expiry`: YYYY-MM-DD (so status-update can surface it)
  - `last_verified`: today's date (so next run knows when to re-verify)
- **Timeline** — if this feeds a production phase, note it
- **Risks** — if rights are tight or complexity is "Heroic", append a risk
- Update `_index.md`

## Edge Cases

- **Platforms not specified** → generate for the most common set (Instagram, LinkedIn, TikTok) and flag "please confirm"
- **Paid media with no concept count** → assume 1 concept, 2 messages, 1 audience and surface "that's my assumption — change it if wrong"
- **Print specs without paper stock** → flag that stock affects colour reproduction and bleed; produce spec with placeholder and mark as "confirm with printer"
- **Video without duration** → provide standard durations per platform (6s, 15s, 30s, 60s) and ask which are in scope
- **Very large campaign (150+ assets)** → group by workstream, generate in batches, and warn that dynamic creative (Meta Advantage+ etc.) should be considered
- **Client has existing naming convention** → adopt theirs; save to brain or project state so it persists
- **Multiple brands in one campaign** → separate asset lists per brand with clear labelling
- **Spec verification date is stale (>90 days)** → flag loudly at top of output: "Platform specs in references/ were verified {date}. Re-verify before production."
- **Upstream skill output conflicts with user input** → trust the user's in-session answer over the upstream output, and tell them you did
- **Multi-market with no transcreation decision** → default to "translation only" and flag that transcreation may be needed for taglines and idiomatic lines
- **Rights info is vague** → include the tracking table with placeholders and flag "complete before production"

### What this skill can't do

This skill generates specs, variant matrices, and production-ready documentation. It
does not produce the creative itself, automate the building of the assets, or integrate
directly with DAMs, trafficking houses, or DSPs. The CSV tracker is the interchange
format — paste it into whichever tool your production pipeline already uses.

With a fully-stocked brain (tools, rate card, clients, visual style), this skill gets
dramatically more useful — conventions come from memory, time estimates are calibrated
to the agency's actual rates, and client-specific delivery preferences are applied
automatically.

---
*CreativeStack by Cameron Jones — jones.cam*
