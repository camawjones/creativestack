# WebSearch Fallback Procedure

Read this when the browse daemon is unavailable. The output format must remain identical to the browse path so caller skills don't have to branch on method — only the data-gathering technique differs.

## When to use this

You've checked for the browse daemon and it's not available:
```bash
which browse 2>/dev/null
```

Returns nothing → run the WebSearch fallback. Note in the output header:
> `**Method:** WebSearch fallback (browse daemon unavailable)`

## Procedure

### Step 1: Source-scoped queries

For each source you'd normally hit, run a WebSearch query scoped to that domain:

```
{query} site:itsnicethat.com
{query} site:creativereview.co.uk
{query} site:thedieline.com
```

This gets you the top results from each curated source without having to navigate the site directly.

Run these queries in parallel where possible (multiple WebSearch calls in one message).

### Step 2: Open-web sweep

Run 2-3 broader WebSearch queries to catch sources outside the curated library:

```
{query} 2025 site:.com -pinterest -reddit
{query} case study
{query} {category} report
```

The `-pinterest -reddit` exclusions cut noise. Use `-{domain}` to skip sources you don't trust.

### Step 3: WebFetch the top results

For each promising URL from steps 1 and 2:

1. WebFetch the URL with a prompt like: "Extract: headline, publication date, author, key quotes, key claims, brief summary, any visual/design descriptions."
2. Capture the structured response into your findings list

### Step 4: Convert to standard output format

The output is identical to the browse path with these substitutions:

| Browse path | WebSearch fallback |
|---|---|
| Annotated screenshot | **Visual description** (text-only — pulled from article descriptions of imagery) |
| `**Visual qualities:**` (from screenshot) | `**Visual qualities (described):**` (from article text or WebFetch summary) |
| `## Visual Reference Sheet` | `## Visual Reference Sheet (text descriptions only — no screenshots)` |
| Source quality `Recency` from page metadata | `Recency` from publication date in WebFetch result |

Everything else stays the same: scoring, deduplication, theme synthesis, coverage gaps, output format.

### Step 5: Flag the limitation

In the output header AND in coverage gaps, explicitly state:

> **Method:** WebSearch fallback (browse daemon unavailable)
> Visual evidence is text-described only. For annotated screenshots, run `/browse` to set up the browse daemon and re-run this scrape.

In `## Coverage Gaps`:
> - No visual screenshots captured (browse daemon unavailable). Visual qualities are described from article text only and may be inaccurate or incomplete.

## Quality scoring under fallback

The 4-dimension scoring rubric still applies, but with these adjustments:

- **Relevance:** unchanged
- **Authority:** unchanged
- **Recency:** unchanged (date still extractable from WebFetch)
- **Depth:** **cap at 4 instead of 5** — WebFetch summaries are inherently less rich than direct page reads. A "5" requires deep direct engagement with the source.

Note this cap in the source notes column: `WebSearch fallback — Depth capped at 4`.

## Source coverage under fallback

Some sources don't index well in WebSearch:
- **Behance, Dribbble:** WebSearch returns project pages but extracting visual evidence is hard. Note in coverage gaps if you tried these and couldn't get usable evidence.
- **Awwwards:** Same — WebSearch finds entries but the visual quality description requires the actual page.
- **Paywalled sources (AdAge, Campaign):** WebSearch returns headlines and abstracts only. Score Depth as 1.

These limitations are why the browse daemon is preferred. The fallback works but misses ~30% of the value, particularly for `visual` mode.

## When `visual` mode is requested under fallback

This is the worst-case scenario for the fallback — visual mode without screenshots is significantly degraded. Tell the user/caller:

> "Visual mode under WebSearch fallback returns text descriptions only — no annotated screenshots. For full visual evidence, run `/browse` to enable the browse daemon and re-run. Continuing with text descriptions..."

Then proceed. Caller skills like `/design-research` and `/competitor-audit` will know from the method header to warn the user that visual evidence is limited.

## When `evidence` mode is requested under fallback

This is the **best-case scenario** for the fallback — `evidence` mode is mostly text-based (stats, quotes, claims), and WebSearch + WebFetch handles it well. Quality should be near-parity with the browse path. Don't apologise for the fallback in this mode unless specific sources couldn't be accessed.

## Caching applies to fallback too

Session-cache rules from SKILL.md still apply. If a fallback scrape was run earlier in this session for the same query+mode, reuse it.
