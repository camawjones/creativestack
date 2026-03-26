---
name: rfi-response
description: Draft responses to RFIs and EOIs from existing case studies, bios, and methodology — flagging sections that need bespoke creative input.
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

# /rfi-response

> Paste the RFI, get a drafted response with gaps flagged.

## Vault Files
- `agency.md` (for agency details and positioning)
- `case-studies.md` (for relevant project examples)
- `methodology.md` (for process and approach)
- `team.md` (for bios and expertise)

## What This Skill Does

Takes an RFI (Request for Information) or EOI (Expression of Interest) document and
drafts responses to each section using your existing case studies, team bios, methodology,
and agency information from the vault. Identifies which sections can be answered from
existing content and flags sections that need bespoke creative input, original thinking,
or information not in the vault. Saves hours of cut-and-paste while making sure the
important sections get proper attention.

## Inputs
- Pasted RFI / EOI document (full or key sections)
- Optional: specific opportunity context
- Optional: which case studies to prioritise
- Optional: word or page limits
- Optional: any mandatory requirements or evaluation criteria

## Conversation Flow

1. Ask: "Paste the RFI or EOI (or the key sections you need to respond to)."
2. Ask: "Are there word or page limits?"
3. Ask: "Any case studies or team members you specifically want to feature?"
4. Ask: "Do you know the evaluation criteria or weighting?"
5. Review vault content, map to RFI sections, draft and flag

## Output Format

# RFI Response: {Opportunity Name}
**Issuing body:** {organisation}
**Deadline:** {if stated}
**Date:** {today}
**Prepared by:** {agency name from vault}

---

## Response Overview
| Section | Status | Source | Notes |
|---------|--------|--------|-------|
| {section title} | Drafted / Partial / Needs Input | {vault file(s) used} | {notes} |
| {section title} | Drafted / Partial / Needs Input | {vault file(s) used} | {notes} |

**Sections fully drafted:** {count}
**Sections needing input:** {count}

---

## Section 1: {Section Title from RFI}
**RFI asks:** {summary of what they want}
**Status:** Drafted / Partial / Needs Input
**Word limit:** {if specified}

{Drafted response using vault content — written in the agency's voice, tailored to
the opportunity. Cites specific case studies, team members, or methodology as relevant.}

{If partial or needs input:}
> **Needs input:** {What's missing — e.g., "This section asks for your approach to
> accessibility testing. Your methodology vault doesn't cover this — draft 150 words
> on your QA/accessibility process."}

---

## Section 2: {Section Title}
...

---

## Case Study Mapping
{Which case studies were used where and why}

| Case Study | Used In Section(s) | Relevance |
|-----------|-------------------|-----------|
| {case study} | {sections} | {why it was chosen} |

## Team Mapping
| Team Member | Featured In | Role Highlighted |
|------------|-------------|-----------------|
| {name} | {section(s)} | {relevant experience} |

## Compliance Check
{Cross-reference against any mandatory requirements stated in the RFI}
- [ ] {Requirement} — {met / not met / check}
- [ ] {Requirement} — {met / not met / check}

## Gaps & Action Items
| Gap | Section | Action Required | Priority |
|-----|---------|----------------|----------|
| {what's missing} | {section} | {what to write or find} | High / Medium / Low |

## Submission Notes
- **Format requirements:** {any format specs from the RFI}
- **Submission method:** {if stated}
- **Deadline:** {if stated}
- **Evaluation criteria:** {if stated, with suggested emphasis}

## Edge Cases
- RFI is very long (50+ sections) → prioritise scored/weighted sections, provide skeleton responses for the rest
- Vault has no relevant case studies → flag clearly, suggest which past projects to write up
- RFI requires specific certifications or accreditations → flag if not found in vault
- Consortium or partnership bid → adjust language for "we" vs "our partner"
- RFI asks for pricing → flag that pricing sections need commercial input, don't guess

### What this skill can't do

This skill drafts from your vault content. With an Agency Brain, it could also pull
from your complete library of past RFI responses, learn which answers scored well,
auto-populate boilerplate sections, track win rates by response approach, and maintain
a reusable response library that improves with every submission.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
