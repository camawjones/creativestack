---
name: case-study
description: Brain-first case study writing for creative agencies. Three modes — Write (auto-extracts from projects/{slug}-brief.md, -meetings.md, -copy-deck-v*.md, -competitor-audit.md, project state; falls back to pasted inputs), Awards (craft-focused, process-revealing, longer form for submissions), Update (add new results, awards, press, client changes to an existing case study without rewriting). Produces multi-length output — 1-line, 1-paragraph, 1-page, long-form — from a single source. Extracts hero client quotes automatically from meeting logs. Generates a client approval package (approval-safe version + draft email + sign-off checklist) because approval is where most case studies die. Inherits style from existing case-studies.md for portfolio coherence. Runs portfolio gap analysis. Persists versioned case studies to case-studies/{slug}.md. Solves the #1 case-study problem: gathering the material.
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

# /creativestack:case-study

> Creatives don't hate writing case studies — they hate gathering the material. This skill does the gathering.

## What This Skill Does

Most creatives hate writing case studies. Not because writing is hard —
because **gathering the material is hard**. The brief is in one place,
the client quotes are buried in meeting notes, the metrics haven't been
pulled yet, the team has moved on, the work is three months cold. By the
time the user opens a blank document, half the material has been lost.

This skill flips the problem. If the project ran through CreativeStack,
the material is already in the brain:

- `projects/{slug}-brief.md` — **the Challenge is literally here**
- `projects/{slug}.md` — stakeholders, timeline, sentiment arc
- `projects/{slug}-meetings.md` — client quotes, decisions
- `projects/{slug}-copy-deck-v*.md` — the work that shipped
- `projects/{slug}-competitor-audit.md` — category context
- `post-mortem` outputs — what was hard and what was learned
- `project-profitability` — commercial metrics (for internal case studies)
- `feedback-consolidator` — client sentiment trajectory

The skill extracts all of this automatically, tells the user what it
found, asks only about specific gaps, and writes the case study from
the assembled evidence. **Gathering is no longer the user's job.**

Plus:

- **Multi-length output** — 1-line / 1-paragraph / 1-page / long-form,
  produced together from the same source
- **Hero quote extraction** — scans meeting logs for candidate client
  quotes, ranks them, picks the hero
- **"What was hard" section** — honest framing of the struggle, sourced
  from project state decisions and sentiment trajectory
- **Unexpected outcomes** — first-class section, often the most
  compelling part
- **Client approval package** — approval-safe version + draft email +
  sign-off checklist. Closes the loop where most case studies die.
- **Narrative pattern selection** — picks from 6 patterns (Before/After,
  Tension/Resolution, Code-break, Process reveal, Unexpected outcome,
  Long relationship) based on what the evidence supports
- **Asset brief** — specific visuals to commission, pre-populated from
  the project's deliverables
- **Style inference** — reads existing case studies and matches the
  style so the portfolio reads as one voice
- **Portfolio gap analysis** — is this case study needed, or does the
  portfolio already over-index here?
- **Version tracking** — case studies evolve with new results, awards,
  press
- **Awards mode** — craft-focused, process-revealing, longer form for
  submissions
- **Update mode** — add new info to an existing case study without
  rewriting

