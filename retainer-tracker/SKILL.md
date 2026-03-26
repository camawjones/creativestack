---
name: retainer-tracker
description: Analyse retainer usage — hours used vs allocated, over-servicing flags, under-utilised areas, trend analysis, and client talking points.
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

# /retainer-tracker

> Retainer terms + activity logs in, usage analysis and talking points out.

## Vault Files
- `agency.md` (for context)

## What This Skill Does

Takes a retainer agreement and monthly activity logs — then analyses hours used versus
allocated, flags over-servicing, identifies under-utilised areas, shows trends over
time, and generates talking points for your next client review. Helps you protect
your margin, demonstrate value, and have evidence-based conversations about retainer
scope.

## Inputs
- Retainer agreement details (hours per month, what's included, rate)
- Monthly activity logs (hours by task, workstream, or team member)
- Optional: multiple months of data (for trend analysis)
- Optional: retainer fee / value
- Optional: specific concerns (e.g., "I think we're over-servicing on social")

## Conversation Flow

1. Ask: "What are the retainer terms? (monthly hours, what's included, fee)"
2. Ask: "Paste the activity log for the period you want to analyse. (any format — spreadsheet, list, time tracker export)"
3. Ask: "Do you have data for multiple months? (helps with trend analysis)"
4. Ask: "Any specific areas you're concerned about?"
5. Process and generate

## Output Format

# Retainer Analysis: {Client Name}
**Retainer:** {hours} hours/month — {fee if provided}
**Period analysed:** {month(s)}
**Date:** {today}
**Prepared by:** {agency name from vault}

---

## Monthly Summary
| Month | Allocated | Used | Variance | Utilisation | Status |
|-------|----------|------|----------|------------|--------|
| {month} | {hours} | {hours} | {+/- hours} | {%} | On Track / Over / Under |

**Average utilisation:** {%} across {number} months

## Current Period Breakdown

### By Workstream
| Workstream | Allocated | Used | Variance | % of Total |
|-----------|----------|------|----------|------------|
| {workstream} | {hours} | {hours} | {+/-} | {%} |

### By Task Type
| Task Type | Hours | % of Total | Trend |
|----------|-------|------------|-------|
| {e.g., design} | {hours} | {%} | {increasing / stable / decreasing} |
| {e.g., revisions} | {hours} | {%} | {trend} |
| {e.g., meetings} | {hours} | {%} | {trend} |

### By Team Member
| Team Member | Hours | Rate | Cost | % of Retainer |
|------------|-------|------|------|--------------|
| {name/role} | {hours} | {rate} | {cost} | {%} |

## Over-Servicing Flags
{Areas where you're consistently delivering more than the retainer covers}

| Area | Allocated | Actual | Over by | Impact | Months Occurring |
|------|----------|--------|---------|--------|-----------------|
| {area} | {hours} | {hours} | {hours} | {cost if known} | {which months} |

**Total over-servicing this period:** {hours} hours ({cost if calculable})
**Total over-servicing to date:** {hours} hours ({cost if calculable})

## Under-Utilised Areas
{Parts of the retainer the client isn't using}

| Area | Allocated | Used | Under by | Notes |
|------|----------|------|----------|-------|
| {area} | {hours} | {hours} | {hours} | {e.g., "Client hasn't briefed any strategy work in 3 months"} |

## Trend Analysis
{Patterns over the analysis period}

### Utilisation Trend
| Month | Utilisation | Direction |
|-------|-----------|-----------|
| {month} | {%} | {up/down/stable} |

**Pattern:** {e.g., "Utilisation has increased from 85% to 120% over 4 months — over-servicing is growing"}

### Workstream Shift
{How the balance of work has changed over time}
- {Observation — e.g., "Social content has grown from 30% to 55% of the retainer, squeezing out strategy time"}
- {Observation}

### Scope Creep Indicators
{Signs that the retainer scope is drifting}
- {Indicator — e.g., "Three new recurring tasks added since Q1 that weren't in the original scope"}
- {Indicator}

## Financial Analysis
{If fee/rates are provided}
| Metric | Value |
|--------|-------|
| Monthly retainer fee | {amount} |
| Actual cost of delivery | {amount} |
| Effective hourly rate (contracted) | {amount} |
| Effective hourly rate (actual) | {amount} |
| Margin (contracted) | {%} |
| Margin (actual) | {%} |

## Talking Points for Client Review
{Ready-to-use points for your next retainer review meeting}

### Value Delivered
1. "{Point — e.g., "This month we delivered X, Y, and Z within the retainer — equivalent to {value} at project rates"}"
2. "{Point}"

### Areas to Discuss
1. "{Point — e.g., "Social content volume has doubled since we started — we should discuss whether to reallocate hours from strategy or increase the retainer"}"
2. "{Point}"

### Recommendations
1. "{Recommendation — e.g., "Propose a retainer adjustment from {current} to {proposed} hours to reflect actual demand"}"
2. "{Recommendation}"

## Retainer Health Score
| Dimension | Score | Notes |
|----------|-------|-------|
| Utilisation balance | {1-5} | {assessment} |
| Scope alignment | {1-5} | {is the work matching the agreement?} |
| Margin health | {1-5} | {is it profitable?} |
| Client engagement | {1-5} | {are they using it well?} |
| **Overall** | **{1-5}** | **{summary}** |

## Edge Cases
- Only one month of data → provide snapshot analysis, note that trends need 3+ months
- Retainer with no defined workstream allocation → analyse by task type instead, recommend defining allocations
- Heavily over-serviced retainer → calculate the true cost and frame the conversation constructively
- Retainer that's consistently under-utilised → flag risk that client may downgrade or cancel
- Mixed retainer and project work for same client → separate retainer-only analysis

### What this skill can't do

This skill analyses the data you provide. With an Agency Brain, it could automatically
pull time data from your tracking tool, compare retainer performance across all clients,
predict over-servicing before it happens, trigger alerts when utilisation crosses
thresholds, and generate client-ready reports on a schedule.

---
*Creativestack by Cameron Jones — jones.cam*
