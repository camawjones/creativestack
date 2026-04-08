---
name: rfi-response
description: Parse and respond to RFIs, EOIs, RFPs, framework applications, and design competition entries. Drafts each section from existing case studies, bios, and methodology. Tracks word counts per section, scores compliance against mandatory and weighted requirements, threads win themes through the response, and flags gaps. Use when the user pastes an RFI/EOI/tender document, asks to draft a tender response, or needs to respond to a public sector procurement, framework agreement, or design competition.
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

# /creativestack:rfi-response

> Paste the RFI, get a drafted response with gaps flagged.

## Brain Files
- `profile.md` (for details and positioning)
- `case-studies.md` (for relevant project examples)
- `methodology.md` (for process and approach)
- `team.md` (for bios and expertise)
- `tone-of-voice.md` (for response voice)

## What This Skill Does

Takes an RFI (Request for Information) or EOI (Expression of Interest) document and
drafts responses to each section using your existing case studies, team bios, methodology,
and agency information from the brain. Tracks word counts per section against limits,
scores compliance against mandatory requirements with evaluation weighting, and identifies
which sections can be answered from existing content versus those needing bespoke input.
Saves hours of cut-and-paste while making sure the important sections get proper attention.

## Inputs
- Pasted RFI / EOI document (full or key sections)
- Optional: specific opportunity context
- Optional: which case studies to prioritise
- Optional: word or page limits
- Optional: any mandatory requirements or evaluation criteria

## Conversation Flow

### Step 1: Upstream Skill Check

Before asking anything, scan the current conversation for output from other CreativeStack
skills run earlier. If any are present, auto-populate the relevant data:

| Skill run earlier | What to pull in | Where it appears |
|---|---|---|
| `/creativestack:pitch-research` | Organisation context, stakeholders, strategic priorities, recent news | Understanding section, tailored positioning, win themes |
| `/creativestack:case-study` | Formatted case studies with outcomes and metrics | Case study sections, evidence for claims |
| `/creativestack:competitor-audit` | Competitive positioning, differentiators, white space | Why-us sections, win themes |
| `/creativestack:creative-strategy` | Strategic approach, audience insights | Methodology and approach sections |
| `/creativestack:brief-sharpener` | Sharpened version of the opportunity, ranked questions | Understanding, gap list |

When upstream data is available, tell the user explicitly:
"I can see you ran `/creativestack:pitch-research` earlier — I'll use the organisation
context and stakeholder insights to tailor the response and seed the win themes. You
don't need to repeat that."

Only ask about information that isn't already available from upstream skills.

### Step 2: Brain Check

Read the brain files listed at the top of this skill. Report what was found:
- "I found {n} case studies in your brain — I'll match them against the RFI sections."
- "Your methodology covers {phases} — I'll use this for the approach section."
- "{n} team members in your team file — I'll feature the most relevant for each section."

If `case-studies.md` is empty or sparse, flag it now (not at the end): "Your brain has
no case studies yet. The response will be much weaker without them. You can keep going
and I'll flag every section that needs proof, or pause and run `/creativestack:case-study`
on 2-3 of your strongest projects first."

### Step 3: User pastes the RFI

Ask: "Paste the RFI, EOI, or tender document — full or just the sections you need to
respond to. If it's a long PDF, paste the section list and any mandatory requirements
or scoring criteria."

### Step 4: Parse and classify

Parse the pasted content into a section list. Extract:
- Section titles and what each one is asking for
- Word or page limits per section (if stated)
- Mandatory ("must") requirements
- Evaluation criteria and weightings (if stated)
- Format and submission requirements
- Deadline

Then ask:

1. [SELECT] "What kind of opportunity is this?"
   - Public sector procurement (UK gov, council, NHS, university)
   - Private sector RFP (corporate brand or marketing team)
   - Framework agreement application (DOS, G-Cloud, CCS, etc.)
   - Design competition or pitch invite
   - Simple EOI or capability statement
   - Other

2. [SELECT] "How should I draft against word limits?"
   - Conservative — draft to ~85% of limits, leave room for editing and additions
   - Standard — draft to ~95% of limits (default)
   - Maximum — draft to 100% of limits, push every word for compliance points

3. "Do you know the evaluation criteria or weighting? Paste it if so — this drives
   the priority order I draft in." {If unknown, weight all sections equally and flag
   that asking the issuing body would sharpen the response.}

