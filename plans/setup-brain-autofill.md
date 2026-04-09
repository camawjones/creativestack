# Plan: `/setup-brain` autofill from a URL

> **Status:** draft — not yet implemented
> **Branch:** `setup-brain-autofill-plan`
> **Owner:** Cam
> **Last updated:** 2026-04-09

## The problem

The current `/setup-brain` flow is a 5–10 minute interview. It works, but it has three
failure modes that quietly cost users:

1. **Tone-of-voice is the highest-value brain file and the hardest one to self-describe.**
   People are bad at articulating their own voice. They reach for adjectives
   ("confident, warm, playful") that every other agency also claims, and the resulting
   `tone-of-voice.md` is generic — so every downstream skill that reads it (copy-deck,
   proposal-generator, status-update, case-study, update-voice) inherits generic output.
2. **Friction at the first-run moment.** The onboarding is the make-or-break moment for
   the whole stack. A user who bounces at Step 4 never discovers what the suite can do.
   Typing out team rosters and client lists from scratch feels like admin, not magic.
3. **The richest source of truth about an agency is already online.** Their website is
   their tagline, positioning, services, team, clients, process, and voice — all
   written, public, and authoritative. We're asking users to re-describe what a scraper
   could extract in fifteen seconds.

## The goal

Let a user paste a URL at the start of `/setup-brain` and have the skill **propose**
a prefilled brain they can review, edit, or reject section by section.

**Non-goals:**
- Not a replacement for the interview — it's a head start. Every auto-extracted value
  is reviewed by the user before it lands in the brain.
- Not auto-saving anything without confirmation.
- Not scraping gated or private pages. Public URLs only.
- Not a full crawler. A handful of key pages (home, about, work, team, process) is
  enough. No sitemap traversal, no pagination.
- Not replacing `/update-voice` — that stays the dedicated voice-refinement skill.
  Autofill produces a v1 voice; `/update-voice` sharpens it.

## Why this is worth building

- **Tone of voice from real samples.** Extracting voice from the user's own website
  copy is a fundamentally better method than asking them to describe it. Their
  homepage headline, about-page narrative, and case-study writeups *are* their voice —
  ground truth, not self-report.
- **Compounds with the rest of the stack.** A better tone-of-voice file immediately
  sharpens copy-deck, proposal-generator, status-update, case-study, pitch-research,
  rfi-response, social-calendar, meeting-notes (the action-items rewriter), and
  feedback-consolidator (the client-reply drafter). Nine skills improve from one
  autofill pass.
- **Onboarding becomes the demo.** Watching the skill extract your own tone-of-voice
  correctly from your own website is the "oh, this is different" moment. It earns the
  user's attention for the rest of the flow.
- **Second-order wins.** Brand colours and typography scraped from CSS can seed
  `visual-style.md`, which feeds every Figma/FigJam/slide-generating skill in the
  suite. Free upgrade to the visual output of ~8 skills.

## User flow — before vs after

### Before (current)

```
/setup-brain
→ Welcome message (Debussy)
→ Step 2: Who are you? (freelancer/studio/agency/in-house/company)
→ Step 3: Profile basics (6–7 questions)
→ Step 4: Tone of voice (4 questions)
→ Step 5: Team (1–2 questions)
→ Step 6: Clients (1–2 questions)
→ Step 7: Tools (1 question)
→ Step 7b: Visual style (1 preset pick)
→ Steps 8–10: Stubs, confirmation, health check
```

15–20 questions. All manual. 5–10 minutes.

### After (proposed)

```
/setup-brain
→ Welcome message (Debussy)
→ NEW Step 1.5: "Before we begin — do you have a website or portfolio I can read?"
    ├─ Yes → paste URL → autofill runs → review pass
    │   → Step 2–7 show prefilled values as defaults, user hits enter to accept
    │     or types to override
    └─ No / skip → unchanged interview flow
→ Steps 8–10: Stubs, confirmation, health check (unchanged)
```

For a user with a decent website, the flow compresses from "answer 20 questions" to
"paste URL, press enter 8 times, correct 2 things." For a user without, nothing
changes.

## What's realistically auto-extractable

Mapped to the 9 brain files, with confidence ratings.

### `profile.md` — **high**

| Field | Source | Notes |
|---|---|---|
| name | `<title>`, logo alt text, first H1 | Very reliable |
| location | Footer, contact page, address | Usually explicit |
| size | About page ("team of 12"), team page headcount | Inferable, often stated |
| type | Inferred from copy ("studio" vs "agency" vs "creative practice") + size | LLM inference, flag for review |
| specialisms | Services page, home subtitle, "what we do" section | Highly reliable |
| industries | Work page client list, About page positioning | Reliable if clients shown |
| positioning | Home hero subtitle, About page first paragraph | Usually one clean sentence |
| growth areas | — | Cannot extract. Must ask. |

