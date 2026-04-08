# Brand Guidelines Output Formats

The skill produces guidelines in different shapes depending on Type × Audience ×
Format. This file contains the templates.

## The four document types

| Type | What it covers | Typical length | Primary audience |
|------|----------------|----------------|------------------|
| **Brand book** | Foundational — strategy, story, personality, all visual + voice systems, applications | 60-150 pages | Internal teams, agency partners, sub-brands |
| **Visual identity guidelines** | The visual system — logo, colour, type, imagery, layout, motion | 30-80 pages | Designers, print suppliers, digital teams |
| **Design system** | Component-level rules for digital products | Lives in Figma + linked docs | Product designers, engineers |
| **Editorial guidelines** | Voice, writing rules, terminology, tone flex | 15-40 pages | Writers, content teams, customer support |

The four types are not mutually exclusive — a mature brand needs all four. But
each one has a different audience, a different shape, and a different
maintenance cadence.

## The three depths

| Depth | Use for |
|-------|---------|
| **Quick reference** | One-pager. Logo + colour + type + voice in one sentence each. For internal teams who need a refresher, not training. |
| **Standard guidelines** | Full structure, working depth. The default for most projects. |
| **Brand book** | Full structure, deep treatment, rationale, examples, source material, governance. The "definitive" version. |

## The audience modulator

The same brand needs *different documents for different audiences*. This is the
single biggest mistake in brand guideline production: writing one document for
everyone, which serves nobody.

### Internal team
Tone: assumes context, can be opinionated about *why*, can include strategic
rationale. Can reference internal tools and processes.

### External partner / agency
Tone: assumes craft competence but no internal context. Needs explicit how-to.
Should include enough rationale that the partner can make sound judgment in
edge cases.

### Licensee / franchisee
Tone: explicit, prescriptive, defensive. Lots of "don't". Heavy on
do/don't examples. Light on rationale (they don't need it; they need rules).
Co-branding section becomes critical.

### Public / open-source
Tone: educational, transparent. The brand is being shown to candidates,
journalists, competitors, fans. Strategy section becomes important. Asset
download access is the headline feature.

When the user picks an audience, modulate tone, depth, and section selection
accordingly. Always confirm the modulation choice with the user before
generating.

## The four formats

### Markdown / PDF (default)
The fallback. Always generated. Use the structure in this file. PDF export is
the user's job (they paste markdown into Pages, Notion, Word, or run it through
a tool).

### Notion
If `mcp__claude_ai_Notion__` is available, offer to publish to a Notion database
or page. Notion guidelines are easier to maintain and update — they win for
living documents. Each section becomes a page; each rule becomes a block. Save
the Notion page ID to project state Skill Memory so future runs can update
in place rather than duplicate.

### Figma
If `mcp__claude_ai_Figma__` or `mcp__plugin_figma_figma__` is available, offer
to lay the document out in Figma. **Critical distinction:** the agency's
`visual-style.md` applies to the *layout of the document itself* — its
typography, spacing, tone of presentation. The brand colours and type *being
documented inside* belong to the client. Don't blend the two.

### Brand portal *(Frontify, Lingo, Brandfolder, etc.)*
If the user mentions they use one of these tools, generate the markdown content
in the structure their tool expects, but don't try to push directly. Tell the
user: "Paste the section content into your Frontify pages — I've structured
each section to match Frontify's standard page layout."

---

## Universal document template

