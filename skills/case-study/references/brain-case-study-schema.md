# Brain Case Study Schema, Versioning & Handoffs

This file defines:
1. Schema for `~/.creativestack/case-studies/{slug}.md`
2. How it relates to the existing `case-studies.md` portfolio index
3. Versioning rules (case studies evolve with new info)
4. Multi-length output structure
5. Gap analysis logic
6. Project state write flow
7. Handoff rules

The goal is a case study artifact that lives in the brain, compounds with
new information (awards, press, new metrics), and is readable by
downstream skills (pitch-research, proposal-generator, rfi-response,
creative-brief) without re-parsing.

---

## 1. Two-file pattern: index + full file

Case studies live in two places in the brain:

1. **`~/.creativestack/case-studies.md`** — the portfolio index (existing
   file, keep appending). Short summary per case study, read by many
   other skills.

2. **`~/.creativestack/case-studies/{slug}.md`** — the full case study
   file (new). Contains the long-form narrative, multi-length outputs,
   asset brief, approval package, version history.

This pattern preserves backward compatibility — existing skills that
read `case-studies.md` keep working unchanged. The new full-file location
is additive.

### Portfolio index format (existing `case-studies.md`)

Keep the existing format. Each new case study appends a block:

```markdown
## {Client Name} — {Project Name} ({date})
- Type: {project type}
- Industry: {client industry}
- Key result: {most impressive metric or outcome}
- Services: {what was delivered}
- Tags: {industry, service type, deliverables}
- Narrative pattern: {Before/After, Tension/Resolution, Code-break, Process reveal, Unexpected outcome, Long relationship}
- Hero quote: "{short hero quote or "n/a"}"
- URL: {if published}
- Full case study: `case-studies/{slug}.md`
- Available for: pitches, proposals, RFI responses
```

The portfolio index is the **discovery layer** — other skills scan it to
find relevant case studies. The full file is the **content layer** —
where the long-form lives.

### Full file format (`case-studies/{slug}.md`)

```markdown
---
project: Nike Air Refresh
slug: nike-air-refresh
client: Nike (Air division)
industry: Sport
type: brand_refresh
version: 1.2
previous_version: 1.1
status: approved
narrative_pattern: tension_resolution
hero_quote: "We brought them onboard to refresh a logo and they redefined the brand."
hero_quote_attribution: "Marcus Liu, CMO, Nike"
primary_metric: "30% lift in unaided awareness"
created: 2026-04-15
last_updated: 2026-05-03
approval_date: 2026-05-01
published_date: 2026-05-15
published_url: https://agency.com/work/nike-air-refresh
source_mode: from_brain
brain_depth: rich
---

# {Project Name} — Case Study

## Version history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-04-15 | Initial draft from brain extraction |
| 1.1 | 2026-04-22 | Client approval cycle — quote adjustment, one metric removed |
| 1.2 | 2026-05-03 | Final version after 2 awards wins added to results |

## Extraction coverage

{The coverage report from references/extraction.md. Kept for provenance.}

## Multi-length outputs

### 1-line credential
{Single sentence, agency-facing. Used in credentials decks.}

> "We refreshed the Nike Air brand — 30% lift in unaided awareness in nine months."

### 1-paragraph summary
{For proposals, pitches, RFIs. 60-100 words.}

> "Nike Air needed a brand refresh that could scale across product,
> marketing, and retail without losing the performance heritage the
> business was built on. We led a 6-month system rebuild: typography,
> colour, motion, application guidelines, and internal governance. The
> refresh launched in Q3 alongside the Air Max 90 relaunch. In the
> first 9 months: 30% lift in unaided awareness, 2x social engagement,
> and adoption across 14 business units without central enforcement."

### 1-page case study
{The standard website case study length — 600-900 words.}

{Full narrative per the chosen pattern from craft-and-framing.md}

### Long-form case study
{For editorial, design press, or awards submissions. 1200-2000 words.}

{Longer version with process reveal, craft detail, team attribution,
client collaboration detail, unexpected outcomes section.}

## Sections (used across all lengths)

### Hero quote
> "{quote}" — {attribution}

### Challenge
{From brief § tension and real objective}

### Approach
{From brief § single-minded thought and methodology}

### Solution
{From copy deck and deliverables}

### What was hard
{From project state § open decisions + sentiment arc + post-mortem}
{Skip if no evidence exists}

### Results
{Multi-framework metrics presentation per craft-and-framing.md}

### Unexpected outcomes
{If applicable}

## Client quotes (all candidates)

{Full list of candidate quotes extracted from meeting logs, scored and
ranked. Hero quote at the top, secondary quotes below.}

| Quote | Source | Date | Score | Status |
|---|---|---|---|---|
| "{quote}" | Meeting 2026-03-22 | 2026-03-22 | 9/10 (hero) | Approved |
| "{quote}" | Meeting 2026-04-05 | 2026-04-05 | 7/10 | Secondary |

## Metrics

{All metrics considered, with framing framework used, and publication status.}

| Metric | Raw value | Chosen framing | Framework | Publishable? |
|---|---|---|---|---|
| Unaided awareness | 25% → 32.5% | "30% lift in unaided awareness" | Percentage change | ✓ Approved |
| Social engagement | 2x | "2x social engagement" | Baseline comparison | ✓ Approved |
| Sales impact | £12M | — | — | ✗ Commercially sensitive, internal only |

## Asset brief

{Full asset brief per craft-and-framing.md § "The asset brief"}

## Client approval package

{Full approval package per client-approval.md § "The approval package output"}

## Brain overlays applied

- **From `projects/{slug}-brief.md`:** tension, SMT, audience, desired response
- **From `projects/{slug}-meetings.md`:** 4 client quotes, sentiment arc
- **From `projects/{slug}-copy-deck-v1.3.md`:** hero headline, voice samples
- **From `projects/{slug}-competitor-audit.md`:** category codes, code-break framing
- **From `case-studies.md`:** style inference from 3 previous case studies
- **From `methodology.md`:** Approach structured as Discover → Define → Design → Deliver

## Handoff readiness

- ✓ Ready for `/pitch-research` — portfolio index updated
- ✓ Ready for `/proposal-generator` — case study available as brain evidence
- ✓ Ready for `/rfi-response` — relevant for sport/brand_refresh RFIs
```

