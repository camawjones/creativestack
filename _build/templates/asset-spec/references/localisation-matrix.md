# Localisation Matrix

> Localisation is rarely "swap the copy". When the campaign runs in multiple markets,
> generate a localisation matrix early — it surfaces hidden production work the
> creative team would otherwise discover three weeks in.

## How to use this file

When the user mentions multiple markets, languages, or regions, generate a
localisation matrix before finishing the asset spec. Add a `## Localisation Matrix`
section to the spec output.

---

## What localisation actually involves

It's not just translation. Each market may need:

| Layer | What changes | Effort |
|---|---|---|
| **Copy translation** | Headline, body, CTA | Low |
| **Transcreation** | Idiomatic rewrite (taglines, puns, cultural references) | Medium-High |
| **Image selection** | Subjects, settings, hand gestures, food, ethnicity, signage | High |
| **Layout reflow** | German/Finnish/Russian text expands 30-50%; Chinese/Japanese contract | Medium |
| **Direction (RTL)** | Arabic, Hebrew, Farsi, Urdu — entire layout flips | High |
| **Numerical formats** | Date (DD/MM vs MM/DD), currency, decimal separator, units | Low |
| **Legal copy** | Disclaimers vary by jurisdiction (FTC, ASA, etc.) | Medium |
| **Music / VO** | Music license, native voiceover talent, language-appropriate music | Medium-High |
| **Brand assets** | Logo lockup language variants, language-specific brand marks | Low |
| **Compliance** | Allergen/ingredient marks, sustainability claims, age-gating | Medium |

Mark each layer per market in the matrix.

---

## Character expansion table (text length changes by language)

When the master is in English, expect text to grow or shrink in localised versions.
This affects layout — buttons, headlines, and tightly-spaced copy break.

| Target language | Expansion vs English |
|---|---|
| German | +30% to +50% |
| Russian | +20% to +30% |
| French | +15% to +25% |
| Spanish | +15% to +25% |
| Italian | +10% to +20% |
| Portuguese (BR) | +10% to +20% |
| Dutch | +20% to +30% |
| Finnish | +30% to +60% |
| Polish | +20% to +30% |
| Arabic | -10% to +10% (RTL) |
| Hebrew | -10% to +10% (RTL) |
| Chinese (Simplified) | -50% to -70% |
| Chinese (Traditional) | -50% to -70% |
| Japanese | -40% to -60% |
| Korean | -20% to -40% |
| Thai | -20% to -10% (no spaces between words) |

**Implication:** Design English masters with 20-30% headroom. Always confirm against
the longest target language.

---

## RTL (right-to-left) considerations

Languages: Arabic, Hebrew, Farsi, Urdu.

When delivering RTL versions:

- **Flip the entire layout horizontally** (mirror — not just text alignment)
- Logos: most stay LTR (don't mirror brand marks unless the brand has an RTL lockup)
- Icons: directional icons (arrows, play buttons) usually flip; non-directional don't
- Numbers: Western Arabic numerals (1234567890) are standard in modern Arabic; Eastern only when explicitly requested
- Punctuation: question marks and parentheses flip
- Mixed content (English brand + Arabic body) needs careful bidirectional handling
- Test with native speakers — automated mirroring breaks subtleties

---

## Image and creative concept localisation

Images often can't be reused across markets. Things to flag:

- **People:** Ethnicity, age, dress, body language must reflect target market
- **Hand gestures:** Thumbs up, OK sign, pointing — meanings vary by culture
- **Food / drink:** Beer in Saudi Arabia, beef in India, pork in Israel — never reuse blindly
- **Signage / typography in-frame:** Background signs, posters, books should be in target language or generic
- **Holidays / weather / seasons:** Northern vs Southern hemisphere; Ramadan vs Christmas
- **Currencies / units:** £/$/€, miles/km, °F/°C, stones/kg
- **Colour symbolism:** White = mourning in some East Asian markets; red = luck in China but warning in Western
- **Animals / symbols:** Owls, dogs, pigs, cows have different cultural weight by region

Flag in the matrix which images can be reused across markets and which need market-specific shoots.

---

## Localisation matrix template (for the asset spec output)

```markdown
## Localisation Matrix

**Markets:** {list}
**Master language:** {language}

| Asset ID | EN (master) | FR | DE | ES | AR (RTL) | JP | Notes |
|---|---|---|---|---|---|---|---|
| PM-001 | ✓ master | Translate | Translate + reflow | Translate | RTL flip + transcreate | Transcreate + image swap | Hand gesture replaced for AR |
| PM-002 | ✓ master | Translate | Translate + reflow | Translate | RTL flip | Transcreate | — |

**Translation effort:** {total word count} × {N languages} = {total words}
**Reflow effort:** {N assets} where target language exceeds master length
**Image variants needed:** {list of asset IDs that need new shots}
**RTL flips:** {N assets}
**Transcreation needed:** {Y/N — list which copy lines}
```

---

## Translation deliverables — what production needs

Provide translators with:

1. **Source copy in plain text or .xliff** (not Word — translators use CAT tools)
2. **Character/line limits per field** (especially for buttons, headlines, captions)
3. **Tone of voice notes per market** (some allow informality, some don't)
4. **Glossary of brand terms that don't translate** (product names, taglines)
5. **Reference visual** so they can see how copy lays out
6. **Deadlines per language** (rarely all simultaneous)
7. **Review process** — in-market reviewer? Legal sign-off?

---

## Common mistakes

- Treating French Canada (fr-CA) and France (fr-FR) as the same. They're not.
- Treating Spanish (es-ES) and LatAm Spanish (es-419) as the same. They're not.
- Translating brand product names that should stay in source language
- Forgetting that some platforms (TikTok, Pinterest) auto-detect locale and serve based on user, not target market
- Ignoring legal/disclaimer differences (e.g., GDPR cookie language, ASA requirements, FTC #ad, France's Loi Évin for alcohol)
- Forgetting voiceover lip sync for video — re-edits may be needed
- Using stock footage with text in-frame in the wrong language

---

## When to push back

If the localisation matrix balloons production beyond budget, push back early. Options:

1. **Reduce markets** — Can the campaign hold for tier-2 markets while tier-1 ships?
2. **Reduce localisation depth** — Can tier-2 markets get translation only, with master visuals?
3. **Use neutral assets** — Design for global from the start (no in-frame text, neutral imagery)
4. **Phased delivery** — Tier 1 markets first; tier 2 a week later
5. **Dynamic creative** — Modular components, language-aware composition at serve time