4. "Any case studies or team members you specifically want to feature?" {Optional —
   defaults to brain matching.}

### Step 5: Identify win themes

Before drafting any section, identify **2-3 win themes** — short, repeatable phrases
that capture why the user is the right fit for *this specific* opportunity. Pull from:
- `profile.md` positioning
- Upstream `/creativestack:pitch-research` or `/creativestack:competitor-audit` output
- The RFI's stated priorities or evaluation criteria

Show the win themes to the user and ask: "These are the win themes I'll thread through
every section. Push back, edit, or add to them before I draft."

Examples of good win themes:
- "Public sector experience without public sector pace" (for a council brief)
- "We've shipped this exact thing before" (for a niche capability ask)
- "Three of our team have worked in your industry" (for a sector-specific brief)

Bad win themes are generic ("we're creative", "we care about quality") — push for
sharper if the user offers these.

### Step 6: Draft

Draft each section using brain content + win themes. **Drafting priority order:**
1. Sections with the highest evaluation weighting first
2. Mandatory requirements next
3. Everything else last

For long RFIs (20+ sections), draft scored/weighted sections in full and provide
**skeleton responses** for the rest — half a paragraph each, clearly marked, with
"Expand if time allows."

Apply word-limit strategy from Step 4. If conservative, draft to ~85%. If standard,
~95%. If maximum, 100% with no buffer.

Match the voice in `tone-of-voice.md`. RFI responses are often the first piece of
writing a buyer reads — voice consistency matters here more than almost anywhere else.

## Output Format

# RFI Response: {Opportunity Name}
**Issuing body:** {organisation}
**Opportunity type:** {public sector / private RFP / framework / competition / EOI}
**Deadline:** {if stated}
**Date:** {today}
**Prepared by:** {agency name from brain}

---

## Win Themes

The 2-3 ideas threaded through every section of this response:

1. **{Win theme 1}** — {one-line explanation of how this maps to the opportunity}
2. **{Win theme 2}** — {explanation}
3. **{Win theme 3 (optional)}** — {explanation}

---

## Response Overview
| Section | Status | Source | Word Count | Limit | Notes |
|---------|--------|--------|-----------|-------|-------|
| {section title} | Drafted / Partial / Needs Input | {brain file(s) used} | {actual} | {limit or "—"} | {notes} |
| {section title} | Drafted / Partial / Needs Input | {brain file(s) used} | {actual} | {limit or "—"} | {notes} |

**Sections fully drafted:** {count}
**Sections needing input:** {count}
**Total word count:** {actual} / {total limit if applicable}

{If any section exceeds its word limit:}
> **Word count warnings:** {X} section(s) over limit — marked with ⚠️ below.

---

## Compliance Tracker

{Cross-reference against mandatory requirements from the RFI. If evaluation weighting
is provided, include it. Score each requirement.}

