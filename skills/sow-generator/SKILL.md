---
name: sow-generator
description: Generate, learn, and maintain a Statement of Work that matches the user's own format. Modes — first-run style setup, ingest an existing SOW, generate a new SOW from project parameters, manage a reusable clause library, edit saved style. Synthesises upstream skills (timeline, proposal, brief, resource-conflict). Persists style to ~/.creativestack/sow-style.md so every future SOW uses the user's structure, clauses, terminology, and defaults. Not legal advice.
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

# /creativestack:sow-generator

> Your SOW, in your format. Learns once, reuses forever. Not legal advice.

## What This Skill Does

Most SOW generators print a generic template. This one acts as a **SOW system**:

1. **Learns your format once** — through setup or by ingesting an existing SOW
2. **Stores it in the Brain** as `sow-style.md` — section order, custom sections, your verbatim standard clauses, default payment terms, default revision policy, your voice ("the studio" / "the provider" / "we"), your reference numbering format
3. **Generates new SOWs in your format**, pulling project details from upstream skills where possible
4. **Maintains a clause library** so reusable clauses (kill fee, AI usage, rush surcharge, IP terms) live in one place and can be slotted in by name

The result: the first SOW takes 10 minutes to set up. Every SOW after that takes 60 seconds and looks like *yours*, not like a generic template.

**Important: This skill generates a working draft based on your saved patterns. It is not legal advice. All Statements of Work should be reviewed by a qualified legal professional before being sent to clients.**

## Brain Files
- `sow-style.md` — **the SOW DNA**: section order, custom sections, saved clauses, defaults, voice (this skill creates and maintains it)
- `profile.md` — agency name, location, standard payment terms
- `tone-of-voice.md` — voice for prose sections
- `learnings.md` — past project patterns, especially revision actuals vs. planned
- `methodology.md` — phase structure for the Phased template

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/templates.md`** — read when generating a fresh SOW with no saved style, or when the user asks for a specific template variation (Project / Retainer / Discovery / Phased)
- **`references/clause-library.md`** — read when the user has no saved clauses and needs starting points (IP, confidentiality, termination, AI usage, kill fee, rush surcharge, force majeure, indemnification)
- **`references/ingestion.md`** — read when the user is in **Ingest** mode and pastes an existing SOW; this file contains the extraction heuristics
- **`references/jurisdictions.md`** — read when the project involves cross-border work, GDPR, US state considerations, or international clients

## Conversation Flow

### Step 1: Brain check & mode selection

Run the brain discovery from the preamble. Then check specifically for `sow-style.md`:

```bash
[ -f "$HOME/.creativestack/sow-style.md" ] && echo "STYLE_EXISTS" || echo "NO_STYLE"
```

**If `sow-style.md` does NOT exist** and the user has asked to generate a SOW, say:

"I don't have your SOW style saved yet. Two ways to set it up:

- **Quick setup** (~3 mins) — I ask a few questions and save your defaults
- **Ingest existing SOW** (~1 min) — paste a SOW you've used before and I'll extract the structure

Or skip setup and use a generic template for this one — but every SOW will look generic until you do."

[SELECT] mode:
- Quick setup
- Ingest existing SOW
- Generic template (one-off, don't save)

**If `sow-style.md` exists**, ask what they want to do:

[SELECT] "What do you need?"
- Generate a new SOW
- Ingest another SOW (refine my saved style)
- Edit my saved style
- Add or update a clause in my library
- Show me what's saved

### Step 2: Setup mode (first-run only)

Goal: build `~/.creativestack/sow-style.md` with the user's defaults.

Ask in batches using `AskUserQuestion`:

1. **Voice & terminology** — how they refer to themselves ("the Provider" / "the Agency" / "the Studio" / "we"), how they refer to the client ("the Client" / "you" / actual name), tone (formal legal / professional / conversational)
2. **Defaults** — revision policy (1/2/3 rounds, unlimited-windowed, custom), payment structure (50/50, milestone, monthly, per phase, custom), payment terms in days, late payment terms
3. **Sections** — walk through the default order (Overview, Scope, Deliverables, Timeline, Investment, Revisions, Client Responsibilities, IP, Confidentiality, Termination, General Terms). Ask what to add/remove/reorder. Common additions: Sustainability, AI Usage, DEI rider, Accessibility, Data handling, Subcontractor disclosure.
4. **Clauses** — paste verbatim standard clauses (IP, confidentiality, termination, kill fee, AI usage). Save to clause library. Skip if not ready — `references/clause-library.md` has starting points.
5. **Reference numbering** — how SOWs are numbered/referenced

Write `~/.creativestack/sow-style.md` per the schema below. Confirm and tell the user they can edit the file directly or re-run sow-generator's Edit style mode.

### Step 3: Ingest mode

Goal: extract a user's SOW format from a pasted document and save it to `sow-style.md`.

Ask: "Paste the SOW (markdown, plain text, or copied from Word/Google Docs/PDF). Don't worry about formatting — I'll figure it out."

Then **read `references/ingestion.md`** for the extraction heuristics. Apply them. Show the user what you extracted in this format:

```
Extracted from your SOW:

**Voice:** "the Provider" / "the Client", formal legal tone
**Sections (in order):** Overview, Scope, Deliverables, Timeline, Fees, Revisions, IP, Confidentiality, Termination
**Custom sections detected:** AI Usage Policy, Sustainability Commitments
**Default revision policy:** 2 rounds, 5 business days per round
**Default payment:** 50% upfront, 50% on completion, NET 30
**Standard clauses captured:** IP transfer, mutual NDA, kill fee (50%), force majeure, AI usage policy
**Reference format:** {CLIENT}-{PROJECT}-{YYYYMM}

Save this as your SOW style? (yes / edit first / discard)
```

If "edit first" — let them tweak. If "yes" — write to `sow-style.md`. If they already have a saved style, ask: replace, merge, or compare.

### Step 4: Generate mode

This is the main path once `sow-style.md` exists.

#### 4a. Upstream skill check

Scan the current conversation for output from other Creativestack skills. Auto-populate where possible:

| Skill run earlier | What to pull in |
|---|---|
| `/creativestack:timeline-generator` | Phase structure, durations, milestones |
| `/creativestack:proposal-generator` | Scope, deliverables, pricing model, investment |
| `/creativestack:resource-conflict` | Team availability → delay clauses |
| `/creativestack:creative-brief` | Objectives, deliverables, success metrics |

Tell the user what you're pulling in: "I can see you ran `/creativestack:proposal-generator` earlier — pulling in the scope, deliverables, and pricing. You don't need to repeat them."

#### 4b. Project parameters

Only ask for what isn't already covered:

1. "What's the project and who's the client?" (skip if from `/creativestack:creative-brief`)
2. "Key deliverables?" (skip if from proposal)
3. [SELECT] "SOW type?" (skip if obvious)
   - Project (fixed scope, fixed fee)
   - Retainer (monthly, ongoing)
   - Discovery (time-boxed exploration)
   - Phased (with go/no-go gates)
4. "Budget / fee?" (skip if from proposal)
5. "Timeline / hard deadlines?" (skip if from `/creativestack:timeline-generator`)
6. "Anything different from your saved defaults for this one?" — payment terms, revisions, custom clauses, anything bespoke

If the project type is Retainer / Discovery / Phased, **read `references/templates.md`** for that variation's adjustments. For Project type with a complete saved style, you don't need the references file.

#### 4c. Brain-informed nudges

If `learnings.md` has data on revision rounds for this project type:
> "Heads up — your past {project type} projects averaged {n} revision rounds. Your default of {policy} aligns with that / runs short / has buffer."

If the user is contracting internationally and `references/jurisdictions.md` hasn't been read yet, **read it** and surface the relevant flag (currency, jurisdiction, GDPR, tax).

#### 4d. Generate

Build the SOW using `sow-style.md`:
- Use the **section order** from `sow-style.md`
- Insert the user's **custom sections** verbatim where they belong
- Use the user's **saved clauses verbatim** for IP, confidentiality, termination, etc.
- Use the user's **terminology** ("the Studio" not "the Provider")
- Use the user's **reference number format**
- Apply the user's **default revision and payment terms** unless overridden for this project

Output the full SOW as clean markdown (see Output Format below).

### Step 5: Manage clauses mode

[SELECT] "What do you want to do with your clause library?"
- Add a new clause
- Edit an existing clause
- Remove a clause
- List all saved clauses
- Suggest clauses I might be missing (read `references/clause-library.md`)

For "add": ask for clause name, when it should appear (which section), and the verbatim text. Append to `sow-style.md` under `## Clause Library`.

For "suggest missing": read `references/clause-library.md`, compare against what the user has saved, list ones they might want with a one-line description. Don't add anything without their say-so.

### Step 6: Edit style mode

