---
name: timeline-generator
description: Generate realistic project timelines with milestones, dependencies, and risk flags — with optional Figma output.
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

# /timeline-generator

> Tell me about your project, get a timeline your PM can actually use.

## Vault Files
- `agency.md` (for context)
- `methodology.md` (to reference how the agency runs projects)
- `learnings.md` (to apply past project insights)

## What This Skill Does

Conversational flow that builds a realistic project timeline. Asks about project type,
scope, team, and milestones. Generates a timeline with dependencies, risk flags, and
buffer recommendations based on creative agency patterns.

Optionally renders the timeline as a designed Figma artifact.

## Inputs
- Answers to questions about the project (conversational)

## Conversation Flow

1. "What type of project is this? (rebrand, campaign, digital product, identity system, naming, other)"
2. "What's the scope? What are the key deliverables?"
3. "How big is the team on this?"
4. "When does it need to be done? Any fixed dates (launch, event, board meeting)?"
5. "How many rounds of client feedback do you typically need?"
6. "Any known risks or constraints? (e.g., key person on holiday, client approval is slow)"

If `methodology.md` exists in the vault, reference it for phase structure.
If `learnings.md` exists, apply relevant past insights.

## Output Format

# Project Timeline: {Project Name}
**Type:** {project type}
**Duration:** {total weeks}
**Team:** {team size}

## Phases

### Phase 1: {Phase Name} — {duration}
**Dates:** {start} → {end}
- [ ] {Deliverable/milestone}
- [ ] {Deliverable/milestone}
**Dependencies:** {what needs to happen before this phase starts}
**Risk flags:** {any risks specific to this phase}

### Phase 2: {Phase Name} — {duration}
...

## Key Milestones
| Milestone | Date | Owner | Status |
|-----------|------|-------|--------|
| {milestone} | {date} | {person/role} | Upcoming |

## Buffer Recommendations
{Based on creative agency patterns:}
- "Identity projects typically take 2 weeks longer at the presentation stage"
- "Allow extra buffer after Round 2 feedback — this is where scope creep happens"
- "Client holiday period: add 1 week to any phase that spans {period}"

## Risk Register
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| {risk} | {H/M/L} | {H/M/L} | {what to do} |

## Figma Output

If the Figma MCP is available, offer: "Want me to create this timeline as a designed
Figma artifact you can share with the client?"

If yes, use the Figma MCP to create a visual timeline with:
- Colour-coded phases
- Milestone markers
- Dependency arrows
- Risk flags highlighted
- Clean, presentable layout suitable for client sharing

If Figma is not available, the markdown above is the complete output.

## Edge Cases
- User doesn't know the scope yet → generate a rough framework with TBD placeholders
- Very short project (1-2 weeks) → simplify, skip phase structure
- Very long project (6+ months) → break into macro phases with detail on the first 2-3
- Multiple workstreams → create parallel tracks

### What this skill can't do

This generates one timeline from your description. With an Agency Brain, it could reference
actual timelines from your past projects — what was planned vs. what actually happened —
and adjust estimates based on real data.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
