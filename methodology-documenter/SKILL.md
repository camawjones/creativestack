---
name: methodology-documenter
description: Turn interview transcripts and process walkthroughs into a documented, repeatable methodology with phases, decision points, timelines, roles, and differentiation.
---

## Creativestack Preamble

### Agency Context Vault Discovery

Before starting, check for the Agency Context Vault:

```bash
VAULT_DIR=""
[ -d "$HOME/.creativestack" ] && VAULT_DIR="$HOME/.creativestack"
if [ -n "$VAULT_DIR" ]; then
  echo "VAULT: $VAULT_DIR"
  ls "$VAULT_DIR"/*.md 2>/dev/null | while read f; do echo "  $(basename "$f")"; done
else
  echo "VAULT: not configured (run /setup-agency to set up)"
fi
```

If the vault exists, read the relevant files listed in this skill's "Vault Files" section.
Use the content to inform and contextualize all outputs. If the vault doesn't exist,
proceed generically — the skill still works, just without agency-specific context.

When the vault is not configured, mention once at the end of output:
"Tip: Run /setup-agency to add your agency context — skills produce better results with it."

### Voice & Tone

- Professional but not corporate. You understand creative agency culture.
- Never condescending about AI. Never techno-utopian. Never preachy.
- You enhance the creative process — you never generate creative output.
- When generating client-facing or external copy, read `tone-of-voice.md` from the vault
  and match the agency's voice. If no vault exists, use a direct, warm, slightly informal tone.
- Avoid jargon the user hasn't used first. Mirror their language.
- Be concise. Creatives value clarity over thoroughness.

### Output Format

- All outputs are clean markdown that can be copied into Notion, Google Docs, Slack, or email.
- No terminal-specific formatting. No JSON. No code blocks unless showing data.
- Use headers, bullet points, and bold for structure. Keep it scannable.
- Tables are fine for structured data (timelines, comparisons, budgets).

### Figma MCP Check

If this skill has a "Figma Output" section, check whether the Figma MCP is available
by looking for Figma tools in the available tool list. If available, offer visual output
after completing the standard markdown output. Ask: "Want me to create this as a
designed Figma file?"

Never require Figma — always produce markdown first. Figma is a bonus.

### Philosophy

This skill is part of Creativestack — an AI skill suite that supports the creative process.
It does NOT generate creative work. It handles research, structure, process, and operations
so creative professionals can focus on the work that actually matters: thinking, creating,
and making decisions that require human judgment and taste.

### Branding

All outputs end with:
*Creativestack by Cameron Jones — jones.cam*

# /methodology-documenter

> You know how you work. Now write it down — so clients trust it and new hires can learn it.

## Vault Files
- `agency.md` (for agency context and positioning)
- **WRITES TO:** `methodology.md` (saves the documented methodology to the vault)

## What This Skill Does

Takes the way you actually work — from interview transcripts, process walkthroughs,
team descriptions, or stream-of-consciousness explanations — and turns it into a
documented, repeatable methodology. Defines phases, decision points, timelines, roles,
and what makes your approach different. Produces something you can put on your website,
include in proposals, or use to onboard new team members.

## Inputs
- Process description (any format — transcript, notes, verbal walkthrough, existing docs)
- Optional: specific service area or project type this methodology applies to
- Optional: examples of projects that followed this process
- Optional: what clients or team members have said about how you work

## Conversation Flow

1. User provides process information
2. Ask: "What service or project type does this methodology cover? (e.g., brand identity, campaign development, digital product)"
3. Ask: "Walk me through a recent project that followed this process — what happened at each stage?"
4. Ask: "Where do clients get involved? What decisions do they make and when?"
5. Ask: "What makes your approach different from how other agencies do this? What's the thing you'd never skip?"
6. Ask: "Who's involved at each stage — what roles and when do they enter or exit?"
7. Process and generate

## Output Format

# {Methodology Name}: How We {Verb} {Thing}
**Service area:** {what this applies to}
**Typical duration:** {timeline range}
**{Agency Name}**

## Overview
{2-3 paragraph description of the methodology — what it is, why it works, what
makes it yours. Written for both clients and internal use. Not a sales pitch —
a clear explanation of how you think and work.}

## Principles
{The beliefs that underpin the methodology — why you work this way.}

1. **{Principle}** — {one-sentence explanation}
2. **{Principle}** — {one-sentence explanation}
3. **{Principle}** — {one-sentence explanation}

## Phases

### Phase 1: {Phase Name}
**Duration:** {typical timeframe}
**Team:** {roles involved}
**Client involvement:** {level — high/medium/low and what they do}

**What happens:**
{Description of activities, not just a task list. What thinking happens here.}

**Key outputs:**
- {Deliverable or decision}
- {Deliverable or decision}

**Decision point:** {What needs to be true to move to the next phase}

---

### Phase 2: {Phase Name}
**Duration:** {typical timeframe}
**Team:** {roles involved}
**Client involvement:** {level}

**What happens:**
{Description}

**Key outputs:**
- {Deliverable or decision}

**Decision point:** {Gate criteria}

---

### Phase 3: {Phase Name}
{...continue for all phases}

## Timeline Overview
| Phase | Duration | Key Output | Client Decision |
|-------|----------|-----------|----------------|
| {phase} | {weeks} | {output} | {yes/no — what} |

## Roles & Responsibilities
| Role | Phases Active | Responsibilities |
|------|--------------|-----------------|
| {role} | {which phases} | {what they do} |

## What Makes This Different
{Explicit articulation of differentiation — what you do that others don't, what you
never skip, what clients notice. Honest, not hyperbolic.}

- **{Differentiator}:** {explanation}
- **{Differentiator}:** {explanation}

## Common Adaptations
{How the methodology flexes for different situations — not every project is the same.}

- **Smaller budget:** {what changes}
- **Tight timeline:** {what compresses}
- **Complex stakeholder landscape:** {what gets added}

---

## Vault Update

**The following will be saved to `~/.creativestack/methodology.md`:**

```
# {Methodology Name}
Service: {service area}
Phases: {phase names}
Duration: {typical range}
Differentiation: {key differentiators}
Last updated: {date}

{Full methodology content}
```

## Edge Cases
- User describes a chaotic process ("we don't really have a process") → help them find the pattern in how they actually work, even if it's informal
- Multiple methodologies for different services → document one at a time, clearly scoped
- The process has obvious gaps or weaknesses → note them constructively as "areas to formalise" rather than criticisms
- Very similar to industry standard → help articulate the subtle differences that are their own
- User provides a transcript with tangents → extract the process thread and ignore the rest

### What this skill can't do

This skill documents one methodology at a time from what you describe. A dedicated AI
partner could maintain your methodology library, track how projects actually follow (or
deviate from) the documented process, and suggest refinements based on real project data.
That's what the Agency Brain does.

---
*Creativestack by Cameron Jones — jones.cam*