```markdown
# Brand Guidelines: {Brand Name}
**Document type:** {Brand book / Visual identity / Design system / Editorial}
**Version:** {X.Y}
**Last updated:** {date}
**Owner:** {role / name}
**Audience:** {Internal team / Agency partner / Licensee / Public}
**Status:** {Draft / In review / Approved / Archived}

## How to use this document

{2-3 sentences. Who this document is for, what they should reach for it for,
what it doesn't cover. Include a "when in doubt, ask {role}" line.}

## What's new in this version
{Versioning summary — only the changes since the last version. Critical for
adoption: people reading the doc for the second time should not have to read
the whole thing again.}

---

## Completeness score *(internal — strip before publishing)*

A brand system audit before the document is published. Each section is rated
Complete / Partial / Missing.

| # | Section | Status | Notes |
|---|---------|--------|-------|
| 1 | Brand strategy | {Complete / Partial / Missing} | {1 line} |
| 2 | Brand personality | {status} | {notes} |
| 3 | Logo | {status} | {notes} |
| 4 | Colour palette | {status} | {notes} |
| 5 | Typography | {status} | {notes} |
| 6 | Imagery & photography | {status} | {notes} |
| 7 | Iconography | {status} | {notes} |
| 8 | Layout & grid | {status} | {notes} |
| 9 | Tone of voice | {status} | {notes} |
| 10 | Writing rules | {status} | {notes} |
| 11 | Motion & animation | {status} | {notes} |
| 12 | Interaction patterns | {status} | {notes} |
| 13 | Responsive behaviour | {status} | {notes} |
| 14 | Brand applications | {status} | {notes} |
| 15 | Co-branding | {status} | {notes} |
| 16 | Asset library | {status} | {notes} |
| 17 | Governance | {status} | {notes} |
| 18 | Accessibility *(threaded)* | {status} | {notes} |

**Overall completeness:** {X / 18 sections} — **{percentage}%**

{The completeness score reflects the brand SYSTEM, not the document. A 60%
score means the brand has 40% of decisions still to make — which is fine for a
v1, but should be flagged honestly so the user knows what's missing.}

---

## Strategic foundation

{Sections 1-4 from `references/section-library.md`, picked based on document
type. Brand books include all four; visual identity guidelines usually include
1 and 3 only; design systems usually skip these.}

## Visual system

{Sections 5-11 from `references/section-library.md`, picked based on document
type. Visual identity guidelines and brand books include most or all; design
systems include 5-7 + 11; editorial guidelines may include 5-7 only.}

## Voice & language

{Sections 12-14 from `references/section-library.md`, picked based on type.
Editorial guidelines centre on these; brand books include them; visual identity
may include 12 only.}

## Digital system *(if relevant)*

{Sections 15-19 from `references/section-library.md`, picked based on type.
Design systems include all; brand books for digital-first brands include most;
visual identity for print-first brands may skip entirely.}

## Application & governance

{Sections 20-26 from `references/section-library.md`. Sections 24 (Asset
library), 25 (Governance), and 26 (Accessibility summary) should be included
in EVERY document beyond a one-pager. Section 21 (Co-branding) should be
included for any brand that gets co-marketed.}

---

## Gaps identified *(strip before publishing externally)*

Brand decisions still to be made — auto-populated from the completeness score
and the per-section pre-flight check. This list is the most useful internal
output of this skill.

- [ ] **{Section}** — {what's missing — e.g., "No defined colour ratios.
  Recommend deciding 60/30/10 split or proportional rule."}
- [ ] **{Section}** — {gap}
- [ ] **{Accessibility gap}** — {e.g., "3 colour combinations fail WCAG AA.
  Suggested alternatives: {hex values that stay within the palette family}"}
- [ ] **{Section}** — {gap}

## Next steps
1. {Specific next step — e.g., "Decide colour ratios and confirm secondary
   palette before document is shared externally"}
2. {Next step}
3. {Next step}

---

## Document version history *(for governance)*

| Version | Date | Owner | Changes |
|---------|------|-------|---------|
| {X.Y} | {date} | {name} | {summary} |
```

---

## One-pager format *(Quick reference depth)*

