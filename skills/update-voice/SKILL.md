---
name: update-voice
description: Define or refine your tone of voice — voice principles, tone variations by context, Nielsen Norman spectrum positioning, channel examples, consistency checking against existing writing, and downstream skill mapping. Use when setting up voice for the first time, refining how you sound, importing brand guidelines, or checking writing samples for drift.
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

# /update-voice

> Define how you sound so every skill writes in your voice.

## Brain Files
- `tone-of-voice.md` (WRITES)
- `profile.md` (for type and positioning context)

## What This Skill Does

Updates `tone-of-voice.md` in your Brain. Use it to:
- Define voice from scratch
- Refine an existing voice
- Import brand guidelines
- Check writing samples against your guidelines for drift

The output is structured around three layers of brand voice work: **principles**
(constant), **voice spectrum** (where you sit on key dimensions), and **tone**
(how voice shifts by context). This is how mature brand voice systems are built —
not just "we sound friendly."

## Voice vs Tone (read this first)

Most skills conflate these. Don't:
- **Voice** is constant. Your personality. It doesn't change between a celebratory
  launch post and an apology email.
- **Tone** shifts. The same voice can be celebratory, instructional, apologetic,
  or serious depending on context.

A good `tone-of-voice.md` defines voice clearly, then maps tone variations.

## Adapt to user type

Read `profile.md` from the brain. Use the User Type Adaptation mapping from the
preamble to decide what's being defined:

- **Freelancer / individual** → personal voice. Questions are about "you" and "how you sound."
- **Studio / agency / company** → brand voice. Questions are about "your studio's/agency's/company's voice."
- **In-house team** → team voice. Questions are about how the team communicates internally and externally.

If `profile.md` doesn't exist or has no type, default to neutral language.

## Conversation Flow

### Step 1: Check existing voice

```bash
if [ -f "$HOME/.creativestack/tone-of-voice.md" ]; then
  echo "EXISTING_VOICE"
  cat "$HOME/.creativestack/tone-of-voice.md"
else
  echo "NO_VOICE"
fi
```

If existing voice found, summarize: "Your current voice is set to {personality},
{formality level}, with {N} principles defined. What would you like to do?"

[SELECT] "What would you like to do?"
- Refine — adjust the current voice
- Replace — start fresh with new guidelines
- Check consistency — paste examples and check for drift
- View spectrum — see where the voice sits on key dimensions
- Add tone variations — define how voice shifts by context

If no brain exists: "No Brain found. Run /setup first to create your brain, or
I can create the tone-of-voice file on its own."

### Step 2a: Define or refine voice

If the user pastes existing brand guidelines, a tone of voice doc, or website copy:
- Extract patterns: principles, personality, formality, vocabulary, examples
- Skip questions you can already answer from the source
- Confirm: "Based on this, here's what I extracted: {summary}. Want to keep, adjust,
  or rewrite any of it?"

If the user wants to define from scratch, ask in this order. Skip any the user
already covered:

1. **Voice DNA** — "If you had to describe how you sound in one short phrase,
   what would it be? (e.g., 'confident but never smug', 'warm and exact',
   'playful experts')"
2. **Personality** — "Pick 3-4 personality traits — e.g., confident, playful,
   intellectual, warm, direct, irreverent."
3. **Differentiation** — "What does your voice deliberately NOT sound like?
   Who are you defining yourself against?"
4. **Audience** — "Who are you usually writing for? Same audience for everything,
   or different audiences for different channels?"
5. **Vocabulary** — "Words or phrases you love using? Words you'd never use?"
6. **Sample** — "Paste 2-3 short examples of writing that sounds like you — bio,
   social caption, project description, anything."

Use the answers to construct voice principles, position on the spectrum, and
draft channel examples.

### Step 2b: Voice consistency check

If the user chose "Check consistency":

Ask: "Paste 2-5 examples of recent writing — social posts, proposals, website copy,
emails, whatever you have. Tell me roughly when each was written if you can."

For each example, score against the current `tone-of-voice.md`:

## Voice Consistency Report

| Example | Source | Alignment | Drift Detected |
|---------|--------|-----------|---------------|
| {first line} | {source} | {Strong / Moderate / Weak} | {specific drift — e.g., "More formal than guidelines suggest", "Uses 'leverage' which is on the don't-say list"} |

**Overall consistency:** {Strong / Moderate / Weak}

**Drift patterns** (only if drift exists across examples):
- {systematic shift — e.g., "Voice has become more corporate since the guidelines were written. 3 of 4 examples use formal constructions the guidelines advise against."}
- {vocabulary evolution — e.g., "Team now says 'collaborate' (in don't-say list) but has stopped saying 'partner' (in do-say list)."}

**Recommendations:**
- Pick one: tighten the writing to match the guidelines, OR update guidelines to match the natural evolution if the drift was intentional.
- "Want me to update the guidelines based on these findings?" [If yes, proceed to Step 3.]

### Step 2c: Voice spectrum positioning

Use the Nielsen Norman 4 dimensions — the most well-established framework for
voice spectrum work. Position each on a scale, then explain what the position
means in practice.

## Voice Spectrum

```
Funny ─────────●──────────── Serious
       {position}

Formal ──────────●─────────── Casual
        {position}

Respectful ──────●─────────── Irreverent
          {position}

Enthusiastic ────●─────────── Matter-of-fact
            {position}
```