[SELECT] "What do you want to update?"
- Section order or custom sections
- Voice / terminology
- Default revision policy
- Default payment terms
- Reference number format
- A specific saved clause

Make the targeted edit to `sow-style.md`. Don't rewrite the whole file.

## sow-style.md Schema

When creating or updating `~/.creativestack/sow-style.md`, use this structure:

```markdown
---
last_updated: {date}
voice_us: {"the Provider" | "the Agency" | "the Studio" | "we"}
voice_them: {"the Client" | "you" | "client name"}
tone: {formal | professional | conversational}
default_revision_policy: {strict | standard | generous | unlimited-windowed | custom}
default_revision_window_days: {n}
default_payment_structure: {50-50 | milestone | monthly | per-phase | custom}
default_payment_terms_days: {n}
late_payment_terms: {string or empty}
reference_format: {e.g. "{CLIENT}-{PROJECT}-{YYYYMM}"}
---

## Section Order
1. Project Overview
2. Scope of Work
3. Deliverables
4. Timeline
5. Investment & Payment Schedule
6. Revision Policy
7. Client Responsibilities
8. Intellectual Property
9. Confidentiality
10. Termination
11. General Terms
{...any custom sections in their preferred position}

## Custom Sections
### {Section name, e.g. "AI Usage Policy"}
**Position:** {after which standard section}
**Content:**
{verbatim text or template the user provided}

## Clause Library

### {Clause name, e.g. "IP Transfer"}
**Section:** Intellectual Property
**Text:**
{verbatim clause text}

### {Clause name, e.g. "Kill Fee"}
**Section:** Termination
**Text:**
{verbatim clause text}

## Notes
{Any free-form notes the user added during setup or ingestion}
```

## Output Format

Generate the SOW as clean markdown. Use the user's saved structure if it exists, otherwise fall back to the default Project template in `references/templates.md`.

Always end with the signature block and disclaimer:

```
**Agreed and accepted:**

| | {voice_them} | {voice_us} |
|---|--------|--------|
| Name | _________________ | _________________ |
| Title | _________________ | _________________ |
| Date | _________________ | _________________ |
| Signature | _________________ | _________________ |

---
*This document is a working draft generated by CreativeStack. It is not legal advice.
Please have all contracts reviewed by a qualified legal professional.*
```

## Skill Chains

### Upstream (what feeds sow-generator)

If saved style exists but no upstream skills were run, suggest 1-2 only when they'd help:
- No proposal → "Run `/creativestack:proposal-generator` first to lock in scope and pricing — the SOW will pull from it directly."
- No timeline → "Run `/creativestack:timeline-generator` for milestone dates."

### Downstream

- SOW signed → "Run `/creativestack:project-kickoff` to build a kickoff pack from this SOW."
- After 3+ SOWs generated → "Run `/creativestack:post-mortem` after the project to feed revision/scope actuals back into your defaults."

Only suggest 1-2 chains. Pick the most relevant.

## Edge Cases

- **No saved style, user wants to generate now** → offer Generic mode but warn it won't reflect their format. After generating, suggest setup.
- **Ingested SOW is messy / inconsistent** → extract what you can with confidence. List what you couldn't extract and ask the user to fill the gaps. Don't guess at clauses.
- **User pastes a SOW from a Word doc with weird formatting** → strip the noise (page numbers, headers, table of contents) before extracting.
- **No budget provided** → use `[FEE TBD]` placeholders, don't block.
- **Retainer / Discovery / Phased type** → read `references/templates.md` for the variation patterns.
- **International client** → read `references/jurisdictions.md`, surface relevant flags.
- **User's style says "use clause X" but clause X isn't in the library** → flag it, ask them to paste the clause text now.
- **`learnings.md` shows past projects of this type averaged 3.2 revision rounds but the user's default is 2** → surface this and ask if they want to override for this SOW.
- **User wants unusual terms** → include them, but flag anything that deviates from common practice.
- **Conflict between saved style and upstream skill data** → upstream wins for project specifics (scope, pricing, timeline). Saved style wins for structure, clauses, terminology.

### What this skill can't do

This skill is a SOW system, not a lawyer. It can't tell you whether a clause is enforceable in your jurisdiction, draft bespoke legal language for novel situations, or replace legal review. What it *can* do is make sure every SOW you send looks consistent, contains your standard clauses verbatim, reflects your actual project data, and takes 60 seconds to produce instead of an hour of copy-paste.

---
*CreativeStack by Cameron Jones — jones.cam*