| # | Mandatory Requirement | Met | Section | Weighting | Evidence |
|---|----------------------|-----|---------|-----------|----------|
| 1 | {requirement from RFI} | {Yes / Partial / No} | {which section addresses it} | {X% if stated} | {brief note on how it's addressed} |
| 2 | {requirement} | {status} | {section} | {weight} | {evidence} |

**Compliance score:** {X}/{total} mandatory requirements met
**Weighted score:** {X}% of available evaluation marks addressed

{If any mandatory requirement is not met:}
> **Critical gaps:** {X} mandatory requirement(s) not fully addressed — see Gaps & Action Items.

---

## Section 1: {Section Title from RFI}
**RFI asks:** {summary of what they want}
**Status:** Drafted / Partial / Needs Input
**Word count:** {actual} / {limit} {⚠️ if over limit}
**Evaluation weight:** {X% if known}

{Drafted response using brain content — written in your voice, tailored to
the opportunity. Cites specific case studies, team members, or methodology as relevant.}

{If over word limit:}
> **Over limit by {X} words.** Suggested cuts: {specific sentences or paragraphs to trim}

{If partial or needs input:}
> **Needs input:** {What's missing — e.g., "This section asks for your approach to
> accessibility testing. Your methodology brain doesn't cover this — draft 150 words
> on your QA/accessibility process."}

---

## Section 2: {Section Title}
...

---

## Case Study Mapping
{Which case studies were used where and why}

| Case Study | Used In Section(s) | Relevance |
|-----------|-------------------|-----------|
| {case study} | {sections} | {why it was chosen} |

## Team Mapping
| Team Member | Featured In | Role Highlighted |
|------------|-------------|-----------------|
| {name} | {section(s)} | {relevant experience} |

## Gaps & Action Items
| Gap | Section | Action Required | Priority | Compliance Impact |
|-----|---------|----------------|----------|-------------------|
| {what's missing} | {section} | {what to write or find} | High / Medium / Low | {mandatory requirement affected, or "none"} |

## Submission Notes
- **Format requirements:** {any format specs from the RFI}
- **Submission method:** {if stated}
- **Deadline:** {if stated}
- **Evaluation criteria:** {if stated, with suggested emphasis}

---

## Slack Format: Response Progress

{Compact single-message summary for sharing progress with the team.}

*RFI: {Opportunity Name} — {Issuing Body}*
**Deadline:** {date}

**Progress: {X}/{total} sections drafted**
**Compliance: {X}/{total} mandatory requirements met**

*Drafted:* {list of section names}
*Needs input:* {list of section names with who/what is needed}
*Over word limit:* {list or "None"}

*Next action:* {most urgent gap}

---

## Skill Chains

### Upstream (what feeds rfi-response)

If upstream skills weren't run but would have strengthened the response, suggest 1-2:

- If no pitch research → "Run `/creativestack:pitch-research` next time to gather context on the issuing organisation before drafting — it sharpens the win themes considerably."
- If case studies are sparse → "Run `/creativestack:case-study` on your 2-3 strongest relevant projects before finalising — the response is much stronger with proof."
- If no competitor view → "Run `/creativestack:competitor-audit` to sharpen the differentiators in the why-us sections."
- If the brief itself is messy → "Run `/creativestack:brief-sharpener` first to clarify what the opportunity is really asking for."

### Downstream (what rfi-response triggers)

Based on the response, suggest the most relevant next action:

- If shortlisted → "Run `/creativestack:creative-strategy` to build the strategic spine for the pitch stage."
- If shortlisted and the pitch is imminent → "Run `/creativestack:proposal-generator` to convert this into a formal proposal."
- After submission (win or lose) → "Run `/creativestack:post-mortem` once you hear back to capture what worked — it'll feed `learnings.md` and improve the next response."

Only suggest 1-2 chains — pick the most relevant for where the user is in the cycle.

## Edge Cases
- **Very long RFI (20+ sections)** → prioritise scored/weighted sections in full, skeleton responses for the rest, clearly marked.
- **Brain has no relevant case studies** → flag clearly at Step 2 (not at the end), suggest pausing to run `/creativestack:case-study` on 2-3 projects first.
- **RFI requires specific certifications or accreditations** (ISO 27001, Cyber Essentials, etc.) → flag if not found in brain. Don't fabricate.
- **Consortium or partnership bid** → ask which partner is leading, adjust pronouns for "we" vs "our partner" throughout.
- **RFI asks for pricing or day rates** → flag that pricing needs commercial input. Don't guess. Suggest a placeholder block with "[Commercial team to confirm]".
- **No evaluation criteria provided** → recommend asking the issuing body. Weight sections equally in the interim and flag this assumption in the response overview.
- **Public sector procurement** (UK gov, NHS, council, university) → flag if response needs to follow a specific template (Crown Commercial Service, DOS, G-Cloud frameworks have rigid structures). Don't restructure their template.
- **Word limits very tight** → default to conservative drafting (~85%) regardless of the chosen strategy, and warn the user.
- **Mandatory requirement can't be met** → mark it clearly in the compliance tracker as a deal-breaker. Tell the user before drafting the rest of the response — sometimes the right call is not to bid.
- **Design competition** → tone shifts toward creative ambition over compliance. Win themes matter more than checklist completeness.

### What this skill can't do

This skill drafts from your current brain content and the pasted RFI. With a deeper
brain — including a library of past RFI responses with win/loss data — it could
auto-populate boilerplate sections that have already scored well, learn which answers
landed for which buyer types, track win rates by response approach, and maintain a
reusable answer library that improves with every submission. For now, every response
is drafted fresh; consider pasting good past answers into `methodology.md` or
`case-studies.md` so the brain accumulates them over time.

---
*CreativeStack by Cameron Jones — jones.cam*