### Frontmatter field reference

| Field | What it does |
|---|---|
| `project` | Human-readable project name |
| `slug` | URL-safe identifier, matches project slug |
| `client` | Client name |
| `industry` | Client industry (for filtering) |
| `type` | Project type from stable vocabulary |
| `version` | Semver-style |
| `previous_version` | Previous version this evolved from |
| `status` | `draft` / `in_review` / `approved` / `published` / `archived` |
| `narrative_pattern` | Which of the 6 patterns from craft-and-framing.md |
| `hero_quote` / `hero_quote_attribution` | The star quote |
| `primary_metric` | The single strongest metric for quick reference |
| `approval_date` / `published_date` / `published_url` | Lifecycle markers |
| `source_mode` | `from_brain` / `from_inputs` / `awards` / `update` |
| `brain_depth` | `rich` / `partial` / `minimal` |

---

## 2. Versioning rules

Case studies evolve. Results come in over time, awards get won, client
promotions create new context, press coverage adds credibility. The
versioning should accommodate this.

### Version numbers

- **v1.0** — initial case study, first draft written
- **v1.x** — minor updates (new metric, new award, client feedback from
  approval cycle, press mention)
- **v2.0** — major rewrite (significant new evidence, new narrative
  pattern, client relationship changed, additional project phase
  completed)
- **v3.0+** — same rule as v2.0

### When to bump

- **v1.1+** — new supporting evidence that doesn't change the story
  (awards, press, updated metric, new client quote)
