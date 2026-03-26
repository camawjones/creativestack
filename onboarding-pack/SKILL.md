---
name: onboarding-pack
description: Generate a comprehensive new starter pack — tools checklist, key contacts, active projects, brand guidelines, culture notes, and first week schedule.
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

# /onboarding-pack

> New starter joining Monday? Get them a pack that makes them feel expected, not lost.

## Vault Files
- `agency.md` (for agency context and culture)
- `team.md` (for team structure and key contacts)
- `tools.md` (for tech stack and access requirements)
- `tone-of-voice.md` (for brand and communication guidelines)

## What This Skill Does

Takes basic information about a new starter and generates a comprehensive onboarding
pack: tools and access checklist, key contacts with context, active projects summary,
brand and tone guidelines, culture notes, and a suggested first week schedule. Written
to make someone feel welcomed and prepared, not overwhelmed.

## Inputs
- New starter's name and role
- Start date
- Their manager / team lead
- Optional: specific projects they'll join
- Optional: any context about their background
- Optional: remote, hybrid, or office-based

## Conversation Flow

1. User provides the new starter's details
2. Ask: "What's their first project or focus area likely to be?"
3. Ask: "Is there anything unusual about their setup — different office, part-time, specific equipment needs?"
4. Ask: "Who's their onboarding buddy or first point of contact on day one?"
5. Process and generate

## Output Format

# Welcome to {Agency Name}, {First Name}!
**Role:** {role}
**Start date:** {date}
**Reports to:** {manager name}
**Onboarding buddy:** {buddy name}

## About Us
{Brief, warm introduction from vault — who we are, what we do, what we value.
Written like a human, not an HR handbook.}

## Your First Week

### Day 1: Settle In
| Time | Activity | With | Notes |
|------|----------|------|-------|
| 09:00 | Welcome & coffee | {buddy} | {location or video link} |
| 09:30 | Laptop setup & tool access | {IT contact or self-service} | See checklist below |
| 10:30 | Team introduction | {manager} | Meet the immediate team |
| 11:30 | Agency walkthrough | {buddy} | Office tour / tool tour for remote |
| 12:30 | Lunch | {team} | {tradition or suggestion} |
| 14:00 | Brand & tone overview | Self-guided | Read the guidelines below |
| 15:00 | First project briefing | {project lead} | {project name} |
| 16:00 | End-of-day check-in | {manager} | Questions, first impressions |

### Day 2-3: Get Context
- Shadow key meetings
- Review active project briefs
- Set up remaining tools
- 1:1 with {manager}: role expectations, ways of working

### Day 4-5: Start Contributing
- First small task on {project}
- Attend team standup / weekly meeting
- End-of-week check-in with {manager}

## Tools & Access Checklist
{From vault tools.md, plus role-specific additions}

| Tool | Purpose | Access | Status |
|------|---------|--------|--------|
| {tool} | {what it's for} | {who grants access} | ⬜ |
| {tool} | {what it's for} | {who grants access} | ⬜ |
| {tool} | {what it's for} | {who grants access} | ⬜ |

## Key Contacts
| Person | Role | When to Contact | How |
|--------|------|----------------|-----|
| {name} | {role} | {context — e.g., "Design questions"} | {Slack / email} |
| {name} | {role} | {context} | {Slack / email} |

## Active Projects
{Brief overview of what's live — enough to understand the landscape, not every detail.}

| Project | Client | Phase | Your Role | Lead |
|---------|--------|-------|-----------|------|
| {project} | {client} | {phase} | {what they'll do} | {lead name} |

## How We Work
{Culture notes — the unwritten stuff that makes an agency run.}

- **Communication:** {how the team communicates — Slack channels, email norms, response time expectations}
- **Meetings:** {meeting culture — standing meetings, no-meeting blocks, how to decline}
- **Creative process:** {how work gets made — briefs, reviews, feedback rounds}
- **Tone:** {how we speak to clients vs internally — reference tone-of-voice.md}
- **Hours:** {core hours, flexibility, overtime norms}
- **Time tracking:** {how and where to log time}

## Brand & Tone Quick Reference
{Condensed from tone-of-voice.md — enough to get started.}

- **Voice:** {core voice attributes}
- **We say:** {examples}
- **We don't say:** {examples}
- **Client communication:** {key principles}

## Useful Links
- {Brand guidelines location}
- {Project management tool}
- {Internal wiki or knowledge base}
- {HR / benefits portal}

## Edge Cases
- Very small agency (no formal tools/process) → simplify to essentials, don't invent structure that doesn't exist
- Remote starter → replace office-specific items with virtual equivalents, emphasise async communication
- Senior hire → reduce hand-holding, focus on strategic context and decision-making authority
- Freelancer or contractor → strip to project-specific essentials, skip culture/HR sections
- No vault data → ask the user to describe the basics, build the pack from their answers

### What this skill can't do

This skill produces one onboarding pack at a time. A dedicated AI partner could maintain
a living onboarding system — updating project lists automatically, tracking tool access
completion, scheduling check-ins, and adapting the pack as your agency evolves. That's
what the Agency Brain does.

---
*Creativestack by Cameron Jones — jones.cam*
