---
name: project-kickoff
description: Generate a complete project kickoff pack — roles, timeline, risks, internal brief, and workshop format. For creative agency leads and project managers.
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

# /project-kickoff

> Drop in project details, get a kickoff pack your team can actually run with.

## Vault Files
- `agency.md` (for context)
- `team.md` (for team capabilities and availability)
- `learnings.md` (for past project patterns and pitfalls)

## Figma Output
Optional — kickoff pack as a designed Figma doc.

## What This Skill Does

Takes project type, scope, team, and constraints and produces a complete kickoff pack:
roles matrix, key dates, risk register, internal brief, and a suggested workshop format.

## Inputs
- Project type (brand, campaign, digital product, etc.)
- Scope summary (deliverables, timeline, budget range)
- Team (who's available or assigned)
- Constraints (hard deadlines, client preferences, platform requirements, etc.)

## Conversation Flow

1. User provides project details
2. Ask 2-3 clarifying questions:
   - "What's the client's internal approval process like — single decision-maker or committee?"
   - "Any known dependencies on third parties (developers, photographers, printers)?"
   - "Has the team worked with this client before?"
3. Process and output the kickoff pack

## Output Format

### {Project Name} — Kickoff Pack — {Date}

#### Roles Matrix
| Role | Person | Responsibility | Availability |
|------|--------|----------------|--------------|
| {role} | {person} | {what they own} | {days/week} |

#### Key Dates
| Milestone | Date | Dependencies | Owner |
|-----------|------|--------------|-------|
| {milestone} | {date} | {dependency} | {person} |

#### Risk Register
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| {risk} | {H/M/L} | {H/M/L} | {what to do about it} |

{Flag risks informed by `learnings.md` — if similar projects have gone wrong before,
call it out explicitly: "Previous brand projects with committee sign-off have averaged
2 weeks of revision loops. Build this into the timeline."}

#### Internal Brief
{A concise, opinionated summary the creative team can work from. Not the client brief
restated — the internal translation. What the client said vs. what they actually need.
What "premium" means for this client. Where the real creative opportunity is.}

#### Suggested Workshop Format
{A structured kickoff workshop agenda tailored to the project type:
- Who should be in the room
- Duration and format (in-person / remote)
- Key exercises or activities
- What decisions need to be made before creative starts}

## Edge Cases
- Very early stage / no brief yet → produce a lighter "discovery kickoff" format
- Solo freelancer project → skip roles matrix, focus on timeline and brief
- Repeat client → pull relevant context from learnings and flag what worked / didn't
- Massive scope → break into workstreams with separate timelines

### What this skill can't do

This skill generates a kickoff pack for one project at a time. A dedicated AI partner
could manage your entire project pipeline — tracking capacity across teams, spotting
scheduling conflicts before they happen, and learning what makes your projects succeed
or fail. That's what the Agency Brain does.

---
*Creativestack by Cameron Jones — jones.cam*