### `tone-of-voice.md` — **medium-high** (the killer feature)

Source: concatenate home hero copy + About page body + 2–3 case study intros. Feed
to an extraction prompt that produces:

- **formality** — casual / casual-professional / professional / formal
- **personality** — 3 traits backed by quoted evidence from the source
- **We sound like / We don't sound like** — inferred from sentence structure,
  vocabulary, rhythm
- **Vocabulary** — distinctive words the user actually uses ("craft", "systems",
  "stories we tell", "the work")
- **Examples** — verbatim passages, cited by source URL

The final review step must include a verification gate:
*"Here are 3 sample paragraphs I'd write in your voice. Does this sound like you?"*
Generate 3 short paragraphs in the inferred voice and ask yes/no. If no, fall back
to the current interview for voice only. This gate is non-negotiable — voice is
where a wrong autofill does the most damage downstream.

### `team.md` — **high** (when a team page exists)

Scrape `/team`, `/people`, `/studio`, `/about`:

- Names (high confidence)
- Roles (high confidence)
- Photos (skip — not in brain schema)
- Department inference (for agency type) — medium confidence

Cannot extract: day rates, contracted hours, substitutability, leave patterns. Those
stay in the manual flow or get added later via `/resource-conflict` setup mode.

### `clients.md` — **high with caveats**

Scrape `/work`, `/projects`, `/clients`, case study listings:

- Client names / logos-with-alt-text
- Possibly the project type per client

**Critical caveat:** must flag every extracted client with
`source: user's public website` and ask *"confirm these are safe to store in your
brain — no current NDAs?"* before writing. Some agencies list legacy clients they
can't actively reference. Never silently ingest.

### `visual-style.md` — **medium**

From the page CSS / inline styles:

- Brand colours — computed text colour + background colour + any `--color-*`
  custom properties in the root. Filter to brand-ish values (drop greys, whites,
  blacks-near-black).
- Typography — `font-family` declarations on `<body>` and `<h1>`. Match against the
  Google Fonts directory to canonicalise names.
- Register — if serif primary + sans body → Editorial Modern preset is a good
  default; if all-sans geometric → Architectural; etc.

If confidence is high, prefill `visual-style.md` with a custom inline entry rather
than one of the three canned presets. If low, offer the preset picker as today.

### `tools.md` — **low**

Agencies rarely list tools on their website. Skip autofill. Stay manual.

### `methodology.md` — **medium**

If a `/process`, `/how-we-work`, `/approach` page exists, extract the phases
("Discover → Define → Design → Deliver" or similar). Otherwise leave empty. This is
a nice-to-have, not critical for v1.

### `case-studies.md` — **deliberately skipped**

Even though work pages have case studies, don't auto-populate this. `/case-study` is
its own dedicated skill with a rubric, approval workflow, and versioning. Autofilling
it would produce low-quality case studies that contaminate the library. Leave empty
and let `/case-study` handle it on demand.

### `learnings.md` — **cannot extract**

Learnings only accrue with use. Stays empty.

### `projects/` — **not applicable**

Per-project state is created on demand, not at setup.

## Primitives available

| Tool | Source | Available to all users? | Use for |
|---|---|---|---|
| `WebFetch` | Built-in Claude Code | **Yes** | Primary URL fetch + extraction |
| `WebSearch` | Built-in Claude Code | **Yes** | Fallback to find pages not linked from home |
| `/source-scrape` | CreativeStack (this repo) | Yes — but has internal browse-daemon dependency with WebSearch fallback | Optional enrichment if available |
| `/browse` | gstack | **No — other stack** | Do not use. |

**Decision:** use `WebFetch` as the only primary primitive. Every CreativeStack user
has it because it ships with Claude Code itself. `WebSearch` is a supporting fallback
for finding pages not linked from the homepage (e.g. "site:agency.com team"). No
dependency on `/source-scrape` or `/browse`.

Manual paste is the universal fallback: if `WebFetch` fails, can't follow JS, or
returns thin content, fall through to "paste your About page copy and your team page
copy and I'll read them directly."

## Proposed implementation — changes to the template

Edits to `_build/templates/setup-brain/SKILL.md.tmpl`:

### New Step 1.5: Offer autofill

Insert between the existing Step 1 (brain check) and Step 2 (who are you). On a
first run only — never on update mode.

