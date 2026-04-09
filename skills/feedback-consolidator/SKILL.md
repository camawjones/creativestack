---
name: feedback-consolidator
description: Brain-first feedback intelligence for creative agencies. Three modes — Translate (single vague feedback → creative direction using this client's own vocabulary), Consolidate (multi-round → deduplicated action list with 8-archetype detection, priced round cost, real-ask methodology, stakeholder map), Respond (draft the client-facing reply in agency tone of voice). Detects 8 creative-industry feedback archetypes (Swerve, Committee, Compound Notes, Ego Note, Safe Retreat, Bait & Switch, Relitigation, Preference vs Principle) with specific response playbooks. Persists per-client vocabulary, archetype history, and stakeholder memory in learnings.md § Feedback so every round gets sharper.
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

# /feedback-consolidator

> Turn scattered feedback into action. Detect the archetype. Draft the reply. Learn this client's language over time.

## What This Skill Does

Most feedback tools treat client feedback as a data consolidation problem.
Creative feedback is a **human-judgment problem with known patterns**. This
skill acts as a feedback intelligence brain:

1. **Learns each client's vocabulary** — when Marcus says "bold" he means
   "brand-confident", not "louder." Saved to `learnings.md § Feedback` and
   applied automatically in future rounds.
2. **Detects 8 feedback archetypes** — Swerve, Committee, Compound Notes,
   Ego Note, Safe Retreat, Bait & Switch, Relitigation, Preference vs
   Principle. Each has a specific playbook for responding correctly rather
   than reactively.
3. **Prices every round** — uses `rate-card.md` to convert "make the
   headlines bigger" into "£1,800 of senior design time." Flags when a round
   exceeds the SOW revision cap.
4. **Finds the real ask** — applies the 3-signal methodology (what they
   return to, what they agree on silently, what they're avoiding) to surface
   the underlying concern the client keeps circling but hasn't stated.
5. **Maps stakeholders across projects** — the Influence Map persists per
   client, so "Marcus is the decision-maker, Priya is the craft lead" is
   known from round 1 of the next project.
6. **Drafts the client response** in the agency's tone of voice, matched
   to the detected archetype. Closes the loop most feedback tools leave open.
7. **Compounds value** — every run offers one brain enrichment. Three runs
   per client in and the skill catches things only an experienced PM would.

## Brain Files
- `learnings.md § Feedback` — **the feedback DNA**: per-client vocabulary, archetype history, stakeholder memory (this skill creates and maintains it)
- `methodology.md` — for framing the Creative Team Brief in the agency's methodology language
- `rate-card.md` — to price revision rounds in £ (requires `/project-profitability` Setup rates first)
- `tone-of-voice.md` — for Respond mode drafts
- `projects/{slug}.md` — project state, brief content, revision cap from SOW
- `projects/{slug}-meetings.md` — past meetings on this project for cross-reference and archetype detection
- `clients.md` — client relationship history

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant:

- **`references/archetypes.md`** — read in Consolidate mode to run archetype detection. The 8 archetypes with detection signals and response playbooks. Also read in Translate mode if the feedback looks archetypal.
- **`references/translation-and-real-ask.md`** — read in Translate mode for vague phrase translation using client vocab, and in Consolidate mode for the 3-signal real ask methodology.
- **`references/brain-feedback-schema.md`** — read whenever writing to `learnings.md § Feedback`. Schemas for Vocabulary, Archetypes, and Stakeholder Memory subsections.
- **`references/response-drafting.md`** — read in Respond mode only. Response archetypes, drafting rules, tone application.

## Conversation Flow

### Step 1: Brain check & mode selection

Run brain discovery. Check specifically:

```bash
[ -f "$HOME/.creativestack/learnings.md" ] && grep -q "## Feedback" "$HOME/.creativestack/learnings.md" && echo "FEEDBACK_LEARNINGS_EXIST" || echo "NO_FEEDBACK_LEARNINGS"
[ -f "$HOME/.creativestack/rate-card.md" ] && echo "RATE_CARD_EXISTS" || echo "NO_RATE_CARD"
```

[SELECT] "What do you need?"
- Consolidate — multi-round or multi-source feedback (default)
- Translate — single piece of vague feedback
- Respond — draft a client reply from recent feedback analysis

**Auto-detection:** If the user pastes feedback without picking a mode:
- Single short piece of vague feedback → default to Translate
- Multiple sources, multiple rounds, or structured feedback → default to Consolidate
- Respond is never auto-picked — always explicit

**Routing:**
- If the user picks Respond but there's no recent Translate/Consolidate output in the session → "I need a feedback analysis to draft from. Paste the feedback first and I'll consolidate, then draft the response."

### Step 2: Upstream skill check

Scan the conversation for output from earlier skills:

| Skill run earlier | What to pull in | How it's used |
|---|---|---|
| `/creative-brief` | Objectives, deliverables, constraints, key message | Contradiction detection against the brief |
| `/meeting-notes` | Decisions, actions, client patterns already captured | Cross-reference decisions; avoid re-surfacing things already addressed |
| `/sow-generator` | Revision cap, payment milestones | Revision cap check |
| `/project-profitability` | Rate card, current margin status | Price the round in £ |

### Step 3: MCP context enrichment

**Gmail MCP** — check for `mcp__claude_ai_Gmail__*` tools.

If available and the user mentions feedback sitting in email:
- Offer: "Want me to pull the feedback threads? Give me the client name or subject."
- Use `gmail_search_messages` and `gmail_read_thread` to fetch
- Tell the user what was pulled

If not available, skip silently.

### Step 4: Receive feedback

User pastes the feedback. Accept any format (email, Slack thread, meeting
notes, marked-up PDF transcribed, scribbled notes). Don't force a structure.

### Step 5: Clarifying questions

Ask only what isn't already known:

- Round number — skip if derivable from project state or past meetings log
- [SELECT] "How urgent?" — Today / This week / No rush
- Source attribution — skip if already clear from the pasted content

If Translate mode and no brief in scope → ask "What's the original creative
direction or brief?" once.

If Consolidate mode → ask "Single decision-maker, or should I map
stakeholder influence?" — skip if brain already has a stakeholder map for
this client.

### Step 6: Read brain feedback context

Before processing, read `learnings.md § Feedback` for this client (filter by
client name from project state or user input). Load:
- Vocabulary for this client (and specific speakers if attributable)
- Archetype history
- Stakeholder memory

This is what makes the output specific to *this* client, not generic.

### Step 7: Process

**Translate mode:**
1. Read `references/translation-and-real-ask.md` § "Part 1: Translation"
2. Apply client vocab first, fall back to generic patterns
3. Contextualise against the brief
4. Generate clarifying questions for Low-confidence translations
5. Draft the Creative Team Brief using `methodology.md` language

**Consolidate mode:**
1. Parse the feedback items from all sources
2. Read `references/archetypes.md` and run archetype detection
3. Read `references/translation-and-real-ask.md` § "Part 2: The Real Ask" — apply 3-signal methodology if 2+ rounds exist
4. Cross-reference each item against the brief (contradiction detection)
5. Cross-reference against past meetings and past rounds (scope creep, recurring items)
6. Price the round using `rate-card.md` if available
7. Check against SOW revision cap
8. Build or update the Stakeholder Influence Map using `learnings.md § Feedback` Stakeholder Memory
9. Assemble output

**Respond mode:**
1. Read `references/response-drafting.md`
2. Identify which response archetype fits based on the preceding analysis
3. Read `tone-of-voice.md` for voice
4. Draft the response with alternate openings

### Step 8: Write to project state

Update `projects/{slug}.md`:
- **Open Decisions** — append unresolved feedback questions
- **Risks** — add flags for detected archetypes, scope creep, revision cap
- **Engagement Health** — append if sentiment shifted
- **Recent Activity** — append `YYYY-MM-DD — feedback-consolidator — round {N}, {archetype if detected}, {N items} → {N actions}`
- **Frontmatter** — update `last_updated`

### Step 9: Compounding loop

Offer **at most one** brain enrichment. Pick the most valuable:

- **New vocabulary term detected (2+ instances)** → "I noticed Marcus used 'bold' to mean 'brand-confident' again. This is 2 instances — want me to save it as a Nike vocab entry? Future translations will use his meaning automatically."
- **Archetype repeated for this client** → "This is Nike's 3rd Committee archetype. Want me to refine the playbook based on what worked this time?"
- **Stakeholder pattern emerging (3+ rounds)** → "Priya's feedback style is consistent across 3 rounds — want me to save a Stakeholder Memory entry?"
- **No rate-card and cost priceable** → "I couldn't price this round — no rate card. Want to set one up via /project-profitability? Future rounds will be priced automatically."
- **Revision cap exceeded** → "This round puts you at {N} rounds vs {M} in the SOW. Want me to flag this as a risk in the project state?"

One offer. Don't pile on.

## Output Format — Translate mode

```markdown
# Feedback Translation: {Project}

## What the client said
{Verbatim, attributed where possible}

## Client vocab applied
{If learnings.md § Feedback had matches for this client, list which translations were applied. If not, note "no saved vocab for this client — using generic patterns."}

## What they probably mean

| Client said | Possible meaning | Confidence | Source |
|---|---|---|---|
| {phrase} | {translation} | {High/Med/Low} | {Vocab entry / generic pattern / context-derived} |

## Contradictions with the brief

{Only if contradictions exist. Reference specific brief sections. Skip the section if nothing found.}

## Clarifying questions for the client

{Only for Low-confidence translations. Each question proposes a specific interpretation for yes/no.}

1. {Question}
2. {Question}

## Creative Team Brief

**The feedback in one sentence:** {synthesis}

**What it means for the work:**
{2-3 sentences in the agency's methodology language — not a bullet list}

**Do:**
- {Specific action tied to a principle}

**Don't:**
- {Specific action to avoid}

**Open for exploration:**
- {Where the team has freedom}

**Blocked on client clarification:**
- {Items waiting on answers to the clarifying questions}
```

## Output Format — Consolidate mode

Sections in order (the consolidation output spine):

1. **Header** — project, round (N of cap from SOW), sources, brain depth
2. **⚡ Top-level findings** — 1-3 bullets, lead with the highest-priority issue (usually an archetype detection, revision cap breach, or major contradiction)
3. **Archetypes detected** — top 1-2 from `references/archetypes.md` with detection signals (quoted), severity, this client's archetype history from `learnings.md § Feedback`, and the response playbook adapted to this client
4. **The real ask** — only if 2+ rounds exist. Apply the 3-signal methodology (return / agreement / avoidance) from `references/translation-and-real-ask.md`. Synthesis paragraph + specific next step.
5. **Round cost (priced)** — table using `rate-card.md`, total round cost, revision cap status. Skip if no rate-card. Bold if cap exceeded.
6. **Summary** — counts (total / actionable / needs clarification / contradictions / scope additions)
7. **Pattern analysis** — recurring themes and recurring items (scope creep candidates) tables
8. **Stakeholder Influence Map** — table loaded from `learnings.md § Feedback Stakeholder Memory` if available, otherwise built fresh and offered to save
9. **By Asset / Deliverable** — per-asset breakdown with Agreed actions / Contradictions / Already approved (Relitigation guard) / Questions for client
10. **Scope creep detection** — table separating refinement from expansion, with cost
11. **Creative Team Brief** — distilled "what to act on first / defer / protect" sections
12. **Recommended next steps** — 2 specific actions

For full detail on each section's content and the scoring rules, see `references/archetypes.md` and `references/translation-and-real-ask.md`.

## Output Format — Respond mode

Strict format from `references/response-drafting.md` § "Output format". Always
include the drafted response + alternate openings + edit suggestions.

---

## Slack Format

For Consolidate:

*Feedback: {Project} — Round {N}*
**Archetype:** {detected archetype or "none"}
**Round cost:** {£range if priceable, or "—"}
**Items:** {total} ({actionable} actionable, {contradictions} contradictions)
**Real ask:** {1 sentence or "—"}
**Top action:** {1 sentence from recommended next steps}
**Needs client:** {1-2 items blocked on clarification}

For Translate:

*Translate: {Project} — {speaker}*
**They said:** "{phrase}"
**Likely meaning:** {best translation}
**Ask:** {single clarifying question to send back}

---

## Skill Chains

Pick the most relevant 1-2:

**Upstream:**
- **No brief or rate card** → "Run `/creative-brief` for contradiction detection and `/project-profitability` Setup rates for round cost pricing."

**Downstream:**
- **Swerve / contradictions detected OR revision cap exceeded** → "Run `/meeting-notes` Pre-meeting mode and flag in `/status-update` — this round needs a live conversation, not more async, and leadership should know."
- **Scope creep detected** → "Run `/project-profitability` to model the impact on margin."

## Edge Cases
- **Feedback is already specific** → organise rather than translate; skip the translation section
- **Single round only** → skip real ask (needs 2+ rounds); focus on Translate + archetype detection
- **Very vague ("I don't like it")** → flag for clarification, generate specific questions. Don't pretend to translate without signal.
- **Feedback contradicts saved vocab** → flag the discrepancy: "Marcus used 'bold' in a new way today. Update the entry?" Never silently override.
- **Respond mode invoked without preceding analysis** → refuse, route to Consolidate or Translate first
- **Archetype detection conflicts with user's read** → surface the signals, let the user decide. Don't argue.

### What this skill can't do

This skill processes the feedback you provide. With deeper integration, it
could watch feedback arrive in real time (email, Slack, Figma comments),
auto-detect archetypes as rounds happen, and proactively flag clients who
are about to blow revision caps. The brain provides the vocabulary and
archetype memory; deeper integrations unlock the real-time layer.

---
*CreativeStack by Cameron Jones — jones.cam*
