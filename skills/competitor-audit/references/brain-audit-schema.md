# Brain Audit Schema, Versioning, and Flow

This file defines:
1. Schema for `~/.creativestack/competitor-audits/{category-slug}.md`
2. Versioning rules and Shift mode diff logic
3. Conflict of interest flow (the first check every audit runs)
4. Source-scrape call patterns for audit research
5. Handoff rules to downstream skills

Competitor audits are one of the highest-value persistent brain artifacts.
A category audit reused across multiple projects saves days of research per
pitch and compounds intelligence over time. This file is the operational
reference for making that happen.

---

## 1. competitor-audits/{category-slug}.md schema

Per-category file. Accumulates intelligence over time. Gets versioned on
significant updates but retains full history.

```markdown
---
category: Sport (running)
slug: sport-running
version: 2.1
previous_version: 2.0
last_audit_date: 2026-04-15
first_audit_date: 2025-09-03
audit_count: 4
status: active
top_competitors: [Nike, Adidas, New Balance, On Running, Tracksmith, Hoka, Asics]
conflicts_flagged: [Adidas]
aggregate_category_health: growing
prepared_by: Sarah Chen
---

# Competitor Audit — Sport (Running) — v2.1

## Version history

| Version | Date | Major change |
|---|---|---|
| 1.0 | 2025-09-03 | Initial audit |
| 1.1 | 2025-11-10 | On Running rebrand update |
| 2.0 | 2026-01-22 | Adidas Yeezy split, Nike Air platform shift |
| 2.1 | 2026-04-15 | Tracksmith cultural capital spike, New Balance agency shift |

## Shift summary (2.0 → 2.1)

{What's changed since the last version — the most valuable section of any
re-audit. Surfaces movements that would otherwise be invisible.}

### Competitor shifts
- **Tracksmith:** cultural capital 3/5 → 4/5. Driven by festival partnerships
  and editorial campaign. Watch for continued acceleration.
- **New Balance:** agency shift detected. Previously Doubleday & Cartwright,
  now Mother. Campaign activity slowed as new agency ramps. 6-month
  vulnerability window.
- **Nike Air:** narrative strength dipped from 5/5 to 4/5. Messaging feels
  less coherent since the platform restructure.

### New entrants
- **Hoka:** added to top competitors list (was tier 2 in v1.1, now tier 1)

### Exited competitors
- {None this cycle}

### Category shifts
- "Action photography" code continues to erode. 3 of 8 audited competitors
  now break it (was 2 in v2.0).
- New code emerging: product-focused still photography without lifestyle
  context (On Running, Hoka, now partial adoption by Asics).

### Conflict status
- Adidas remains flagged (client since Q3 2024). Audit treats Adidas with
  summary-level analysis only — no vulnerability section for ethical
  reasons.

## Conflict of interest check

- **Brand audited:** Nike (Air division)
- **Client overlap:** Adidas (per clients.md, active since 2024-08)
- **Decision:** Proceed with explicit Adidas redaction in vulnerability
  section. User acknowledged 2026-04-15.

## Brand overview — Nike (Air division)

{Per the main audit output}

## Competitive landscape

{Per the main audit output, with Adidas flagged as "redacted — client conflict"}

## Scoring

{Per the scoring-rubrics.md methodology}

## Category codes

{Per the category-codes.md methodology}

## Vulnerabilities

{Per the vulnerability-patterns.md methodology — Adidas excluded}

## 3 brands to watch

{The prioritised watch list — who to monitor most closely in the next 3-6 months}

## Sources

{All sources with URLs and dates}

## Confidence summary

{Per-section confidence, per the existing methodology}

## Brain overlays applied

{What this audit pulled from the brain}
```

### Frontmatter field reference

| Field | What it does |
|---|---|
| `category` | Human-readable category name |
| `slug` | URL-safe category slug, used for file naming |
| `version` | Semver-style |
| `previous_version` | The version this one evolved from |
| `last_audit_date` / `first_audit_date` | ISO dates |
| `audit_count` | How many times this audit has been refreshed |
| `status` | `active` / `archived` |
| `top_competitors` | Array of competitor names — used for quick lookup |
| `conflicts_flagged` | Array of competitors that are also current clients |
| `aggregate_category_health` | `growing` / `stable` / `declining` / `consolidating` |
| `prepared_by` | Name of the person who ran the most recent audit |

### Slugging rules

Category slugs should be specific enough to be unique but broad enough to
be reusable:

- Sport (running) → `sport-running`
- Fintech (consumer banking) → `fintech-consumer-banking`
- Luxury watches → `luxury-watches`
- Craft beer → `craft-beer`
- Fashion (streetwear) → `fashion-streetwear`

If multiple sub-categories matter, create separate files:
- `fashion-streetwear.md`
- `fashion-outdoor.md`
- `fashion-designer.md`

Don't lump them into one file. Different sub-categories have different
competitors, codes, and vulnerabilities.

---

## 2. Versioning rules

### Version numbers

- **v1.0** — first audit for this category
- **v1.x** — refreshes within a quarter (competitor update, minor shifts)
- **v2.0** — major update (new top competitors, major agency shifts, new
  category codes emerging, 6+ months since v1.x)