```markdown
# {Brand Name} — Brand at a glance
**Version:** {X.Y}  |  **Last updated:** {date}  |  **Owner:** {role}

## What we are
{One sentence — the positioning. Specific.}

## How we look
**Logo:** {primary lockup, 1 line on usage}
**Colour:** {primary hex + 1 line on ratio}
**Typography:** {primary typeface + scale rule}
**Imagery:** {1 line on style}

## How we sound
**Voice:** {3 adjectives}
**We are:** {trait, trait, trait}
**We are not:** {trait, trait, trait}

## When in doubt
{The single brand-wide heuristic. The most useful sentence in any guidelines
document. Example: "If it doesn't sound like something a thoughtful person
would say in the room, rewrite it."}

## Where to find more
**Full guidelines:** {link}
**Asset library:** {link}
**Owner / questions:** {name + contact}
```

The one-pager is for people who already know the brand and need a refresher.
For new joiners, point them to the full guidelines.

---

## Notion publishing notes

If publishing to Notion via MCP:

1. **Database structure:** create one database per document type, with pages
   for each section. Properties: Section, Status, Owner, Last updated, Version.
2. **Section pages:** each section becomes a page. Use H2/H3 for principle /
   rules / show / don't / when in doubt.
3. **Image embeds:** use Notion's image block, not file uploads, when possible.
4. **Save the Notion page / database ID to project state Skill Memory** so
   future runs of this skill can update in place.

## Figma publishing notes

If laying out in Figma via MCP:

1. **Read `~/.creativestack/visual-style.md` first.** Apply its typography,
   colour, spacing rules to the document chrome — the headers, footers,
   navigation, page numbers, captions. This is the agency's house style for
   *the document itself*.
2. **Do not apply visual-style to the brand being documented.** The colours,
   type, and imagery being shown *inside* the document belong to the client
   brand. Keep these strictly separated.
3. **Page structure:**
   - Cover page: brand name, version, date, document type
   - Table of contents
   - One spread per major section
   - Asset library page (with download links if available)
   - Governance page
4. **Reusable components:** colour swatch component, type specimen component,
   do/don't comparison component, version banner component. These should match
   `visual-style.md` aesthetic.
5. **After generating, walk the anti-slop checklist** in this file *and* the
   anti-slop checklist in `visual-style.md`. Fix anything that fails before
   showing the user.

## Anti-slop checklist *(run before showing the user)*

Brand guidelines slop is among the most common output in any agency. It looks
"comprehensive" but doesn't help anyone make decisions. Run this checklist
before delivering — fix any failures.

- [ ] **Every section has a Principle line.** Without principles, rules are
  arbitrary and break the moment a designer hits an unanticipated case.
- [ ] **Every section has at least one Don't example.** Anti-examples are the
  most under-included element in real-world guidelines.
- [ ] **Every section has a "When in doubt" line.** This is what designers
  reach for at 11pm on a Friday.
- [ ] **No "passionate, innovative, human" personality traits.** These describe
  every brand and define no brand. Force specificity.
- [ ] **No rules without reasons.** Every rule should be traceable to either a
  principle, an accessibility requirement, or a brand-strategy decision.
- [ ] **No floating logos.** Every logo example should be in context — on a
  product, on a sign, in a layout. Logos floating on white teach designers
  nothing.
- [ ] **Colour combinations have been WCAG-tested** and any failures are
  surfaced explicitly with suggested alternatives.
- [ ] **Type scale is real.** A single sample isn't a scale. Real type scales
  show the relationship between sizes, weights, and line heights at the scale
  designers will actually use.
- [ ] **The asset library section exists and points somewhere real.**
  Guidelines without an asset library are theory.
- [ ] **The governance section exists** and answers: who owns this, how is it
  updated, how do you request an exception?
- [ ] **The audience is named** in the "How to use this document" section.
  Documents written for "everyone" serve nobody.
- [ ] **The "what's new" section is up to date.** Versioning that nobody
  updates is worse than no versioning.
- [ ] **No section exists just to look comprehensive.** If a section is
  included but has no real input, mark it as a gap, don't fabricate content
  to fill it.
- [ ] **The brand could not be confused with its nearest competitor** based on
  this document. If it could, the document is describing the category, not
  the brand.
