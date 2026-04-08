# Category Codes

Every category has visual and linguistic conventions — **category codes** —
that most brands in the space follow. These codes exist because they work:
they signal category membership, meet audience expectations, and reduce
cognitive friction. They're also the single biggest opportunity for
creative differentiation.

This reference is the operational guide for the category codes analysis
section of every audit. It explains:

1. What category codes are
2. How to find them
3. How to analyse who breaks them
4. How to identify code-break opportunities for creative work

This section is **especially critical for rebrand and positioning work**.
If a brand wants to differentiate, they need to know which codes to hold
and which to break.

---

## What category codes are

Category codes are the conventions brands in a category **share** without
having to defend. They're the expectations baked into the category over
time. They span:

- **Visual** — colour palettes, type choices, photography styles, layouts, motion language
- **Linguistic** — tagline patterns, claim language, benefit framing, tone
- **Structural** — naming conventions, product architecture, packaging shape
- **Behavioural** — what brands do (sponsorships, partnerships, cadence)
- **Channel** — where brands show up (trade shows, specific press outlets, specific platforms)

### Examples of category codes

**Running shoes category codes:**
- Action photography (runners mid-stride, from low angles)
- Gradients and motion lines
- Performance metrics overlaid on images
- Bold sans-serif type
- "Empower", "unleash", "elevate" language
- Partnerships with pro athletes
- Launch cadence tied to marathon season

**Fintech category codes:**
- Blue palettes (trust signal)
- Geometric sans-serif (modern, tech-forward)
- Product screenshots on iPhone mockups
- "Simplify", "empower", "take control" language
- Young diverse lifestyle photography
- Partnership with finfluencers
- Mobile-first web design

**Luxury watches category codes:**
- Serif typography (heritage)
- Dark palettes, gold accents
- Product-on-black photography
- Craftsmanship language, family-generation stories
- Limited editions, numbered pieces
- Brand ambassadors from film or sport
- Traditional advertising in print

**Craft beer category codes:**
- Hand-lettered type, illustration-heavy packaging
- Earthy or vibrant colour palettes
- Stories about founders and ingredients
- "Small batch", "crafted", "local" language
- Tap room as retail destination
- Local partnerships and festivals

These codes aren't wrong. They exist because they work. The question is
**which codes to hold and which to break**.

---

## How to find category codes

### Step 1: Audit 8-10 competitors across tiers

Don't just look at the top 3 — look at tier 1, tier 2, and tier 3 brands
in the category. Codes are visible in what brands **share**, not what
they claim to do differently.

Run source-scrape in visual mode across 8-10 competitors:

> `/source-scrape query='{category} brand identity' mode='visual' output='data' target_sources=10`

### Step 2: List what's shared

For each dimension (visual, linguistic, structural, behavioural, channel),
list what you see across **most** competitors. Not what one brand does —
what the category does.

```markdown
### Visual codes (observed in 7+ of 10 competitors)
- Photography: action shots, mid-motion, low angle
- Colour: energetic primary + black/white neutrals
- Type: bold sans-serif (Graphik, Söhne, or similar)
- Layout: large hero image, minimal text
- Motion: gradients, speed lines, zoom transitions

### Linguistic codes (observed in 7+ of 10 competitors)
- Imperative verbs ("Run", "Push", "Go")
- Abstract benefit language ("Elevate", "Unleash", "Transform")
- Athlete testimonials with performance quotes
- Category self-references ("runners", "athletes")
```

### Step 3: Note who follows and who breaks

For each code you identified, note:
- **Followers** — brands that follow the code (most competitors)
- **Breakers** — brands that break the code (usually differentiators)
- **Outliers** — brands that ignore the code entirely (interesting or lost)

```markdown
**"Action photography" code:**
- Followers: Nike, Adidas, Puma, Under Armour, Asics, Brooks
- Breakers: Tracksmith (long-form editorial), On Running (product-only)
- Outliers: — (none)
```

### Step 4: Flag codes that are eroding

Some codes are stable. Others are eroding — old conventions being abandoned.
Flag both:

**Stable codes:** most brands still follow, no visible shift
**Eroding codes:** newer brands actively breaking, could be dead in 2 years
**New codes:** emerging conventions that didn't exist 3 years ago

For rebrand work, eroding codes are the highest-leverage break targets.
You get the distinctiveness benefit **and** the trend tailwind.

---

## How to analyse code-breakers

A code-breaker is a brand that deliberately breaks a category code. Not
every non-compliant brand is a code-breaker — some are just incompetent.
Real code-breakers make the break **load-bearing**: the break is
intentional and serves a positioning.

### The code-break test

For each apparent code-breaker, ask:

1. **Is the break intentional or accidental?**
   - Intentional: the rest of the system reinforces the break
   - Accidental: the brand probably doesn't even know the code exists

2. **Is the break load-bearing?**
   - Load-bearing: removing the break would make the brand feel less distinctive
   - Not load-bearing: the break could be reversed without losing much

