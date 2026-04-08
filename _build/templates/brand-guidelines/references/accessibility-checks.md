# Brand Guidelines Accessibility Checks

Accessibility in brand guidelines is almost always treated as a single section
at the back of the document — usually a paragraph saying "we care about
accessibility" — and almost never threaded through the system itself. This is
the difference between accessible brands and brands that perform accessibility.

This file is read at generation time to run the actual checks and to thread
accessibility considerations through every relevant section.

---

## Where accessibility shows up *(thread it through)*

| Section | Accessibility consideration |
|---------|----------------------------|
| Logo | Minimum size for legibility, alt text patterns, monochrome variations for backgrounds |
| Colour | Contrast ratios for every foreground/background combination, colour-blindness simulation, never relying on colour alone for meaning |
| Typography | Minimum body size (16px web / 12pt print), line height ratios, tracking, weight contrast, reading-aloud language |
| Imagery | Alt text patterns, captions for video, no flashing content (3-flash rule) |
| Iconography | Minimum size, label requirements, never icon-only without label |
| Layout & grid | Reading order, focus order for digital, touch target minimums (44×44pt) |
| Tone of voice | Plain language principles, reading age, jargon avoidance |
| Writing rules | Inclusive language, alt text writing patterns, link text patterns ("read more" is bad) |
| Motion | `prefers-reduced-motion` support, no parallax-only navigation, motion sensitivity |
| Interaction | Keyboard navigation, focus indicators, screen reader behaviour, error patterns |
| Component library | Each component has accessibility notes baked in (ARIA roles, keyboard, contrast) |
| Asset library | Alt text on every asset, accessibility notes in metadata |

The goal: every section ends with an accessibility note, even if it's one line.
The summary "Accessibility" section at the back of the document is the
*roll-up*, not the only place accessibility appears.

---

## Colour contrast methodology

This is the most concrete accessibility check the skill runs.

### What to check
- Every primary colour as foreground against every other primary colour as
  background
- Every primary colour as foreground against neutrals (white, black, greys in
  the system)
- Every secondary colour against likely backgrounds
- Brand colour against the most common product / web background
- Colour-on-colour combinations the user has shown in marketing or product

### How to check
For each pair, compute the WCAG contrast ratio using the standard formula
(relative luminance). Report:

| Combination | Contrast Ratio | WCAG AA *(4.5:1 body, 3:1 large)* | WCAG AAA *(7:1 body, 4.5:1 large)* | Use case |
|------------|---------------|-----------------------------------|------------------------------------|----------|
| {fg colour} on {bg colour} | {X.X:1} | {Pass / Fail} | {Pass / Fail} | {body text / large text / UI element / decorative} |

### What counts as "large text"
- 18pt+ regular weight, OR
- 14pt+ bold weight

### When a combination fails AA
Surface the failure explicitly. Don't bury it. Suggest alternatives:

> **Action required:** {N} colour combinations fail WCAG AA for body text.
> Suggested alternatives that stay within the brand palette:
> - {fg hex} → {fg hex alternative}: {ratio against bg, with reason —
>   "darker shade preserves brand mood while lifting contrast to 5.2:1"}
> - {fg hex} → {fg hex alternative}: {ratio with reason}

If no alternatives within the palette work, recommend: "Limit this combination
to decorative use only — never body copy or UI text. Consider expanding the
palette with a darker / lighter variant of {colour name}."

### Decorative vs functional colour
Not every colour combination needs to pass AA. A decorative gradient or a
background image doesn't carry information, so it doesn't need contrast
compliance. The rule is: if the colour carries meaning or contains text, it
must pass. If it's purely visual, it doesn't.

Always state which combinations are decorative-only in the colour section.

### Colour-blindness simulation
For brands where colour carries meaning (data viz, status indicators,
categorisation), recommend running the palette through:
- Protanopia (red-blind) simulation
- Deuteranopia (green-blind) simulation — most common
- Tritanopia (blue-blind) simulation
- Achromatopsia (no colour) simulation

If colour is the *only* way meaning is communicated, flag as a failure
regardless of contrast ratio. **Never rely on colour alone.**

---

## Typography accessibility

### Minimum sizes
- **Body text web:** 16px minimum (some accessibility guides now recommend
  18px). Anything below is a flag.
- **Body text print:** 9pt minimum, 11pt preferred.
- **Captions and microcopy:** 12px web / 8pt print minimum, and only for
  truly secondary information.
- **Touch targets:** 44×44pt minimum (Apple HIG) or 48×48dp (Material).

### Line height
- Body copy: 1.4–1.6× the font size, depending on the typeface
- Headings: 1.1–1.3×
- Tighter than 1.4 for body becomes hard to read at length

### Tracking
Tight tracking on body copy is fashionable and inaccessible. Default to 0
tracking on body, ±20 on headings.

### Weight contrast
The hierarchy between body and emphasis (bold, semibold) should be visually
clear at the body size. If you can't tell bold from regular at 16px, the
typeface or weight choice is wrong.

