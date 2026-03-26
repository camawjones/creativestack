---
name: credentials-deck
description: Tailor a credentials deck for a specific prospect — reorder case studies, adjust positioning, surface relevant stats and testimonials.
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

# /credentials-deck

> Master creds + prospect context in, tailored deck out.

## Vault Files
- `agency.md` (for agency positioning and details)
- `case-studies.md` (for available case studies)
- `team.md` (for team bios and expertise)
- `tone-of-voice.md` (for communication style)

## What This Skill Does

Takes your master credentials content and a prospect's industry, brief, or context —
then generates a tailored version of your creds deck. Reorders case studies by relevance,
adjusts positioning language to resonate with the prospect's world, surfaces the most
relevant stats and testimonials, and recommends which team members to feature. Produces
slide-by-slide content ready for your design team to lay up.

## Inputs
- Prospect company name and industry
- Optional: specific brief or opportunity context
- Optional: what they care about most (creativity, strategy, results, speed, etc.)
- Optional: who's in the meeting (CMO, procurement, marketing manager, etc.)
- Optional: any case studies or topics to exclude

## Conversation Flow

1. Ask: "Who's the prospect and what industry are they in?"
2. Ask: "Is this for a specific opportunity, or a general credentials meeting?"
3. Ask: "Who will be in the room? (helps adjust the emphasis — CMO vs procurement vs marketing manager)"
4. Ask: "Anything to exclude? (competitors of theirs you work with, sensitive topics)"
5. Review vault content and generate

## Output Format

# Tailored Credentials Deck: {Prospect Name}
**Industry:** {industry}
**Opportunity:** {specific brief or "general credentials"}
**Date:** {today}
**Prepared by:** {agency name from vault}

---

## Deck Strategy
{Brief note on how this deck has been tailored and why}
- **Lead with:** {what to emphasise first — e.g., "category experience" or "results-driven approach"}
- **Audience lens:** {what matters to the people in the room}
- **Tone:** {adjusted tone recommendation based on prospect type}

## Recommended Slide Order

### Slide 1 — Title
**{Agency name}** + **{Prospect name}**
{Tailored tagline or opening statement that speaks to this prospect's world}

### Slide 2 — Who We Are
{Agency positioning, adjusted to emphasise aspects most relevant to this prospect}
{Pull from agency.md, reframe for the audience}

### Slide 3 — Why Us for {Prospect Industry}
{Specific reasons your agency is relevant to their sector}
- {Relevant experience point}
- {Relevant capability}
- {Relevant stat or result}

### Slide 4 — Case Study: {Most Relevant Case Study}
**Client:** {client}
**Challenge:** {brief}
**What we did:** {approach}
**Result:** {outcome with stats}
**Why it's relevant:** {connection to prospect's situation}

### Slide 5 — Case Study: {Second Most Relevant}
...

### Slide 6 — Case Study: {Third Most Relevant}
...

### Slide 7 — Our Approach / Methodology
{How you work, framed in terms that matter to this prospect}

### Slide 8 — The Team
{Recommended team members to feature, with bios adjusted for relevance}
- **{Name}** — {role} — {experience relevant to this prospect}
- **{Name}** — {role} — {experience relevant to this prospect}

### Slide 9 — Client List / Logos
{Recommended client logos to feature — prioritise same industry or adjacent}

### Slide 10 — Next Steps
{Suggested CTA tailored to where you are in the relationship}

---

## Case Study Ranking
{Why case studies were ordered this way}

| Rank | Case Study | Relevance Score | Reasoning |
|------|-----------|----------------|-----------|
| 1 | {case study} | High | {why it's most relevant} |
| 2 | {case study} | High | {why} |
| 3 | {case study} | Medium | {why} |

**Excluded:** {any case studies deliberately left out and why}

## Talking Points
{Key things to say in the meeting that connect your experience to their needs}
1. "{Talking point}"
2. "{Talking point}"
3. "{Talking point}"

## Anticipate Their Questions
{Likely questions from the prospect and suggested responses}
1. **"{Question}"** → {suggested response}
2. **"{Question}"** → {suggested response}

## Edge Cases
- Very few relevant case studies → lead with methodology and approach, use adjacent-industry examples
- Prospect is a competitor of an existing client → flag the conflict, recommend how to address it
- No vault content available → ask the user to describe their key case studies and positioning
- Pitch to procurement (not marketing) → shift emphasis from creative to process, timelines, and value
- Multiple decision-makers with different priorities → suggest variant slides or a modular deck approach

### What this skill can't do

This skill tailors your creds content based on what's in your vault. With an Agency
Brain, it could also pull from your CRM to understand the prospect's history with
your agency, auto-generate custom case study pages, track which deck versions led to
wins, and learn which case study combinations resonate with different industries.

---
*Creativestack by Cameron Jones — jones.cam*
