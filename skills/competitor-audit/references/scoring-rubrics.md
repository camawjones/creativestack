# Scoring Rubrics

Five scoring rubrics, each 5 dimensions × 1-5 points, applied to each
competitor in the audit. These are the quantitative backbone of the audit —
the qualitative analysis hangs off them.

1. **Visual Identity** — how strong is the brand visually
2. **Digital Maturity** — how sophisticated is the digital presence
3. **Narrative Strength** — what story they tell and how well
4. **Cultural Capital** — how much cultural relevance they carry
5. **Share of Voice (direction)** — where attention is moving

Each rubric has clear anchors at 1, 3, 5 so scoring is consistent. The skill
should cite specific evidence for every score — vague scoring is the death
of credibility.

---

## Rubric 1: Visual Identity

Score each competitor 1-5 on five dimensions. Total 5-25.

| Dimension | What it measures | 1 | 3 | 5 |
|---|---|---|---|---|
| **Distinctiveness** | Could you identify this brand with the logo hidden? | Generic, interchangeable with competitors | Some ownable elements but not unmistakable | Unmistakable at a glance — type, colour, or composition is ownable |
| **Consistency** | Does it hold together across touchpoints (web, social, OOH, product, retail)? | Inconsistent, fragmented — feels like different brands | Mostly coherent with some drift | Bulletproof system that holds across every surface |
| **Modernity** | Does it feel current without chasing trends? | Dated or desperate (trend-chasing) | Competent and current | Sets the pace — other brands will copy this in 18 months |
| **Craft** | Quality of execution — typography, photography, production, art direction | Rough, unpolished, template-looking | Professional and well-made | Exceptional detail — the kind of craft that wins awards |
| **System depth** | Depth of the design system — does it scale across formats and flex gracefully? | Logo + colours only, breaks at edges | Core toolkit that handles most needs | Full system with flexibility for motion, product, editorial, environmental |

**Scoring discipline:**

- **Don't grade on a curve.** Most brands score 2-3 on most dimensions. A 5 is rare. If most competitors in your audit score 4+, the bar is wrong.
- **Cite evidence for every score.** Reference annotated screenshots from `/source-scrape` where possible. Quote the `visual_qualities` field verbatim.
- **Score what you can see, not what you assume.** If you only have a website to look at, your score is about the website — say so.

**Special note on typography:**

Type quality is often the single biggest differentiator in modern identity
work. If a competitor has custom or exceptionally well-chosen type, call it
out in the craft score specifically. Weak type is almost always a sign the
rest of the system is weaker than it appears.

**Category conventions:**

After scoring all competitors, identify the **category conventions** — what
most brands in this space do visually. This becomes input for the
category-codes analysis (see `category-codes.md`).

---

## Rubric 2: Digital Maturity

Score each competitor 1-5 on five dimensions. Total 5-25.

| Dimension | What it measures | 1 | 3 | 5 |
|---|---|---|---|---|
| **Site quality** | Craft, performance, and sophistication of the primary site | Template site, dated or broken | Professional and functional | Best-in-class — the kind of site you send to reference |
| **Content strategy** | Depth and originality of editorial/content presence | No content, or stale blog that nobody reads | Regular content with some value | Genuinely useful, audience-first content that stands alone |
| **Social presence** | Quality and authenticity of social — not follower count | Dormant, bot-posted, or broadcast-only | Active on-platform with some engagement | Community-building, culturally engaged, original formats |
| **Innovation** | Use of new tech where it serves the brand (AR, AI, interactive, personalisation) | Brochureware — no innovation visible | Standard features, well executed | Pioneering — features that become reference for the industry |
| **UX / performance** | Speed, usability, accessibility, flow quality | Slow, confusing, poor mobile | Smooth and intuitive | Delightful, fast, accessible — UX that stops being invisible |

**Scoring discipline:**

