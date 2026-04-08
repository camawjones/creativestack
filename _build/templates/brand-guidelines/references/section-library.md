# Brand Guidelines Section Library

The full menu of sections a brand guidelines document might contain. The skill
picks a subset based on Type × Audience × Depth — *don't include all of them*.
That's the single biggest mistake brand guideline documents make.

## How each section is structured

Every section in this library follows the same five-part shape. The four parts
that matter most — and that almost every real-world guidelines doc skips — are
**Principle**, **Show**, **Don't**, and **When in doubt**.

```
**Principle** — the underlying intent in 1-2 sentences. Why this rule exists.
                Without the principle, the rule looks arbitrary and gets broken
                the moment a designer hits an edge case the rule didn't anticipate.

**Rules** — the bright lines. Specific, testable, unambiguous. Use bullets and
            short sentences. If a rule needs three paragraphs to explain, it's
            probably a principle in disguise.

**Show** — at least one *do* example with a clear caption explaining what makes
           it right. A picture without a caption is decoration, not guidance.

**Don't** — at least one anti-example with a caption explaining what makes it
            wrong. Anti-examples are the most under-included element in real
            brand guidelines and the most useful.

**When in doubt** — the heuristic to apply when an edge case isn't covered. This
                    is what designers will actually reach for at 11pm on a Friday.
                    Without it, the rules are useless in the cases that matter.
```

If a section can't yet be written with all five parts, that's a gap — flag it
in the gaps list.

---

## Section depth modulation

Each section has three depths. Pick based on the user's overall depth selection
*and* the section's importance for this brand.

- **Quick** — 3-6 lines. The single most important rule + one example. Used in
  one-pagers, quick reference cards, and sections that don't matter much for
  this brand.
- **Standard** — full five-part structure (principle, rules, show, don't, when
  in doubt). The default for most sections in most brand documents.
- **Deep** — full structure plus rationale paragraphs, multiple examples,
  multiple anti-examples, edge cases, exceptions, and links to source material
  (research, case studies, decisions). Used for foundational sections (logo,
  colour, type, tone of voice) in full brand books.

---

## The section menu

### Foundational

#### 1. Brand strategy *(why this brand exists)*
**Include for:** Brand book *(always)*, Visual identity guidelines *(usually)*,
Design system *(rarely)*, Editorial *(usually)*, Sub-brand *(always)*
**Standard contents:** vision, mission, purpose, values, positioning statement.
Pull from the project state Brief if available, or from `/creativestack:creative-strategy`
output if it ran earlier.

**Standard treatment:**
- Principle: One paragraph on what the brand exists to do
- Rules: 3-5 bullet points — vision, mission, values, positioning, audience
- Show / Don't: usually skipped for this section *(strategy is words, not
  visuals)* — replace with 1-2 sentences on how strategy shows up in the work
- When in doubt: "Does this decision make the brand more like itself, or less?"

#### 2. Brand story *(narrative)*
**Include for:** Brand book *(always)*, others *(rarely)*
**Standard contents:** origin, key moments, where the brand is going. Optional
unless the brand has a strong narrative worth telling.

#### 3. Brand personality *(traits and attributes)*
**Include for:** Brand book *(always)*, Visual identity *(usually)*, Editorial *(always)*

**Standard treatment:**
- Principle: How personality shapes every choice
- Rules: 3-5 personality traits, each with 1-line definition. Avoid generic
  ones like "passionate", "innovative", "human" — they describe every brand
- Show: A "we are / we are not" table — far more useful than the trait list
  alone, because it forces specificity through opposition
- Don't: A list of personality traits to actively reject
- When in doubt: "Which trait is loudest in this moment, and is it being
  expressed through more than just words?"

#### 4. Brand architecture *(when there are sub-brands)*
**Include for:** Multi-brand companies, parent + sub-brand systems, endorsed
brand structures
**Standard contents:** the architecture model (masterbrand / endorsed /
independent / hybrid), how brands relate visually and verbally, when to use
each, naming conventions for sub-brands.

**This section is almost always missing from brand guidelines and almost always
needed.** If the company has more than one brand, ask whether it should be
included.

---

### Visual identity

#### 5. Logo
**Include for:** Brand book *(always)*, Visual identity *(always)*, Design
system *(often)*, Editorial *(rarely)*

**Standard treatment:**
- Principle: What the logo represents and why it looks the way it does
- Rules: primary lockup, variations (horizontal, stacked, icon-only), clear
  space (specified in units of the mark itself, not pixels — e.g., "1x the
  height of the symbol"), minimum size (specify both digital pixels and print
  millimetres), file formats provided
- Show: examples of the logo in actual context, not floating on white
- Don't: 6-8 explicit misuses, each captioned (stretching, recolouring,
  rotating, drop-shadowing, outlining, putting on busy backgrounds, recreating
  in code, modifying the mark)
- When in doubt: "Is the logo legible, contained, and unmodified? If yes, use
  it. If no, use a different lockup or a different background."

