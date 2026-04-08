# Invocation Contract

This is the formal contract for calling `/creativestack:source-scrape` from another skill (or directly from the user). Read this first when called by a caller skill.

## Quick reference for caller skills

If you're a CreativeStack skill and you want research evidence, your call should look like this in your conversation flow:

> "I'll call `/creativestack:source-scrape` with query='{the query}', mode='{mode}', output='{report|data}'."

You don't literally invoke a function — you describe the call in plain language and the user-facing flow handles execution. The point is: **be explicit about query, mode, and output format** so source-scrape knows exactly what you want.

## Input parameters

### Required

| Parameter | Type | Description |
|---|---|---|
| `query` | string | The research question. Be specific. "premium skincare visual trends 2026" is better than "skincare". |
| `mode` | enum | One of: `trends`, `brands`, `landscape`, `visual`, `evidence`, `people` |

### Optional

| Parameter | Type | Default | Description |
|---|---|---|---|
| `output` | enum | `report` | `report` for human-readable markdown, `data` for skill-parseable structured output |
| `include` | array | `[]` | Source names to prioritise (overrides default selection) |
| `exclude` | array | `[]` | Source names to skip |
| `time_window` | string | `last_year` | One of: `last_3_months`, `last_6_months`, `last_year`, `2_years`, `2025_onwards` (or any explicit range) |
| `max_per_source` | int | 3 | Cap on results per source |
| `target_sources` | int | 6-10 | Total source count to hit |

## Mode selection guide for callers

| If you need... | Use mode |
|---|---|
| Pattern signals, "rise of / shift toward" language, dated for velocity | `trends` |
| A specific brand's recent campaigns, visual identity, activity | `brands` |
| A broad sweep of a category for white-space identification | `landscape` |
| Heavy visual references for mood boards, design inspiration | `visual` |
| Stats, quotes, attributable data points to back claims | `evidence` |
| Creative directors, founders, decision-makers, recent moves | `people` |

When in doubt: `trends` for "what's happening", `brands` for "who's doing what", `landscape` for "what's the field", `visual` for "what does it look like", `evidence` for "prove it", `people` for "who matters".

## Output schemas

### `report` output

Human-readable markdown. Use for direct user consumption or when you'll cite-and-paraphrase the results in your own output.

Top-level sections (always present):
- `# Source Scrape: {Query}` — header with metadata
- `## Key Findings` — 3-5 deduplicated bullets
- `## Synthesised Themes` — patterns across sources
- `## Visual Reference Sheet` — annotated screenshots grouped by visual pattern
- `## By Source` — per-source breakdown with quality scores
- `## Coverage Gaps` — what couldn't be found
- `## Source Quality Summary` — table

### `data` output

Skill-parseable. Use when you need to extract specific items into your own output structure. Predictable headings, stable field names.

Top-level sections (always present, in order):
1. `# SOURCE_SCRAPE_DATA` + metadata block
2. `## FINDINGS` — list of findings with stable fields (`id`, `source`, `headline`, `date`, `freshness`, `excerpt`, `url`, `quality`, `corroborated_by`)
3. `## VISUAL_CAPTURES` — list of annotated screenshots (`id`, `source`, `subject`, `visual_qualities`, `mood`, `relevance`, `visual_pattern`)
4. `## THEMES` — list of themes (`id`, `name`, `description`, `supporting_finding_ids`, `supporting_capture_ids`)
5. `## COVERAGE_GAPS` — bullet list
6. `## SOURCE_SCORES` — list of per-source scores (`source`, `relevance`, `authority`, `recency`, `depth`, `total`, `freshness`, `notes`)

**Stable field guarantee:** Field names in `data` output never change. If you grep for `headline:` you'll find every headline. If you grep for `visual_pattern:` you'll find every pattern label. This is the contract.

## Caller examples

### Example 1: trend-report calling for evidence

> "I'll call `/creativestack:source-scrape` with query='quiet luxury packaging 2026', mode='trends', output='data', time_window='last_6_months'."

What trend-report does with the result: parses `## FINDINGS` for dated signals, parses `## THEMES` for trend candidates, uses `freshness` field for velocity scoring, uses `## COVERAGE_GAPS` to decide whether to widen the query.

### Example 2: design-research calling for visual evidence

> "I'll call `/creativestack:source-scrape` with query='warm minimalism food brand identity', mode='visual', output='data', target_sources=8, max_per_source=4."

What design-research does with the result: parses `## VISUAL_CAPTURES` grouped by `visual_pattern`, references `subject` and `visual_qualities` directly in research boards, uses `source_url` for citations.

### Example 3: pitch-research calling for prospect background

> "I'll call `/creativestack:source-scrape` with query='Oatly recent campaigns 2025-2026', mode='brands', output='report', time_window='last_year'."

What pitch-research does with the result: cites the full report inline in the prospect background section, references quality scores to flag confidence.

### Example 4: pitch-research calling for decision-makers

> "I'll call `/creativestack:source-scrape` with query='Oatly creative leadership', mode='people', output='data'."

What pitch-research does with the result: parses for named individuals, current roles, recent moves, quotes — populates the decision-maker profiles section.

## Session caching

Caller skills should be aware: if `/creativestack:source-scrape` was already run earlier in the conversation with the same query and mode, the second call **reuses the prior result**. This is intentional — avoids redundant scraping.

If you need a fresh scrape (e.g. you're checking for updates), include something like `(fresh)` or a different time_window in your query, or explicitly tell the user "this needs a fresh scrape."

## When source-scrape returns Coverage Gaps

If `## COVERAGE_GAPS` lists significant gaps, the caller should:

1. **Decide whether the gaps are blocking.** Sometimes the missing piece is critical; sometimes it doesn't matter.
2. **If blocking**: fall back to your own WebSearch, ask the user for the missing info, or explicitly note the limitation in your final output.
3. **Never silently ignore gaps.** A trend report built on thin evidence is worse than one that admits what it doesn't know.

## When source-scrape used the WebSearch fallback

The output header will say `**Method:** WebSearch fallback (browse daemon unavailable)`. When this happens:

- Visual captures will be **descriptions, not screenshots** (WebSearch can't capture images)
- Quality scores apply to text findings only
- Caller skills that depend heavily on visual evidence (`/creativestack:design-research`, `/creativestack:competitor-audit` in visual sections) should warn the user that visual evidence is text-only for this run

## Direct user invocation

When called directly by the user (not by another skill), source-scrape asks for the query and mode interactively, defaults `output` to `report`, and uses the user's `sources.md` (Brain) if it exists.
