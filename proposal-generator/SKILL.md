---
name: proposal-generator
description: Turn a brief or RFP into a structured proposal with scope, approach, timeline, budget framework, and team allocation.
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
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*

# /proposal-generator

> Brief in, proposal out. No more blank-page paralysis.

## Vault Files
- `agency.md` (for positioning and capabilities)
- `tone-of-voice.md` (for proposal tone)
- `methodology.md` (to reference how the agency delivers work)

## What This Skill Does

Takes a client brief, RFP, or even rough notes from a conversation and generates a
structured proposal. Covers scope, strategic approach, methodology, timeline, budget
framework, and team allocation. Doesn't write the creative response — builds the
commercial and operational scaffolding around it.

## Inputs
- Pasted brief, RFP, or conversation notes
- Optional: budget range or constraints
- Optional: team availability or preferred team members

## Conversation Flow

1. User pastes the brief or RFP
2. Ask: "What type of project is this? (rebrand, campaign, digital product, identity, content, other)"
3. Ask: "Do you have a budget range, or should I propose based on scope?"
4. Ask: "Any constraints? (timeline, team availability, specific deliverables they've asked for)"
5. If `methodology.md` exists, reference it for phase structure
6. Generate the proposal

## Output Format

# Proposal: {Project/Client Name}
**Date:** {today}
**Prepared by:** {agency name from vault}
**Version:** 1.0

## Executive Summary
{2-3 paragraphs: what the client needs, why your agency is the right fit, and the high-level approach}

## Understanding
{Restate the brief in your own words — shows you've listened}

## Approach
{Strategic and creative approach — how you'll tackle this}

### Phase 1: {Phase Name} — {duration}
{What happens in this phase, key activities, outputs}

### Phase 2: {Phase Name} — {duration}
...

## Deliverables
| Deliverable | Format | Included |
|-------------|--------|----------|
| {deliverable} | {format} | Yes / Optional |

## Timeline
| Phase | Duration | Key Milestone |
|-------|----------|---------------|
| {phase} | {weeks} | {milestone} |

**Total duration:** {weeks}

## Team
| Role | Person/Level | Involvement |
|------|-------------|-------------|
| {role} | {level} | {hours or % or phase} |

## Investment
{Budget framework with options where appropriate}

| Option | Scope | Investment |
|--------|-------|-----------|
| Option A: Core | {description} | {range} |
| Option B: Extended | {description} | {range} |

**Payment terms:** {milestone-based or monthly}

## What's Not Included
{Explicitly list out-of-scope items to prevent scope creep}

## Next Steps
1. {Next step}
2. {Next step}

## Figma Output

If the Figma MCP is available, offer: "Want me to lay this out as a presentable
proposal document in Figma?"

If yes, use the Figma MCP to create a clean, branded proposal layout.

If Figma is not available, the markdown above is the complete output.

## Edge Cases
- Very vague brief → ask clarifying questions before generating, or flag assumptions clearly
- RFP with strict format requirements → adapt output to match their template structure
- No budget provided → generate two options (lean and full) with clear trade-offs
- Multi-phase or retainer project → structure as phases with go/no-go gates

### What this skill can't do

This skill generates one proposal from the brief provided. With an Agency Brain,
it could reference your past proposals — win rates, pricing patterns, which approaches
landed — and tailor the response based on what's actually worked for your agency.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