**Deep treatment additions:**
- Construction grid (how the mark is built)
- Co-existence rules (when used alongside other brands)
- Animation rules (if the logo animates)
- Historical evolution (if relevant — rare)
- Trademark notation rules

#### 6. Colour palette
**Include for:** Brand book *(always)*, Visual identity *(always)*, Design
system *(always)*, Editorial *(usually)*

**Standard treatment:**
- Principle: How colour carries the brand's personality
- Rules:
  - Primary colours table (name, hex, RGB, CMYK, Pantone)
  - Secondary colours table (same)
  - Tints and shades if applicable
  - Recommended ratios (e.g., 60/30/10)
  - Combinations that work and combinations to avoid
- **Accessibility check:** every foreground/background combination tested
  against WCAG. See `references/accessibility-checks.md` for the methodology.
- Show: 3-5 example combinations in context
- Don't: combinations that fail accessibility *or* the brand mood
- When in doubt: "Use primary first, secondary as accent, neutral as ground.
  Reach for tints/shades only when the primary palette can't carry the layout."

**Deep treatment additions:**
- Colour psychology rationale (why these colours, briefly)
- Print-vs-digital colour management notes
- Dark mode adaptations
- Brand colour for partner or co-branded contexts
- Colour token names if mapping to a design system

#### 7. Typography
**Include for:** Brand book *(always)*, Visual identity *(always)*, Design
system *(always)*, Editorial *(always)*

**Standard treatment:**
- Principle: How type carries the brand's voice
- Rules:
  - Primary typeface (name, foundry, weights licensed, where to source)
  - Secondary typeface (if applicable)
  - System / web fallback chain (critical and almost always missing)
  - Type scale (sizes, line heights, weights, tracking) — give a real scale,
    not a single sample
  - Hierarchy rules (when to use H1 vs H2 vs body, etc.)
  - Numerals (lining or oldstyle, tabular for tables)
  - Ligatures, OpenType features used
- Show: a type specimen at multiple sizes
- Don't: type misuse (stretching, fake bold, fake italic, mixed weights, web-safe
  substitutions when the licensed font is available)
- When in doubt: "Use the primary typeface unless the use case explicitly
  requires the secondary. Default to the type scale; only break it if a
  specific layout needs it and the principle still holds."

**Deep treatment additions:**
- Licensing information (who pays, how seats work, what's included)
- Multilingual / multi-script support
- Variable font axes if applicable
- Typeface substitution rules for low-bandwidth contexts
- Token names if mapping to a design system

#### 8. Imagery & photography
**Include for:** Brand book *(always)*, Visual identity *(usually)*, Design
system *(usually for stock library)*, Editorial *(usually)*

**Standard treatment:**
- Principle: What photography / imagery does for this brand and how it differs
  from competitors
- Rules:
  - Subject matter (what we shoot, who we cast, what we don't)
  - Treatment (colour grade, post-production, mood)
  - Composition (framing, depth, light)
  - Sourcing (commissioned vs stock, where stock comes from, how to credit)
  - Cropping and aspect ratios
- Show: 6-9 photographs that exemplify the system, each captioned
- Don't: 3-5 photographs that look "close but wrong", each captioned with what
  makes it wrong (this is the most useful part of any imagery section)
- When in doubt: "Would the audience recognise this as one of ours if the logo
  was removed?"

#### 9. Iconography
**Include for:** Visual identity *(usually)*, Design system *(always)*,
Editorial *(rarely)*

**Standard treatment:**
- Principle: What icons do for the brand
- Rules: style (filled vs outlined vs duotone), grid (e.g., 24×24),
  stroke weight, corner radius, end caps, custom vs library, naming convention
- Show: a small grid of icons in context
- Don't: inconsistent styles, off-grid icons, mixing icon families
- When in doubt: "If the icon doesn't exist in the system, use the closest
  match from the library — don't draw a new one without going through the
  governance process."

#### 10. Illustration
**Include for:** brands that use illustration as a system; skip otherwise.
Don't include this section just to look comprehensive.

#### 11. Layout & grid
**Include for:** Visual identity *(usually)*, Design system *(always)*,
Editorial *(usually)*

**Standard treatment:**
- Principle: How layout creates rhythm and hierarchy
- Rules: grid (columns, gutters, margins), spacing scale (multiples of a
  base unit), alignment rules, hierarchy patterns
- Show: example layouts at common formats
- Don't: layouts that violate the grid for no clear reason
- When in doubt: "Use the grid. Break it only when a specific layout requires
  it and the brand still feels like itself."

---

### Voice & language

#### 12. Tone of voice
**Include for:** Brand book *(always)*, Editorial *(always)*, Design system
*(usually for content patterns)*

**Standard treatment:**
- Principle: How the brand sounds, expressed in 1-2 sentences
- Rules: 3-5 voice principles (e.g., "plain, never patronising"), each with a
  short rationale
- Show: 3-5 *before / after* rewrites — original sentence, then on-brand
  rewrite. Far more useful than abstract voice descriptions.
- Don't: words and phrases the brand never uses + the reasons why
- When in doubt: "Read it aloud. If it sounds like something a human would say
  in the room with the audience, ship it. If it sounds like a brochure, rewrite."

**Deep treatment additions:**
- Voice flex across contexts (apology vs celebration, support vs marketing)
- Voice in motion (how voice flexes in animation, video, sonic identity)
- Pull from `/creativestack:update-voice` output if available

#### 13. Writing rules
**Include for:** Editorial *(always)*, Brand book *(usually)*

**Standard treatment:**
- Capitalisation (sentence case vs title case — pick one and commit)
- Punctuation (oxford comma yes/no, em vs en dash, ellipses)
- Numerals (write out one to nine, use figures from 10)
- Dates and times (preferred format, time zone notation)
- Currency
- Acronyms (full term first time, then acronym)
- Product, feature, and brand names (which are capitalised, which are not)
- Inclusive language guidance (gender, ability, age, race, neurodivergence)
- Translation and localisation notes if relevant

#### 14. Terminology
**Include for:** brands with specific product or feature vocabulary — SaaS,
financial, healthcare, technical brands. Skip otherwise.

A simple A-Z table of approved terms with definitions, plus terms to avoid
and what to say instead.

---

### Digital-first

#### 15. Motion & animation
**Include for:** any brand that lives on screens; especially Design system
*(always)* and Visual identity for digital-first brands *(usually)*

**Standard treatment:**
- Principle: how motion expresses the brand's personality (snappy, fluid,
  restrained, playful)
- Rules: durations (e.g., 200ms micro / 400ms macro), easing curves, what
  triggers motion, what motion should never do, motion sensitivity
  considerations (`prefers-reduced-motion`)
- Show: 2-4 reference animations linked from real product or campaign work
- Don't: motion anti-patterns (bouncing, elastic, gratuitous parallax,
  motion-only feedback)
