# Platform Variants

Per-platform constraints, conventions, and enforcement rules. When the
user asks for variants, the skill generates each variant to the rules
below and **enforces character limits** rather than just stating them.

---

## Enforcement vs guidance

Platform rules come in two flavours:

- **Hard limits** — platform-enforced. Generated copy that exceeds must
  be rejected, not shipped. The skill flags and rewrites.
- **Soft conventions** — platform norms that work best in practice but
  aren't enforced by the platform. The skill flags but doesn't reject.

Every variant below notes which is which.

---

## Web (marketing site / landing page)

### Atoms typically needed
Headline, subhead, body, primary CTA, secondary CTA, meta title, meta description.

### Hard limits
- **Meta title:** 60 characters (Google truncates beyond)
- **Meta description:** 160 characters (Google truncates beyond)

### Soft conventions
- **H1 (hero headline):** 4-10 words. Longer works but reads as tagline-y.
- **H2 (subhead):** 1 sentence, 10-20 words.
- **Body paragraphs:** 2-4 sentences, never more.
- **CTA:** 2-5 words, verb-first.
- **Scannable hierarchy:** every page should support skimming. 2-3 H2s
  minimum on long-form.
- **Above the fold:** headline, subhead, primary CTA, hero image.

### Generation rules
1. Generate H1 first — everything else hangs off it
2. H2 completes the promise H1 opens
3. Body starts with the most important sentence (inverted pyramid)
4. Primary CTA is the action the user should take if they only scan
5. Meta title and description written last, based on the body's promise

### Enforcement output

```markdown
### Web Variant

**Meta title** (59 chars ✓): "Ultra Running Shoes Tested by Ultra Runners | Nike"
**Meta description** (158 chars ✓): "The first shoe tested in real races by real ultra runners. 94% of testers broke their personal bests. See the proof at nike.com."

**H1**: "Run faster. Recover harder."
**H2**: "The first shoe tested by ultra marathoners instead of focus groups."
**Body** (3 sentences, avg 14 words): "..."
**Primary CTA**: "Get your pair" (3 words ✓)
**Secondary CTA**: "See the proof" (3 words ✓)
```

If a limit is exceeded, flag it:

```markdown
**Meta description** (174 chars ✗ — exceeds 160 limit): "..."
**Suggested rewrite** (156 chars): "..."
```

---

## Email

### Atoms typically needed
Subject line, preheader, headline, body, CTA, P.S.

### Hard limits
- **Subject line:** ~50 characters (Gmail / most clients truncate)
- **Preheader:** 35-90 characters (varies; safer at the shorter end)