- **Don't confuse scale with sophistication.** A small brand with a beautifully crafted site scores higher than a massive brand with a template site.
- **Actually visit the sites.** Use the browser if available, or reference source-scrape visual captures.
- **Test on mobile** — where most traffic lives.
- **Check performance** — Lighthouse or direct observation. Slow sites score low.

**Motion and interaction note:**

Modern digital maturity is increasingly about motion and interaction design,
not just static layout. If a competitor's site has exceptional motion
(thoughtful transitions, interactive elements, hover states with character),
note it in the site quality score.

---

## Rubric 3: Narrative Strength

This is new — the previous skill version didn't have it. Narrative is
different from positioning (where they are) and messaging (what they say).
Narrative is the **arc of the story** they're telling about themselves.

Score each competitor 1-5 on five dimensions. Total 5-25.

| Dimension | What it measures | 1 | 3 | 5 |
|---|---|---|---|---|
| **Clarity** | Is the narrative clear enough that you could describe it in one sentence? | No discernible narrative — they just exist | Narrative is present but takes effort to articulate | You could describe their story in one sharp sentence |
| **Distinctiveness** | Is the narrative ownable, or could another brand tell it? | Generic category story — any competitor could say it | Some ownable elements | Only this brand could tell this story |
| **Consistency** | Does the narrative hold across channels and time? | Narrative shifts with every campaign | Consistent in big moments, drifts in small ones | Every touchpoint reinforces the same arc |
| **Emotional tension** | Does the narrative contain a tension the audience can feel? | No tension — just claims | Some implicit tension | Clear tension that the brand is actively resolving |
| **Proof** | Does the brand actually prove the narrative with its actions? | Narrative claims, no proof | Some proof points visible | Every business decision proves the narrative |

**Examples of narrative quality:**

- **Nike:** "From athletes, for athletes. Performance is earned." — **High clarity, high distinctiveness, high proof** (R&D spend, athlete partnerships, product testing program)
- **Adidas:** "Sport is culture." — **High clarity, medium distinctiveness** (others could say it), **high proof** (Yeezy, cultural collabs, music partnerships)
- **On Running:** "Redefine running." — **Medium clarity, medium distinctiveness**, **high proof** (CloudTec innovation, Roger Federer partnership, visible product difference)
- **Generic sportswear brand:** "Gear for every athlete." — **Low on everything** — this is a placeholder, not a narrative

**Narrative detection signals:**

Look for the same story showing up in:
- The homepage above-the-fold
- CEO interviews and press
- Investor decks (if public)
- Product launch language
- Brand campaigns
- Partnership choices (what they associate with tells the story)
- What they refuse to do (often the strongest signal)

If the same story shows up in 5+ places, it's a narrative. If it doesn't,
they don't have one.

---

## Rubric 4: Cultural Capital

Market share tells you who's big. Cultural capital tells you who matters.
These are different. This rubric measures cultural relevance — whether the
brand is being referenced, imitated, or talked about by people who set
taste.

Score each competitor 1-5 on five dimensions. Total 5-25.

| Dimension | What it measures | 1 | 3 | 5 |
|---|---|---|---|---|
| **Press voice** | Are they in the cultural press (not just trade press)? | Trade press only | Some cultural coverage | Regular cultural commentary |
| **Social signal** | Are they referenced organically on social (not paid)? | Zero organic mentions | Some organic mentions | Frequently memed, referenced, quoted |
| **Creator adoption** | Do creators and tastemakers use them unprompted? | Invisible to creators | Some creator use | Creators reach for them without being paid |
| **Copy target** | Are other brands trying to be like them? | Nobody copies them | Some imitation | Category imitates them within 12 months |
| **Community depth** | Do they have an actual community, not just followers? | Transactional follower base | Engaged audience | Self-organising community that extends beyond the brand |

**How to score cultural capital:**

Run source-scrape in a "culture" query:
- `{brand} mentions cultural press last year`
- `{brand} referenced by creators`
- `{brand} community`