- **v3.0+** — same rule as v2.0

### When to bump

- **v1.1+** — routine refresh, single competitor rebrand, new campaign to track
- **v2.0+** — significant category shift, new entrants, old competitors exit, methodology change

### Never overwrite

- Previous versions are never overwritten
- Every update preserves the full history in the `Version history` table
- Old audit text can be retained or summarised as the file grows, but the
  historical record is the whole point

### Freshness thresholds

Competitor audits go stale faster than most brain files. The freshness
threshold is **90 days**. An audit older than 90 days should be flagged
at the end of any skill that reads it (per the Brain Freshness Check in
the preamble).

When a user runs competitor-audit on a category that has a stale saved
audit, default to **Shift mode** rather than a fresh Audit run. Shift mode
is faster and preserves the accumulated intelligence.

---

## 3. Shift mode diff logic

Shift mode reads the previous saved version and surfaces what's changed
since. It's where the audit skill earns its value as a persistent
intelligence system.

### What to diff

For each section of the saved audit:

1. **Competitor scoring** — which scores moved, by how much, why
2. **Category codes** — what's stable, what's eroding, what's emerging
3. **Vulnerabilities** — which archetypes appeared or disappeared per competitor
4. **Top competitors list** — new entrants, exits, tier changes
5. **Cultural capital** — who's gained, who's lost attention
6. **Agency activity** — visible agency shifts, campaign cadence changes
7. **Sources** — what's changed in press coverage and visible activity

### Diff output format

```markdown
## Shift Summary — {Category} — v{previous} → v{current}

**Period covered:** {previous date} → {today}
**Time elapsed:** {N months}
**Refresh triggered by:** {user request / freshness threshold / specific event}

### Most significant shifts (top 3)

1. **{Competitor or category-level shift}** — {what changed} — {why it matters}
2. **{Shift}** — ...
3. **{Shift}** — ...

### Competitor score changes

| Competitor | Rubric | Previous | Current | Delta | Driver |
|---|---|---|---|---|---|
| {name} | Narrative Strength | 4/5 | 5/5 | ↑ | New platform campaign |
| {name} | Visual Identity | 18/25 | 14/25 | ↓ | Recent rebrand feels unfinished |
| {name} | Share of Voice | 3/5 | 5/5 | ↑↑ | Cultural moment this quarter |

### Category code shifts

- **{Code}** — stable → eroding ({who broke it})
- **{Code}** — emerging → convention ({who adopted it})
- **{Code}** — new emergence ({who started it})

### New competitors identified
- **{name}** — tier 2 → tier 1 because {reason}
- **{name}** — new entrant since last audit

### Exited competitors
- **{name}** — moved out of category OR de-prioritised

### New vulnerabilities surfaced
- **{Competitor}** — new vulnerability: {archetype}. Evidence: {what changed}.

### Resolved vulnerabilities
- **{Competitor}** — previously flagged for {archetype}. Resolved via {what they did}.

### Agency activity
- **{Competitor}** — agency shift detected (or not). Campaign cadence: {stable / slower / faster}.

### What to do about it
{2-3 specific actions the team should take given these shifts — not just "be aware"}
```

### Shift mode is the default for re-audits

Whenever a user runs `/competitor-audit` on a category that
already has a saved version in `competitor-audits/`, default to Shift mode.
Only run a full Audit if the user explicitly asks for it, or the previous
version is older than 12 months (at which point a full re-audit is worth
the effort).

---

## 4. Conflict of interest check

**This runs as the first step of every audit.** Before any research
happens, check for conflicts.

### The check

1. Read `clients.md`
2. Identify the brand being audited and the expected top competitors
3. Cross-reference against the client list:
   - Is the brand being audited a current client? → **Hard stop**
   - Is any expected competitor a current client? → **Flag and ask**
   - Is any expected competitor a recent past client? → **Flag and note**

### Flow

**Case 1: The brand being audited is a current client**

> "⛔ **Conflict of interest.** {brand} is a current client per clients.md
> (active since {date}). Running a competitive audit where they're the
> target raises confidentiality concerns. This audit cannot proceed.
>
> If you meant to audit their competitors *for them*, reframe the category:
> what are you trying to help {brand} understand?"

Hard stop. Refuse to continue until the framing changes.

**Case 2: A competitor is a current client**

> "⚠️ **Conflict of interest flag.** {competitor} is a current client per
> clients.md. Including them in this audit means:
>
> - Their positioning and vulnerabilities will be analysed
> - Your notes will live in the brain
> - This creates a confidentiality risk if the notes leak or are shared
>
> Options:
> 1. **Proceed with redaction** — {competitor} is summarised at high level
>    only; no vulnerability analysis, no scoring beyond what's public
> 2. **Proceed with exclusion** — {competitor} is excluded from the audit
>    entirely
> 3. **Abort** — don't run this audit
>
> Which do you want?"

Wait for explicit user choice before continuing. Record the choice in the
audit's `conflicts_flagged` frontmatter and in the Conflict of Interest
Check section of the output.

**Case 3: A competitor is a recent past client (<2 years)**

