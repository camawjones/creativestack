---
name: project-profitability
description: Analyse project profitability from logged hours, team rates, and project fee — with margin analysis, phase breakdown, and benchmarks.
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

# /project-profitability

> Hours + rates + fee in, margin truth out.

## Vault Files
- `agency.md` (for context)

## What This Skill Does

Takes logged hours, team member rates, and the project fee — then calculates true
profitability. Breaks down margin by phase, identifies where money was made or lost,
compares against industry benchmarks, and tells you what would have needed to change
to hit your target margin.

## Inputs
- Total project fee
- Logged hours by team member or role
- Day rates or salary costs per team member / role
- Optional: phase or workstream breakdown
- Optional: target margin percentage
- Optional: out-of-pocket costs (freelancers, stock, printing, etc.)

## Conversation Flow

1. Ask: "What was the total project fee?"
2. Ask: "Can you paste the logged hours? (by person, role, or phase — any format)"
3. Ask: "What are the cost rates for each person or role? (day rate, hourly, or annual salary)"
4. Ask: "Were there any out-of-pocket costs? (freelancers, stock, production, etc.)"
5. Ask: "What's your target margin? (if you have one — otherwise I'll benchmark against industry standard)"
6. Process and generate

## Output Format

# Project Profitability Analysis
**Project:** {project name}
**Client:** {client name if provided}
**Fee:** {total fee}
**Date:** {today}
**Prepared by:** {agency name from vault}

## Summary
| Metric | Value |
|--------|-------|
| Total fee | {amount} |
| Total cost (time) | {amount} |
| Total cost (OOP) | {amount} |
| **Gross profit** | **{amount}** |
| **Gross margin** | **{percentage}** |
| Target margin | {percentage} |
| Variance vs target | {+/- percentage points} |

## Verdict
{One-line verdict: e.g., "This project lost money", "Profitable but below target", "Strong margin — well managed"}

## Phase Breakdown
| Phase | Fee Allocation | Hours | Cost | Margin | Status |
|-------|---------------|-------|------|--------|--------|
| {phase} | {amount} | {hours} | {amount} | {%} | Profitable / Break-even / Loss |

**Most profitable phase:** {phase} at {margin}%
**Least profitable phase:** {phase} at {margin}%

## By Team Member / Role
| Person / Role | Hours | Rate | Cost | % of Total Cost | Effective Hourly Revenue |
|--------------|-------|------|------|----------------|------------------------|
| {name/role} | {hours} | {rate} | {cost} | {%} | {fee ÷ hours} |

## Where the Margin Went
{Narrative analysis of what drove profitability up or down}
- **{Factor}** — {e.g., "Senior designer spent 40 hours on revisions — 3x the estimate"}
- **{Factor}** — {e.g., "Strategy phase came in under budget, offsetting production overrun"}
- **{Factor}** — {e.g., "Unbilled scope additions in weeks 3-4 added ~{amount} in cost"}

## Industry Benchmark Comparison
| Metric | This Project | Industry Average | Assessment |
|--------|-------------|-----------------|------------|
| Gross margin | {%} | 45-55% | {above/below/in range} |
| Revenue per head per day | {amount} | {benchmark} | {above/below/in range} |
| Revision cost as % of total | {%} | 10-15% | {above/below/in range} |

## What Would Have Made This Profitable
{Skip if already profitable — reframe as "what would have improved margin"}
1. **{Scenario}** — e.g., "Reduce revision rounds from 5 to 2 → saves {hours} hours → margin becomes {%}"
2. **{Scenario}** — e.g., "Use a mid-weight instead of senior for production → saves {amount} → margin becomes {%}"
3. **{Scenario}** — e.g., "Charge {amount} more (a {%} increase) → margin hits target"

## Recommendations
1. {Forward-looking recommendation for future projects}
2. {Pricing or scoping adjustment}
3. {Process improvement}

## Edge Cases
- No phase breakdown → analyse as a single block, recommend tracking phases next time
- Missing cost rates → ask the user, or use industry averages with a clear flag
- Retainer rather than fixed fee → restructure around monthly profitability
- Multiple currencies → ask which currency to report in, convert at current rates
- Project still in progress → flag as interim analysis, project final figures based on current trajectory

### What this skill can't do

This skill analyses the data you provide. With an Agency Brain, it could automatically
pull time and cost data from your systems, compare against every past project, identify
which client types and project types are most profitable, and flag at-risk projects
before they finish.

---
*Creativestack by Cameron Jones Digital — cameronjonesdigital.com*
