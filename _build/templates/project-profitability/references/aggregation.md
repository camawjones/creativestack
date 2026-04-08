# Aggregate Mode

Aggregate mode is the killer brain-powered feature. It reads `project-history.md`
and answers questions no single project analysis can:

- Which **clients** are most profitable for us?
- Which **project types** make us money — and which don't?
- Which **team members** consistently deliver the best margin work?
- How has profitability **trended** over time?
- Where are the **structural pricing issues**?

Requires `project-history.md` with at least 3 projects. With fewer, the skill
should not run aggregate mode — it should run Backfill mode first to populate
the history.

## Aggregation views

### View 1: By client

Group projects by client, compute aggregate metrics:

```markdown
## Profitability by Client

| Client | Projects | Total Fee | Avg Margin | Best | Worst | Trend |
|--------|----------|-----------|------------|------|-------|-------|
| Nike | 4 | £180,000 | 28% | 41% | 19% | ↓ declining |
| Tate | 3 | £165,000 | 47% | 52% | 42% | → stable |
| Adidas | 2 | £85,000 | 38% | 42% | 33% | n/a (need 3+) |

**Top earner:** Tate — 47% average margin, consistent delivery, healthy
relationship.

**Concern:** Nike margins have declined from 41% to 19% across 4 projects.
This is a structural issue, not a one-off. Either pricing has drifted, scope
has expanded without fee adjustment, or both. Worth raising at next account
review.
```

**Key insight to surface:** Clients whose margin has trended down >10 points
across multiple projects. This is the highest-leverage finding from aggregation.

### View 2: By project type

Group by `type` field (use the stable vocabulary from rate-card-schema.md):

```markdown
## Profitability by Project Type

| Type | Projects | Avg Margin | Avg Fee | vs Industry | Verdict |
|------|----------|------------|---------|-------------|---------|
| brand_identity | 5 | 38% | £55,000 | 50-60% — below | Pricing issue |
| brand_refresh | 4 | 47% | £62,000 | 45-55% — in range | Healthy |
| campaign | 3 | 33% | £75,000 | 40-50% — below | Scope issue |
| digital_product | 2 | 35% | £120,000 | 35-45% — low end | Need more data |

**Insight:** Your most common work (brand identity, n=5) is averaging 38%
against an industry healthy range of 50-60%. This is the biggest structural
opportunity in your business — closing this gap to industry average would
add ~£11,000 of profit per project.

**Insight:** Brand refresh work is your most profitable category at 47%.
Worth investing in winning more of this type.
```

**Key insight to surface:** Most-common type vs industry. If the most-frequent
work is below benchmark, that's a structural pricing/scoping issue worth
fixing across the agency.

### View 3: By team member

Group by team member appearing in the `team` field. Compute average margin
of projects they were on:

```markdown
## Profitability by Team Member

| Person | Projects | Avg Margin | Best Type | Worst Type |
|--------|----------|------------|-----------|------------|
| Sarah | 9 | 44% | brand_refresh (52%) | campaign (28%) |
| Mike | 7 | 41% | brand_identity (47%) | digital_product (33%) |
| Jade | 6 | 39% | web (46%) | brand_identity (32%) |

**Insight:** Sarah delivers the highest margin on brand refresh work but is
significantly below average on campaigns. The two campaigns she led both ran
over on revisions. Consider keeping her on brand work and rotating campaign
leadership.
```

**Caveats to communicate:**
- This is correlation, not causation. The team member isn't the only variable.
- Senior team members often appear on harder, lower-margin projects by design.
- Use as a conversation starter, not a performance review.

### View 4: Trend over time

Group by quarter or year:

```markdown
## Profitability Trend

| Period | Projects | Avg Margin | Avg Fee | Note |
|--------|----------|------------|---------|------|
| 2024 H1 | 6 | 44% | £52k | Baseline |
| 2024 H2 | 8 | 42% | £55k | Stable |
| 2025 H1 | 7 | 38% | £58k | Margin compression |
| 2025 H2 | 9 | 35% | £62k | Continued compression |
| 2026 Q1 | 4 | 33% | £61k | At risk |

**Insight:** Margin has compressed by 11 points over 18 months while average
fees have grown by 17%. You're winning bigger work but it's costing more to
deliver — a classic scaling failure. Likely culprits: senior time on
oversight rather than billable work, scope creep on larger contracts, or
under-investment in process for bigger projects.
```

### View 5: Pricing power

Cross-reference fee vs effective hourly rate:

```markdown
## Pricing Power

| Type | Avg Fee | Avg Hours | Effective Hourly | Card Hourly | Leakage |
|------|---------|-----------|------------------|-------------|---------|
| brand_identity | £55k | 480 | £115 | £140 | 18% |
| brand_refresh | £62k | 380 | £163 | £140 | -16% (above card) |
| campaign | £75k | 720 | £104 | £125 | 17% |

**Insight:** Brand refresh work bills 16% above card — your team is fast and
efficient at this work, or you're pricing it correctly. Brand identity and
campaign work both leak ~18% — fees aren't holding their hourly value.
```

## Aggregation flow

1. Read `project-history.md`
2. Confirm there's enough data: "I have {N} projects in your history. Aggregate
   needs at least 3 — you're good."
3. [SELECT] which views to run:
   - All views (default)
   - By client
   - By project type
   - By team member
   - Trend over time
   - Pricing power
4. Compute and output
5. Surface the **top 3 insights** at the top — don't make the user read tables to find them
6. Offer next steps:
   - "The brand identity gap is structural. Want to use this in `/proposal-generator` to set new floor pricing for that work?"
   - "Nike's decline is the biggest red flag. Want to draft a `/status-update` for the next account review?"

## Insight prioritisation

Aggregate output should always lead with insights, not tables. The 3 most
valuable insights to surface (in order of priority):

1. **Structural pricing issues** — work types where avg margin is materially
   below industry AND consistent across 3+ projects
2. **Declining clients** — clients whose margin has trended down >10 points
3. **Most profitable patterns to replicate** — best-margin combinations
   (specific type + specific client + specific team member)

Skip insights that require <3 data points. Skip insights that can't be acted on.

## What aggregate mode does NOT do

- It does not predict future profitability — it surfaces past patterns
- It does not assign blame — team-member views are conversation starters
- It does not replace gut judgement — context the brain doesn't have always matters
- It does not run on retainers — those use `retainer-history.md` and the
  retainer trajectory feature in retainer-analysis.md