## Brain Files
- `case-studies/{slug}.md` — **the case study DNA**: versioned per-project full case study files (this skill creates and maintains them)
- `case-studies.md` — the portfolio index (existing file; this skill appends summaries for discoverability by other skills)
- `projects/{slug}-brief.md` — **the #1 source**: Challenge, Approach framing, audience, SMT
- `projects/{slug}.md` — project state, stakeholders, timeline, sentiment arc
- `projects/{slug}-meetings.md` — client quotes (hero quote source), decision moments
- `projects/{slug}-copy-deck-v*.md` — the work that shipped
- `projects/{slug}-competitor-audit.md` — category context for the Challenge framing
- `methodology.md` — for structuring the Approach around the agency's framework
- `tone-of-voice.md` — for the writing voice (the skill's own prose)
- `clients.md` — client relationship context
- `team.md` — team credits

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/extraction.md`** — read at the start of every Write or Update run. How to pull case study material from every project state file type, in strict order, with gap detection and fallback rules. This is the operational heart of the skill.
- **`references/craft-and-framing.md`** — read during case study generation. Six narrative patterns (Before/After, Tension/Resolution, Code-break, Process reveal, Unexpected outcome, Long relationship), the "What was hard" discipline, six metrics framing frameworks, unexpected outcomes, and the asset brief format.
- **`references/client-approval.md`** — read after generating the full case study. Approval-safe version differences, draft email template, sign-off checklist, pre-empted client questions, partial approval handling, follow-up drafts.
- **`references/brain-case-study-schema.md`** — read whenever writing files, running versioning, or checking portfolio gaps. Schema for `case-studies/{slug}.md`, two-file pattern with the portfolio index, versioning rules, multi-length output structure, gap analysis logic, Awards mode extensions, handoff rules.

## Conversation Flow

### Step 1: Brain check and project identification

Run brain discovery. Check specifically:

```bash
[ -d "$HOME/.creativestack/case-studies" ] && echo "CASE_STUDIES_DIR_EXISTS" || echo "NO_CASE_STUDIES_DIR"
[ -f "$HOME/.creativestack/case-studies.md" ] && echo "PORTFOLIO_INDEX_EXISTS" || echo "NO_PORTFOLIO_INDEX"
[ -d "$HOME/.creativestack/projects" ] && echo "PROJECTS_DIR_EXISTS" || echo "NO_PROJECTS_DIR"
```

Ask once: "Which project is this case study for?"

Use the project name to identify the slug and look for project state files:

```bash
ls "$HOME/.creativestack/projects/{slug}"* 2>/dev/null
```

Also check for existing case studies on this project:

```bash
[ -f "$HOME/.creativestack/case-studies/{slug}.md" ] && echo "CASE_STUDY_EXISTS"
```

### Step 2: Mode selection

[SELECT] "What do you need?"
- Write — new case study (default)
- Awards — case study formatted for award submission
- Update — add new info to an existing case study

**Routing:**
- If **Write** and an existing case study exists → "I have a case study for this project at v{current}. Update it instead, or start fresh? (Fresh creates v2.0.)"
- If **Update** and no existing case study → "No existing case study for this project. Switching to Write mode."
- If **Awards** → proceed to Awards flow (different depth and format)

### Step 3: Extraction pass (Write and Awards modes)

Read `references/extraction.md` for the strict 13-source extraction order and the extraction coverage report format. Run the pass and surface a coverage table to the user.

If **critical gaps** exist (no brief, no client quotes, no description of the work), pause and offer the user the choice between running upstream skills retrospectively or pasting what they have for a thinner case study.

### Step 4: Portfolio gap analysis

Read `references/brain-case-study-schema.md` § "Gap analysis logic". Categorise this project type/industry as underrepresented, balanced, or overrepresented. If overrepresented, surface a nudge but let the user proceed.

### Step 5: Narrative pattern selection

Read `references/craft-and-framing.md` § "Narrative patterns" — six patterns (Before/After, Tension/Resolution, Code-break, Process reveal, Unexpected outcome, Long relationship). Pick the pattern the evidence supports strongest, surface the suggestion, let the user confirm or override.

### Step 6: Hero quote extraction

Read `references/extraction.md` § "Hero quote extraction". Scan meeting logs, score each candidate on specificity, emotional weight, brandedness, length. Surface the top 3-5 with the suggested hero quote and reasoning. All quotes need client sign-off — flag this for the approval package.

### Step 7: Generate the case study (all lengths)

Read `references/brain-case-study-schema.md` § "Multi-length output
structure". Generate in this order:

1. **Long-form** (1200-2000 words) — fullest version using chosen pattern
2. **1-page** (600-900 words) — distilled from long-form
3. **1-paragraph** (60-100 words) — distilled from 1-page
4. **1-line credential** (10-20 words) — distilled from 1-paragraph

Each length compresses the previous. This ensures consistency.

Apply throughout:
- The chosen narrative pattern
- "What was hard" section (if evidence supports it)
- Unexpected outcomes section (if evidence supports it)
- Metrics framing from `craft-and-framing.md` § "Metrics framing"
- Voice from existing case studies + `tone-of-voice.md`
- Methodology framing from `methodology.md`

### Step 8: Asset brief and client approval package

Read `references/craft-and-framing.md` § "The asset brief" and `references/client-approval.md`. Produce both — the asset brief specifies visuals to commission (pre-populated from deliverables); the approval package contains the approval-safe version + draft email + sign-off checklist + sensitive-item flags + follow-up draft.

### Step 9: Write files

Create or update `case-studies/{slug}.md` per the schema, append the portfolio index entry to `case-studies.md`, update `projects/{slug}.md` Recent Activity, update `projects/_index.md`. Tell the user what was written and what the next step is (usually: send the approval email).

### Step 10: Compounding loop

Offer **at most one** brain enrichment based on what's most valuable:

- **Portfolio has strong coverage in this area now** → "You now have 4 case studies in the Sport industry. Worth updating positioning materials to lean into this specialism? Consider `/creativestack:update-voice` or refreshing your agency bio."
- **Case study surfaced an unexpected learning** → "The 'what we didn't expect' section captured something useful. Want me to save it to `learnings.md` for future projects in this category?"
- **Client approval cycle likely to be slow (based on learnings.md § Client Patterns)** → "This client has taken an average of 3 weeks to approve past case studies. Build that into your timeline."
- **No post-mortem for this project** → "The 'what was hard' section is thin. If the project is still fresh, running `/creativestack:post-mortem` would strengthen this case study materially."
- **Awards mode ran** → "The awards version is saved separately. Remember: {award deadline} is in {N days}. Want me to generate the submission checklist?"

One offer. Don't pile on.

### Awards mode (differences from Write)

Ask which award + category + deadline. Run the same extraction but weight Process reveal pattern heavily. Generate long-form only (no multi-length — awards need one submission-ready piece). Include extended individual team credits and a submission requirements checklist. Save to `case-studies/{slug}-awards-{award-name}.md` as a separate file. Approval package still generated.

### Update mode (differences from Write)

Read existing `case-studies/{slug}.md`. Ask "What's new?" (new metric / award / press / client change / correction). Determine version bump: minor (v1.x) for additive, major (v2.0) if the story changes. Update the relevant sections only, preserve the rest, append to version history. Major version regenerates the approval package.

## Output Format

### Extraction Coverage Report
{See Step 4}

### Portfolio Gap Analysis
{See Step 5}

### Narrative Pattern Selection
{See Step 6 — the chosen pattern with reasoning}

### Candidate Client Quotes
{See Step 7 — hero quote suggestion with alternates}

---

### Case Study: {Project Name} — {Client} — v{version}

## 1-Line Credential
> "{single sentence}"

## 1-Paragraph Summary
{60-100 words, 4 sentences}

## 1-Page Case Study

#### Suggested Headlines
1. {Straightforward headline}
2. {Provocative headline}
3. {Metrics-led headline}

#### The Challenge
{From the brief's tension and real objective}

#### The Approach
{Single-minded thought as the central idea; methodology framing if applicable}

#### The Solution
{The work that shipped, referencing the copy deck and deliverables}

#### What Was Hard
{From project state open decisions, sentiment arc dip, post-mortem notes.
Skip if no evidence.}

#### The Results
{Multi-framework metrics from craft-and-framing.md § "Metrics framing"}

> **{Key metric framed in chosen framework}**

> **{Key metric framed in chosen framework}**

#### What We Didn't Expect
{Unexpected outcome, if one emerged. Skip if no evidence.}

#### Pull Quotes
> "{hero quote}" — {attribution}

{Additional pull quotes if available}

#### Tags
{Industry, service type, deliverables}

## Long-Form Case Study
{1200-2000 words — the full version with process reveal, craft detail,
team attribution, client collaboration detail, multiple quotes}

---

### Metrics Framing

{Show the framing decisions — for each metric, the frameworks considered
and the chosen framing with rationale. This is internal working notes
the user can keep or cut.}

| Metric | Raw value | Chosen framing | Framework | Rationale |
|---|---|---|---|---|
| {metric} | {raw} | "{framed}" | {framework} | {why this is strongest} |

---

### Asset Brief

{Generate per `references/craft-and-framing.md` § "The asset brief". Hero image (must-have), supporting images with reasoning, optional video/diagrams, source inventory of what exists vs what to commission.}

---

### Client Approval Package

{Generate per `references/client-approval.md` § "The approval package output". Includes:
- Approval-safe version of the case study (softened "what was hard", smoothed sentiment arc, sensitive metrics removed)
- Draft approval email in agency tone, addressed to client contact from project state
- Sign-off checklist (required + optional + published items)
- Items flagged as sensitive
- Follow-up draft for 2 weeks later}

---

### Brain Overlays Applied

- **From `projects/{slug}-brief.md`:** {specific applications}
- **From `projects/{slug}-meetings.md`:** {N quotes extracted, top 1 selected as hero}
- **From `projects/{slug}-copy-deck-v*.md`:** {final headline, body samples}
- **From `projects/{slug}-competitor-audit.md`:** {category context applied}
- **From `case-studies.md`:** {style matched against N existing case studies}
- **From `methodology.md`:** {Approach structured around named methodology}
- **From upstream skills this session:** {list}

### Written to Brain

- ✓ `case-studies/{slug}.md` — v{version} ({new / updated})
- ✓ `case-studies.md` — portfolio index updated
- ✓ `projects/{slug}.md` — Recent Activity updated
- ✓ `projects/_index.md` — updated

---

## Slack Format

*Case Study: {Project} — {Client} — v{version}*
**Pattern:** {narrative pattern}
**Primary metric:** {framed metric}
**Hero quote:** "{short version}"
**Status:** {draft / in approval / approved / published}
**Next:** {send approval email OR follow up OR publish}

---

## Skill Chains

Pick the most relevant 1-2:

**Upstream:**
- **No brief or meeting log for this project** → "Run `/creativestack:creative-brief` and `/creativestack:meeting-notes` retrospectively if the info is still fresh — they're the #1 sources for the Challenge and client quotes."

**Downstream:**
- **Case study fills an industry gap** → "Run `/creativestack:pitch-research` on prospects in {industry} — the new case study is now in the brain and gets referenced automatically."
- **Case study published** → "Run case-study Update mode when external results come in (press, awards, performance data) to keep it current."

## Edge Cases
- **Project has no brain data** → fall back to pasted inputs. Flag as "minimal brain depth" in frontmatter.
- **Meeting log has no client quotes** → suggest 2-3 paraphrased candidate quotes for client sign-off. Never fabricate direct quotes.
- **NDA restrictions** → produce anonymised version with [Client] placeholders; skip the approval package.
- **The project didn't go well** → use Unexpected outcomes pattern. Flag if nothing publishable surfaces — some projects shouldn't be case studies.
- **Metrics are weak** → lean on qualitative results (retention, recognition, follow-on work). Don't fabricate.
- **Portfolio gap analysis says overrepresented** → surface the nudge, honour the user's call to proceed.

### What this skill can't do

This skill writes from what's in the brain and what you paste. With a
deeper integration, it could pull press mentions automatically, detect
when a project has enough evidence to warrant a case study, and notify
when results come in that should trigger an Update. The brain enables
the extraction layer; automatic monitoring is the remaining frontier.

---
*CreativeStack by Cameron Jones — jones.cam*