> "ℹ️ **Note:** {competitor} was a past client ({dates}). You may have
> inside knowledge that shouldn't inform this audit. The audit will
> proceed, but the Vulnerabilities section for {competitor} will be
> flagged as 'from public sources only' — don't include anything you know
> from the past engagement."

Proceed, but flag the section.

### Why this matters

Creative agencies have stronger ethical obligations than most businesses
around client confidentiality. An audit that leaks past-client knowledge
into a competitive analysis can end relationships and damage reputation.
The skill should make it impossible to accidentally produce such an audit
without the user explicitly acknowledging the risk.

### Clients.md read format

The skill expects `clients.md` to have entries like:

```markdown
## Active clients
- **Adidas** — brand refresh + campaign work — since 2024-08
- **Tate Modern** — identity refresh — since 2025-11

## Past clients
- **Nike (SB division)** — 2022-2023 — brand campaign
```

If `clients.md` doesn't follow this structure, the skill reads what it can
and surfaces uncertainty:

> "⚠️ clients.md exists but doesn't follow the expected structure. I
> can't confidently check for conflicts. Please confirm: are any of these
> competitors current or past clients? {list}"

---

## 5. Source-scrape call patterns

The audit is built on `/source-scrape` output. These are the
standard call patterns:

### Visual identity research

```
mode: visual
query: "{brand} {category} brand identity visual system"
target_sources: 8-10
max_per_source: 3-4
```

Parse `## VISUAL_CAPTURES` for annotated screenshots. Use `visual_qualities`
verbatim in the Visual Identity Comparison rubric. Group by `subject`
(which competitor).

### Brand activity research

```
mode: brands
query: "{brand} {top 3 competitors} recent campaigns"
time_window: last_year
target_sources: 10
```

Parse `## FINDINGS` for messaging themes and `## THEMES` for cross-competitor
patterns. Feed into Messaging Themes and Narrative Strength sections.

### Cultural capital research

```
mode: landscape
query: "{brand} {competitors} cultural moment references press"
target_sources: 10
```

Parse for press mentions, creator adoption, meme presence. Feed into
Cultural Capital scoring.

### Agency attribution research (NEW)

```
mode: landscape
query: "{competitor} agency design credit campaign"
target_sources: 5
```

Parse for agency attribution in press or case study sites. Feed into the
"Who's their agency?" section of the audit. Useful for detecting agency
shifts in Shift mode.

### Parallel calls

Where possible, run multiple source-scrape calls in parallel to minimise
wait time. The Audit mode typically runs 3-4 calls in parallel at the
start of research.

### Coverage gap handling

If source-scrape reports `## COVERAGE_GAPS`, don't pad the affected
sections — lower their Confidence rating instead. A section marked
"Low confidence — source coverage was thin for social presence" is more
honest and more useful than a fabricated assessment.

---

## 6. Handoff rules

### Upstream

If these skills weren't run but would have strengthened the audit, suggest:

- **No trend-report** → "Run `/trend-report` first to add trend adoption scoring to each competitor."
- **No source-scrape output yet** → not a suggestion — the audit calls source-scrape itself

### Downstream

Based on the audit's findings, suggest the most relevant next step:

- **Clear competitive gaps identified** → "Run `/creative-strategy` to turn these gaps into strategic territory."
- **Preparing for a pitch** → "Run `/pitch-research` on the specific prospect to layer pitch-specific intelligence on top of this category audit."
- **Rebrand brief in progress** → "Run `/creative-brief` — this audit will automatically inform the Category Context and Tension sections."
- **Brand tension visible** → "Run `/creative-brief` or `/brief-sharpener` to articulate the tension explicitly."
- **Code-break opportunity clear** → "Run `/design-research` to build visual references for the code-break approach."
- **Audit is stale / Shift mode surfaced major changes** → "The category has shifted significantly. Consider flagging in `/status-update` for client-relevant projects."

Suggest 1-2 chains at most. Pick the most urgent.

### Not suggested

- Don't suggest re-running the audit on the same category
- Don't suggest skills that have already run this session
- Don't suggest skills that require brain data the user doesn't have

---

## 7. Privacy

Competitor audits contain:
- Subjective assessments of competitor weaknesses
- Strategic recommendations that could be sensitive if leaked
- Possibly past-client intelligence (which must be handled per the COI rules)
- Agency intelligence (who's working for whom)

Rules:

- **Don't log assessments that you wouldn't want forwarded to the competitor being audited.**
- **Don't use inside knowledge from past or current client relationships** to sharpen the competitor analysis.
- **Treat the saved audit file as semi-confidential** — it's brain data, but unlike a creative brief, this file contains analysis of people and brands who didn't consent to being analysed.
- **The Conflict of Interest check is not optional.** It must run every time.

---

## 8. Archiving old audits

If a category falls out of the agency's focus, mark its audit as archived
but don't delete:

```yaml
status: archived
archived_date: 2026-12-01
archived_reason: "Agency pivoted away from running category"
```

Archived audits remain readable but don't trigger freshness warnings and
don't appear in routine listings. They can be reactivated if the category
returns to scope.