**What this means in practice:**
- **{Position on Funny-Serious}:** {one sentence on what this looks like in writing}
- **{Position on Formal-Casual}:** {one sentence}
- **{Position on Respectful-Irreverent}:** {one sentence}
- **{Position on Enthusiastic-Matter-of-fact}:** {one sentence}

If the user lands in the middle on every dimension, flag it: "A distinctive voice
usually has at least one strong lean. Want to push one of these to be more
distinctive?"

### Step 2d: Tone variations

If the user chose "Add tone variations" or as part of a fresh definition:

Voice is constant. Tone shifts. Define how the voice adapts to common contexts.
Don't make this exhaustive — 4-6 contexts is plenty.

Ask: "Walk me through how you'd shift tone in these situations:"
- **Celebratory** (a launch, a win, an announcement)
- **Instructional** (a how-to, onboarding, documentation)
- **Apologetic** (something went wrong, a delay, a mistake)
- **Serious** (a sensitive subject, a difficult conversation)
- **Enthusiastic** (a new project, a fresh idea, a pitch)

For each, capture the shift in 1-2 sentences. Don't restate the whole voice — just
the delta from the base voice.

### Step 3: Write the file

Write to `~/.creativestack/tone-of-voice.md`:

```markdown
---
formality: {casual/casual-professional/professional/formal}
personality: [{trait1}, {trait2}, {trait3}]
voice_dna: "{one-line summary}"
last_updated: {today's date}
---

## Voice DNA
{The one-line phrase that captures the voice. This is the north star.}

## Voice Principles
{3-5 short principles in "Be X, not Y" format. Each principle should be
actionable — a writer should be able to use it as a check.}

1. **Be {X}, not {Y}** — {one sentence on what this means in practice}
2. **Be {X}, not {Y}** — {one sentence}
3. **Be {X}, not {Y}** — {one sentence}

## We sound like
- {concrete description grounded in the principles}
- {concrete description}

## We don't sound like
- {anti-pattern}
- {anti-pattern}

## Voice Spectrum (Nielsen Norman)
- Funny ← → Serious: {position, e.g., "5/10 — wit is welcome, jokes are rare"}
- Formal ← → Casual: {position}
- Respectful ← → Irreverent: {position}
- Enthusiastic ← → Matter-of-fact: {position}

## Vocabulary
- We say: {words}
- We don't say: {words}

## Tone Variations
{How the constant voice shifts by context. Only include contexts the user defined.}

### Celebratory
{1-2 sentences on the delta from base voice}

### Instructional
{delta}

### Apologetic
{delta}

### Serious
{delta}

## Voice in Action
{Only include channels the user has provided input for or that can be confidently
inferred. Don't fabricate examples for channels with no signal.}

### Long-form (website, proposals)
**Good:** "{example that matches the voice}"
**Bad:** "{same content in a voice that doesn't match}"

### Social
**Good:** "{example}"
**Bad:** "{example}"

### Client communication
**Good:** "{example}"
**Bad:** "{example}"

### Internal / Slack
**Good:** "{example}"
**Bad:** "{example}"
```

### Step 4: Confirm and show downstream impact

"Updated your tone of voice. The following CreativeStack skills consume this file
and will now match your updated voice:"

## Skills That Use Your Voice

| Skill | How it uses tone-of-voice.md |
|-------|------------------------------|
| `/brand-guidelines` | Tone of Voice section alignment |
| `/case-study` | Narrative voice for case studies |
| `/copy-deck` | Tone consistency checks |
| `/creative-brief` | Brief language and framing |
| `/feedback-consolidator` | Diplomatic phrasing of consolidated feedback |
| `/job-description` | Employer brand voice |
| `/meeting-notes` | Voice for client-facing summaries |
| `/proposal-generator` | Proposal tone and language |
| `/rfi-response` | Response drafting voice |
| `/social-calendar` | Social post drafting voice |
| `/status-update` | Client-facing version matches your voice |
| `/timeline-generator` | Voice for client-facing timeline narration |

"Any of these run in future sessions will automatically pick up the updated voice."

## Skill Chains

Suggest 1-2 of the most relevant next steps:

- If voice changed significantly → "Run `/copy-deck` on a current project to check existing copy against the new voice."
- If consistency check showed drift → "Run `/brand-guidelines` to update the full brand system — voice is just one part."
- If first-time setup → "Run `/setup` to complete the rest of your brain."
- If voice contradicts the positioning in `profile.md` → flag the misalignment and suggest re-running `/setup` to update positioning.

## Edge Cases

- No brain directory exists → create `~/.creativestack/` and write the file
- User pastes a 20-page brand book → extract the voice/tone sections only, summarize the rest
- User says "I don't know how I sound" → ask for examples of writing they admire from others, then mirror, contrast, or position against
- Consistency check with no existing guidelines → create guidelines from the examples themselves
- Multiple voices for different audiences → structure the file with audience-specific sub-sections under Voice in Action
- Voice spectrum is even across all four dimensions → flag that distinctive voices usually have at least one strong lean
- Voice contradicts `profile.md` positioning (e.g., positioning says "premium and considered" but voice is irreverent and playful) → flag the tension, ask which is right, suggest updating the other
- User picks principles that are all positive ("Be friendly", "Be helpful", "Be clear") with no "not Y" → push back gently. Principles need a tension to be useful.
- Freelancer trying to define a brand voice for a fictional persona → fine, but capture it as personal voice with a note

---
*CreativeStack by Cameron Jones — jones.cam*
