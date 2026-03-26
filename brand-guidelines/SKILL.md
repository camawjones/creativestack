---
name: brand-guidelines
description: Turn scattered brand assets and notes into a structured brand guidelines document with colour, typography, tone, and usage rules.
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

# /brand-guidelines

> Scattered brand notes in, structured guidelines out.

## Vault Files
- `agency.md` (for context)

## What This Skill Does

Takes scattered brand inputs — hex values, type specs, logo notes, tone-of-voice
fragments, usage rules scribbled in emails — and organizes them into a structured
brand guidelines document. Identifies gaps in the brand system and flags where
decisions still need to be made.

## Inputs
- Pasted brand information (any format — hex codes, font names, tone notes, logo usage rules, Slack messages, email chains)
- Optional: existing brand assets or links
- Optional: "How comprehensive should this be?" (quick reference vs. full guidelines)

## Conversation Flow

1. User pastes brand information
2. Ask: "Is this for a new brand or documenting an existing one?"
3. Ask: "How comprehensive should the guidelines be? (quick reference card, standard guidelines, full brand book)"
4. Ask: "Any specific sections you need that aren't covered by the inputs?"
5. Organize and generate

## Output Format

# Brand Guidelines: {Brand Name}
**Version:** 1.0
**Date:** {today}
**Prepared by:** {agency name from vault}

## Brand Overview
{What the brand stands for — mission, vision, values if provided}

## Logo
### Primary Logo
{Description and usage rules}
### Logo Variations
{Variations: horizontal, stacked, icon-only, etc.}
### Clear Space
{Minimum clear space rules}
### Don'ts
- {Logo misuse to avoid}

## Colour Palette
### Primary Colours
| Colour | Hex | RGB | CMYK | Pantone | Usage |
|--------|-----|-----|------|---------|-------|
| {name} | {hex} | {rgb} | {cmyk or TBD} | {pantone or TBD} | {when to use} |

### Secondary Colours
| Colour | Hex | RGB | Usage |
|--------|-----|-----|-------|
| {name} | {hex} | {rgb} | {when to use} |

### Colour Ratios
{Recommended proportions — e.g., 60/30/10 split}

## Typography
### Primary Typeface
- **Name:** {typeface}
- **Weights:** {weights available}
- **Usage:** {headlines, body, etc.}

### Secondary Typeface
- **Name:** {typeface}
- **Usage:** {where and when}

### Type Scale
{Heading sizes, body text size, line heights if specified}

## Tone of Voice
### Brand Personality
{3-5 personality traits}

### We are / We are not
| We are | We are not |
|--------|------------|
| {trait} | {opposite} |

### Writing Guidelines
- {Guideline}
- {Guideline}

## Imagery & Photography
{Style, subject matter, treatment — if provided}

## Iconography
{Style, stroke weight, grid — if provided}

## Gaps Identified
{Brand decisions that still need to be made}
- [ ] {Gap — e.g., "No secondary colour palette defined"}
- [ ] {Gap — e.g., "Tone of voice not documented"}
- [ ] {Gap — e.g., "No guidance on photography style"}

## Figma Output

If the Figma MCP is available, offer: "Want me to create this as a designed brand
guidelines page in Figma with colour swatches and type specimens?"

If yes, use the Figma MCP to create a visual guidelines document.

If Figma is not available, the markdown above is the complete output.

## Edge Cases
- Very minimal input (just colours and a font) → generate a skeleton with [TBD] markers, flag what's missing
- Input includes conflicting information → flag with [CONFLICT] and ask for clarification
- Input is a full existing guidelines doc → restructure and improve rather than start from scratch
- Multiple brands / sub-brands → organize with clear hierarchy

### What this skill can't do

This skill structures the brand information you provide. With an Agency Brain,
it could reference your agency's past brand systems, suggest standard sections
you typically include, and check new guidelines against industry best practices
from your portfolio.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