3. **What does the break signal?**
   - A good break tells the audience something the follower brands can't say
   - A bad break tells the audience "we're different" without saying why

4. **Is the break working?**
   - Measured by cultural capital + share of voice direction
   - If a code-breaker has high cultural capital and accelerating SoV, the break is working
   - If the code-breaker is struggling, the break may not be the issue but worth noting

### Example analysis

**Tracksmith (running) — code-break analysis:**

| Code broken | Their approach | Intentional? | Load-bearing? | Working? |
|---|---|---|---|---|
| Action photography | Long-form editorial with runners in rest | ✓ | ✓ | ✓ |
| Imperative verbs | Literary, first-person narrative | ✓ | ✓ | ✓ |
| Abstract benefit language | Specific product stories | ✓ | ✓ | ✓ |
| Partnership with pro athletes | Amateur athletes and running culture | ✓ | ✓ | ✓ |
| Launch cadence | Magazine-style seasonal drops | ✓ | ✓ | ✓ |

**Conclusion:** Tracksmith is a deliberate, coherent code-breaker. Their
position ("running as a way of life, not a sport") is the reason for every
break. A client considering a similar position should look at them
carefully. A client with a different position should not imitate them —
the breaks won't serve a different story.

---

## Code-break opportunities (for creative work)

The final output of the category codes section is a list of **code-break
opportunities** — places where a client could differentiate by breaking
a code that most competitors follow.

Each opportunity should answer:

1. **Which code?** (specific, not general)
2. **How to break it?** (specific creative move)
3. **Why it would work for this brand?** (ties to positioning, audience, ambition)
4. **Who's already breaking it?** (precedent to reference or to avoid)
5. **What's the risk?** (every break has a cost)

### Example opportunity

```markdown
### Code-break opportunity 1: Action photography

**The code:** Every running brand shoots runners mid-action, from low
angles, with motion blur. This is the category's visual default.

**The break:** Shoot runners in stillness — before a run, after a run,
in the moments around running rather than during. Use natural light,
portrait composition, no motion blur.

**Why it would work:** The brief says this client wants to own the
"running is a way of life" positioning. Action photography makes running
look like a spectacle; stillness makes it look like a life. The
photography should match the positioning.

**Who's already breaking it:** Tracksmith owns this break. If the client
goes here, they'll be compared to Tracksmith — they need to bring something
Tracksmith doesn't have (maybe a different audience cut, or a different
editorial voice).

**The risk:** The break sacrifices the energy and urgency that action
photography provides. If the client has a performance-focused audience,
the break will feel weirdly slow. This is only for brands where stillness
is the point.
```

### Prioritisation

Not every code-break opportunity is equal. Prioritise by:

1. **How many competitors follow the code** — the more followers, the higher the differentiation payoff
2. **How defensible the break is** — is there a clear reason this brand can make the break that others can't?
3. **How load-bearing the code is** — breaking a load-bearing code is more valuable but riskier
4. **Whether someone's already done it** — if there's a successful precedent, the break is less risky but less distinctive

Present 3-5 opportunities, ranked by priority. Don't present 10 — the team
can't explore 10 in depth.

---

## Codes and confidence

Category codes analysis depends on how many competitors were audited. If
you only looked at 3-5 competitors, the codes are hypotheses, not findings.
If you looked at 10+, you can be confident.

Always state the sample size:

> "Category codes observed across 8 competitors audited. Codes that appeared
> in 6+ of 8 are listed as category conventions. Codes that appeared in
> 4-5 are flagged as 'common but not universal'."

---

## Codes evolve

Categories have a code evolution lifecycle:

1. **Emerging** — a new brand introduces a break, it feels weird
2. **Spreading** — other brands copy it, the break becomes visible
3. **Convention** — the break becomes the new code
4. **Stale** — brands start breaking the new code
5. **Dead** — the code is gone, replaced by a newer one

Shift mode (in the main skill) reads previous audits and tracks code
evolution over time. If a code was "emerging" 12 months ago and is now
"convention," that's a meaningful shift.

Track codes over time in the saved audit file — they're intelligence that
compounds.

---

## Output format for the category codes section

```markdown
## Category Codes

**Sample size:** 8 competitors audited
**Confidence:** High (based on consistent observation across sample)

### Visual codes

**Stable codes (followed by 6+ of 8):**
- {code} — followers: {list}
- {code} — followers: {list}

**Eroding codes (abandoned by 3+ of 8):**
- {code} — still followed by: {list} / broken by: {list}

**Emerging codes (new, appearing in 2-3 of 8):**
- {code} — adopted by: {list}

### Linguistic codes

{Same structure}

### Structural codes

{Same structure}

### Notable code-breakers

{For each deliberate code-breaker in the sample}

### Code-break opportunities for creatives

{3-5 prioritised opportunities per the format above}
```