- When in doubt: "If the motion isn't communicating something specific about
  state, hierarchy, or attention, cut it."

#### 16. Sound & sonic identity
**Include for:** brands with sonic identity systems — broadcast brands, audio
products, brands with sonic logos. Skip otherwise.

#### 17. Interaction patterns
**Include for:** Design system *(always)*, digital-first Visual identity
*(usually)*

**Standard treatment:**
- Interactive states table (default, hover, active, focus, disabled, error)
  for each common element
- Feedback patterns (success, error, loading, empty states)
- Microcopy patterns
- Accessibility (focus order, keyboard navigation, screen reader behaviour)

#### 18. Component library
**Include for:** Design system *(always)*. Skip for non-digital guidelines.

This is rarely written into the document itself — it lives in Figma, Storybook,
or a design system tool. The guidelines should *link* to the component library
and document the principles, not duplicate the components.

#### 19. Responsive behaviour
**Include for:** Design system *(always)*, digital-first Visual identity
*(usually)*

**Standard treatment:**
- Breakpoints table (name, width, what changes)
- Logo responsive rules
- Typography responsive scale
- Grid responsive rules
- Imagery art direction shifts

---

### Application & governance

#### 20. Brand applications
**Include for:** Brand book *(usually)*, Visual identity *(usually)*

A spread per major touchpoint — packaging, OOH, digital, print, environmental,
merchandise, social. Each with one example and the principle that drove it.
Aim for *representative*, not *exhaustive*.

#### 21. Co-branding & partnerships
**Include for:** brands that are routinely co-branded or appear alongside
partners — sponsorships, affiliates, co-marketing relationships

**Standard treatment:**
- Principles for co-branding
- Lockups for common partner relationships
- Spacing and hierarchy when shown alongside other brands
- Pre-approval requirements for new co-branding contexts

**This is almost always missing and almost always needed for any brand that
gets co-marketed.**

#### 22. Print & production
**Include for:** brands with significant print presence (FMCG, hospitality,
retail, publishing). Skip for digital-only brands.

Paper stocks, finishes, ink notes, supplier preferences, file formats, print
production standards.

#### 23. Localisation & internationalisation
**Include for:** brands operating across languages or scripts

How the brand flexes across languages, scripts, reading directions, and
cultural contexts. Logo, colour, type, imagery, voice — each may need
adaptation rules.

#### 24. Asset library
**Include for:** every guidelines document. Always.

Where the actual files live, how to access them, naming conventions, version
status of each asset, who to contact for missing assets. **Brand guidelines
without an accompanying asset library are theory.**

#### 25. Governance
**Include for:** every guidelines document beyond a one-pager. Always.

See `references/governance.md` for the full treatment. Covers: ownership,
versioning, exception requests, audit cadence, distribution, training. The
single most under-included section in real brand guidelines.

#### 26. Accessibility
**Include for:** every guidelines document. Always.

See `references/accessibility-checks.md` for the full treatment. Critically,
accessibility should be **threaded through every section**, not just bolted on
as a single section at the end. Use a single accessibility section as the
*summary* of the threaded checks throughout the doc.
