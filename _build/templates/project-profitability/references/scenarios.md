# Scenario Modelling

After computing the actual margin, model 2-3 scenarios that show what would
have changed it. Use **real numbers from this project** — never generic
percentages. The point is to make the lesson concrete.

Pick the most informative 3 scenarios for this specific project. Don't run all
of them every time.

## Scenario A: Fewer revision rounds

**When to run:** Revisions are visible in the data (timesheet-summary `revision_tax`
field, or evidence in cost breakdown).

**Inputs:**
- Actual revision hours (from timesheet or estimated as % of design hours)
- Cap target: typical contractual cap (often 2 rounds)

**Math:**
- Hours saved = actual_revision_hours − (estimated hours within cap)
- Cost saved = hours saved × person/role rate
- New margin = (fee − (cost − cost saved) − oop) ÷ fee

**Output:**
```
"If revision rounds were capped at 2 instead of {actual}:
 - Hours saved: 32h (Sarah at £750/day = £3,000)
 - Revised margin: 38% (vs actual 32%)
 - Verdict: Would have closed half the gap to your 45% target."
```

## Scenario B: Different team mix

**When to run:** Senior allocation looks heavy for the work type, OR a specific
production task was done by a senior when a mid could have done it.

**Inputs:**
- Specific task and the person who did it
- A more appropriate rate from rate-card.md

**Math:**
- Cost reduction = task_hours × (actual_rate − alternate_rate)
- New margin = (fee − (cost − cost reduction) − oop) ÷ fee

**Output:**
```
"If the production polish (40h) had used a mid-weight instead of senior:
 - Rate difference: £500/day → £350/day = £150/day saved
 - Cost reduction: £750 (40h ÷ 8h × £150)
 - Revised margin: 33% (vs actual 32%)
 - Verdict: Marginal — production polish wasn't the leak."
```

When this scenario doesn't move the needle (<2 margin points), say so plainly
and skip — don't pad.

## Scenario C: Higher fee

**When to run:** Always. This is the "what should we have charged" scenario.

**Inputs:**
- Target margin (from question or rate-card default)

**Math:**
- Required fee = total_cost ÷ (1 − target_margin)
- Increase = required_fee − actual_fee
- % increase = (required_fee − actual_fee) ÷ actual_fee

**Output:**
```
"To hit your target margin of 45% with the same team and scope:
 - Required fee: £56,800 (vs actual £45,000 — a 26% increase)
 - Per-hour rate needed: £142 (vs actual £113)
 - Verdict: A 26% price increase is at the high end of market range for
   this project type. Worth discussing for next time, but probably not
   defensible retroactively."
```

If the user has `project-history.md` data, add: "Your last 4 brand identity
projects averaged £58k — you priced this one £13k below your own average."

## Scenario D: Scope reduction

**When to run:** Scope creep is visible (unbilled scope additions noted in
timesheet-summary or in `top_delta` field).

**Inputs:**
- The specific scope added without fee adjustment
- Hours that scope consumed

**Math:**
- Cost saved = added_scope_hours × blended_rate
- New margin = (fee − (cost − cost saved) − oop) ÷ fee

**Output:**
```
"If the additional social rollout (added in week 4 with no fee change) had been
 quoted as a separate scope:
 - Hours that would have moved to billable: 24h
 - Margin improvement: +6 points (32% → 38%)
 - Verdict: This is the biggest single leak. Future projects should require
   a change order before any new workstream starts."
```

## Scenario E: OOP renegotiation

**When to run:** OOP is unusually high (>15% of fee, or above the user's history
average).

**Inputs:**
- Specific OOP line items
- Plausible alternates (different supplier, in-house option, lower-spec)

**Output:**
```
"OOP came in at £6,400 (14% of fee) — above your average of 8%. Drivers:
 - Stock photography: £2,200 (could have used unsplash + commissioned shots)
 - Print proofs: £1,800 (3 rounds — could have been 1 with better digital review)
 - Verdict: £2-3k recoverable through OOP discipline alone."
```

## Scenario F: Pitch effort recovery

**When to run:** Project is type=pitch (won) AND margin is low.

**Inputs:**
- Pitch effort hours and cost (pre-fee work)
- Project fee from the win

**Output:**
```
"This pitch took 80h of senior time (~£7,500 in pre-fee cost). At 24% margin
 on a £45k fee, the project nets £11k after costs but only £3.5k after the
 pitch investment is amortised. To recover pitch effort, you need wins
 averaging 35%+ margin or fees averaging £60k+. Worth tracking pitch ROI as
 a separate metric."
```

## How to choose scenarios for the output

Run the math for all six in your head, then include only the 3 most informative:

1. **The biggest single lever** — the scenario that would have moved margin most
2. **The structural lesson** — the scenario that points to a process or pricing fix
3. **The fee scenario** (always include) — what the project should have cost

Skip scenarios that move <2 margin points unless they reveal a structural issue.
Never pad — the output should make the lesson obvious.

## What to write

Each scenario gets exactly 4 lines:
1. **The change** (one sentence)
2. **The numbers** (real, from this project)
3. **The new margin**
4. **Verdict** (one sentence — what to learn or do)
