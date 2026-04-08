# Rate Card & History Schemas

This skill reads from and (with permission) writes to three Brain files:

1. `~/.creativestack/rate-card.md` — internal cost rates + billing rates
2. `~/.creativestack/project-history.md` — append-only log of every analysed project
3. `~/.creativestack/retainer-history.md` — monthly data points for each retainer

All three are hand-editable. The skill creates them on demand. Existing
`team.md` (with optional `day_rate` field per person) is read as a secondary
source — `rate-card.md` takes precedence when both exist.

---

## rate-card.md — Cost & billing rates

Two layers: **role-level** (most agencies have this) and **person-level**
(optional override). Margin math uses the most specific rate available.

```markdown
---
currency: GBP
last_updated: 2026-04-07
overhead_multiplier: 1.4
billable_target: 0.75
default_target_margin: 45
---

## Role rates

| Role | Internal Cost (day) | Billing Rate (day) | Notes |
|------|--------------------|--------------------|-------|
| Creative Director | 750 | 1500 | |
| Strategy Director | 700 | 1400 | |
| Senior Designer | 500 | 1000 | |
| Mid Designer | 350 | 750 | |
| Junior Designer | 220 | 500 | |
| Producer | 400 | 800 | |
| Strategist | 450 | 900 | |

## Person overrides

Only list people whose actual cost differs from the role default (e.g. partners,
part-timers, or people whose salary doesn't match their job title).

| Person | Role | Internal Cost (day) | Notes |
|--------|------|---------------------|-------|
| Sarah Chen | Creative Director | 850 | Partner — higher draw |
| Mike Torres | Design Lead | 540 | Part-time, 4 days/week |

## Freelance defaults

If freelance day rates aren't in `freelance-bench.md`, use these as fallbacks:

| Role | Day Rate |
|------|---------|
| Senior Designer (freelance) | 550 |
| Mid Designer (freelance) | 425 |
| Strategist (freelance) | 600 |
```

### Field reference

| Field | Required? | What it does |
|---|---|---|
| `currency` | yes | Reporting currency (GBP, USD, EUR…) |
| `overhead_multiplier` | optional | Used in setup math: salary × multiplier ÷ billable days = internal cost. Default 1.4 (40% overhead). |
| `billable_target` | optional | Used in setup math: assumed billable utilisation. Default 0.75 (75%). |
| `default_target_margin` | optional | Skips the target margin question on every run |
| Internal Cost (day) | yes | What the agency actually pays for one day of this person's time, including overhead |
| Billing Rate (day) | optional | What clients see on proposals — only used in scenario modelling |

### Internal Cost vs Billing Rate

**Critical distinction**:

- **Internal cost** is what matters for margin math. It's salary + overhead ÷
  billable days. This is the cost the agency actually bears.
- **Billing rate** is what's on the proposal. It's used in "what would the fee
  have been at full rate card" scenario modelling and aggregate-mode pricing
  insights. It's NOT used for margin calculations.

If the user only knows one number, they almost always know the billing rate.
Push for internal cost — it's the number that determines whether the project
made money.

### Setup rates flow

When the skill enters Setup rates mode and `rate-card.md` doesn't exist:

1. "What currency do you report in?"
2. "Do you want to enter cost rates directly, or compute them from salaries?"
   - **Direct** — ask role + day cost for each role they use
   - **Computed** — ask annual salary + overhead %, compute: `salary × (1 + overhead) ÷ (260 × billable_target)`
3. "Walk me through your roles. What roles do you bill, and what does each cost
   per day internally?" (batched, 3-5 at a time)
4. Optional: "Anyone whose actual cost is materially different from the role
   default? Partners, part-timers, recent hires?"
5. Optional: "Default billing rates for proposals — same roles, what do you
   charge?"
6. Write `~/.creativestack/rate-card.md`
7. Confirm: "Rate card saved. Future profitability runs will use these
   automatically — no more re-entering rates."

### Read order in Analyse mode

When computing the cost of N hours from person/role:

1. If person has an entry in `rate-card.md` § Person overrides → use that
2. Else if person has `day_rate` set in `team.md` → use that
3. Else if role has an entry in `rate-card.md` § Role rates → use that
4. Else ask the user once for that role and offer to save it to the rate card

---

## project-history.md — Project log

Append-only structured log. Every Analyse run on a project (in project mode)
creates one entry. Aggregate mode reads this file.

