# Paid Media Variant Matrix

> The single biggest hidden time sink in any digital campaign. A "single hero" almost
> never ships as a single asset — it ships as a matrix.

## How to use this file

When the campaign involves paid media (any platform, any format), generate a variant
matrix BEFORE generating individual specs. The matrix tells you (and the production
team) the true asset count, surfaces production complexity early, and prevents the
"oh, we also need 4:5 versions" surprise three days before launch.

---

## The variant equation

Total asset count is rarely "one per platform". For paid, it's:

```
Total assets = Concepts × Messages × Audiences × Placements × Languages × Aspect ratios
```

A campaign with:
- 1 concept
- 3 messages (e.g., feature-led, benefit-led, social proof)
- 2 audiences (acquisition vs retention)
- 4 placements (Feed, Story, Reel, Display)
- 3 languages
- 4 aspect ratios per placement on average

= **288 individual assets** from a "single hero".

Generate the matrix first. Then decide which axes to collapse to keep it producible.

---

## Variant axes — what to ask the user

When generating the matrix, ask the user for each axis:

1. **Concepts** — How many distinct creative routes? (Often 1; sometimes 2-3 for A/B)
2. **Messages** — How many message variants per concept? (Hooks, benefits, USPs, social proof, urgency)
3. **Audiences** — Are different audiences seeing different creative?
4. **Placements** — Which platforms and formats?
5. **Languages / markets** — How many language variants? (See `localisation-matrix.md`)
6. **Aspect ratios** — Per placement, which crops? (1:1, 4:5, 9:16, 16:9, 2:3)
7. **Durations** (video only) — 6s, 15s, 30s cut-downs?

---

## Standard placement → aspect ratio matrix

When in doubt, this is what most paid digital campaigns ship per placement:

| Placement | Aspect ratios needed | Notes |
|---|---|---|
| Meta Feed | 1:1, 4:5 | 4:5 takes more screen real estate on mobile |
| Meta Story / Reel | 9:16 | UI safe zones critical |
| Meta Right Column | 1.91:1 | Desktop only |
| TikTok | 9:16 | One ratio, but plan for multiple hook variants |
| YouTube TrueView (in-stream) | 16:9 | Plus 6s bumper cut-down |
| YouTube Shorts | 9:16 | — |
| LinkedIn Feed | 1:1, 1.91:1 | Square outperforms landscape |
| LinkedIn Sponsored Content video | 16:9, 1:1, 9:16 | — |
| Pinterest | 2:3, 9:16 (Idea) | Vertical mandatory |
| X promoted | 16:9, 1:1 | — |
| Display banner network | 300×250, 728×90, 160×600, 320×50, 970×250 | See display-ad-specs.md |

---

## Matrix template (for the asset spec output)

Generate a table like this in the asset spec output. Each row is one shipped asset.

```markdown
## Paid Media Variant Matrix

| ID | Concept | Message | Audience | Placement | Aspect | Duration | Language | Status |
|---|---|---|---|---|---|---|---|---|
| PM-001 | Hero | Feature-led | Acquisition | Meta Feed | 1:1 | static | EN | TBD |
| PM-002 | Hero | Feature-led | Acquisition | Meta Feed | 4:5 | static | EN | TBD |
| PM-003 | Hero | Feature-led | Acquisition | Meta Story | 9:16 | static | EN | TBD |
| PM-004 | Hero | Feature-led | Acquisition | Meta Story | 9:16 | 15s | EN | TBD |
| PM-005 | Hero | Benefit-led | Acquisition | Meta Feed | 1:1 | static | EN | TBD |
| ... | | | | | | | | |

**Total variants:** {N}
**Asset breakdown:** {N} static, {N} video
**Production complexity:** {Simple / Moderate / High / Heroic}
```

---

## Collapsing the matrix (when it's too much)

If the raw matrix is >50 variants, propose collapses:

1. **Adapt, don't recreate** — Build one master per aspect ratio, then run text/copy variants on top (this is often automated in After Effects, Figma, or Bannerflow)
2. **Drop low-impact placements** — If a placement has <5% of budget, can it be dropped?
3. **Collapse audiences** — Often acquisition and retention can share creative with different copy/CTA
4. **Reduce message variants** — A/B 2 messages is often as informative as A/B/C/D 4
5. **Use dynamic creative** (Meta Advantage+, Google Responsive) — Provide modular components instead of finished compositions

---

## Production complexity bands

Use these to set client expectations:

| Variant count | Band | Production approach |
|---|---|---|
| 1-15 | Simple | Hand-build each |
| 16-50 | Moderate | Master + manual variants |
| 51-150 | High | Master + templated variants (AE/Figma/Bannerflow) |
| 150+ | Heroic | Dynamic creative platform required (or scope reduction) |

---

## Naming convention for variants

Standard variant naming extends the base convention:

```
{client}_{campaign}_{concept}_{message}_{audience}_{placement}_{aspect}_{lang}_v{n}.{ext}
```

Example:
```
acme_summer25_hero_featureled_acq_metafeed_1x1_en_v1.jpg
acme_summer25_hero_featureled_acq_metareel_9x16_en_v1.mp4
```

This is verbose but searchable. Production teams sort by any axis instantly.

---

## Common mistakes to flag

- "We'll just resize the hero" — masters need to be **composed** for each aspect, not stretched. A 16:9 hero rarely re-crops cleanly to 9:16 without losing key subject matter.
- "We'll do localisation later" — lang variants often need different image selections (people, scenery, hand gestures, food, signage)
- "Display is just a banner" — 5+ IAB units, file weight budgets, HTML5 trafficking, backup images. It's rarely "just a banner".
- "One video, all platforms" — Different LUFS, different durations, different captions, different end-cards.
- "Stories will autoplay with sound" — They won't. Always plan for silent-first with subtitles.