```
### Step 1.5: Offer autofill (first run only)

Before asking who they are, offer to prefill from a URL:

> "Before we begin — do you have a website, portfolio, or LinkedIn I can read?
> I'll read it and prefill what I can. You'll review everything before it's saved.
> It takes about 30 seconds and usually saves 5 minutes of typing.
>
> (You can skip this and answer manually — totally fine.)"

[SELECT]
- Yes — I have a URL
- No — let's do it manually
- What would you read? (explain, then re-ask)

If "What would you read?":
explain briefly: "Your home page, about page, work page, team page, and process page
if you have one. I'll extract your name, location, services, team, clients, and —
most importantly — your tone of voice from your own writing. Nothing saves until you
review each section."
Then re-ask.

If "No": proceed to Step 2 unchanged.

If "Yes": proceed to Step 1.6.
```

### New Step 1.6: Fetch and extract

```
### Step 1.6: Fetch and extract (autofill mode)

Ask for the URL:
"Paste your main URL. One is enough — I'll find the sub-pages."

Normalise the URL (add https:// if missing, strip trailing slash).

**Discovery pass:** use WebFetch on the homepage with a prompt that asks it to
return a JSON object containing:
- title, tagline, hero copy
- detected navigation links, filtered to /about, /studio, /team, /people, /work,
  /projects, /clients, /process, /approach, /how-we-work, /services, /contact
- any raw footer content (often has location + social links)
- any CSS custom properties starting with `--color-` or `--font-`
- the `<body>` and `<h1>` computed font-family (if available)

**Enrichment pass:** for each discovered sub-page URL, run WebFetch again with a
page-type-specific extraction prompt. Run these in parallel when possible:
- About → positioning, size, location, founding date, values
- Team → names + roles
- Work / Projects → client names, project titles, industries
- Process / Approach → methodology phases
- Services → specialisms

**Voice corpus:** concatenate home hero copy + About page body + first 2 case study
intros into a `voice_corpus` string. Cap at ~2000 words.

Store everything in a structured proposal object before writing anything. Do not
write to `~/.creativestack/` yet.
```

### New Step 1.7: Voice inference

```
### Step 1.7: Voice inference

Feed `voice_corpus` to an inference prompt that returns:
- formality: one of casual / casual-professional / professional / formal
- personality: 3 traits, each with a 1-sentence rationale and a verbatim quote
- we_sound_like: 3–5 bullet points describing register, rhythm, sentence length,
  and distinctive moves
- we_dont_sound_like: 3 anti-patterns
- vocabulary:
    - preferred: distinctive domain words they actually use (not generic adjectives)
    - avoided: inferred from absence — words similar agencies use that they don't
- examples: 2–3 verbatim passages from the corpus

Then **generate a verification set**: 3 short paragraphs (50–80 words each) written
in the inferred voice, covering a mundane topic (e.g., a project status update, an
out-of-office reply, a social post about finishing a brand refresh).

Present the verification set to the user:

> "I read your site and here's how I'd write in your voice. Does this sound like you?"
>
> [3 generated paragraphs]
>
> [SELECT]
> - Yes, that's me
> - Close, but needs tweaking
> - No, that's not me at all

If "Yes": save the inferred voice to the proposal.
If "Close": save it and flag for user refinement in the review step.
If "No": discard the inferred voice entirely and fall through to the current
manual voice interview (Step 4). This is the non-negotiable safety gate.
```

### New Step 1.8: Review each proposal

```
### Step 1.8: Review the proposed brain

Walk the user through each proposed file, one at a time, showing:

- What was extracted
- Where it came from (source URL + brief evidence quote)
- Confidence level (high / medium — never show "low", those should be empty)

For each section, offer:
- Accept as-is
- Edit (open a scratch buffer for the file, user edits, save)
- Discard (fall through to manual interview for that file only)

Sections to review, in this order:
1. profile.md — type, name, location, specialisms, positioning
2. tone-of-voice.md — only if the verification gate passed
3. team.md — with explicit confirmation: "these names were extracted from your
   public team page. Anyone missing, anyone who left?"
4. clients.md — with NDA gate: "these were extracted from your public work page.
   Confirm these are safe to store — any under current NDA?"
5. visual-style.md — if colour/typography extraction confidence is high, show the
   proposed inline style; if not, drop through to the preset picker in Step 7b
6. methodology.md — only if a process page was found; otherwise leave empty

After review, fill any remaining gaps with the current manual interview steps — but
skip questions already answered by the autofill. This is where the time saving
lands: autofill handles 15 of the 20 questions, manual interview handles the rest.
```

### Modified Steps 2–7

Each manual step already exists. The change: if autofill provided a value, show it as
a prefilled default rather than asking from scratch.

