# Industry Benchmarks

Use these as a fallback when the user has no `project-history.md` data, or as a
sanity check alongside their own averages. **Always prefer the user's own
historical average when 3+ projects of the same type exist** — it's more
relevant than industry averages from a different agency, market, and era.

## Gross margin by project type

| Project Type | Healthy Range | Notes |
|---|---|---|
| Brand identity | 50-60% | Highest-margin work in most agencies. Strategy + craft, low OOP. |
| Brand refresh | 45-55% | Less greenfield than identity but still high-craft. |
| Campaign (single) | 40-50% | Production OOP eats margin. |
| Campaign (integrated, multi-channel) | 35-45% | Coordination tax + multiple production tracks. |
| Digital product / app | 35-45% | Long timelines, eng-heavy, hard to scope. |
| Web (marketing site) | 40-50% | Cleaner scope than product work. |
| Naming | 55-65% | Mostly senior strategy time, very low OOP. |
| Packaging | 40-50% | Mid range; OOP varies hugely (printing, dielines, stock). |
| Motion / animation | 35-45% | Long render time, freelance-heavy. |
| Print collateral | 35-45% | OOP heavy; thin margins on production. |
| Pitch (won) | n/a | Pitches are an investment — measure return across multiple wins, not a single fee. |

**Sources:** Composite of public agency reporting (Mirren, RSW/US, Wieden+Kennedy
financial filings), AIGA studio benchmarks, IPA (UK) margin surveys 2023-2025.
Numbers are directional, not authoritative — every market and every cost
structure is different.

## Other useful benchmarks

| Metric | Healthy Range | Notes |
|---|---|---|
| Revision cost as % of total | 10-15% | Above 20% = scope/process problem |
| OOP as % of fee | 5-15% | Higher for production-heavy work |
| Effective hourly rate | Should be ≥ 80% of card billing rate | Below = leakage |
| Senior-to-junior cost ratio per project | 30-50% senior | Senior-heavy = expensive, junior-heavy = quality risk |
| Pitch effort as % of annual senior creative time | <15% | Above = pitch addiction, hard to recover |

## When to override with the user's own data

If `project-history.md` has 3+ projects of the same type, use **their** average
as the primary benchmark and reference industry numbers only as a sanity check:

> "Brand refresh average: yours is 47% (n=4), industry healthy range is 45-55%.
> You're in healthy territory and consistent with your own track record."

If the user's average is materially below industry healthy range AND consistent
across 3+ projects, that's a structural pricing issue, not a one-off miss:

> "Your brand identity work averages 38% (n=5) vs industry 50-60%. This isn't a
> one-off — it's a pattern. Either your fees are too low for this work, or
> your scopes are too generous, or both. Worth a pricing review."

## When to ignore industry numbers entirely

- The user works in a regulated category with unusual cost structures (pharma, regulated finance, defense)
- The user is in a market with very different rate norms (rural agency, emerging market, highly specialised practice)
- The project has unusual constraints (charity rate, longstanding relationship discount, strategic loss leader)

In these cases, use only the user's own history. If they have none, flag the
analysis as "no benchmark — interpret with care."

## How to display benchmarks in output

In the standard output, show benchmark comparison only when it adds insight:

```markdown
## Industry Benchmark Comparison

| Metric | This Project | Your Average ({type}, n={N}) | Industry Range | Assessment |
|--------|-------------|------------------------------|----------------|------------|
| Gross margin | 32% | 45% (n=4) | 50-60% | Below both — concerning |
| Revision cost % | 28% | 14% | 10-15% | Significantly above |
| OOP as % of fee | 6% | 8% | 5-15% | In range |
```

If the user has no history, drop the middle column and use industry only.
If the user's history strongly disagrees with industry, prefer their average
and note the disagreement in plain language.
