---
name: trend-report
description: Research a category or cultural space and generate a rigorously evidenced trend report. Uses parallel research across 4+ angles, confidence scoring per claim, fact-check methodology to catch hallucinations and echo chambers, velocity scoring, capability matching, counter-trend analysis, and Slack-formatted summary. Use when researching trends in a category, building cultural context for a brief or pitch, or auditing what's shifting in a space. Chains into strategy, pitch, brief, and competitor skills.
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
  echo "BRAIN: not configured (run /creativestack:setup to set up)"
fi
```

If the brain exists, read the relevant files listed in this skill's "Brain Files" section.
Use the content to inform and contextualize all outputs. If the brain doesn't exist,
proceed generically — the skill still works, just without your specific context.

When the brain is not configured, mention once at the end of output:
"Tip: Run /creativestack:setup to add your context — skills produce better results with it."

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
| `case-studies.md` | 90 days | `/creativestack:case-study` |
| `clients.md` | 90 days | `/creativestack:setup` |
| `team.md` | 90 days | `/creativestack:resource-conflict` Setup team mode |
| `freelance-bench.md` | 120 days | `/creativestack:resource-conflict` Setup bench mode |
| `rate-card.md` | 180 days | `/creativestack:project-profitability` Setup rates mode |
| `methodology.md` | 180 days | `/creativestack:setup` |
| `tone-of-voice.md` | 180 days | `/creativestack:update-voice` |
| `sow-style.md` | 180 days | `/creativestack:sow-generator` Edit style mode |
| `profile.md` | 365 days | `/creativestack:setup` |
| `projects/*` | N/A | living documents — updated by their own skills |
| `prospects/*` | 90 days | `/creativestack:pitch-research` Refresh mode |

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
session of `/creativestack:setup` Refresh mode to bring everything current.
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
   freshness check entirely. The `/creativestack:setup` nudge from the Brain
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

# /creativestack:trend-report

> Name a space, get the trends shaping it — researched in parallel, fact-checked, and ranked by confidence.

## Brain Files
- `profile.md` (for type, specialisms, industries, growth areas)
- `case-studies.md` (to cross-reference whether you've already worked in this space)

## What This Skill Does

Takes a category or cultural space and produces a rigorously researched trend report.
Unlike a single-pass search, this skill runs parallel research across multiple angles,
aggregates and cross-references findings, scores each claim by confidence, and
fact-checks using a methodology designed to catch hallucinations and echo chambers.

The output is 4-6 trends backed by evidence, each with velocity, confidence,
visual examples, brand activity, and capability fit against your specialisms.

This is not a survey — it's a research methodology. The point is trustworthy findings,
not pretty findings.

## Adapt to user type

Read `profile.md` and use the User Type Adaptation mapping from the preamble.
The report header, capability match, and skill chain suggestions adapt to type.
Freelancers and individuals get personal positioning; studios/agencies/companies
get organisational positioning.

## Steps

This skill follows a 6-step research methodology. Don't skip steps — each one
catches errors the previous one missed.

### Step 1: Confirm scope

Ask the user (batch into a single AskUserQuestion call where possible):

1. **Topic** — "What category or cultural space should I research?"
2. **Lens** [SELECT] — "Any specific angle?"
   - Consumer behaviour
   - Visual / design trends
   - Technology shifts
   - Messaging and language
   - Cultural / values shifts
   - Broad overview
3. **Time horizon** [SELECT] — "Emerging or established?"
   - Emerging signals — what's just surfacing
   - Established shifts — what's already moving the category
   - Both
4. **Region / cultural context** [SELECT] — "Where? Trends differ by market."
   - Global / cross-market
   - US
   - UK / Europe
   - APAC
   - Niche subculture (specify)
5. **Depth** [SELECT] — "How deep should I go?"
   - Quick scan (4 trends, ~10 minutes)
   - Standard (6 trends, full methodology)
   - Deep (8 trends, expanded sources, historical context)

### Step 2: Launch parallel research

This is the most important step. Don't do sequential search. Use the Agent tool
to spawn 4+ parallel research streams, each focused on a different angle. This
catches different signals and avoids one-source bias.

**Before launching streams**, check if `/creativestack:source-scrape` already ran in this session
for this category. If so, reuse it (the session cache will handle this automatically
on the second call). If not, kick off a `/creativestack:source-scrape` call **in parallel** with
the agent streams to gather curated industry-press evidence:

> "I'll call `/creativestack:source-scrape` with query='{category} trends {timeframe}',
> mode='trends', output='data', time_window='{matches the user's selection}'."

And a second parallel call for hard evidence (stats, named quotes, attributable claims):

> "I'll call `/creativestack:source-scrape` with query='{category} {trend topic} statistics
> reports', mode='evidence', output='data'."

The `data` output format gives you stable fields (`headline`, `freshness`, `source`,
`url`, `quality`) you can directly parse into the velocity scoring framework below.
Use the `freshness` field as a primary input to velocity classification: lots of
**Current** entries → Accelerating; mostly **Recent** → established; mostly **Dated**
or no recent coverage → Mainstream or Fading.

If the source-scrape results include a `## COVERAGE_GAPS` section, treat each gap as
a candidate for one of your parallel agent streams to fill.

**Default 4 parallel streams** (always run these):

1. **News and recent developments** — industry press, trade publications, journalism
   covering this category in the last 6-12 months. What are commentators writing about?
2. **Expert analysis and opinion** — analyst reports, expert commentary, conference
   talks, podcasts. What are the people who study this category saying?
3. **Criticism and counter-arguments** — backlash, resistance, counter-movements,
   "is X dead?" pieces. What's pushing against the dominant narrative?
4. **Industry-specific implications** — what does this mean for {creative agencies /
   studios / freelancers / in-house teams} working in this space? Adapt to user type.

**Optional additional streams** (run for Standard/Deep depth):

5. **Award sites and portfolios** — D&AD, Cannes, Brand New, It's Nice That, Awwwards.
   What's winning and getting showcased?
6. **Brand activity** — what are the leading brands in this category actually doing?
7. **Creator / social signals** — TikTok creators, Substack writers, niche communities.
   These often surface trends 6-12 months before industry press.
8. **Historical / academic** — long-form analysis, books, academic papers. What's
   the longer arc?

Use the Agent tool with `subagent_type=Explore` (or `general-purpose` if web research
is needed). Run all streams in **a single message with multiple Agent tool calls**
so they execute in parallel.

Each sub-agent should return:
- 3-5 specific findings from its angle
- Source URLs for every finding
- Direct quotes where relevant
- Anything that contradicts the dominant narrative in its lane

If browse tools / WebSearch are unavailable, fall back to training data and flag
clearly: "Based on training data — trends may not reflect the last 6 months."

### Step 3: Aggregate findings and cross-reference

Take the output from all parallel streams and synthesise:

1. **Cluster** — group similar findings across streams. If 3 streams independently
   surfaced the same shift, that's a strong signal.
2. **Identify candidate trends** — distil clusters into 4-8 candidate trends.
3. **Cross-reference against `profile.md`** — flag trends that overlap with user's
   specialisms and growth areas.
4. **Cross-reference against `case-studies.md`** — flag trends where the user has
   relevant past work to draw on.
5. **Note disagreements** — where streams contradict each other, that's interesting,
   not a problem. Surface it.

Don't promote a candidate to a final trend until it's been through Step 4 and Step 5.

### Step 4: Confidence score each claim

For every major claim in the report (not just trends — individual evidence points),
assign a confidence score:

| Score | Definition |
|-------|-----------|
| **HIGH** | 3+ independent, quality sources corroborate the claim |
| **MEDIUM** | 2 sources, OR 1 high-quality primary source |
| **LOW** | Single source, OR contradicted by other evidence |

**Quality of source matters as much as quantity.** A peer-reviewed report or named
analyst beats 5 SEO blog posts. Three articles that all quote the same WSJ piece
count as one source, not three.

Surface confidence in the report. Don't hide LOW confidence behind confident
phrasing — say "early signal, single-source" rather than dressing it up.

### Step 5: Fact-check using methodology

Before generating the final report, run a fact-check pass on every named claim,
brand example, statistic, and quote. Use this methodology:

- **Rare facts (1-2 sources)** → flag for manual validation. Mark in the report
  as "single-source — verify before using publicly."
- **Repeated facts (many sources)** → approve, UNLESS:
  - The claim is high-stakes (specific number, financial figure, accusation,
    legal claim) → still verify against primary source.
  - All sources trace back to a single original (echo chamber risk) → treat as
    one source, not many. Common with viral statistics that get repeated without
    checking.
- **Suspicious consensus** — if every source says the same thing in the same words,
  flag as "verify primary source." This is often AI slop or press-release
  laundering, not genuine consensus.
- **Brand examples** — when you cite "{Brand} did {Thing}", verify it actually
  happened. LLMs hallucinate plausible-sounding brand activity. If you can't
  verify, drop the example or replace it with a verified one.
- **Dates and timing** — verify any "in 2025" / "in Q1 2026" / "last month"
  claims. These are often wrong from training data.

Anything that fails fact-check gets removed or downgraded — not patched up.

### Step 6: Generate the structured report per output format below

Produce the final report. Include the confidence scores and fact-check notes
inline — they're features, not metadata to hide.

## Velocity Scoring Framework

Each trend gets a velocity classification with trajectory and time horizon:

| Velocity | Definition | Time Horizon | Typical Evidence |
|----------|-----------|-------------|-----------------|
| **Emerging** | Early signals, niche adoption, no mainstream uptake | 12-24 months to mainstream | 1-2 innovator brands, design press coverage, award-site spotlights |
| **Accelerating** | Growing fast, moving from niche to notable | 6-12 months to mainstream | Multiple brand adoptions in short window, trend pieces appearing, conference talks |
| **Mainstream** | Widely adopted, category standard | Already here | Majority of category using it, consumer expectation, no longer differentiating |
| **Fading** | Peak passed, fatigue setting in, backlash emerging | 6-12 months to irrelevance | Parodies appearing, "is X dead?" articles, leaders moving on |

## Output Format

# Trend Report: {Category/Space}
**Date:** {today}
**Lens:** {the specific angle researched}
**Region:** {region selected}
**Depth:** {Quick / Standard / Deep}
**Prepared for:** {name from profile.md, or "you" if no brain}

## Methodology Summary
{One short paragraph: how many parallel streams ran, how many sources reviewed,
how many claims passed fact-check vs flagged. This builds trust in the rest.}

- Parallel research streams: {N}
- Sources reviewed: {N}
- Claims flagged in fact-check: {N}
- Single-source claims (verify before public use): {N}

## Executive Summary
{3-4 sentences: the big picture of what's happening in this space and why it matters
now. Name the single most important shift a brand in this space needs to understand.}

## Velocity Overview
{Quick-scan table of all trends — designed to be glanceable.}

| Trend | Velocity | Direction | Time Horizon | Confidence |
|-------|----------|-----------|-------------|-----------|
| {trend name} | {Emerging/Accelerating/Mainstream/Fading} | {↑ ↗ → ↘ ↓} | {e.g., "6-12 months to mainstream"} | {HIGH/MEDIUM/LOW} |

## Capability Match
{Only include if `profile.md` exists. Cross-reference each trend against the user's
specialisms, capabilities, growth areas, and past case studies.}

| Trend | Capability Fit | Match Detail | Past Work | Opportunity |
|-------|---------------|-------------|-----------|-------------|
| {trend} | Strong / Partial / Gap | {which specialism connects} | {case study from case-studies.md if relevant, or "—"} | {how to position around this trend} |

**Strongest plays:** {1-2 trends where capability meets velocity AND there's
existing case-study evidence — these are pitch-ready.}

{If brain doesn't exist, omit this section.}

## Trends

### 1. {Trend Name}

**Velocity:** {Emerging / Accelerating / Mainstream / Fading}
**Trajectory:** {where it's headed and why}
**Time horizon:** {estimated months to next velocity stage}
**Confidence:** {HIGH / MEDIUM / LOW}
**Evidence for velocity:** {specific signals that justify the classification}

**What's happening:**
{Description of the trend — what it is, who's driving it, why now.}

**Evidence:**
- {Specific finding} ([source]({url})) — {confidence: HIGH/MEDIUM/LOW}
- {Specific finding} ([source]({url})) — {confidence}
- {Specific finding} ([source]({url})) — {confidence}

**Visual evidence:**
{Specific visual examples — campaigns, designs, interfaces, packaging — that
demonstrate this trend. If /creativestack:source-scrape was called in Step 2, parse the
`## VISUAL_CAPTURES` block from its data output and reference annotated screenshots
by `subject` and `visual_qualities`. Group by `visual_pattern` where multiple
captures share an aesthetic.}

**Brand examples:** _(fact-checked)_

| Brand | Execution | Position | Verified? |
|-------|-----------|----------|----------|
| {brand} | {specific execution} | Leading / Following / Resisting | ✓ / flag |

**Why it matters in {category}:**
{Specific implications for this category, not generic "stay aware of trends."}

**Fact-check notes:**
{Anything flagged in Step 5 — single sources, echo chamber risks, claims that
need primary-source verification before going public.}

---

### 2. {Trend Name}
...

{Continue for the number of trends matching the depth chosen. Fewer is fine if
evidence is strong — never pad.}

## Trend Map
{How the trends connect — tensions, amplifications, convergences.}
- {Trend 1} + {Trend 3} → {combined implication}
- {Trend 2} is accelerated by {Trend 5}
- **Tension:** {Trend 4} pulls against {Trend 6} — this tension is where interesting creative work lives.

## Counter-Trends
{Movements pushing against the dominant trends. Each counter-trend names the
specific tension it creates. Tensions are where the most interesting creative
work lives.}

### {Counter-trend Name}
- **Pushes against:** {which main trend(s)}
- **The tension:** {name the friction}
- **Who's driving it:** {brands, communities, cultural forces}
- **Evidence:** {specific examples, with confidence scores}
- **Creative opportunity:** {why this tension matters}

## What's Fading
{Trends declining or losing relevance — useful for knowing what to avoid.}
- **{Fading trend}** — {evidence it's declining} (confidence: {HIGH/MEDIUM/LOW})

## Implications for Creative Work
{Practical takeaways. Adapt to user type — freelancers get individual implications,
studios/agencies/companies get organisational ones.}

1. {Specific creative opportunity}
2. {Specific creative opportunity}
3. {Specific creative opportunity}

## Confidence Notes
{Where evidence was strong, where it was thin, what caveats apply. Be honest about
gaps — this is the trust mechanism.}

- **Strongest findings:** {which trends had the strongest evidence}
- **Weakest findings:** {which trends are early signals, not certainties}
- **Echo chamber risks:** {claims that surfaced everywhere but trace to a single source}
- **What was missing:** {gaps in source availability — paywalled reports, niche markets, etc.}

## Slack Format

*Trend Report: {Category/Space} — {Date}*

**Top trends:**
{For each trend, one line:}
• {Trend name} {🟢 Emerging / ⚡ Accelerating / ⚪ Mainstream / 🔴 Fading} {🔒 HIGH / 🔓 MED / ❓ LOW} — {one-sentence summary}

**Strongest counter-trend:** {name} — pushes against {main trend}
**Biggest opportunity:** {one line from implications}
**Methodology:** {N} parallel streams, {N} sources, {N} claims flagged
**Full report:** {note that the full version is available above}

## Sources
{All sources used across parallel streams, with links, dates, source quality,
and which finding(s) they support. Group by stream where helpful.}

## Save This Report?

Ask: "Want me to save this as a dated dossier in your brain? It would go to
`~/.creativestack/trends/{category-slug}-{YYYY-MM}.md` so you can re-run this
later and see what changed."

If yes, write to that path.

## Skill Chains

These trends are inputs to other skills. Suggest 1-2 next steps based on what
the user seems to be working toward:

- **Building a strategy?** → "Run `/creativestack:creative-strategy` — these trends will be referenced as cultural context."
- **Preparing a pitch?** → "Run `/creativestack:pitch-research {prospect}` — trend adoption gaps become pitch angles."
- **Auditing a competitor?** → "Run `/creativestack:competitor-audit {brand}` — trend positioning adds a dimension."
- **Sharpening a brief?** → "Run `/creativestack:brief-sharpener` — trend-blind assumptions will be flagged."
- **Writing a brief?** → "Run `/creativestack:creative-brief` — trend context will be woven into the background."

## Capability Boundaries

This skill uses web search and browse tools to identify and evidence trends from
public sources — articles, reports, industry commentary, award sites, portfolio
platforms. It cannot access proprietary research databases, paywalled reports, or
real-time social analytics. For niche categories, fewer trends may surface — the
skill outputs what's well-evidenced rather than padding with speculation.

The fact-check methodology catches most LLM hallucinations and echo-chamber
errors, but it is not a substitute for human verification on high-stakes claims
(financial figures, legal accusations, named-person quotes). Anything flagged
LOW or single-source should be verified before going public.

## Edge Cases

- Very niche space → fewer trends, focus on adjacent categories and extrapolate with clear labelling
- Very broad space (e.g., "technology") → ask to narrow, or structure by sub-category
- Fast-moving space → flag that trends may shift quickly, include date sensitivity
- User wants future predictions → provide trend trajectories, clearly label as speculation
- All parallel streams returned the same 3 things → expand the source list, add streams (creator signals, academic), or accept that the category is small
- Browse / WebSearch unavailable → fall back to training data, mark report as "based on training data — verify before publishing"
- No brain configured → skip Capability Match section, proceed generically
- User's region wasn't represented in source results → flag explicitly, suggest user provides regional sources for a re-run
- A trend the user expected to see is missing → ask the user, then run a targeted parallel search just for that trend before adding it

### What this skill can't do

This report uses public sources available today. With a Brain that grows over
time, it could track how trends have evolved across past reports, connect trends
to specific client briefs you've worked on, alert you when a trend you've been
watching accelerates, and surface which trends you've already explored creatively.

---
*CreativeStack by Cameron Jones — jones.cam*
