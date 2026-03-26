---
name: churn-warning
description: Analyse client communication patterns for disengagement signals — risk flags, RAG rating with evidence, and recommended interventions.
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

# /churn-warning

> Client data in, churn risk assessment out.

## Vault Files
- `agency.md` (for context)
- `clients.md` (for client history and relationship context)

## What This Skill Does

Takes client communication data — email frequency, meeting cadence, feedback tone,
project pipeline, and any other signals — and assesses churn risk. Identifies
disengagement patterns, flags warning signs, provides a RAG (Red/Amber/Green) rating
with evidence for each signal, and recommends specific interventions. Helps you
spot the quiet slide before it becomes a lost client.

## Inputs
- Client name
- Communication signals (any combination of the below):
  - Email response times and frequency (recent vs historical)
  - Meeting attendance and cadence
  - Feedback tone and detail (enthusiastic vs terse vs absent)
  - Project pipeline (upcoming work, briefs in progress, gone quiet)
  - Invoice payment patterns
  - Key contact changes
- Optional: relationship history and context
- Optional: contract renewal date

## Conversation Flow

1. Ask: "Which client are you concerned about?"
2. Ask: "What signals are you seeing? (slow responses, fewer meetings, shorter feedback, no new briefs, etc.)"
3. Ask: "How does this compare to how they used to communicate?"
4. Ask: "Any context? (new marketing director, budget cuts, competitor pitch, etc.)"
5. Ask: "When is the contract up for renewal? (if applicable)"
6. Assess and output

## Output Format

# Client Churn Risk Assessment: {Client Name}
**Date:** {today}
**Assessment period:** {timeframe being evaluated}
**Prepared by:** {agency name from vault}

---

## Overall Risk Rating: {RED / AMBER / GREEN}
{One-paragraph summary of the overall assessment — what the signals suggest and how
confident the assessment is}

## Signal Analysis

### Communication Frequency
**Rating:** {RED / AMBER / GREEN}
**Evidence:**
- {Specific observation — e.g., "Email response time has increased from same-day to 3-5 days over the past month"}
- {Specific observation}

**Benchmark:** {What normal looks like for this type of client relationship}

---

### Meeting Cadence
**Rating:** {RED / AMBER / GREEN}
**Evidence:**
- {Observation — e.g., "Weekly status calls reduced to fortnightly, last two cancelled by client"}
- {Observation}

---

### Feedback Quality
**Rating:** {RED / AMBER / GREEN}
**Evidence:**
- {Observation — e.g., "Feedback has shifted from detailed, constructive notes to 'looks fine' or single-line approvals"}
- {Observation}

---

### Project Pipeline
**Rating:** {RED / AMBER / GREEN}
**Evidence:**
- {Observation — e.g., "No new briefs in 6 weeks. Previous cadence was 2-3 briefs per month"}
- {Observation}

---

### Payment Patterns
**Rating:** {RED / AMBER / GREEN}
**Evidence:**
- {Observation — e.g., "Last two invoices paid late. Previously always within terms"}
- {Observation}

---

### Relationship Signals
**Rating:** {RED / AMBER / GREEN}
**Evidence:**
- {Observation — e.g., "Primary contact left, replacement has not scheduled an introduction meeting"}
- {Observation}

## Disengagement Pattern
{What pattern do these signals collectively suggest?}

| Pattern | Match | Evidence |
|---------|-------|----------|
| Quiet exit (gradual withdrawal) | {Yes/No/Partial} | {summary} |
| Budget pressure (doing less with less) | {Yes/No/Partial} | {summary} |
| Relationship breakdown (specific trigger) | {Yes/No/Partial} | {summary} |
| Competitive review (testing the market) | {Yes/No/Partial} | {summary} |
| Contact change (new person, new preferences) | {Yes/No/Partial} | {summary} |

**Most likely pattern:** {pattern} — {reasoning}

## Risk Timeline
**Estimated window:** {e.g., "If no intervention, this client is likely to disengage within 2-3 months"}
**Key trigger date:** {e.g., "Contract renewal in April — decision likely being made now"}

## Recommended Interventions
{Specific, actionable steps — not generic "improve the relationship"}

| Priority | Action | Who | When | Expected Impact |
|----------|--------|-----|------|----------------|
| Immediate | {action — e.g., "MD calls client CMO for an informal catch-up this week"} | {person} | {timeframe} | {what this should achieve} |
| This week | {action} | {person} | {timeframe} | {impact} |
| This month | {action} | {person} | {timeframe} | {impact} |

## Conversation Starters
{Specific things to say that address the situation without being defensive}
1. "{Opener — e.g., "We've noticed things have been quieter recently — wanted to check in and make sure we're still aligned on priorities"}"
2. "{Opener}"

## What Not to Do
- {Anti-pattern — e.g., "Don't send a generic 'checking in' email — it signals you've noticed without adding value"}
- {Anti-pattern — e.g., "Don't immediately offer a discount — it undermines your value"}

## Edge Cases
- Only one signal present → note that single signals are unreliable, recommend monitoring rather than alarm
- Client is genuinely just quiet / seasonal → ask about the client's business cycle
- Client has explicitly said everything is fine → note that verbal reassurance doesn't always align with behavioural signals
- New client (less than 6 months) → limited baseline for comparison, flag this
- Multiple contacts with different signals → assess per contact and overall

### What this skill can't do

This skill assesses the signals you describe. With an Agency Brain, it could
automatically monitor email patterns, meeting cadence, and project pipeline across
all clients in real time, alert you when signals change, track which interventions
worked on past at-risk clients, and generate a portfolio-wide health dashboard.

---
*Creativestack by Cameron Jones — jones.cam*
