# Retainer Analysis

Retainer analysis is fundamentally different from project analysis. Projects
are point-in-time math; retainers are **trajectories** that only make sense
across multiple months. The killer metric isn't "what was margin this month"
but "where is this heading."

## The trajectory rule

**3+ months of data is the minimum** for any trajectory call. With less:
- 1 month: snapshot only. No trajectory. Recommend monthly runs to build history.
- 2 months: directional only. "Looks like X is changing — check next month."
- 3+ months: real trajectory. Confident calls.
- 6+ months: pattern detection. Seasonal, scope creep cycles, client behaviour.

`retainer-history.md` is where the months persist. Without it, retainer mode
is degraded.

## Trajectory states

Compute trajectory by comparing the last 3 months to the previous 3 months
(or earliest available period).

| State | Trigger | Meaning |
|---|---|---|
| **STABLE** | All metrics within ±5% across periods | Healthy, no action needed |
| **IMPROVING** | Margin ↑ AND utilisation balanced | Doing better — figure out why and replicate |
| **DECLINING** | Margin ↓ 5+ points across 3 months | Action needed before next QBR |
| **CRITICAL** | Margin ↓ 10+ points OR utilisation 130%+ | Emergency — escalate now |
| **AT RISK** | Utilisation under 60% for 3+ months | Client may downgrade or cancel — value conversation needed |

The trajectory state should be the first thing in the retainer output, not
buried in the middle.

## Over-servicing detection

Over-servicing = used > allocated, persistently.

| Pattern | What it means | What to do |
|---|---|---|
| One-off spike (1 month, then back to normal) | Project peak, holiday catch-up, ad-hoc work | Note in talking points, don't escalate |
| Persistent (3+ months in a row, gradual increase) | Scope expansion, client habit forming | Renegotiate at next QBR |
| Persistent (3+ months, sudden jump) | New workstream not in original scope | Change order needed now |
| Cyclical (specific months each year) | Seasonal demand | Bake into next contract |

Always quantify the cost: `over-servicing_hours × blended_cost_rate × months`.
The number is more persuasive than the percentage.

## Under-utilisation detection

Under-utilisation = used < allocated, persistently. This is **not** a profit
win — it's a cancellation risk.

| Pattern | What it means | What to do |
|---|---|---|
| 1-2 months under | Holiday, project gap, client distraction | Monitor |
| 3+ months under at >25% gap | Client isn't getting value | Proactive value conversation: "what would you use these hours for?" |
| Under for 6+ months | Retainer is dead in the water | Recommend restructuring or honest exit conversation |

Never treat under-utilisation as a margin win without flagging the cancellation
risk. A 60%-utilised retainer at 60% margin generates less revenue than a
90%-utilised retainer at 35% margin and is far more likely to cancel.

## Scope creep indicators

Watch for **net new** workstreams added month-over-month without fee adjustment:

- New recurring task types (was email design only, now also social)
- New deliverable formats (was monthly newsletter, now also monthly report)
- New stakeholders requesting work (was one team, now three)
- Shorter turnaround expectations (was 5 days, now 2 days — same work, more cost)

Tag each detected scope addition in `retainer-history.md` with `scope_additions: N`.
Three or more in a quarter = structural scope creep, worth a renegotiation
conversation.

## Talking points framework

Every retainer analysis should produce talking points for the next client review.
Three buckets, in this order:

### 1. Value delivered (lead with this)

The client needs to feel the retainer is paying off before any tough conversation.

For each month or quarter, list the high-impact deliverables and quantify them
where possible:

> "This quarter we delivered the brand identity refresh, 12 social campaigns,
> the annual report design, and the website CMS migration — equivalent to
> approximately £42,000 at project rates against a retainer fee of £36,000.
> The retainer is paying off for you."

If the retainer is over-utilised (i.e. margin is suffering on your side), the
value framing is stronger because you've objectively given more than agreed.

### 2. Areas to discuss

Bring up scope expansion, over-servicing, or process friction in **constructive**
language. Frame it as "let's talk about how we work together" not "you owe us
hours."

> "Social content volume has roughly doubled since the retainer started — from
> 8 pieces a month to 17. This isn't a complaint; it reflects how well it's
> working. We'd like to discuss reallocating retainer hours toward this growing
> stream, or expanding the retainer to match."

### 3. Recommendations

Specific, actionable, time-boxed:

> "Three suggestions for next quarter:
> 1. Reallocate 20 hours/month from strategy (under-used) to social production
> 2. Add a quarterly content calendar workshop to reduce ad-hoc requests
> 3. Increase retainer from 80h to 100h/month to match actual usage"

Never recommend without quantifying the math.

## When to recommend retainer changes

| Trajectory | Recommendation |
|---|---|
| STABLE healthy (40%+ margin) | No change. Document the win, use as case study. |
| IMPROVING | No change. Identify what changed and replicate. |
| DECLINING (utilisation up, margin down) | Renegotiate at next QBR. Three options: (a) increase fee, (b) reduce scope, (c) shift hours between workstreams. |
| CRITICAL (margin <20% or utilisation 130%+) | Escalate now, don't wait for QBR. The retainer is losing money. |
| AT RISK (under-used) | Value conversation. Reframe what the retainer covers. Risk of cancellation is real. |

## Retainer health score

5 dimensions, 1-5 each. Use this as a quick scannable summary at the end:

| Dimension | 1 | 3 | 5 |
|---|---|---|---|
| **Utilisation balance** | Wildly over or under | Within 20% of allocation | Within 10% consistently |
| **Scope alignment** | Constant net-new work | Some scope drift, manageable | Work matches the agreement |
| **Margin health** | Below 20% | Around target | Comfortably above target |
| **Client engagement** | Sporadic, no rhythm | Regular but reactive | Consistent, planned, two-way |
| **Trajectory** | DECLINING or CRITICAL | STABLE | IMPROVING |

Total of 20-25: healthy. 15-19: monitor. <15: action required.

## What to put in `retainer-history.md` after each analysis

The current month's row, with all fields populated. The notes column should
capture anything unusual (holiday, client crisis, big launch). If the trajectory
state changes from the previous month, note that in the row too.

After 3+ months, the trajectory section of the standard output becomes
meaningful. Before then, show only the snapshot and tell the user what's
needed to unlock the trajectory feature.