```
### Step 3: Profile basics — autofill-aware

If autofill proposed a value, show it as a default:

"Your name: **{autofilled name}** — press enter to accept, or type a different one."

If no autofill value, ask from scratch as today.

Same pattern for Steps 4, 5, 6, 7, 7b.
```

### Step 9: Confirmation — add autofill badge

In the confirmation summary, add a small indicator next to each file that was
autofilled vs manually entered:

```
- **profile.md** — {name}, {type}, {location} (autofilled, reviewed)
- **tone-of-voice.md** — {personality summary} (autofilled, reviewed)
- **team.md** — {count} members (manual)
...
```

This makes provenance visible for future debugging ("why does my voice sound off?
check what was autofilled").

## The hard part: voice inference

Voice is the most valuable thing to autofill and the easiest to get wrong. A wrong
voice propagates into 9+ downstream skills and users may not notice for weeks.

Three defences:

1. **Cite evidence for every claim.** Every personality trait, every preferred
   vocabulary word, every "we sound like" bullet must be backed by a quoted passage
   from the source corpus. If the inference can't be cited, don't write it.
2. **Verification gate before save.** The 3-paragraph generation + yes/no gate must
   run before the voice ever lands in the brain. No autofill voice writes without
   an explicit "yes, that's me."
3. **Soft save with a confidence flag.** Write the file with a
   `confidence: autofilled-v1` flag in the frontmatter and prompt the user to run
   `/update-voice` as their next action. Frame it as: "I've got a first draft of
   your voice — `/update-voice` will sharpen it."

## Review UX pattern

Each autofilled section follows the same three-panel pattern:

```
─── profile.md ───

Proposed:
  name: Dixon Baxi
  type: agency
  location: London
  specialisms: brand identity, digital product, motion
  positioning: We're a branding agency that builds bold, unapologetic brands.

Evidence:
  name       ← <title> on dixonbaxi.com
  type       ← "an independent branding agency" on /about
  location   ← footer "London • New York"
  specialisms ← /services page headers
  positioning ← /about first paragraph

[SELECT]
- Accept
- Edit
- Discard and ask manually
```

Consistent, quick to scan, one keypress to accept. That's where the time saving
actually lives.

## Edge cases

- **No website at all** (freelancers, new studios) → autofill offers LinkedIn /
  Behance / Are.na / Dribbble as alternative URL types. If none, fall through to
  manual.
- **Outdated website** → always ask "does this still reflect how you work?" during
  review. Capture a `last_updated` date the user supplies.
- **Heavy JS / SPA site** → `WebFetch` may return sparse content. Detect by word
  count (< 200 words total across discovered pages), warn the user, offer manual
  paste fallback.
- **Multi-brand studios** (umbrella agency with sub-brands) → ask "which brand
  should I use as the primary?" and only autofill from that one.
- **NDA clients** → hard gate at the clients review step. Never silently save.
- **Extracted client names that are logos only (no alt text)** → skip them. Don't
  make up names.
- **Bilingual sites** → extract in the site's primary language. Don't translate.
- **Personal name vs studio name for freelancers** → ask "do you work under your
  own name or a practice name?" during review.
- **`WebFetch` fails / times out / returns 403** → immediately fall through to
  manual paste. Show one friendly error, don't retry in a loop.
- **User pastes a password-protected URL** → the fetch will fail; error handler
  catches it and explains we only read public pages.
- **User pastes a URL to an Are.na channel or Behance portfolio** → different
  parsing strategy. v1 should handle the common web domains; Are.na/Behance can be
  v2.
- **Autofill produces Editorial Modern preset by coincidence** → still show the
  extracted colours/fonts in the review panel so the user knows *why*, not just
  "we picked this preset."

## Risks

- **Getting voice subtly wrong and not catching it** — mitigated by verification
  gate + confidence flag + evidence citation. Still a real risk.
- **Hallucinated team members or clients** — mitigated by only extracting what's
  on the page verbatim. The extraction prompt must forbid inference for these
  fields: names and client lists are quote-only.
- **NDA exposure** — mitigated by explicit confirmation gate. Still requires user
  attention at the right moment.
- **Over-reliance on WebFetch quality** — if it produces poor markdown on
  JavaScript-heavy sites, the feature degrades silently. Needs a content-quality
  floor (minimum word count, minimum number of pages extracted) with automatic
  fallback to manual.
- **Privacy optics** — the user might not love that the skill scrapes their site,
  even though it's public. Framing matters: "I'll read your website" is better
  than "I'll scrape your website." Emphasise that nothing saves without review.
- **Hallucinated voice personality from generic agency copy** — some agency sites
  are so blandly written that no distinctive voice exists to extract. The
  extraction prompt should be able to return "no distinctive voice detected —
  fall through to manual" as a valid output.
- **Drift from upstream site changes** — if the user rebrands in 6 months, the
  brain still has the old voice. Mitigated by the existing 90-day staleness check
  in Step 10 health report.

## Open questions

1. **Autofill for update mode too?** A user who already has a brain might want to
   re-run autofill to refresh voice after a rebrand. v1 is first-run only. v2
   could add "refresh from URL" as a new sub-mode in Step 1b.
2. **Per-file confidence thresholds.** What's the minimum evidence quality for each
   file? e.g. team.md needs at least 3 names to be useful — fewer than that and
   fall through to manual. Needs tuning during implementation.
3. **Cache extractions?** If a user runs `/setup-brain` twice with the same URL
   within a session, re-fetch or reuse? Probably reuse within the session. No
   persistent cache — too much complexity.
4. **Voice verification set topics.** The 3 paragraphs need to cover topics
   generic enough that any user can judge them. Status update, social post, email
   sign-off? Needs prompt engineering work.
5. **Extraction prompt location.** Lives inline in the SKILL.md.tmpl, or in a
   `references/extraction-prompts.md` file that ships with the skill? The
   references approach is cleaner and matches the pattern other skills use.
6. **Should the autofill skill be a separate skill invoked from `/setup-brain`?**
   Probably not for v1 — the flow is tightly coupled to setup and splitting it
   adds UX seams. Keep it as steps inside `/setup-brain`.
7. **LinkedIn handling.** LinkedIn blocks most scrapers. v1 should say "paste the
   URL and I'll try, but LinkedIn often blocks automated reading — you might need
   to paste the About section directly." Manual paste fallback, always.

## Test plan

Manual testing during implementation against a mix of real agency sites. Pick one
from each category:

| Category | Example site type | What to verify |
|---|---|---|
| Branding agency, team page, process page, full stack | e.g. dixonbaxi.com | All files autofill, voice verification passes |
| Independent design studio, minimal site | Studio-blog style | Profile + voice extract, team/clients empty |
| Freelance portfolio on Cargo/Framer | Single page | Profile + voice only, rest manual |
| Agency with JavaScript-heavy SPA | React site | Detect thin content, fall back to manual paste |
| Non-English primary language site | Continental European agency | Extracts in source language without forcing translation |
| Site with a password-gated work section | Selective portfolio | Public pages extract, gated pages ignored |
| Personal-name freelancer | cameronjones.com style | Handles name-as-brand correctly |
| In-house team (no public site) | — | Falls through gracefully since no URL to paste |

After each test, check: does the proposed brain need more than 2 edits to be correct?
If yes, the extraction prompts need tuning. Target: ≤ 2 edits per review on average.

## Scope — proposed phases

### Phase 1 (this branch, if we proceed)
Ship this plan document. Get feedback. No code changes yet.

### Phase 2 — spike (separate branch)
Minimum viable autofill:
- Steps 1.5–1.8 added to the template
- `profile.md` + `tone-of-voice.md` extraction only
- Voice verification gate
- Manual paste fallback
- Real-site test on 3 example URLs

Ship as PR. Validate the review UX feels right before expanding.

### Phase 3 — extend
- `team.md` + `clients.md` + NDA gate
- `visual-style.md` colour/typography extraction
- `methodology.md` process-page extraction
- Tune extraction prompts against ≥ 8 test sites

### Phase 4 — refinement
- Update mode autofill ("refresh from URL")
- Are.na / Behance / Cargo-specific parsers
- `references/extraction-prompts.md` modularisation
- Staleness-triggered re-autofill suggestion in Step 10 health check

## Success criteria

- A user with a decent agency website can go from `/setup-brain` to a reviewed,
  saved brain in under 2 minutes.
- The voice verification gate catches wrong-voice extractions before they write.
- No silent ingestion of NDA clients.
- Autofilled sections average ≤ 2 edits per review.
- Users who run `/update-voice` after autofill describe the v1 voice as "close, not
  perfect" — not "totally wrong."
- Onboarding completion rate (users who reach Step 9) increases vs the pre-autofill
  baseline. (Needs a way to measure — probably just user reports for now.)

## What this plan deliberately doesn't decide

- The exact wording of the extraction prompts (done during implementation).
- The exact WebFetch prompt templates (done during implementation).
- Whether to show evidence inline or behind a "show sources" toggle (decided during
  UX polish).
- How to handle sites that require consent banners / GDPR walls (case-by-case).
