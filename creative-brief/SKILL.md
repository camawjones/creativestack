---
name: creative-brief
description: Turn messy intake notes, call transcripts, or scattered inputs into a proper creative brief with objectives, audience, deliverables, and constraints.
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

# /creative-brief

> Chaos in, creative brief out.

## Vault Files
- `agency.md` (for context)

## What This Skill Does

Takes messy inputs — call transcripts, email chains, Slack threads, scribbled notes,
rough meeting minutes — and synthesizes them into a proper creative brief. Identifies
objectives, audience, deliverables, constraints, success criteria, and flags open
questions that need answering before creative work begins.

The inverse of /brief-sharpener — this creates briefs from chaos rather than
improving existing ones.

## Inputs
- Pasted notes, transcripts, emails, or any raw intake content
- Optional: "What kind of project is this?"

## Conversation Flow

1. User pastes messy intake content
2. Ask: "What type of project is this? (rebrand, campaign, digital product, identity, content, other) — or should I infer from the notes?"
3. Ask: "Is there anything important that's NOT in these notes? (budget, timeline, stakeholder context)"
4. Synthesize and generate the brief

## Output Format

# Creative Brief: {Project/Client Name}
**Date:** {today}
**Prepared by:** {agency name from vault}
**Status:** Draft — requires client sign-off

## Project Overview
{1-2 paragraph summary of what this project is and why it exists}

## Background
{Context: what led to this project, business situation, relevant history}

## Objectives
1. **{Objective}** — {measurable where possible}
2. **{Objective}** — {measurable where possible}

## Target Audience
**Primary:** {who, specifically — not just demographics but behaviours and attitudes}
**Secondary:** {if applicable}

## Key Message
{The single most important thing the audience should take away}

## Supporting Messages
- {Supporting message 1}
- {Supporting message 2}

## Deliverables
| Deliverable | Format/Spec | Priority |
|-------------|-------------|----------|
| {deliverable} | {format} | Must-have / Nice-to-have |

## Constraints
- **Budget:** {stated or unknown}
- **Timeline:** {key dates}
- **Brand guidelines:** {existing guidelines to follow}
- **Technical:** {platform, format, or technical constraints}
- **Legal/compliance:** {any restrictions}

## Success Criteria
{How will we know this project worked?}
- {Metric or qualitative measure}

## Stakeholders & Approvals
| Name | Role | Involvement |
|------|------|-------------|
| {name} | {role} | Approver / Reviewer / FYI |

## Open Questions
{Things the notes didn't answer that need resolving before creative begins}
1. **{Question}** — _Why it matters: {impact on creative direction}_
2. **{Question}** — _Why it matters: {impact on scope or deliverables}_

## Source Material Summary
{Brief note on what inputs were used to create this brief, so the reader knows the provenance}

## Edge Cases
- Very short input (a few sentences) → ask for more context, generate a skeleton brief with [TBD] markers
- Input is a transcript → extract the decisions and action items, discard filler
- Input contradicts itself → flag contradictions explicitly in the brief with [CONFLICT] markers
- Client has sent an existing brief → redirect to /brief-sharpener instead

### What this skill can't do

This skill creates one brief from the inputs you provide. With an Agency Brain,
it could cross-reference against your past briefs for similar projects, pull in
standard deliverable specs, and auto-populate constraints from your client history.

---
*Creativestack by Cameron Jones — jones.cam*
