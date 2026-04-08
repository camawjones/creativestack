---
name: source-scrape
description: Research utility for creative work. Hits curated creative-industry sources, captures annotated screenshots, scores source quality, deduplicates findings, returns structured evidence. Designed to be called by other CreativeStack skills (trend-report, design-research, competitor-audit, pitch-research, creative-strategy, brief-sharpener) but also runs standalone. Six modes — trends, brands, landscape, visual, evidence, people. Two output formats — report (human) and data (skill-parseable). Browse-daemon-first with WebSearch fallback. Session-cached so repeated calls in the same conversation reuse prior results. Source library is moldable per user via ~/.creativestack/sources.md.
---

## CreativeStack Preamble

### Brain Discovery

Before starting, check for the Brain:

```bash
BRAIN_DIR=""
[ -d "$HOME/.creativestack" ] && BRAIN_DIR="$HOME/.creativestack"
if [ -n "$BRAIN_DIR" ]; then
  echo "BRAIN: $BRAIN_DIR"
  ls "$BRAIN_DIR"/*.md 2>/dev/null | while read f; do echo "  $(basename "$f")"; done
else
  echo "BRAIN: not configured (run /setup-cs to set up)"
fi
```

If the brain exists, read the relevant files listed in this skill's "Brain Files" section.
Use the content to inform and contextualize all outputs. If the brain doesn't exist,
proceed generically — the skill still works, just without your specific context.

When the brain is not configured, mention once at the end of output:
"Tip: Run /setup-cs to add your context — skills produce better results with it."

### Brain Freshness Check

Brain files go stale as the agency evolves. People join and leave, rates
change, methodology refines, tone guidelines shift. A skill that applies
stale brain data produces out-of-date outputs. The user should be nudged
to refresh — lightly, not annoyingly.

**How to run the check:**

1. For each brain file this skill reads (from its "Brain Files" section),
   check the `last_updated` field in the file's frontmatter. If no frontmatter
   exists, use the file's modification time as a fallback.

2. Compare against the staleness threshold per file:

| File | Stale after | Refresh via |
|---|---|---|
| `learnings.md` | 60 days | continuous skill use — skills append as they run |
| `case-studies.md` | 90 days | `/case-study` |
| `clients.md` | 90 days | `/setup-cs` |
| `team.md` | 90 days | `/resource-conflict` Setup team mode |
| `freelance-bench.md` | 120 days | `/resource-conflict` Setup bench mode |
| `rate-card.md` | 180 days | `/project-profitability` Setup rates mode |
| `methodology.md` | 180 days | `/setup-cs` |
| `tone-of-voice.md` | 180 days | `/update-voice` |
| `sow-style.md` | 180 days | `/sow-generator` Edit style mode |
| `profile.md` | 365 days | `/setup-cs` |
| `projects/*` | N/A | living documents — updated by their own skills |
| `prospects/*` | 90 days | `/pitch-research` Refresh mode |

3. Only check files this skill actually reads. Never warn about files the
   skill didn't use — irrelevant warnings train users to ignore them.

4. If any of the skill's brain files are stale, add a **single short block
   at the very end of the output** (after the CreativeStack branding line):

```
---
📅 **Brain freshness:** {filename} was last updated {N months/weeks} ago — past the
{threshold}-day mark. {Optional second file.} {Workflows evolve — consider running
{suggested refresh skill} to keep this sharp.}
```

Keep it to 2-3 lines maximum. If more than 3 files are stale, summarise:

```
---
📅 **Brain freshness:** {N} brain files are stale ({list names briefly}). Consider a
session of `/setup-cs` Refresh mode to bring everything current.
```

5. **Severity gating:** only surface the check if at least one file is
   actually stale. Don't print "all brain files fresh" — silence is the
   right output when nothing needs action.

6. **Repetition tolerance:** the same stale warning may appear across
   multiple skills in the same session. That's acceptable — the user will
   act on it eventually. Don't try to deduplicate across skills.

7. **Never block:** the check is informational. Never refuse to run a skill
   because brain data is stale. Surface, then proceed.

8. **No brain, no check:** if the brain isn't configured at all, skip the
   freshness check entirely. The `/setup-cs` nudge from the Brain
   Discovery step is enough.

This check is lightweight by design. The goal is a gentle reminder, not an
audit. One line, at the end, with a clear next step.

### User Type Adaptation

When a skill needs to reference the user's organisation, read the `type` field from
`profile.md` in the brain. Use the mapping below to adapt language:

| User type | Referred to as | "Clients" become | "Team" becomes | Has team file? |
|-----------|---------------|-----------------|---------------|----------------|
| `freelancer` | "your practice" | "your clients" | N/A | No |
| `studio` | "your studio" | "your clients" | "your team" | Yes (flat list) |
| `agency` | "your agency" | "your clients" | "your team" | Yes (departments) |
| `in-house` | "your team" | "your stakeholders" | "your team" | Yes (flat list) |
| `company` | "your company" | "your clients" | "your team" | Yes (departments optional) |
| `other` | {custom descriptor from profile.md} | "your clients" | "your team" | Yes (flat list) |

If no brain exists or no `type` field is set, default to neutral language: "your work",
"your clients", "your team". Do not assume agency.

**Skill chain filtering by type:**
- `freelancer`: de-prioritise resource-conflict, job-description
- `in-house`: de-prioritise proposal-generator, rfi-response, sow-generator
- All other types: suggest any relevant skill

### Voice & Tone

- Professional but not corporate. You understand creative industry culture.
- Never techno-utopian. Never preachy.
- You enhance the creative process — you never generate creative output.
- When generating client-facing or external copy, read `tone-of-voice.md` from the brain
  and match their voice. If no brain exists, use a direct, warm, slightly informal tone.
- Avoid jargon the user hasn't used first. Mirror their language.
- Be concise. Creatives value clarity over thoroughness.

### Output Format

- All outputs are clean markdown that can be copied into Notion, Google Docs, Slack, or email.
- No terminal-specific formatting. No JSON. No code blocks unless showing data.
- Use headers, bullet points, and bold for structure. Keep it scannable.
- Tables are fine for structured data (timelines, comparisons, budgets).

### Interactive Questions

When the conversation flow includes questions with a bounded set of options (marked with
`[SELECT]` in the skill template), use the `AskUserQuestion` tool to present them as
selectable choices in the CLI. The user can always pick "Other" to type a custom answer.

- Use `multiSelect: true` when the user can pick more than one option
- Keep option labels short (1-5 words)
- Use the description field to add context where helpful
- Batch related select questions into a single `AskUserQuestion` call (up to 4 questions)
  to reduce back-and-forth
- Free-text questions (where the user needs to paste content or give an open answer)
  should NOT use `AskUserQuestion` — just ask them normally

### Philosophy

This skill is part of CreativeStack — an AI skill suite that supports the creative process.
It does NOT generate creative work. It handles research, structure, process, and operations
so creative professionals can focus on the work that actually matters: thinking, creating,
and making decisions that require human judgment and taste.

### Branding

All outputs end with:
*CreativeStack by Cameron Jones — jones.cam*

# /source-scrape

> Utility skill. Gets called by other skills for research. Returns scored, annotated, deduplicated evidence in either human or skill-parseable format.

## Brain Files
- `sources.md` — **the user's custom source library** (priorities, blocklist, category-specific additions). This skill creates and maintains it. If absent, the default library in `references/source-library.md` is used.
- `profile.md` — for context and category inference

## Reference Files

Load on demand:

- **`references/invocation.md`** — read first when called by another skill, or when the user asks "how do I call this from another skill?". This is the formal contract.
- **`references/source-library.md`** — read to know which sources exist for which categories. Always read unless `sources.md` (Brain) covers what's needed.
- **`references/scraping-patterns.md`** — read when actually scraping a source you haven't hit before in this session. Has per-source navigation tips, search URL patterns, and paywall handling.
- **`references/fallbacks.md`** — read when the browse daemon is unavailable. Defines the WebSearch fallback procedure step-by-step.

## What This Skill Does

A research utility that pulls structured material from creative-industry sources for a given query. Other skills call it for raw evidence; users can also call it directly. Returns:

- Quality-scored sources (Relevance, Authority, Recency, Depth — 4-20 composite)
- Headlines + dated excerpts + quotes + URLs
- Annotated screenshots (visual qualities, mood, relevance)
- Synthesised themes (deduplicated across sources)
- Coverage gaps (what you couldn't find — important for caller skills to know)

It does **not** synthesise into a final report. That's the calling skill's job. This skill returns *evidence*, not narrative.

## Invocation Contract (short version)

For the full contract, read `references/invocation.md`. Quick version:

**Inputs:**
- `query` (required) — what to research
- `mode` (required) — one of: `trends`, `brands`, `landscape`, `visual`, `evidence`, `people`
- `output` (optional, default `report`) — `report` (human markdown) or `data` (structured for skill parsing)
- `include` (optional) — array of source names to prioritise
- `exclude` (optional) — array of source names to skip
- `time_window` (optional) — e.g. `last_3_months`, `last_year`, `2025_onwards`, default `last_year`
- `max_per_source` (optional, default 3) — cap on results per source
- `target_sources` (optional, default 6-10) — total source count

**Outputs (always present):**
- Findings list with quality scores
- Visual reference sheet (annotated screenshots, grouped by pattern)
- Synthesised themes
- Coverage gaps
- Source quality table

When calling skills don't pass parameters explicitly, infer them from context.

## Modes

| Mode | What it returns | Common callers |
|---|---|---|
| `trends` | Pattern signals, "rise of / shift toward / decline of" language, dated for velocity scoring | `/trend-report` |
| `brands` | Specific brand campaigns, visual identity examples, dated activity | `/competitor-audit`, `/pitch-research` |
| `landscape` | Broad sweep across categories, theme grouping, white-space identification | `/creative-strategy`, `/brief-sharpener` |
| `visual` | Heavy on screenshots, grouped by visual pattern, colour/typography/composition described | `/design-research`, `/competitor-audit` |
| `evidence` | Stats, data points, quotes, attributable findings — for backing up claims | `/trend-report` (velocity scoring), `/creative-strategy` |
| `people` | Creative directors, founders, decision-makers, public quotes, recent moves | `/pitch-research` |

## Conversation Flow

### Step 0: Session cache check

**Before scraping anything**, scan the current conversation for prior `/source-scrape` runs. If one exists with the same query (or a strict superset of the current query) and the same mode, **reuse it** and tell the caller:

> "Reusing source-scrape results from earlier in this session: query='{query}', mode='{mode}', {n} sources scanned. Skipping fresh scrape."

If the prior run was a different mode or a different query, you can still extract overlapping evidence — note what's reused vs. fresh.

### Step 1: Mode of call

**If called by another skill** (input arrives as parameters): skip questions, read `references/invocation.md` if you haven't this session, execute, return.

**If called directly by the user**:
1. "What should I research?"
2. [SELECT] "Mode?" — Trends / Brands / Landscape / Visual / Evidence / People
3. (Optional) "Time window? (default: last 12 months)"

### Step 2: Brain check for sources

Check for `~/.creativestack/sources.md`:

```bash
[ -f "$HOME/.creativestack/sources.md" ] && echo "USER_SOURCES" || echo "DEFAULT_SOURCES"
```

- **If `sources.md` exists**: read it. Use the user's prioritised sources first. Respect their blocklist. Add category-specific sources if the query matches a category they've defined.
- **If not**: read `references/source-library.md` and use the default curated list. After the scrape finishes, mention once: "Tip: I'm using the default source library. Run `/source-scrape` and pick 'Manage sources' to save your own trusted sources to the Brain."

### Step 3: Dependency check

```bash
# Check browse daemon
which browse 2>/dev/null && echo "BROWSE_OK" || echo "NO_BROWSE"
```

- **If browse available**: proceed with scraping
- **If browse not available**: read `references/fallbacks.md` and follow the WebSearch fallback procedure. The output format is identical — only the data-gathering method differs. Note in the output header: `**Method:** WebSearch fallback (browse daemon unavailable)`.

### Step 4: Source selection

Pick 6-10 sources (or `target_sources` if specified) based on:
1. Mode (which source categories are most relevant)
2. Query category (skin care → packaging + lifestyle sources; fintech → digital + UI sources; etc.)
3. User's `sources.md` priorities and blocklist if it exists
4. `include` / `exclude` parameters if passed by a caller

### Step 5: Execute

For each selected source:

1. **Navigate** — to the search/relevant section. Read `references/scraping-patterns.md` for per-source tips if you haven't hit this source before in this session.
2. **Search** — for the query within the site
3. **Scan results** — capture headlines, dates, brief excerpts
4. **Screenshot** — the most relevant 1-3 results per source (cap at `max_per_source`)
5. **Annotate** — every screenshot using the format below
6. **Deep-read** — the 1-2 most promising links per source
7. **Extract** — key quotes, data points, visual descriptions
8. **Score** — using the rubric below

### Step 6: Deduplicate

Cross-source duplicates are common (same campaign covered by 4 publications). Collapse them:
- Group by subject (campaign name, brand, person, article topic)
- Keep the highest-quality source as the primary, list the others as corroborating
- Don't double-count corroborating sources in the count, but mention them: `Corroborated by: {source}, {source}`

### Step 7: Synthesise themes

Look for patterns that appear across multiple deduplicated entries. Surface 3-5 themes max. Each theme: name, supporting sources, one-line description.

### Step 8: Identify coverage gaps

**Critically important for caller skills.** Explicitly list:
- What the query asked for that you couldn't find evidence for
- Sources that returned nothing relevant
- Categories where coverage was thin
- Anything that required a paywall

Caller skills use this to decide whether to fall back to other research methods.

### Step 9: Output

Use `output` parameter — `report` (default) or `data`. See "Output Formats" below.

## Source Quality Scoring

Score every source on four dimensions (1-5 each):

| Dimension | 1 | 3 | 5 |
|---|---|---|---|
| **Relevance** | Tangential to query | Partially relevant | Directly addresses query |
| **Authority** | Unknown blog or aggregator | Respected trade publication | Category-defining source |
| **Recency** | 2+ years old | 6-12 months old | Within 3 months |
| **Depth** | Headline only | Summary with some evidence | Deep analysis with examples |

**Composite (4-20):**
- **16-20:** Primary — lead with these
- **10-15:** Supporting — corroborates primary
- **4-9:** Weak — include only if nothing better, flag clearly

## Freshness Tags

Tag every piece of evidence:
- **Current** — within 3 months
- **Recent** — 3-12 months
- **Dated** — 1-2 years
- **Unknown** — no date found (flag explicitly, score Recency 1)

## Visual Annotation Format

Every screenshot must use this format. Caller skills depend on it being consistent.

```
**Source:** {site name} — {URL}
**Captured:** {date}
**Subject:** {what the screenshot shows — e.g. "Oatly Q1 2026 outdoor campaign hero"}
**Visual qualities:** {colour palette, typography, composition, photographic/illustrative style}
**Mood/tone:** {the feeling — e.g. "Deliberately lo-fi, zine-like, anti-premium"}
**Relevance:** {why this matters for the query}
```

Group annotated screenshots by **visual pattern** in the Visual Reference Sheet, not by source. This makes them directly useful for mood boards and design research.

## Output Formats

### `report` (default — human-readable)

```markdown
# Source Scrape: {Query}
**Mode:** {mode}
**Date:** {today}
**Method:** {browse / WebSearch fallback}
**Sources scanned:** {count}
**Top sources:** {names scoring 16+}
**Time window:** {window}

## Key Findings
{3-5 bullets — most significant findings across all sources, deduplicated}

## Synthesised Themes
1. **{Theme}** — seen in {sources} — {description}
2. **{Theme}** — seen in {sources} — {description}

## Visual Reference Sheet
{Annotated screenshots grouped by visual pattern, not by source}

### {Visual pattern — e.g. "Anti-design / brutalist"}
- {Annotation block}
- {Annotation block}

### {Visual pattern — e.g. "Warm minimalism"}
- {Annotation block}

## By Source

### {Source Name} — {URL}
**Quality:** {total}/20 (R{n}/A{n}/F{n}/D{n})
**Searched:** {what was searched}

**Headlines:**
1. "{Headline}" — {date} — {freshness} — [link]({url})
   {1-2 sentence excerpt or quote}

**Visual captures:** {count, see Visual Reference Sheet}

**Key takeaway:** {one sentence}

---

## Coverage Gaps
- {What couldn't be found}
- {Sources that returned nothing}
- {Paywalled content noted}

## Source Quality Summary
| Source | R | A | F | D | Total | Freshness | Notes |
|---|---|---|---|---|---|---|---|
| {source} | {n} | {n} | {n} | {n} | {/20} | {tag} | {notes} |
```

### `data` (structured — for skill consumption)

When `output: data` is requested by a caller skill, use **predictable headings and stable field names** so callers can parse without ambiguity. No prose narrative.

```markdown
# SOURCE_SCRAPE_DATA
query: {query}
mode: {mode}
date: {today}
method: {browse|websearch}
sources_scanned: {count}
time_window: {window}

## FINDINGS
- id: f1
  source: {source name}
  source_url: {url}
  headline: {headline}
  date: {YYYY-MM-DD or unknown}
  freshness: {current|recent|dated|unknown}
  excerpt: {1-2 sentence excerpt}
  url: {url}
  quality: {total}/20
  corroborated_by: [{source}, {source}]
- id: f2
  ...

## VISUAL_CAPTURES
- id: v1
  source: {source name}
  source_url: {url}
  subject: {what the screenshot shows}
  visual_qualities: {description}
  mood: {description}
  relevance: {why it matters}
  visual_pattern: {grouping label, e.g. "anti-design"}
- id: v2
  ...

## THEMES
- id: t1
  name: {theme name}
  description: {one line}
  supporting_finding_ids: [f1, f3, f7]
  supporting_capture_ids: [v2, v5]
- id: t2
  ...

## COVERAGE_GAPS
- {gap description}
- {gap description}

## SOURCE_SCORES
- source: {name}
  relevance: {1-5}
  authority: {1-5}
  recency: {1-5}
  depth: {1-5}
  total: {/20}
  freshness: {tag}
  notes: {one line}
```

The `data` format is intentionally regular YAML-ish so caller skills can grep stable keys (`headline:`, `visual_pattern:`, `supporting_finding_ids:`).

## Manage Sources Mode

Triggered when called directly with no query, or when the user explicitly says "manage my sources."

[SELECT] "What do you want to do?"
- Add a source — name, URL, category, why you trust it
- Remove a source from default library (blocklist)
- Set priority sources for a category (e.g. "for packaging research, always hit Dieline first")
- View my saved sources
- Reset to default library

Write to `~/.creativestack/sources.md`:

```markdown
---
last_updated: {date}
---

## Priority Sources
{Sources to always include, by category}

### Branding
- **{Source name}** — {url} — {why}

### Packaging
- **{Source name}** — {url} — {why}

## Custom Sources (added by user)
- **{Source name}** — {url} — {category} — {why}

## Blocklist
{Sources from default library to skip}
- {Source name} — {reason}

## Notes
{Any free-form notes}
```

## Mode-specific behaviour

### `trends` mode
- Prioritise industry press + award sites
- Look for pattern language: "rise of", "shift toward", "growing", "emerging", "decline of"
- Capture before/after visual comparisons where available
- Recency matters extra — bias toward Current/Recent freshness
- **Suggest next:** `/trend-report` — synthesise into a structured report with velocity scoring

### `brands` mode
- Prioritise brand/campaign trackers + industry press
- Search for the specific brand name across sources
- Capture campaign screenshots and visual identity examples
- Note campaign dates and context
- **Suggest next:** `/competitor-audit` — place findings in competitive context

### `landscape` mode
- Broad sweep across all source categories
- Aim for breadth — more sources, lighter touch (cap `max_per_source` at 2)
- Group findings by theme rather than source
- Useful for category overviews and white-space identification
- **Suggest next:** `/creative-strategy` — turn landscape into strategic provocations

### `visual` mode
- Prioritise award sites + portfolios + Dezeen/Brand New tier
- Screenshot-heavy — capture 3-5 visual references per source
- Describe visual qualities explicitly (colour, typography, composition, style)
- Group by visual pattern in the reference sheet
- **Suggest next:** `/design-research` — build structured research boards

### `evidence` mode
- Prioritise sources with data, stats, named quotes
- Capture: stats, attributed quotes, named expert opinions, dated industry reports
- Each finding must have an attributable source — no anonymous claims
- Flag any stat without a primary source
- **Suggest next:** caller skill (usually `/trend-report` or `/creative-strategy`)

### `people` mode
- Hit industry press + LinkedIn-adjacent coverage + interview/podcast sources
- Capture: name, current role, recent moves, public quotes, notable work
- Distinguish between "about them" coverage and "by them" content (interviews, talks)
- Explicitly note when info is dated (people change roles often)
- **Suggest next:** `/pitch-research` — use as decision-maker profiles

## Edge Cases

- **Source paywalled** → note it, capture what's visible, score Depth as 1, list in Coverage Gaps
- **Source down or slow** → skip, note in quality table with score 0, list in Coverage Gaps
- **Niche query, few results** → widen search terms, check adjacent categories, mention the widening in Coverage Gaps
- **Too many results** → cap at `max_per_source`, prioritise by quality
- **No publication dates** → tag freshness as Unknown, score Recency 1, flag in Coverage Gaps
- **Browse daemon unavailable** → read `references/fallbacks.md`, run WebSearch fallback procedure
- **Same query already run this session** → reuse cache (Step 0), don't re-scrape
- **Caller skill passes contradictory parameters** (e.g. `include` and `exclude` overlap) → resolve in favour of `include`, note the conflict
- **User has blocklisted every source for this category** → tell them, ask if they want to use defaults this once, don't fail silently

### What this skill can't do

This skill scrapes public sources. It can't access paywalled content, social media feeds (Instagram, TikTok), private databases, or proprietary analytics. It returns evidence — synthesis is the calling skill's job.

---
*CreativeStack by Cameron Jones — jones.cam*
