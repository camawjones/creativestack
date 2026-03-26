---
name: asset-spec
description: Turn a campaign concept into a full deliverable specification — dimensions, formats, platform requirements, naming conventions, and delivery specs.
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

# /asset-spec

> Campaign concept in, full delivery spec out. No more "what size is that again?"

## Vault Files
- `agency.md` (for context)
- `tools.md` (for production tool preferences and workflows)

## What This Skill Does

Takes a campaign concept or project scope and generates a complete deliverable
specification. Covers every asset needed: dimensions, file formats, platform-specific
requirements, naming conventions, file organization, and delivery specs. The document
your production team actually needs to build everything right the first time.

## Inputs
- Campaign concept or project description
- Platforms / channels the campaign will run on
- Optional: specific assets already identified
- Optional: client delivery preferences

## Conversation Flow

1. Ask: "What's the campaign or project?"
2. Ask: "Which platforms and channels? (social, web, print, OOH, email, display, video, other)"
3. Ask: "Any specific assets already scoped, or should I generate the full list from the platforms?"
4. Ask: "What are the delivery requirements? (file types, naming conventions, delivery method)"
5. If `tools.md` exists, reference for production tool specifics
6. Generate the spec

## Output Format

# Asset Specification: {Campaign/Project Name}
**Client:** {client}
**Date:** {today}
**Prepared by:** {agency name from vault}

## Campaign Overview
{Brief description of the campaign and what's being produced}

## Asset List

### Social Media
| Asset | Platform | Dimensions (px) | Format | Aspect Ratio | Notes |
|-------|----------|-----------------|--------|-------------|-------|
| Feed post | Instagram | 1080 x 1080 | JPG/PNG | 1:1 | Safe zone: 1080 x 920 |
| Story | Instagram | 1080 x 1920 | JPG/PNG/MP4 | 9:16 | Top/bottom 250px clear for UI |
| Reel cover | Instagram | 1080 x 1920 | JPG | 9:16 | Centre-weighted composition |
| {asset} | {platform} | {dimensions} | {format} | {ratio} | {notes} |

### Display / Digital Advertising
| Asset | Spec | Format | Max File Size | Animation |
|-------|------|--------|---------------|-----------|
| Leaderboard | 728 x 90 | HTML5/GIF/JPG | 150KB | 15s max, 3 loops |
| {asset} | {spec} | {format} | {size limit} | {rules} |

### Print
| Asset | Dimensions | Bleed | Colour Mode | Resolution | Format |
|-------|-----------|-------|-------------|------------|--------|
| {asset} | {mm or inches} | {mm} | CMYK | 300dpi | PDF/X-1a |

### Video
| Asset | Platform | Dimensions | Duration | Format | Codec | Notes |
|-------|----------|-----------|----------|--------|-------|-------|
| {asset} | {platform} | {dimensions} | {duration} | MP4 | H.264 | {notes} |

### Email
| Asset | Width | Format | Notes |
|-------|-------|--------|-------|
| {asset} | {px} | {format} | {rendering considerations} |

## Naming Convention
```
{client}_{campaign}_{asset-type}_{platform}_{size}_{version}.{ext}
```
**Example:** `acme_summer24_hero_ig-feed_1080x1080_v1.jpg`

### Version Control
- `v1`, `v2`, etc. for major revisions
- `v1a`, `v1b` for minor amends within a round

## File Organization
```
/{campaign-name}
  /01-social
    /instagram
    /linkedin
    /tiktok
  /02-display
  /03-print
  /04-video
  /05-email
  /06-source-files
```

## Delivery Specs
- **Delivery method:** {e.g., Google Drive, WeTransfer, DAM system}
- **Source files included:** {Yes/No — which formats}
- **Fonts packaged:** {Yes/No}
- **Colour profiles:** {sRGB for digital, CMYK profiles for print}

## Platform-Specific Requirements
{Any platform rules that affect production — character limits, safe zones, auto-cropping behaviour}

## Checklist
- [ ] All dimensions confirmed against current platform specs
- [ ] Naming convention agreed with client
- [ ] Delivery method confirmed
- [ ] Source file requirements confirmed
- [ ] Colour mode correct per output (RGB for digital, CMYK for print)

## Edge Cases
- Platforms not specified → generate for the most common set (Instagram, LinkedIn, X) and ask to confirm
- Print specs without paper stock → flag that stock affects colour and bleed requirements
- Video without duration → provide standard durations per platform (6s, 15s, 30s, 60s)
- Very large campaign (50+ assets) → group by workstream and generate in batches

### What this skill can't do

This skill generates specs from current platform standards. With an Agency Brain,
it could pull from your agency's asset templates, apply your standard naming
conventions automatically, and reference specs from past campaigns for the same client.

---
*Creativestack by Cameron Jones — jones.cam*