```markdown
---
last_updated: 2026-04-07
project_count: 14
currency: GBP
---

## 2026

### Nike Air Pitch — Nike — 2026-Q1
- type: pitch
- fee: 45000
- internal_cost: 31200
- oop_cost: 2800
- gross_profit: 11000
- margin: 24
- target_margin: 45
- variance: -21
- duration_weeks: 6
- team: Sarah, Mike, Jade, Alex (freelance)
- top_delta: Revision rounds doubled (+£8k cost)
- verdict: Lost margin to revisions; pitch effort unrecovered
- analysed: 2026-04-02

### Tate Refresh — Tate — 2026-Q1
- type: brand_refresh
- fee: 65000
- internal_cost: 32500
- oop_cost: 1500
- gross_profit: 31000
- margin: 47
- target_margin: 45
- variance: +2
- duration_weeks: 10
- team: Sarah, Jade
- top_delta: Strategy phase under-budget (-£4k)
- verdict: Healthy margin, hit target
- analysed: 2026-03-28

## 2025

### Adidas Worldwide — Adidas — 2025-Q4
- type: campaign
- fee: 120000
...
```

### Field reference

| Field | What it does |
|---|---|
| `type` | Tag for aggregation. Use a stable vocabulary: `brand_identity`, `brand_refresh`, `campaign`, `digital_product`, `web`, `pitch`, `naming`, `packaging`, `motion`, `print`, `other` |
| `client` | Already in heading, but tag explicitly to ease grep |
| `fee` | Total fee (in card currency) |
| `internal_cost` | Time cost using rate-card |
| `oop_cost` | Out-of-pocket: freelance, stock, print, travel |
| `gross_profit` | fee − internal_cost − oop_cost |
| `margin` | gross_profit ÷ fee × 100 (as integer) |
| `target_margin` | What was aimed for |
| `variance` | margin − target_margin |
| `duration_weeks` | For revenue-per-week aggregations |
| `team` | Comma list — used to compute team-member efficiency |
| `top_delta` | The single biggest factor that moved margin |
| `verdict` | Two-line plain-English summary |
| `analysed` | Date the run was performed |

### Append flow

After every Analyse run in project mode, the skill offers:

> "Save this to project-history.md? Future Aggregate runs will include it."

If yes, append (never overwrite). Group by year, then by project. Newest at top.

### Read order

Aggregate mode and any project comparison read this file. If it doesn't exist,
those features are disabled with a clear message: "No project history yet —
this is your first run, or you haven't been saving. Run a few Analyses with
'save to history' enabled, then come back."

---

## retainer-history.md — Monthly data points

The retainer trajectory feature requires 3+ months of data. This is where they
live. One section per retainer, one row per month.

```markdown
---
last_updated: 2026-04-07
retainer_count: 3
currency: GBP
---

## Tate Membership Retainer

**Terms:** 80 hours/month, brand + digital, £12,000/month
**Started:** 2025-09
**Status:** active

| Month | Allocated | Used | Variance | Margin | Over-servicing | Scope additions | Notes |
|-------|-----------|------|----------|--------|----------------|----------------|-------|
| 2026-03 | 80 | 95 | +15 | 32% | 15h | 2 | Social volume up |
| 2026-02 | 80 | 88 | +8 | 38% | 8h | 1 | |
| 2026-01 | 80 | 82 | +2 | 42% | 2h | 0 | |
| 2025-12 | 80 | 70 | -10 | 49% | 0 | 0 | Holiday shutdown |
| 2025-11 | 80 | 75 | -5 | 47% | 0 | 0 | |
| 2025-10 | 80 | 80 | 0 | 45% | 0 | 0 | First full month |

**Trajectory:** DECLINING — utilisation up, margin down 13 points in 3 months.

## Adidas Always-On

**Terms:** 60 hours/month, content + design, £9,000/month
**Started:** 2024-06
**Status:** active

| Month | ... |
```

### Field reference

| Field | What it does |
|---|---|
| `Allocated` | Hours per month per retainer terms |
| `Used` | Actual hours logged |
| `Variance` | Used − Allocated |
| `Margin` | Calculated from cost rates × used hours |
| `Over-servicing` | Hours used beyond allocation (capped at 0 if under-utilised) |
| `Scope additions` | Count of net-new tasks/workstreams added that month |
| `Notes` | Free-text reason for anomalies |

### Append flow

After every Analyse run in retainer mode, the skill offers:

> "Save this month's data point to retainer-history.md? With 3+ months I can
> show trajectory. You're at {N} months."

If the retainer section doesn't exist yet, create it (ask for the terms).
If the month already exists, ask whether to overwrite.

### Read order

In retainer mode, the skill reads the section for the current retainer.
If 3+ months exist, the trajectory section of the output becomes meaningful.
If <3, fall back to a snapshot with a note.

---

## Cross-file consistency

- All three files share the same currency. Set once in `rate-card.md`, mirrored
  in the other two.
- Dates are ISO (YYYY-MM-DD or YYYY-MM).
- Project type vocabulary is fixed (see `project-history.md` field reference).
  Stick to the list to make aggregation work.
- Never overwrite history entries. Always append. Old data is the whole point.
