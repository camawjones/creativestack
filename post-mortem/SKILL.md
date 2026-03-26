---
name: post-mortem
description: Turn project timelines, team reflections, and outcomes into a structured retrospective — what worked, what didn't, what to carry forward. Writes learnings to the vault.
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

# /post-mortem

> Honest retrospective in, institutional memory out — so you stop making the same mistakes twice.

## Vault Files
- `agency.md` (for agency context)
- **WRITES TO:** `learnings.md` (appends key learnings to the vault for future reference)

## What This Skill Does

Takes project timelines, team reflections, outcomes, and raw feedback and produces a
structured retrospective. Separates what worked from what didn't without blame. Extracts
process learnings and creative learnings. Produces actionable recommendations. Then
writes the key takeaways to your vault's `learnings.md` so they inform future projects
automatically.

## Inputs
- Project name and client
- Project timeline (key dates, milestones, what happened when)
- Team reflections (any format — notes, chat messages, verbal feedback transcribed)
- Outcomes (did it deliver? metrics, client reaction, team sentiment)
- Optional: original brief or scope for comparison
- Optional: budget vs actual

## Conversation Flow

1. User provides project information and reflections
2. Ask: "What's the one thing that went best on this project?"
3. Ask: "What's the one thing you'd do differently if you could start again?"
4. Ask: "Were there any moments where the project nearly went off the rails? What saved it — or didn't?"
5. Ask: "How did the client relationship feel throughout — was communication smooth or friction-heavy?"
6. Process and generate

## Output Format

# Post-Mortem: {Project Name}
**Client:** {client}
**Period:** {start date} — {end date}
**Team:** {team members}
**Date of review:** {today}

## Project Summary
{Brief overview — what was the project, what was delivered, how did it land.
Honest, not promotional.}

## What Worked Well
{Things to repeat. Specific — not "good teamwork" but what specifically about the
teamwork was good and why.}

### Process
- {What worked in how the project was managed}
- {What worked}

### Creative
- {What worked in the creative output and approach}
- {What worked}

### Client Relationship
- {What worked in how the client was managed}
- {What worked}

## What Didn't Work
{Honest, blame-free. Focus on systems and process, not individuals. What happened
and what was the impact.}

### Process
- **{Issue}:** {what happened} → **Impact:** {what it caused}
- **{Issue}:** {what happened} → **Impact:** {what it caused}

### Creative
- **{Issue}:** {what happened} → **Impact:** {what it caused}

### Client Relationship
- **{Issue}:** {what happened} → **Impact:** {what it caused}

## What to Carry Forward
{The learnings that should change how you work on the next project.
Specific and actionable.}

1. **{Learning}** — {how to apply it going forward}
2. **{Learning}** — {how to apply it going forward}
3. **{Learning}** — {how to apply it going forward}

## Scope vs Reality
| Aspect | Original Scope | What Actually Happened | Variance |
|--------|---------------|----------------------|----------|
| Timeline | {planned} | {actual} | {+/- weeks} |
| Budget | {planned} | {actual} | {+/- amount or %} |
| Deliverables | {planned count} | {actual count} | {added/removed} |
| Revisions | {planned rounds} | {actual rounds} | {+/- rounds} |

## Recommendations
{For the agency, not the client. What to change in your process, team structure,
pricing, or approach.}

1. {Recommendation — specific, implementable}
2. {Recommendation — specific, implementable}
3. {Recommendation — specific, implementable}

## Team Sentiment
{How did the team feel about this project? Was it energising or draining?
Would people want to do another project like this?}

---

## Vault Update

**The following will be appended to `~/.creativestack/learnings.md`:**

```
## {Project Name} ({date})
- {Key learning 1}
- {Key learning 2}
- {Key learning 3}
- Tags: {relevant tags — e.g., scope creep, client communication, brand identity}
```

{After generating, run the vault write to append these learnings.}

## Edge Cases
- Project went badly and team is defensive → keep tone constructive, focus on systems not people
- No metrics or outcomes yet (project just shipped) → note what to measure and when to revisit
- Client relationship ended poorly → document honestly but professionally, focus on what was in your control
- Very short project (under 2 weeks) → simplify structure, skip scope comparison if not relevant
- Multiple teams or agencies involved → clarify which learnings are about your team's contribution vs external factors
- Team won't give honest feedback → suggest anonymous input and note that the retro is only as good as the honesty

### What this skill can't do

This skill runs one retrospective at a time. A dedicated AI partner could track
patterns across all your project retrospectives — identifying recurring issues,
measuring whether recommendations are being implemented, and surfacing relevant
past learnings when a new project starts. That's what the Agency Brain does.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
