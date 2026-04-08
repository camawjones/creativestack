# Prospect Dossier Schema

This skill creates and maintains two brain locations:

1. `~/.creativestack/prospects/_index.md` — lightweight index of all researched prospects
2. `~/.creativestack/prospects/{slug}.md` — full dossier per prospect

This mirrors the existing `~/.creativestack/projects/` pattern. Aggregation
across dossiers (for win/loss learning) reads all `{slug}.md` files via Glob,
not a separate history file.

---

## prospects/_index.md — Lightweight index

One row per prospect. Updated whenever a dossier is created or status changes.

```markdown
---
last_updated: 2026-04-07
prospect_count: 14
---

| Slug | Name | Sector | Status | Fit | Last Touch | Outcome | File |
|------|------|--------|--------|-----|-----------|---------|------|
| nike-air | Nike (Air division) | Sport | Pitching | 5 | 2026-04-02 | — | nike-air.md |
| tate-mod | Tate Modern | Culture | Researched | 4 | 2026-03-12 | — | tate-mod.md |
| stripe-brand | Stripe | Fintech | Lost | 3 | 2026-02-18 | Lost — too small | stripe-brand.md |
| airbnb-rebrand | Airbnb | Travel | Won | 5 | 2025-11-04 | Won | airbnb-rebrand.md |
| revolut-id | Revolut | Fintech | Cold | 2 | 2026-01-08 | — | revolut-id.md |
```

### Status vocabulary (use these exactly)

| Status | Meaning |
|---|---|
| `Cold` | Researched, no contact yet |
| `Warmed` | First contact made (intro, email, LinkedIn) |
| `Engaged` | They're responding, conversations happening |
| `Pitching` | In active pitch process |
| `Won` | Pitch won — closed |
| `Lost` | Pitch lost — closed |
| `Stalled` | Engaged then went quiet >60 days |
| `Passed` | Decided not to pursue |
| `Researched` | Just researched, no decision yet |

### Fit field

1-5 score from `references/angles-and-hooks.md` § "Fit scoring". Aggregation
mode reads this to identify what kinds of prospects you actually win.

---

## prospects/{slug}.md — Full dossier

Living document. Each section can grow over time. Append, never overwrite.