Check:
- Are they in editorial pieces about the category (not sponsored)?
- Are they in "best of" lists written by cultural press?
- Do creators post about them unprompted?
- Do they show up in cultural moments (festivals, films, music)?

**Cultural capital is trend-sensitive.** A brand can have high cultural
capital one year and lose it the next. Always note the time window.

---

## Rubric 5: Share of Voice Direction

Not a score of size — a score of **direction**. Are they gaining or losing
attention? This is often more important than the current level.

Score each competitor 1-5:

| Score | Direction | Signal |
|---|---|---|
| 5 | **Accelerating** | Press coverage up, social mentions up, visible brand moments in the last 3 months |
| 4 | **Growing** | Steady increase in attention metrics, consistent campaign cadence |
| 3 | **Stable** | No significant change, consistent presence |
| 2 | **Declining** | Less coverage, fewer campaign moments, some silence |
| 1 | **Crashing** | Measurable drop in attention, recent negative coverage, visible retreat |

**How to measure direction:**

Look for signals over the last 12-18 months:
- Frequency of press mentions (via source-scrape evidence mode)
- Social conversation volume trend
- Campaign activity cadence
- Product launch pace
- Agency changes (often a signal of direction)
- Executive changes (often a signal)

**Direction often matters more than level.** A tier-2 brand that's
accelerating is more threatening than a tier-1 brand that's stable. Flag
accelerating competitors as high-priority watch targets.

---

## Aggregate scoring

For each competitor, compute an aggregate across the 5 rubrics:

| Rubric | Weight | Notes |
|---|---|---|
| Visual Identity | 20% | Creative agency bias — this matters more here than in a consulting competitor analysis |
| Digital Maturity | 20% | |
| Narrative Strength | 25% | The highest-weight dimension — narrative is the hardest thing to build and the most valuable |
| Cultural Capital | 20% | |
| Share of Voice Direction | 15% | Directional — lower weight because it's trend-sensitive |

Total possible: 100 points (weighted).

**Readiness bands:**

| Aggregate | Competitor assessment |
|---|---|
| 85+ | **Category leader** — sets the pace, others react |
| 70-84 | **Strong competitor** — credible, well-resourced, hard to beat head-on |
| 55-69 | **Capable** — solid but not distinctive |
| 40-54 | **Vulnerable** — exploitable weaknesses |
| <40 | **Struggling** — not a real competitive threat, but may still block mindshare |

---

## Scoring output format

```markdown
## Competitor Scoring Summary

| Competitor | Visual | Digital | Narrative | Cultural | SoV Dir | Aggregate | Assessment |
|---|---|---|---|---|---|---|---|
| {name} | 18/25 | 22/25 | 20/25 | 15/25 | 4/5 | 77 | Strong competitor |
| {name} | 22/25 | 24/25 | 24/25 | 22/25 | 5/5 | 92 | Category leader |
| {name} | 12/25 | 15/25 | 10/25 | 8/25 | 2/5 | 45 | Vulnerable |
```

Each rubric also gets its own detailed breakdown with evidence, per the
rubric-specific sections of the main output.

---

## Scoring discipline summary

1. **Cite evidence for every score.** Quote source-scrape visual_qualities,
   reference specific URLs, describe what you actually saw.
2. **Don't grade on a curve.** Most scores cluster in the middle.
3. **Flag confidence per rubric.** If you only had a website to look at,
   the Visual Identity score is more confident than the Cultural Capital
   score.
4. **Update the methodology against the brain.** If `learnings.md § Pitching`
   shows the agency has strong pattern recognition in a specific category,
   the agency's own past scoring should be a reference point for consistency.
5. **Score what matters for the agency's purpose.** A pitch audit cares
   about vulnerabilities; a rebrand audit cares about visual and narrative;
   a positioning audit cares about narrative and white space. Weight the
   detail accordingly, even though the rubrics remain the same.