- **v2.0+** — new story (the unexpected outcome turned out to be bigger
  than the original result, a follow-on project changed the narrative,
  the client's brand direction shifted)

### Never overwrite

- Previous versions are never overwritten
- Every update preserves the version history in the frontmatter table
- Old narrative can be compressed in the file as the version count grows,
  but the history stays

### Update mode flow

When the user runs case-study in Update mode:

1. Read the existing `case-studies/{slug}.md` file
2. Ask: "What's new?"
   - New metric or result
   - New award or recognition
   - New press mention
   - Client relationship change (promotion, new phase, departure)
   - Correction to existing content
3. Determine version bump type (minor vs major)
4. Update the case study with the new material, preserving previous content
5. Append to version history
6. Update the portfolio index in `case-studies.md`
7. If major version (v2.0+), regenerate the approval package (may need
   re-approval)

Update mode is lightweight — it adds rather than rewrites. Most updates
are minor (new metric, new award) and should complete quickly.

---

## 3. Multi-length output structure

All case studies produce four lengths from the same source material. The
skill generates them together, not on demand.

### Length 1: 1-line credential (10-20 words)

**Purpose:** Agency-facing. Used in credentials decks, team intros,
elevator pitches.

**Format:**

> "We did [thing] for [client] — [primary metric or outcome]."

**Examples:**
- "We refreshed the Nike Air brand — 30% lift in unaided awareness."
- "We built the Tate membership platform — 2x conversion in 6 months."
- "We named and launched Whoop — now a $3.6B category-defining brand."

**Generation rules:**
- Use the primary_metric from the frontmatter
- Active voice ("we did" not "we were engaged to do")
- No adjectives — let the metric do the work
- Max 20 words

### Length 2: 1-paragraph summary (60-100 words)

**Purpose:** For proposals, pitches, RFI responses, about pages.

**Format:**

```
{One-sentence challenge framing}

{One-sentence approach or distinctive move}

{One-sentence solution description}

{One-sentence result with the primary metric}
```

**Generation rules:**
- 4 sentences, one per beat
- Include the client name, the project type, the main metric
- Matches the narrative pattern (before/after, tension/resolution, etc.)
- Scannable — readable in 15 seconds
- Max 100 words

### Length 3: 1-page case study (600-900 words)

**Purpose:** The standard website case study. Most common format.

**Format:** Full narrative using the chosen pattern from
`craft-and-framing.md`. Includes all sections (challenge, approach,
solution, what was hard if applicable, results, unexpected outcomes if
applicable).

### Length 4: Long-form case study (1200-2000 words)

**Purpose:** Editorial use, design press, awards submissions, extended
portfolio features.

**Format:** Longer version with process reveal, craft detail, team
attribution, client collaboration detail, multiple quotes, asset
captions.

**When to include:** Generate this only if the extraction produced enough
material to support long-form. Thin projects shouldn't have long-form
versions — it's a sign of padding.

### Generation order

Generate in this order:
1. Long-form (longest, most material)
2. 1-page (distilled from long-form)
3. 1-paragraph (distilled from 1-page)
4. 1-line (distilled from 1-paragraph)

Each shorter version should be a compression of the longer one, not a
separate writing. This ensures consistency across lengths.

---

## 4. Gap analysis logic

Before writing, the skill reads `case-studies.md` (the portfolio index)
and determines whether this project fills a gap or duplicates existing
coverage.

### Coverage dimensions

For each dimension, count existing case studies and categorise this
project:

| Dimension | Count thresholds |
|---|---|
| **Project type** | 0-1 underrepresented, 2-3 balanced, 4+ overrepresented |
| **Client industry** | 0 underrepresented, 1-2 balanced, 3+ overrepresented |
| **Service offering** | 0-1 underrepresented, 2-3 balanced, 4+ overrepresented |
| **Scale** (fee range proxy for project size) | qualitative |

### Gap analysis output

```markdown
## Portfolio Gap Analysis

**This project:** {type} for {industry} client, {services}

**Coverage in current portfolio:**
- {type}: {N} existing case studies ({state: underrepresented / balanced / overrepresented})
- {industry}: {N} existing case studies ({state})
- {services}: {N} existing case studies ({state})

**Assessment:** {Fills a gap / Balanced addition / Over-covered area}

**Recommendation:**
- If fills a gap: "Priority — this case study strengthens an under-covered area of your portfolio."
- If balanced: "Useful addition — no priority, but worth writing."
- If over-covered: "Your portfolio already has {N} similar case studies. Consider whether a different project would be a better use of the effort. Suggestions: {list other recent projects in underrepresented areas}."
```

### Gap analysis as a proactive nudge

If the skill detects overrepresentation, it doesn't block the user — it
nudges. The user decides whether to proceed:

> "⚠️ Your portfolio already has 5 brand identity case studies and 0 campaign case studies. This project is brand identity. If you have a recent campaign project you haven't written up yet, writing that one first would strengthen your portfolio more. Continue with this one anyway?"

---

## 5. Project state write flow

After generating the case study, update:

1. **`case-studies/{slug}.md`** — create or update the full file
2. **`case-studies.md`** — append to the portfolio index (or update
   existing entry if this is an Update mode run)
3. **`projects/{slug}.md`** — append to Recent Activity:
   `YYYY-MM-DD — case-study — v{N} {status}, narrative: {pattern}, primary metric: {metric}`
4. **`projects/_index.md`** — update `last_updated`

### Writing the portfolio index entry

The summary entry in `case-studies.md` should be concise — it's an index,
not a full case study:

```markdown
## Nike Air Refresh — Nike (2026-04-15)
- Type: brand_refresh
- Industry: Sport
- Key result: 30% lift in unaided awareness
- Services: brand strategy, identity system, motion, guidelines
- Tags: sport, refresh, identity-system, motion
- Narrative pattern: tension_resolution
- Hero quote: "We brought them onboard to refresh a logo and they redefined the brand."
- Full case study: `case-studies/nike-air-refresh.md`
- URL: https://agency.com/work/nike-air-refresh
- Available for: pitches, proposals, RFI responses
```

### Updating existing index entries

If this is an Update mode run, find the existing index entry and update
it (don't create a duplicate). If the project name or slug has changed,
preserve both in a note so old cross-references don't break.

---

## 6. Handoff rules

### Upstream

If these skills weren't run but would have strengthened the case study,
suggest them at the beginning (before extraction):

- **No creative-brief run for this project** → "Run `/creative-brief` retrospectively if the project info is still fresh. The brief is the #1 source for the Challenge section."
- **No meeting-notes run** → "If you have meeting recordings, run `/meeting-notes` on them. Meeting logs are the #1 source for client quotes."
- **No post-mortem** → "Run `/post-mortem` to capture what was hard and what was learned. Makes the case study more honest and compelling."
- **No competitor audit in this category** → "Run `/competitor-audit` for {category} if the category context would strengthen the Challenge framing."
- **No profitability data** → not typically needed for public case studies, don't suggest unless user wants commercial metrics

### Downstream

- **Case study just written** → "Run `/pitch-research` on any prospects in this industry — the new case study is now in the brain and will be referenced automatically."
- **Portfolio has strong coverage in this area now** → "Worth updating your agency's positioning materials. Consider `/update-voice` or running `/proposal-generator` on recent RFIs to leverage the fresh coverage."
- **Case study surfaced an unexpected learning** → "Worth capturing in `learnings.md` via a team retro. The insight might apply to future work."
- **Case study still needs client approval** → "Use the approval package. Follow up in 2 weeks if no response — the draft follow-up is in the package."
- **Multiple case studies written in a session** → "Run `/portfolio-review` when you're done." (Note: portfolio-review is a nice future skill but may not exist. If not, suggest manual review.)

Only suggest 1-2 chains. Pick the most relevant.

### Not suggested

- Don't suggest re-running case-study on the same project unless in Update mode
- Don't suggest skills that have already run this session
- Don't suggest case-study for a different project unless the portfolio gap analysis specifically identified one

---

## 7. Awards mode differences

When the user picks Awards mode, the schema extends:

```yaml
source_mode: awards
awards_target: "D&AD 2026 / Cannes Lions 2026"
awards_category: "Brand Identity / Brand Design"
awards_deadline: 2026-03-15
awards_submission_version: v1.0
```

The Awards version differs from the standard case study in:

- **Length** — longer, closer to 1500-2000 words
- **Craft emphasis** — process reveal pattern preferred
- **Team attribution** — award submissions often require specific individual credits
- **Submission requirements** — the skill should remind the user of typical award requirements (video, images, written submission, team credits)
- **Approval status** — award submissions may have their own approval needs separate from published case studies

The Awards output is saved alongside the standard case study as a
separate section or file:
- `case-studies/{slug}-awards-{award-name}.md`

This keeps the standard case study clean while preserving the awards
version for future reference.

---

## 8. Privacy

Case studies contain:
- Client names, quotes, and attributions (approved publicly)
- Internal notes about what was hard (not public)
- Commercial metrics (sometimes public, sometimes internal)
- Team credits (public)
- Strategic rationale (sometimes sensitive)

Rules:
- **The approval-safe version is for the client**, reviewed and signed
  off. The full version is for internal use.
- **Never log pre-approval quotes as if they're approved.** Mark quote
  status explicitly.
- **Never publish commercial metrics without explicit client approval.**
  Mark sensitive metrics as internal-only in the full file.
- **Treat unpublished case studies as confidential.** Draft case studies
  shouldn't leave the brain until approved.
