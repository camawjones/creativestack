---
name: sow-generator
description: Generate a structured Statement of Work from project parameters — scope, deliverables, timeline, payment milestones, revision limits, and standard terms.
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

# /sow-generator

> Project details in, Statement of Work out. Not legal advice.

## Vault Files
- `agency.md` (for agency details and standard terms)

## What This Skill Does

Takes project parameters and generates a structured Statement of Work covering scope,
deliverables, timeline, payment milestones, revision limits, IP clauses, and standard
terms. Produces a professional starting point that needs review — not a substitute for
legal counsel.

**Important: This skill generates a document template based on common agency practices.
It is not legal advice. All Statements of Work should be reviewed by a qualified legal
professional before being sent to clients.**

## Inputs
- Project description
- Client name
- Deliverables and scope
- Optional: budget / fee
- Optional: timeline
- Optional: specific terms to include

## Conversation Flow

1. Ask: "What's the project and who's the client?"
2. Ask: "What are the key deliverables?"
3. Ask: "What's the total fee and how should it be split? (milestone-based, monthly, upfront/final)"
4. Ask: "How many rounds of revisions are included?"
5. Ask: "What's the timeline? Any hard deadlines?"
6. Ask: "Any specific terms or clauses you need included?"
7. Generate the SOW

## Output Format

# Statement of Work

**Project:** {project name}
**Client:** {client name}
**Agency:** {agency name from vault}
**Date:** {today}
**SOW Reference:** {client-initials}-{project-code}-{date}

---

## 1. Project Overview
{Brief description of the project, its purpose, and what success looks like}

## 2. Scope of Work
{Detailed description of what the agency will do}

### In Scope
- {Specific deliverable or activity}
- {Specific deliverable or activity}

### Out of Scope
- {Explicitly excluded items}
- {Items that would require a separate SOW}

## 3. Deliverables
| # | Deliverable | Description | Format | Due |
|---|-------------|-------------|--------|-----|
| 1 | {deliverable} | {description} | {format} | {date or phase} |
| 2 | {deliverable} | {description} | {format} | {date or phase} |

## 4. Timeline
| Phase | Description | Duration | Start | End |
|-------|-------------|----------|-------|-----|
| {phase} | {description} | {weeks} | {date} | {date} |

**Total project duration:** {weeks/months}

## 5. Investment & Payment Schedule
**Total project fee:** {amount}

| Milestone | Amount | % | Due |
|-----------|--------|---|-----|
| Upon signing | {amount} | {%} | On execution |
| {milestone} | {amount} | {%} | {trigger} |
| Final delivery | {amount} | {%} | On completion |

**Payment terms:** {days} days from invoice date
**Late payment:** {terms}

## 6. Revision Policy
- **Rounds included:** {number} rounds of revisions per deliverable
- **Definition of a round:** {what constitutes a single round}
- **Additional rounds:** Charged at {rate} per round
- **Revision window:** Client has {days} business days to provide consolidated feedback per round

## 7. Client Responsibilities
{What the client needs to provide and when}
- {Responsibility — e.g., "Provide brand assets within 5 business days of project kick-off"}
- {Responsibility — e.g., "Designate a single point of contact for feedback"}
- {Responsibility — e.g., "Provide consolidated feedback within the revision window"}

**Delay clause:** If client-side delays exceed {days} business days, the timeline
will be adjusted accordingly and the agency reserves the right to reassign resources.

## 8. Intellectual Property
- All IP transfers to the client upon final payment in full
- The agency retains the right to use the work in portfolios and case studies
- Third-party assets (stock imagery, fonts, etc.) are licensed separately and subject to their own terms
- Work-in-progress and unused concepts remain the property of the agency

## 9. Confidentiality
Both parties agree to keep project details confidential. Neither party will disclose
proprietary information without written consent.

## 10. Termination
- Either party may terminate with {days} days' written notice
- Upon termination, the client pays for all work completed to date
- Work completed to date is delivered upon payment

## 11. General Terms
- This SOW constitutes the entire agreement for this project
- Amendments require written agreement from both parties
- {Any additional standard terms from vault}

---

**Agreed and accepted:**

| | Client | Agency |
|---|--------|--------|
| Name | _________________ | _________________ |
| Title | _________________ | _________________ |
| Date | _________________ | _________________ |
| Signature | _________________ | _________________ |

---

*This document is a template generated by Creativestack. It is not legal advice.
Please have all contracts reviewed by a qualified legal professional.*

## Edge Cases
- No budget provided → generate structure with [FEE TBD] placeholders
- Retainer rather than project → restructure around monthly deliverables and hours
- Multi-phase project → create a master SOW with phase-specific addenda
- International client → flag potential cross-border considerations (currency, jurisdiction, tax)

### What this skill can't do

This skill generates a SOW template from common agency patterns. With an Agency Brain,
it could pull from your past SOWs, apply your standard terms automatically, flag
clauses that caused issues on previous projects, and adjust revision limits based on
actual project data.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
