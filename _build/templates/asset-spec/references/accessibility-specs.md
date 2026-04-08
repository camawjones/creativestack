# Accessibility Specs

> Accessibility is increasingly contractually required (especially public sector,
> regulated industries, EU markets) and is the single most-skipped section of an
> asset spec. Build it in by default.

## How to use this file

When the campaign includes any digital asset (web, social, video, display), include
an accessibility section in the asset spec. The standards are non-negotiable for some
clients and best-practice for all.

---

## WCAG 2.2 AA — what to check

The de-facto standard for digital accessibility. Required by law in EU (EAA from
2025), UK (PSBAR for public sector), and US (ADA Title III + Section 508).

| Criterion | What it means | How to check |
|---|---|---|
| **Contrast — text** | 4.5:1 minimum for body, 3:1 for large text (≥18pt or ≥14pt bold) | WebAIM Contrast Checker, Stark plugin |
| **Contrast — UI / icons** | 3:1 minimum for interactive elements and graphical info | Same |
| **Text resize** | Text must remain readable at 200% zoom without loss of content | Browser zoom test |
| **Focus visible** | Interactive elements must have visible focus state | Tab through with keyboard |
| **Target size** | Touch targets ≥24×24 CSS px (preferably 44×44) | Spec layout |
| **Don't rely on colour alone** | Information conveyed by colour must also be conveyed by text/icon/pattern | Visual review |
| **Captions for video** | All pre-recorded audio content has captions | See video spec |
| **Audio description** | All pre-recorded video has AD where information is visual-only | See video spec |
| **Motion / animation** | Provide a way to pause/stop motion >5s; avoid flashing >3 per second | Animation review |

---

## Alt text — format and content

Every image needs alt text. Get it right:

### Decorative images
- Decorative-only → empty alt (`alt=""`) — screen readers skip
- Branded background patterns → empty alt
- Hero imagery that conveys mood but no info → still write descriptive alt; don't skip

### Informative images
- Describe **what's important about this image in this context**
- Don't start with "image of" or "picture of" — screen readers already announce that
- Be concise — typically 1-2 sentences, ≤125 chars where possible
- For people: describe what they're doing, not how they look (unless appearance is the point)
- For products: describe what the product is and what's being shown about it

### Examples

**Bad:** `alt="image1.jpg"`
**Bad:** `alt="A photo of a happy woman holding a phone"`
**Good:** `alt="A teacher uses the app to send a single message to parents in 12 languages"`

### Complex images (charts, diagrams, infographics)
- Short alt for the gist
- Long description nearby (in caption, expandable, or `aria-describedby`)
- Provide a text alternative for data — never lock data inside an image

### Alt text for paid social
- Meta, LinkedIn, X all support alt text per image — use it
- Instagram alt is in advanced settings — most teams forget it

### Alt text for video thumbnails
- Describe the video's subject, not just the thumbnail's visual

---

## Captions and subtitles for video

| Type | What it is | When required |
|---|---|---|
| **Closed captions (CC)** | Toggleable text, includes speaker IDs and sound effects ([door slams]) | Best for accessibility |
| **Open captions** | Burned in, can't be turned off | Best for silent autoplay (social) |
| **Subtitles** | Translation of dialogue, no sound effects | For non-native speakers |
| **SDH** (Subtitles for Deaf/HoH) | Translation + sound effects + speaker IDs | Best of both for international + accessibility |

**Production rules:**
- Caption every word, including non-speech sounds essential to comprehension
- Include speaker IDs when ≥2 speakers and they're off-screen
- Use [music], [laughter], [door slams] for non-speech audio
- Time captions to appear when the sound starts, not after
- Don't exceed 2 lines on screen, 32-42 chars per line
- Reading speed: 160-180 words per minute (slower for child audiences)

---

## Audio description (AD)

When the visual contains information not in the audio (text on screen, key actions,
visual gags, scene changes), an audio description track describes them in pauses
between dialogue.

**When required:**
- Public sector and broadcast TV (UK Ofcom mandates AD on % of broadcast hours)
- High-accessibility client work
- Anything where the visual carries information the audio doesn't

**Delivery:** Separate audio stem, mono or stereo, timed to the video. Most TVCs and
explainer videos benefit from AD; pure music videos rarely need it.

---

## Reduced motion

Some users have vestibular disorders triggered by parallax, autoplay video, and
heavy animation.

- Respect `prefers-reduced-motion` in CSS for web
- Provide a way to pause autoplay video and animation
- Avoid parallax for body content (decorative is OK)
- Avoid flash/strobe effects entirely (>3 per second can cause seizures)
- Consider providing a "reduce motion" version of any video-heavy hero

---

## Colour and contrast

- Brand colours often fail contrast — flag this early in the spec
- Provide accessible colour pairs in the brand guidelines
- Test with: WebAIM Contrast Checker, Stark, Figma's plugin, Adobe's Colour
- Specify contrast for: body text, headlines, buttons (default + hover + focus), icons, form fields, error states

| Element | Min contrast (vs background) |
|---|---|
| Body text (<18pt regular) | 4.5:1 |
| Large text (≥18pt or ≥14pt bold) | 3:1 |
| Icons / UI elements | 3:1 |
| Inactive UI | No requirement (but good practice ≥3:1) |

---

## Accessibility section template (for the asset spec output)

```markdown
## Accessibility

**Standard:** WCAG 2.2 AA

### Per asset

| Asset type | Alt text | Captions | AD | Contrast | Reduced motion | Other |
|---|---|---|---|---|---|---|
| Social images | ✓ required | n/a | n/a | ✓ verify | n/a | — |
| Social video | Thumbnail alt | Open + SRT | ✓ if visual-only info | ✓ verify | Pause control | Silent-first design |
| Display banner | ✓ required | n/a | n/a | ✓ verify | ✓ pause control | No flashing |
| Web hero | ✓ required | If video | If video | ✓ verify | ✓ respect prefers-reduced-motion | — |
| TVC | n/a | Open + SRT/STL | ✓ if for broadcast | ✓ verify | n/a | — |

### Sign-off
- [ ] Contrast verified for all text and UI
- [ ] Alt text written for every informative image
- [ ] Captions delivered in correct format
- [ ] AD recorded if required
- [ ] No flashing >3 per second
- [ ] Animation pause control where applicable
- [ ] Tested with screen reader (VoiceOver / NVDA) for any web asset
```