```markdown
---
name: Nike (Air division)
slug: nike-air
sector: Sport
status: Pitching
fit: 5
researched: 2026-04-02
last_updated: 2026-04-02
---

# Nike (Air division) — Prospect Dossier

## Brand Snapshot
{Current positioning, brand description, scale signals — refreshed at every Refresh run}
- HQ: Beaverton, OR
- Division: Air (running + lifestyle)
- 2025 revenue (division est.): $4.2B
- Recent positioning shift: leaning into "performance heritage" after 2024 reset
- Source: {urls + dates}

## Adjacency Check

**Direct relationship in clients.md:** None
**Sector overlap:** Yes — we worked with Adidas Originals (2023, brand identity).
This is a competitive concern — flag during outreach.
**Team adjacency:**
- Sarah Chen previously worked at JD Sports (2018-2020) — sport retail experience
- Mike Torres has a personal contact at Wieden+Kennedy (per profile.md)

**Warmest path in:** Mike's W+K contact is the strongest cold-warm bridge.
Worth a coffee before any direct outreach.

## Recent Work & Campaigns
{Last 18 months of notable campaigns — refreshed at every Refresh run}
- **{Campaign}** — {description} ({source}, {date})
- **{Campaign}** — {description} ({source}, {date})

## Decision-Maker Profiles

### {Name} — {Role}
- **Background:** {career history}
- **Public statements on creative:** {quotes with sources}
- **Communication style:** {inferred from public presence}
- **What they likely care about:** {based on background}
- **Last updated:** 2026-04-02

### {Name} — {Role}
- ...

## Press & Industry Commentary
- {recent coverage with date}

## Competitor Landscape (in their category)
- **Incumbent agency (if known):** {agency name + work}
- **Competitive set:** {brands they compete with}
- **Recent agency moves in this sector:** {context}

## Trend Position
{If trend-report ran, where they sit vs category trends}

## Pain Points (educated guesses)
- {pain point with reasoning}

## Angles In — Ranked by Fit

### Strong Fit
1. **{Angle}** — {why this works}
   - **Brain evidence:** {case study}
   - **What to say:** {framing}

### Good Fit
1. **{Angle}** — {why}
   - **Brain evidence:** {case study}
   - **What to say:** {framing}

### Stretch
1. **{Angle}** — {the stretch}
   - **What to say:** {framing}

## Killer Hook
{The single sentence designed to land in the first 60 seconds. Pressure-tested
against the angles. See `references/angles-and-hooks.md` § "The killer hook".}

> "{One sentence, 15-25 words, specific to this prospect}"

## Past Pitch Learnings (overlay)
{Pulled from learnings.md § Pitching when sector or scale matches.
e.g. "You've pitched 4 sport brands, won 1, lost 3. Losses cited 'too small'
twice. Address scale upfront."}

## Outreach Log

| Date | Channel | Person | Notes |
|------|---------|--------|-------|
| 2026-03-15 | Email | Sarah Chen → Marketing Director | Cold intro, no response |
| 2026-03-22 | LinkedIn | Mike Torres → CMO | Connection accepted |
| 2026-04-01 | Meeting | Full team → CMO + 2 | First chemistry meeting — see notes below |

## Meeting Notes

### 2026-04-01 — First chemistry meeting
**Attendees:** Sarah, Mike (us); Marcus Liu (CMO), Priya Shah (Brand Director)
**Tone:** Warm, curious. Marcus did most of the talking.
**What landed:**
- The Adidas Originals case study landed harder than expected
- Mike's framing of "performance heritage" matched their internal language
**What didn't:**
- Strategy framework slide felt heavy — they tuned out
- No questions on pricing — concerning, may signal price ceiling
**Their priorities (stated):**
- Refresh by AW26 launch
- Must work across digital and in-store
- Wants something "ownable for 5 years"
**Next step agreed:** Tissue session in 3 weeks
**Open questions / risks:**
- Who else are they talking to?
- What's the budget ceiling?

## Outcome
{Filled in via Log outcome mode. See `references/win-loss-patterns.md`.}
```

---

## Read order

When the skill starts a Research run for a prospect:

1. Slug the prospect name (lowercase, dashes)
2. Check `~/.creativestack/prospects/{slug}.md`
3. If it exists → route to **Refresh** mode (offer to update or treat as new with confirmation)
4. If it doesn't exist → proceed with Research

When listing or aggregating:
1. Read `_index.md` for the lightweight view
2. For each dossier referenced, read just the frontmatter for fast filtering
3. Read full dossiers only when the user drills in

---

## Write order

After every Research run that produces a dossier:

1. Slug the prospect name
2. Write `prospects/{slug}.md` with all sections populated
3. Update `prospects/_index.md` with a new row (or update existing row)
4. If the prospect is in a sector the user has won/lost in before, surface
   the past pitch learnings overlay (read `learnings.md § Pitching`)

After every Log outcome run:

1. Append to Outreach Log and/or Meeting Notes
2. Update Outcome section if pitch closed
3. Update status in `_index.md`
4. If outcome was Won or Lost, also append to `learnings.md § Pitching`
   (see `references/win-loss-patterns.md`)

---

## Slugging rules

Convert prospect name to a slug:
- Lowercase
- Replace spaces with `-`
- Strip punctuation except `-`
- If a division/region matters, append: `nike-air`, `unilever-uk`
- Keep under 30 characters
- If slug collision, append a number: `tate-mod-2`

---

## Schema migration

If a user has an old-format dossier from before this version, the skill should
read it as best it can and offer to migrate to the new schema on next Refresh.
Never auto-migrate without confirmation.

---

## What NOT to put in the dossier

- Confidential client information shared in confidence (the dossier may be
  read by anyone with brain access)
- Salary or financial details about named individuals
- Personal information about decision-makers beyond what's publicly available
- Speculation framed as fact — always cite or label as "inferred"
- Anything you wouldn't want forwarded to the prospect themselves