### Soft conventions
- **Subject line:** front-load keywords (most clients truncate)
- **Preheader:** continues or counters the subject (don't just preview it)
- **Headline in body:** often the same as subject or a sharper version
- **Body length:** shorter is better. 150 words is usually enough. 300+ should have a reason.
- **CTA:** one primary CTA. Multiple CTAs confuse in email.
- **P.S.:** highest-read element after subject line — use it for urgency or proof.

### Generation rules
1. Subject line does 80% of the work for open rates — write 3-5 options
2. Preheader complements, doesn't repeat
3. Body opens with the promise from the subject
4. CTA is singular
5. P.S. adds one final reason to act

### Enforcement output

```markdown
### Email Variant

**Subject line options:**
- "How 94 ultra runners got faster" (30 chars ✓)
- "Your first ultra, without coaching the shoes" (45 chars ✓)
- "The shoe we tested for 2 years before shipping" (47 chars ✓)

**Preheader** (72 chars ✓): "We skipped the focus groups and tested it on 100 real ultra runners."

**Body headline**: "Run faster. Without the shoes you have to coach."
**Body** (138 words):
...

**CTA**: "Get your pair" (primary)

**P.S.**: "94 of our 100 testers broke their personal best in the first race. Six didn't — and they told us what to fix."
```

---

## Social — LinkedIn

### Hard limits
- **Post body:** 3,000 characters (platform hard limit)
- **"See more" cut-off:** 210 characters (above-the-fold on mobile)

### Soft conventions
- **First 2 lines:** must earn the "...see more" click
- **Line breaks:** frequent, 1-2 sentences max per line
- **Hashtags:** 3-5 relevant hashtags, end of post
- **CTA:** often implicit in LinkedIn (read the article, visit the site)
- **Tone:** slightly more formal than Instagram but not corporate

### Generation rules
1. Hook the first 210 characters like a headline
2. Break lines often for scannability
3. Don't bury the CTA
4. Never start with "I'm excited to share..."

### Example output

```markdown
### LinkedIn Variant

**Hook (first 210 chars ✓):**
"Most running shoes are designed in labs. Tested on treadmills. Approved by focus groups.

We did none of that."

**Full post:**
[continues with spacing and rhythm]

**Hashtags:** #UltraRunning #ProductDesign #BrandBuilding
```

---

## Social — Instagram

### Hard limits
- **Caption:** 2,200 characters
- **Hashtags:** 30 max (but 5-10 is the sweet spot)
- **First 125 characters:** visible before "more" on mobile feed

### Soft conventions
- **Conversational tone:** Instagram is more casual than LinkedIn
- **Emoji use:** moderate — 1-3 per caption, not a garnish
- **Hashtag placement:** at the end, or in a comment
- **CTA:** "Link in bio" is the canonical phrase; punchier alternatives
  often work better ("Tap the link", "See it at [url]")
- **Line breaks:** frequent

### Generation rules
1. First 125 characters must earn the "more" tap
2. Conversational > corporate
3. Emoji as accent, not decoration
4. End with a clear next action

### Example output

```markdown
### Instagram Variant

**First 125 chars ✓:** "100 ultra runners tested this shoe before we shipped it. 94 broke their personal bests."

**Full caption:**
[continues]

**Hashtags:** 6 selected
```

---

## Social — X (formerly Twitter)

### Hard limits
- **Post:** 280 characters (basic accounts), 25,000 (premium but uncommon)
- **URL in post:** counts as 23 characters regardless of actual length

### Soft conventions
- **Threads:** use when a single post can't carry the idea
- **First post of a thread:** should work as a standalone hook
- **Hashtags:** 1-2 max on X (more feels spammy)
- **CTA:** "Link below" or "Read more" — X is a hook medium, not a close medium

### Generation rules
1. Assume 280 characters. Write for that.
2. If threading, numbered posts or thread indicators
3. First post must hook without context
4. URLs go at the end, not middle

### Example output

```markdown
### X Variant

**Single post (268 chars ✓):** "We tested our shoe on 100 ultra runners across six continents. 94 broke their personal bests in the first race. The six who didn't told us what to fix. Then we shipped it. nike.com"
```

If threading:

```markdown
**Thread (4 posts):**
1/4 (240 chars): "Most running shoes are designed in labs..."
2/4 (255 chars): "So we skipped the labs..."
3/4 (210 chars): "94 of them broke their personal bests..."
4/4 (180 chars): "Here's how it works: [link]"
```

---

## Social — TikTok

### Hard limits
- **Caption:** 2,200 characters
- **Video description:** appears below video, first 1-2 lines visible

### Soft conventions
- **Hook in first 3 seconds:** (video-level, but caption mirrors this)
- **Caption style:** punchy, conversational, often all lowercase
- **Hashtags:** 3-5, trending + niche mix
- **Voice:** irreverent, direct, fast

### Example output

```markdown
### TikTok Variant

**Caption** (lowercase style):
"we tested this shoe on 100 ultra runners. 94 broke their personal bests. the other 6 told us exactly what we got wrong."

**Hashtags:** #running #ultrarunning #productdesign #shoetest
```

---

## Presentation (slide deck)

### Atoms typically needed
Slide headlines, section dividers, body bullets, speaker notes.

### Hard limits
- No platform limit, but the 6x6 rule is a strong convention:
  - Max 6 lines per slide
  - Max 6 words per line

### Soft conventions
- **Headline is the slide's thesis** — each slide earns one idea
- **Body bullets** are scaffolding for the speaker, not a script
- **Speaker notes** carry the detail the slide omits
- **Section dividers** break the deck into chapters

### Generation rules
1. Write headlines first — they define the deck's argument
2. Body bullets support, don't replicate, the headline
3. Speaker notes are full sentences (the slide is not)
4. If a slide can't fit in 6x6, split it

### Example output

```markdown
### Presentation Variant

**Slide 1 — Hero**
Headline: "Tested by runners, not labs."
Body (3 bullets, 4-6 words each):
- 100 ultra runners
- Six continents
- 94 personal bests broken

**Speaker notes:**
"This was a two-year program. We chose ultra runners specifically because
they push shoes to failure in ways no lab can simulate. The 94% figure
isn't marketing — it's the actual pre-release testing result."
```

---

## Print / OOH

### Atoms typically needed
Headline, subhead, body, CTA, legal.

### Hard limits
- No character limits, but physical space is the limit
- Legal copy often has minimum size requirements (regulated categories)

### Soft conventions
- **Complete sentences** (no digital shorthand)
- **CTA without URLs** — physical media has no hyperlinks
- **Legal** in a readable size, positioned as required
- **Contact info** explicit (URL, phone, store location)
- **No emojis** (they read as amateur in print)

### Generation rules
1. Headlines read from distance — shorter, bolder
2. Body written for linear reading, not scanning
3. CTAs are directives, not hyperlinks
4. Legal is legible, not buried

### Example output

```markdown
### Print Variant (OOH / billboard)

**Headline** (5 words, reads at 20m): "Run the shoes they test."

**Subhead**: "Tested by 100 ultra runners."

**CTA**: "Nike.com"

**Legal**: (if required)
```

---

## Packaging

### Atoms typically needed
Front-of-pack hero, benefit line, product description, back-of-pack body, legal, ingredients/nutrition.

### Hard limits
- **Legal / regulatory:** varies by category (food, cosmetics, pharma)
- **Ingredients / nutrition:** minimum font size requirements

### Soft conventions
- **Front of pack:** brand, product, one benefit — maximum three elements
- **Back of pack:** story, specs, legal
- **Hierarchy:** brand > product > benefit > reason to buy
- **Tone shift between front and back is OK:** front is emotional, back is rational

### Generation rules
1. Front of pack is tight — every millimetre earns its place
2. Back of pack is where the story lives
3. Legal is accurate, positioned per regulation
4. Specs are factual, not promotional

---

## Per-variant enforcement summary

For every variant generated, the skill outputs:

```markdown
| Atom | Length | Status | Notes |
|---|---|---|---|
| Meta title | 59/60 chars | ✓ | |
| Meta description | 158/160 chars | ✓ | |
| H1 | 5 words | ✓ | |
| Body | 138 words | ✓ | Within web norm |
| CTA | 3 words | ✓ | |
```

Any ✗ is a hard failure. The skill must rewrite before the variant is
complete.

---

## Cross-variant consistency

When generating multiple variants of the same copy, the skill should:

1. Use the same core claims and proofs across variants
2. Keep the SMT ladder consistent
3. Allow variation in register per platform (TikTok is more casual than print)
4. Flag if any variant introduces a new claim not in the web/email version
5. Verify the brand voice scoring stays consistent across variants

Don't silently rewrite the core message to fit a platform. If the SMT
won't fit in 280 characters, flag that explicitly:

> "The single-minded thought doesn't compress to 280 characters without
> losing specificity. Options: (a) split into a thread, (b) use a shorter
> hook that references the full thought via link, (c) rewrite the SMT
> itself to be more compressible."

---

## When not to generate variants

Skip variant generation when:

- The user asked for one specific platform
- The brief specifies one channel only
- The deliverables list one platform in the brief
- Previous decks for this client have established variants that should be reused

Don't generate variants the user didn't ask for. Variant generation is
opt-in, not default.