### Type that ignores accessibility
- All-caps body copy (slower to read)
- Italic body copy (slower to read for some readers)
- Centred body copy at length (hard to track line ends)
- Justified body copy in narrow columns (creates rivers and uneven spacing)
- Light or thin weights for body copy (low contrast even on dark backgrounds)
- Decorative typefaces for anything other than display

Each of these can be used deliberately for effect. None of them belong in
default body settings.

---

## Motion accessibility

### `prefers-reduced-motion`
The brand's motion system must respect this user preference. Specify:
- What gets disabled when reduced motion is on (parallax, autoplay video,
  decorative animation, complex transitions)
- What persists (functional motion that communicates state, simple fades, very
  brief transitions)

### The 3-flash rule
No content should flash more than 3 times per second. This applies to
motion, video, and gif content.

### Motion as the only signal
If a state change is communicated *only* through motion (e.g., a button shows
it's loading only by spinning), the state is invisible to anyone with reduced
motion. Always pair motion signals with text or icon signals.

### Motion sensitivity
Some users experience motion sickness from animation, even at standard speeds.
Vestibular disorders are more common than designers usually assume. Recommend:
- No autoplay video without user control
- No infinite-scroll parallax
- No persistent background animation in core navigation
- A clearly documented way to disable animation system-wide if motion is
  central to the brand

---

## Voice & writing accessibility

### Plain language principles
- Reading age: target 12-14 unless the audience genuinely requires
  specialised vocabulary
- Sentence length: average 15-20 words
- Active voice: default
- Jargon: cut, or define on first use
- Acronyms: spelled out on first use, then acronymised

### Inclusive language
- Gender-neutral by default ("they" not "he/she")
- Person-first vs identity-first language: ask the community, don't guess
- Avoid disability metaphors ("falling on deaf ears", "blind to") unless
  relevant
- Avoid age, ability, race, neurodivergence assumptions
- Avoid violent language as metaphor ("kill the meeting", "shoot it over")
  unless the brand has a specific reason

### Alt text patterns
Every image asset should have alt text. The brand guidelines should specify:
- The voice and length of alt text
- What to do with decorative images (alt="" not "decorative image")
- How to describe charts and data visualisations
- How to describe brand imagery without being mechanical
- Who writes alt text (designer? copywriter? both?)

### Link text
- Never "click here" or "read more" — both are inaccessible to screen readers
  navigating by link list
- Link text should describe the destination
- The brand voice should flex enough to allow descriptive link text without
  sounding stiff

---

## Component-level accessibility *(for design systems)*

If the document is a design system, accessibility should be baked into every
component, not separated. For each component:

- Keyboard interaction (tab order, enter, space, escape, arrow keys)
- Focus indicator (visible, contrasting, never `:focus { outline: none }`)
- Screen reader behaviour (ARIA role, state, label patterns)
- Touch target size
- Contrast in every state (default, hover, active, focus, disabled)
- Error patterns (clear, contextual, screen reader announced)
- Loading patterns (clear, screen reader announced, never motion-only)
- Empty state patterns

The component documentation should treat accessibility as a first-class
consideration, not a footnote.

---

## Localisation accessibility

For brands operating across languages, accessibility considerations multiply:

- Type that supports the required scripts (Latin, Cyrillic, Arabic, CJK,
  Devanagari, etc.) — many brand typefaces don't, and the substitution
  experience is usually broken
- Right-to-left layout adaptations
- Reading direction effects on iconography (arrows, progress bars)
- Date and number formats
- Cultural colour meanings
- Translation expansion (German is ~30% longer than English; Chinese is much
  shorter — both break tight layouts)

If the brand operates internationally, this should be a section, not a
footnote. If it's monolingual, skip.

---

## Accessibility summary section

The brand guidelines document should still include a single Accessibility
section as the roll-up. But it should be a *summary of the threaded checks*,
not the only place accessibility appears.

Standard structure:

```markdown
## Accessibility

Accessibility is built into every section of these guidelines. This section
summarises the principles and points to where each consideration lives.

### Our commitment
{1-2 sentences. Specific. What standard the brand commits to (WCAG 2.2 AA at
minimum, AAA where possible).}

### Where accessibility lives in this document
- **Colour:** contrast checks for every combination → see Colour palette
- **Typography:** minimum sizes and line heights → see Typography
- **Motion:** `prefers-reduced-motion` and the 3-flash rule → see Motion
- **Voice:** plain language and inclusive language → see Tone of voice
- **Components:** keyboard, screen reader, focus, touch targets → see Components

### Accessibility audit cadence
{When the brand's accessibility is reviewed and by whom — see Governance}

### Who owns accessibility
{Named role / person — see Governance}

### Known gaps
{Honest list of where accessibility is not yet meeting the brand's commitment.
Better to surface this than hide it.}
```

If the brand can't yet make a real accessibility commitment, surface that as
a gap. Don't paper over it.
