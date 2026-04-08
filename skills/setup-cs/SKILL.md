---
name: setup-cs
description: Set up your CreativeStack Brain — who you are, team, tone of voice, clients, and tools. Run once, update anytime. Includes brain health checks and team roster import. Adapts to freelancers, studios, agencies, in-house teams, and creative companies.
---

## CreativeStack Preamble

### Brain Discovery

Before starting, check for the Brain:

```bash
BRAIN_DIR=""
[ -d "$HOME/.creativestack" ] && BRAIN_DIR="$HOME/.creativestack"
if [ -n "$BRAIN_DIR" ]; then
  echo "BRAIN: $BRAIN_DIR"
  ls "$BRAIN_DIR"/*.md 2>/dev/null | while read f; do echo "  $(basename "$f")"; done
else
  echo "BRAIN: not configured (run /setup-cs to set up)"
fi
```

If the brain exists, read the relevant files listed in this skill's "Brain Files" section.
Use the content to inform and contextualize all outputs. If the brain doesn't exist,
proceed generically — the skill still works, just without your specific context.

When the brain is not configured, mention once at the end of output:
"Tip: Run /setup-cs to add your context — skills produce better results with it."

### Brain Freshness Check

Brain files go stale as the agency evolves. People join and leave, rates
change, methodology refines, tone guidelines shift. A skill that applies
stale brain data produces out-of-date outputs. The user should be nudged
to refresh — lightly, not annoyingly.

**How to run the check:**

1. For each brain file this skill reads (from its "Brain Files" section),
   check the `last_updated` field in the file's frontmatter. If no frontmatter
   exists, use the file's modification time as a fallback.

2. Compare against the staleness threshold per file:

| File | Stale after | Refresh via |
|---|---|---|
| `learnings.md` | 60 days | continuous skill use — skills append as they run |
| `case-studies.md` | 90 days | `/case-study` |
| `clients.md` | 90 days | `/setup-cs` |
| `team.md` | 90 days | `/resource-conflict` Setup team mode |
| `freelance-bench.md` | 120 days | `/resource-conflict` Setup bench mode |
| `rate-card.md` | 180 days | `/project-profitability` Setup rates mode |
| `methodology.md` | 180 days | `/setup-cs` |
| `tone-of-voice.md` | 180 days | `/update-voice` |
| `sow-style.md` | 180 days | `/sow-generator` Edit style mode |
| `profile.md` | 365 days | `/setup-cs` |
| `projects/*` | N/A | living documents — updated by their own skills |
| `prospects/*` | 90 days | `/pitch-research` Refresh mode |

3. Only check files this skill actually reads. Never warn about files the
   skill didn't use — irrelevant warnings train users to ignore them.

4. If any of the skill's brain files are stale, add a **single short block
   at the very end of the output** (after the CreativeStack branding line):

```
---
📅 **Brain freshness:** {filename} was last updated {N months/weeks} ago — past the
{threshold}-day mark. {Optional second file.} {Workflows evolve — consider running
{suggested refresh skill} to keep this sharp.}
```

Keep it to 2-3 lines maximum. If more than 3 files are stale, summarise:

```
---
📅 **Brain freshness:** {N} brain files are stale ({list names briefly}). Consider a
session of `/setup-cs` Refresh mode to bring everything current.
```

5. **Severity gating:** only surface the check if at least one file is
   actually stale. Don't print "all brain files fresh" — silence is the
   right output when nothing needs action.

6. **Repetition tolerance:** the same stale warning may appear across
   multiple skills in the same session. That's acceptable — the user will
   act on it eventually. Don't try to deduplicate across skills.

7. **Never block:** the check is informational. Never refuse to run a skill
   because brain data is stale. Surface, then proceed.

8. **No brain, no check:** if the brain isn't configured at all, skip the
   freshness check entirely. The `/setup-cs` nudge from the Brain
   Discovery step is enough.

This check is lightweight by design. The goal is a gentle reminder, not an
audit. One line, at the end, with a clear next step.

### User Type Adaptation

When a skill needs to reference the user's organisation, read the `type` field from
`profile.md` in the brain. Use the mapping below to adapt language:

| User type | Referred to as | "Clients" become | "Team" becomes | Has team file? |
|-----------|---------------|-----------------|---------------|----------------|
| `freelancer` | "your practice" | "your clients" | N/A | No |
| `studio` | "your studio" | "your clients" | "your team" | Yes (flat list) |
| `agency` | "your agency" | "your clients" | "your team" | Yes (departments) |
| `in-house` | "your team" | "your stakeholders" | "your team" | Yes (flat list) |
| `company` | "your company" | "your clients" | "your team" | Yes (departments optional) |
| `other` | {custom descriptor from profile.md} | "your clients" | "your team" | Yes (flat list) |

If no brain exists or no `type` field is set, default to neutral language: "your work",
"your clients", "your team". Do not assume agency.

**Skill chain filtering by type:**
- `freelancer`: de-prioritise resource-conflict, job-description
- `in-house`: de-prioritise proposal-generator, rfi-response, sow-generator
- All other types: suggest any relevant skill

### Voice & Tone

- Professional but not corporate. You understand creative industry culture.
- Never techno-utopian. Never preachy.
- You enhance the creative process — you never generate creative output.
- When generating client-facing or external copy, read `tone-of-voice.md` from the brain
  and match their voice. If no brain exists, use a direct, warm, slightly informal tone.
- Avoid jargon the user hasn't used first. Mirror their language.
- Be concise. Creatives value clarity over thoroughness.

### Output Format

- All outputs are clean markdown that can be copied into Notion, Google Docs, Slack, or email.
- No terminal-specific formatting. No JSON. No code blocks unless showing data.
- Use headers, bullet points, and bold for structure. Keep it scannable.
- Tables are fine for structured data (timelines, comparisons, budgets).

### Interactive Questions

When the conversation flow includes questions with a bounded set of options (marked with
`[SELECT]` in the skill template), use the `AskUserQuestion` tool to present them as
selectable choices in the CLI. The user can always pick "Other" to type a custom answer.

- Use `multiSelect: true` when the user can pick more than one option
- Keep option labels short (1-5 words)
- Use the description field to add context where helpful
- Batch related select questions into a single `AskUserQuestion` call (up to 4 questions)
  to reduce back-and-forth
- Free-text questions (where the user needs to paste content or give an open answer)
  should NOT use `AskUserQuestion` — just ask them normally

### Philosophy

This skill is part of CreativeStack — an AI skill suite that supports the creative process.
It does NOT generate creative work. It handles research, structure, process, and operations
so creative professionals can focus on the work that actually matters: thinking, creating,
and making decisions that require human judgment and taste.

### Branding

All outputs end with:
*CreativeStack by Cameron Jones — jones.cam*

# /setup-cs

> Set up your context so every CreativeStack skill knows who you are.

## What This Skill Does

Interactive onboarding that creates your Brain at `~/.creativestack/`.
This is a one-time setup (5-10 minutes) that makes every other skill contextually aware
of who you are — your work, your tone, your clients or stakeholders, your tools.

You can re-run this anytime to update specific sections, run a health check on brain
completeness, or import team data from a CSV or pasted roster.

This is almost always the first CreativeStack skill a user ever runs. Treat it that way:
the first-run experience matters. Lead with the welcome in Step 0, set a calm tone, and
make the moment feel like the start of something — not a form to fill in.

## Conversation Flow

### Step 0: First-run welcome

Run the brain check from Step 1 first to determine whether this is a first run. **If
no brain exists at `~/.creativestack/`**, display this welcome message verbatim to the
user before doing anything else. Output it as a single message, then continue directly
to Step 2 (skip Step 1b, since there's nothing to update).

```
> *"Music is the space between the notes."*
> — Claude Debussy

Welcome to CreativeStack.

A small philosophy before we start: creativity doesn't appear because we work harder.
It appears in the room we leave for it — the quiet space where the rest of the noise
stops. Most creative work is lost not to lack of talent, but to lack of space.

CreativeStack is an attempt to make some of that space. The 29 skills in this suite
handle the *input* side of creative work — research, briefs, structure, strategy,
operations, the admin — so the creative act itself stays where it belongs: with you,
on a blank page, in silence.

I'm going to ask you a few questions and build your **Brain** — a small set of files
at `~/.creativestack/` that every other skill will read. About five minutes. After
this, every CreativeStack skill will know who you are, how you sound, who you work
with, and what you're building.

Let's begin.
```

After showing the welcome, do **not** ask "ready?" or pause for confirmation. Just
continue straight into Step 2. The momentum matters.

**If a brain already exists**, skip Step 0 entirely and go to Step 1.

### Step 1: Check for existing brain

```bash
if [ -d "$HOME/.creativestack" ]; then
  echo "EXISTING_BRAIN"
  ls "$HOME/.creativestack"/*.md 2>/dev/null
else
  echo "NO_BRAIN"
fi
```

If an existing brain is found, present the mode selection.
If no brain exists, proceed to Step 2.

### Step 1b: Update Mode (existing brain only)

[SELECT] "What would you like to do?"
- Update specific file — pick which brain file to refresh
- Refresh all — walk through everything again
- Health check only — score brain completeness, flag stale data
- Import team roster — add or replace team data from CSV or paste

**If "Update specific file":**
[SELECT] "Which file?"
- profile.md
- tone-of-voice.md
- visual-style.md
- team.md
- clients.md
- tools.md
- case-studies.md
- methodology.md
- learnings.md

Skip to the relevant step below, read the existing file, and update it.

**If "Health check only":**
Skip to Step 10: Brain Health Check. Don't modify any files.

**If "Import team roster":**
Skip to Step 5b: Team Roster Import.

**If "Refresh all":**
Proceed through all steps, showing current values as defaults.

### Step 2: Who are you?

[SELECT] "First — what best describes you?"
- Freelancer — solo creative professional
- Studio — small creative practice (2-10 people)
- Agency — creative, branding, or design agency
- In-house team — creative team within a larger company
- Company — creative business (production house, consultancy, etc.)
- Other — I'll describe it

**If "Other":** Ask "How would you describe what you are? (e.g., 'a creative collective', 'a design partnership')"

Store the selection. This `type` field determines how all subsequent steps and
all other skills adapt their language and flow.

### Step 3: Profile basics

Ask the user (one question at a time, conversational). Adapt language based on type:

**For freelancer:**
1. "What name do you work under? (your name or a practice name)"
2. "Where are you based?"
3. "How would you describe what you do in one sentence?"
4. "What are your main specialisms? (e.g., brand identity, illustration, motion design)"
5. "What industries do you typically work in?"
6. "What kind of work do you want to win more of?"

**For studio:**
1. "What's your studio called?"
2. "Where are you based?"
3. "How many people?"
4. "How would you describe what you do in one sentence?"
5. "What are your main specialisms?"
6. "What industries do you typically work in?"
7. "What kind of work do you want to win more of?"

**For agency:**
1. "What's your agency called?"
2. "Where are you based?"
3. "Roughly how many people?"
4. "How would you describe what you do in one sentence? (e.g., 'We're a branding agency that works with sports and entertainment brands')"
5. "What are your main specialisms? (e.g., brand identity, creative campaigns, digital product, motion design)"
6. "What industries do you typically work in?"
7. "What kind of work do you want to win more of?"

**For in-house team:**
1. "What's the company you're part of?"
2. "What's your team called internally? (e.g., 'Brand team', 'Creative studio')"
3. "Where are you based?"
4. "How many people on the creative team?"
5. "What does your team handle? (e.g., brand campaigns, product design, internal comms)"
6. "What business units or stakeholders do you mainly serve?"

**For company:**
1. "What's your company called?"
2. "Where are you based?"
3. "Roughly how many people?"
4. "How would you describe what you do in one sentence?"
5. "What are your main specialisms?"
6. "What industries do you typically work in?"
7. "What kind of work do you want to win more of?"

Write to `~/.creativestack/profile.md`:

```bash
mkdir -p "$HOME/.creativestack"
```

Use the Write tool to create `~/.creativestack/profile.md` with this structure:

```markdown
---
name: {name}
type: {freelancer/studio/agency/in-house/company/other}
custom_descriptor: {only if type is "other" — their description}
location: {location}
size: {number, or 1 for freelancer}
industries: [{industry1}, {industry2}]
growth_areas: [{area1}, {area2}]
last_updated: {today's date}
---

## Specialisms
- {specialism 1}
- {specialism 2}
- ...

## Positioning
{their one-sentence description}
```

For in-house teams, add:
```markdown
## Parent Company
{company name}

## Internal Team Name
{team name}

## Business Units Served
- {unit 1}
- {unit 2}
```

### Step 4: Tone of voice

Adapt questions based on type:

**For freelancer:**
1. "How would you describe your personality as a creative? (e.g., confident, playful, intellectual, warm)"
2. "Are you more formal or casual in how you communicate with clients?"
3. "Any words or phrases you love using? Any you hate?"
4. "Can you paste an example of writing that sounds like you — a bio, an Instagram caption, a project description, anything?"

**For studio/agency/company:**
1. "How would you describe your {studio's/agency's/company's} personality? (e.g., confident, playful, intellectual, warm)"
2. "Are you more formal or casual in how you communicate?"
3. "Any words or phrases you love using? Any you hate?"
4. "Can you paste an example of writing that sounds like your {studio/agency/company} — a bio, an Instagram caption, a project description, anything?"

**For in-house team:**
1. "How would you describe your team's personality when communicating internally?"
2. "Are you more formal or casual?"
3. "Any words or phrases that are part of your team's culture? Any you avoid?"
4. "Can you paste an example of writing that represents your team's voice?"

Write to `~/.creativestack/tone-of-voice.md`:

```markdown
---
formality: {casual/casual-professional/professional/formal}
personality: [{trait1}, {trait2}, {trait3}]
last_updated: {today's date}
---

## We sound like
- {description based on their answers}

## We don't sound like
- {anti-patterns based on their answers}

## Vocabulary
- We say: {preferred words}
- We don't say: {avoided words}

## Examples
{paste their example, or synthesize one from their answers}
```

### Step 5: Team

**Skip this step entirely for freelancers.** Proceed to Step 6.

**For studio:**
Ask:
1. "Who do you work with? Names and roles — including any regular collaborators or contractors."

Write a flat list to `~/.creativestack/team.md`:

```markdown
---
headcount: {number}
last_updated: {today's date}
---

## Team
- **{Name}** — {Role}
- **{Name}** — {Role} (contractor)
```

**For agency:**
Ask:
1. "Who are the key people? Just names and roles is fine — e.g., 'Sarah - Creative Director, Mike - MD, Jade - Senior Designer'"
2. "Anyone else you want to include? PMs, strategists, producers?"

Write to `~/.creativestack/team.md` grouped by department:

```markdown
---
headcount: {number}
last_updated: {today's date}
---

## Leadership
- **{Name}** — {Role}

## Creative
- **{Name}** — {Role} ({specialisms if mentioned})

## Strategy
- **{Name}** — {Role}

## Production
- **{Name}** — {Role}
```

Group people by department based on their roles. If the user gives a flat list, organize it sensibly.

**For in-house team:**
Ask:
1. "Who's on the team? Names and roles."

Write a flat list (no department grouping forced):

```markdown
---
headcount: {number}
last_updated: {today's date}
---

## Team
- **{Name}** — {Role}
- **{Name}** — {Role}
```

**For company:**
Ask:
1. "Who are the key people? Names and roles."
2. "Want me to group them by department, or keep it as a flat list?"

Write in whichever structure they prefer.

### Step 5b: Team Roster Import

If the user wants to import a team roster from CSV or a pasted list:

Ask: "Paste your team roster. I can handle CSV format (Name, Role, Department, Email)
or just a list of names and roles. Whatever you have."

**CSV format expected:**
```
Name, Role, Department, Email
Sarah Chen, Creative Director, Creative, sarah@studio.com
Mike Torres, Managing Director, Leadership, mike@studio.com
```

**Plain text also works:**
```
Sarah Chen - Creative Director
Mike Torres - MD
Jade Park - Senior Designer
```

Parse the input, organize based on user type (departments for agency, flat list for
studio/in-house/freelancer), and write to `~/.creativestack/team.md`.

If the brain already has a `team.md`, ask:
[SELECT] "You already have team data. What should I do?"
- Replace — overwrite with the new roster
- Merge — add new people, keep existing ones
- Compare — show me the differences first

### Step 6: Clients / Stakeholders

**For freelancer (simplified):**
Ask:
1. "Who do you work with regularly? Just names or companies is fine."

Write to `~/.creativestack/clients.md`:

```markdown
---
client_count: {number}
last_updated: {today's date}
---

## Clients
- {Client/Company 1}
- {Client/Company 2}
```

**For in-house team:**
Ask:
1. "Who are the key stakeholders or business units you serve?"
2. "Any key contacts worth noting? (optional)"

Write to `~/.creativestack/clients.md`:

```markdown
---
stakeholder_count: {number}
last_updated: {today's date}
---

## Stakeholders
- **{Business Unit / Stakeholder 1}**
- **{Business Unit / Stakeholder 2}**

## Key Contacts
- {Contact name} — {role/notes if provided}
```

**For studio/agency/company:**
Ask:
1. "Who are your current clients? Just names is fine."
2. "Any key contacts at those clients worth noting? (optional — you can add these later)"

Write to `~/.creativestack/clients.md`:

```markdown
---
client_count: {number}
last_updated: {today's date}
---

## Active Clients
- **{Client 1}**
- **{Client 2}**
- ...

## Key Contacts
- {Contact name} at {Client} — {role/notes if provided}
```

### Step 7: Tools

Ask (adapt based on type):

**For freelancer:**
1. "What tools do you use day-to-day? (design tools, project management, invoicing, etc.)"

**For all others:**
1. "What tools does your {studio/agency/team/company} use day-to-day? (design tools, project management, communication, etc.)"

Write to `~/.creativestack/tools.md`:

```markdown
---
last_updated: {today's date}
---

## Design
- {tool 1}
- {tool 2}

## Project Management
- {tool}

## Communication
- {tool}

## Other
- {tool}
```

### Step 7b: Visual style

This step defines the agency's house visual style — the visual equivalent of
`tone-of-voice.md`. Any CreativeStack skill that produces visual output (Figma files,
FigJam boards, slide decks, social tiles, charts, diagrams) reads this file and
applies it.

This is **not** the same as brand guidelines for a client. This is the agency's own
style for its own deliverables.

Explain that briefly, then offer the presets:

[SELECT] "Pick a starting visual style. You can edit it after, or write your own from scratch."
- Editorial Modern — warm paper, near-black, vermillion accent. Fraunces / Inter Tight / JetBrains Mono. (Default)
- Newsroom — off-white, signal orange accent. Instrument Serif / IBM Plex.
- Architectural — dark editorial, chartreuse accent. Geometric sans throughout.
- I'll write my own — open the file blank with a TODO header
- Skip — default to Editorial Modern, configure later

The full default content for this file lives in `_build/shared/visual-style-default.md`
and is injected here at build time. It contains all three presets with the active one
marked. To change which preset is active, locate the `[ACTIVE]` marker in the
"Typography" and "Color" sections and move it to a different pairing/palette.

**For "Editorial Modern" (default) or "Skip":**
Write `~/.creativestack/visual-style.md` with the default content as-is — Editorial
Modern is already marked active in the default. No edits needed.

**For "Newsroom":**
Write the default content, then move the `[ACTIVE]` marker:
- In Typography: from "Pairing A — Editorial Modern" to "Pairing B — Newsroom"
- In Color: from "Palette 1 — Paper & Ink" to "Palette 2 — Studio Mono"

**For "Architectural":**
Write the default content, then move the `[ACTIVE]` marker:
- In Typography: from "Pairing A — Editorial Modern" to "Pairing C — Architectural"
- In Color: from "Palette 1 — Paper & Ink" to "Palette 3 — Dark Editorial"

**For "I'll write my own":**
Write a minimal stub file:

```markdown
---
last_updated: {today's date}
---

# Visual Style

_TODO: Define the house visual style. This file is read by every CreativeStack skill
that produces visual output (Figma, FigJam, slide decks, social tiles, charts).
Document typography, color, spacing, anti-slop rules, and brand override rules._

_For a comprehensive starting point, re-run `/setup-cs` and pick one of
the preset visual styles instead of "I'll write my own"._
```

**Default content to write** (used by all preset choices except "I'll write my own"):

```markdown
# Visual Style

This file defines how visual deliverables should look when generated by CreativeStack
skills — Figma files, FigJam boards, slide decks, social tiles, charts, diagrams, and
anything else that gets rendered visually rather than written.

This is the **visual equivalent of `tone-of-voice.md`**. Tone-of-voice covers how you
*write*. This file covers how you *render*. It is the agency's house style for its own
outputs — not the brand guidelines you create *for* clients.

Edit this file freely. Any skill that produces visual output will read it and adapt.

---

## Aesthetic principles

These are the non-negotiables. Every visual deliverable should pass them.

1. **Restraint is the design.** Every element must justify its presence. If a border,
   shadow, or gradient doesn't carry information, remove it.
2. **The grid does the talking.** Alignment, rhythm, and whitespace are the primary
   visual tools — not color or decoration.
3. **Typography carries the hierarchy.** Use type weight, size, and case (small caps,
   tracked uppercase) to create structure before reaching for color.
4. **Hairlines, not heavy rules.** 0.5px or 1px strokes only. Never 2px+ borders.
5. **Pragmatic over decorative.** Whoever opens this in a meeting has to read it fast.
   Legibility beats cleverness.
6. **One accent, used sparingly.** A single saturated color marks the things that
   matter. Never two accents. Never a gradient.

Reference points (the *feel*, not literal copying): Pentagram project documents,
Bloomberg Businessweek infographics, MIT Press project timelines, Wallpaper* feature
layouts, Monocle research charts, Spiekermann's grid work, IDEO process diagrams.

---

## Typography

The active pairing is marked with `[ACTIVE]`. To switch, move the marker to a different
pairing. All listed fonts are available in Figma's font library.

### Pairing A — Editorial Modern  [ACTIVE]
- **Display:** `Fraunces` — variable serif, optical sizes, real character.
- **Body / labels:** `Inter Tight` — tighter than Inter, less generic.
- **Numerals / data:** `JetBrains Mono` — for week numbers, durations, dates in tables.

### Pairing B — Newsroom
- **Display:** `Instrument Serif` — high-contrast editorial serif.
- **Body / labels:** `IBM Plex Sans` — humanist, slightly technical.
- **Numerals / data:** `IBM Plex Mono`.

### Pairing C — Architectural
- **Display:** `Söhne` if licensed in the file, else `Geist`.
- **Body / labels:** Same as display, lighter weight.
- **Numerals / data:** `Geist Mono` or `Space Mono`.

### Type rules
- **Titles:** Display font, large (56–72px for hero, 32–40px for section), tight leading
  (1.0–1.05), regular weight.
- **Section headers:** Body font, 11px, **uppercase, letter-spacing 0.12em**, with a
  1px hairline rule above.
- **Body labels:** Body font, 11–12px, medium weight, sentence case.
- **Metadata blocks:** Mono font, 11px, with **labels in uppercase tracked** and values
  directly beneath.
- **Numeric data** (dates, counts, percentages, weeks): Mono font.
- **Italics for accents.** Display-font italics are the editorial moment — use them for
  pull quotes, milestone callouts, and one-off emphasis. Never bold for emphasis.

### Forbidden fonts
- Inter as the only font (use Inter Tight if needed, paired with a display)
- Roboto, Arial, Helvetica Neue as defaults
- System fonts as defaults
- Anything from the "modern SaaS" family (Plus Jakarta Sans, Manrope, DM Sans) used
  generically without an editorial counterpart

---

## Color

The active palette is marked with `[ACTIVE]`. To switch, move the marker. To use brand
colors instead, see "Brand override" below.

### Palette 1 — Paper & Ink  [ACTIVE]
- Background: `#F5F1E8` (warm paper, NOT pure white)
- Primary text: `#1A1A1A` (near-black, NOT `#000000`)
- Secondary text: `#6B6660` (warm grey)
- Hairlines: `#1A1A1A`
- **Accent:** `#D9341E` (vermillion)

### Palette 2 — Studio Mono
- Background: `#FAFAF7`
- Primary text: `#0F0F0F`
- Secondary text: `#737373`
- Hairlines: `#0F0F0F`
- **Accent:** `#FF5C00` (signal orange)

### Palette 3 — Dark Editorial
- Background: `#141311` (warm black)
- Primary text: `#F0EBE0`
- Secondary text: `#8A857C`
- Hairlines: `#F0EBE0`
- **Accent:** `#E8D547` (chartreuse)

### Color rules
- **One accent, period.** Never two. Never a gradient.
- **The accent is reserved.** It marks the things that need to be noticed: critical
  paths, current state, key milestones, "your input needed" callouts. If you reach for
  it for general decoration, stop.
- **Multi-state visualisations use opacity tiers, not extra hues.** A timeline with
  three workstreams uses the primary color at 100%, 70%, 40% opacity — not three
  different colors.
- **No gradients. No shadows. No glows. Ever.**
- **Backgrounds are warm.** Pure white is reserved for cases where it's required
  (e.g., specific brand mandates). Default to paper / off-white.

### Brand override
If a specific project has its own brand colors and fonts, override sparingly:
- **Substitute the accent color** with the brand accent — but only if it's a single
  saturated hue. Pastels and gradients don't qualify.
- **Substitute the display font** with the brand display font — but only if it's
  available in Figma's font library.
- **Never substitute the background** unless the brand explicitly demands pure white
  or a different paper tone. Editorial warmth wins by default.
- **Never substitute the body or mono font** unless the brand has a strong opinion.
  The defaults are tuned for legibility on dense layouts.

---

## Spatial composition

- **Base unit: 8px.** All spacing is a multiple (8, 16, 24, 32, 48, 64, 96, 128).
  Never arbitrary values like 13 or 27.
- **Generous margins.** Outer padding on any frame is 64–96px minimum. Margins are
  what make a layout feel editorial rather than dashboard.
- **Asymmetry over symmetry.** Don't centre everything. Anchor the composition to a
  grid position with intent.
- **Section dividers are hairline rules with tracked uppercase headers sitting on
  them** — newspaper-style, not boxed-in cards.
- **Sharp corners.** Border radius: 0 by default. 2px maximum if a corner softening is
  truly required. Never 8px+ rounded "card" shapes.

---

## Anti-slop checklist

Before finalising any visual output, verify NONE of these are present. Each one is an
instant tell that this came out of a generic AI design tool with no taste:

- [ ] No purple. No blue-to-purple gradients. No "tech blue" (#3B82F6 or similar).
- [ ] No drop shadows. Anywhere.
- [ ] No gradient fills. Anywhere.
- [ ] No rounded corners >2px. Sharp rectangles only.
- [ ] No emoji used as icons (🚀 ✨ 📅 etc.).
- [ ] No generic SaaS icon set decorating layout (Heroicons, Feather, etc.).
- [ ] No Inter as the only font. Display + body + mono pairing required.
- [ ] No centred-everything layout. Composition is asymmetric and grid-anchored.
- [ ] No more than one accent color. Total hue count ≤ 3 (background, text, accent).
- [ ] No 2px+ heavy borders. Hairlines only.
- [ ] No "card" containers wrapping every element. The grid is the container.
- [ ] No glow, neumorphism, glassmorphism, or "frosted" anything.
- [ ] No 3D effects. No isometric illustrations. No gradient meshes.
- [ ] No legend box in a corner explaining colors. The design should be legible
      without one.
- [ ] No generic placeholder labels ("Phase 1 / Phase 2 / Phase 3"). Use real names.

---

## When the user pushes back

If the user says "make it more colorful" or "this looks too plain":
- Resist adding more hues. Increase typographic contrast instead (bigger display
  title, more italic moments, more whitespace).
- Offer a palette swap (Paper & Ink → Dark Editorial is the most dramatic shift).
- If they insist, add one more accent at most, and only for a single element type
  (e.g., milestone markers). Never recolor the structural elements.

The point of this style is that it ages well. A deliverable rendered in this style
still looks good in three months. A rainbow deliverable looks dated by Friday.

---

*This file is read by CreativeStack skills that produce visual output. Edit it to match
your house style. Run `/setup-cs` to regenerate it from a preset.*
```

After writing, confirm: "Visual style set to **{chosen preset}**. Edit
`~/.creativestack/visual-style.md` directly anytime, or re-run `/setup-cs`
to switch presets."

### Step 8: Remaining brain files

Create empty starter files for sections that get populated by other skills:

Write `~/.creativestack/case-studies.md`:
```markdown
---
last_updated: {today's date}
---

## Case Studies

_No case studies added yet. Use /case-study to create them, or add manually._
```

Write `~/.creativestack/methodology.md`:
```markdown
---
last_updated: {today's date}
---

## Methodology

_No methodology documented yet. Use /post-mortem after completing projects to start capturing how you work._
```

Write `~/.creativestack/learnings.md`:
```markdown
---
last_updated: {today's date}
---

## Project Learnings

_No learnings captured yet. Use /post-mortem after completing projects to build this up over time._
```

### Step 8b: Project state directory

Scaffold the project state directory at `~/.creativestack/projects/`. This is where
per-project state files live — one markdown file per active project — used by skills
like `/status-update`, `/project-kickoff`,
`/meeting-notes`, `/timesheet-summary`, and others to share
context across sessions.

```bash
mkdir -p "$HOME/.creativestack/projects"
```

If `~/.creativestack/projects/_index.md` doesn't exist yet, create it as a starter:

```markdown
# Active Projects

_No projects tracked yet. Run `/project-kickoff` to set one up properly,
or start any project-aware skill (e.g. `/status-update`) — it'll offer
a quick-start option._

| Project | Client | Status | Trend | Phase | Last touched |
|---|---|---|---|---|---|

# Closed Projects
```

Don't ask the user about projects during setup — they're created on demand when the
user kicks off a real piece of work.

### Step 9: Confirmation

After all files are written, summarize what was created. On a first run, frame this as
a meaningful moment, not a file dump. On a returning run (update mode), keep it brief
and functional.

**First-run confirmation** (use this when the brain was just created from scratch):

```
Done. Your Brain is alive at `~/.creativestack/`.

Here's what's in it:

- **profile.md** — {name}, {type}, {location}, {size} {people/person}
- **tone-of-voice.md** — {personality summary}
- **visual-style.md** — {chosen preset, e.g., "Editorial Modern"}
- **team.md** — {number} team members {or "skipped (solo)" for freelancers}
- **clients.md** — {number} {clients/stakeholders}
- **tools.md** — {tool count} tools
- **case-studies.md** — empty (populate with /case-study)
- **methodology.md** — empty (populate with /post-mortem)
- **learnings.md** — empty (populate with /post-mortem)
- **projects/** — ready for per-project state, created on demand when you start work

Every CreativeStack skill will now read this context automatically. You can edit any
of these files directly in a text editor, or re-run `/setup-cs` to update
sections.

**Making CreativeStack yours:** your brain is the primary way you customise
CreativeStack - every skill reads these files and adapts to your agency. Populate
the brain as you work and the suite gets sharper with every run. If you want to
change skill behaviour itself (rename sections, add custom modes, translate
prompts), you can fork the repo and edit the templates directly - see the
"Making it yours" section of the README for details.

The space is made. Now the work can begin.
```

That last line is the callback to the Debussy quote at the start. Keep it.

**Update-mode confirmation** (use this when an existing brain was edited, not created):

"Updated. {Brief one-line summary of what changed.} Re-run `/setup-cs` any
time to update other sections or run a health check."

Then automatically run Step 10: Brain Health Check to show the initial state (first run
only — skip on update mode unless the user asked for a health check).

### Step 10: Brain Health Check

Read every file in `~/.creativestack/` and score completeness. Check for stale data
based on `last_updated` frontmatter.

## Brain Health Report

| File | Status | Completeness | Last Updated | Notes |
|------|--------|-------------|-------------|-------|
| profile.md | {Present/Missing} | {Full/Partial/Empty} | {date or "—"} | {e.g., "Missing specialisms"} |
| tone-of-voice.md | {status} | {completeness} | {date} | {notes} |
| visual-style.md | {status} | {completeness} | {date} | {e.g., "Editorial Modern preset"} |
| team.md | {status} | {completeness} | {date} | {notes — or "N/A (freelancer)" if skipped} |
| clients.md | {status} | {completeness} | {date} | {notes} |
| tools.md | {status} | {completeness} | {date} | {notes} |
| case-studies.md | {status} | {completeness} | {date} | {notes} |
| methodology.md | {status} | {completeness} | {date} | {notes} |
| learnings.md | {status} | {completeness} | {date} | {notes} |
| projects/ | {Present/Missing} | {N active, N closed} | {most recent project last_updated} | {e.g., "3 active, 1 closed"} |

**Brain health: {X}/9 files present — {Y}/9 with content**

**Project state:** {N active projects, N closed} {— or "no projects tracked yet"}

**Completeness scoring:**
- **Full:** File has substantive content in all expected sections
- **Partial:** File exists but has placeholder content, missing sections, or sparse data
- **Empty:** File exists but only has starter/placeholder text

**Stale data check:**
{Flag any file where `last_updated` is more than 90 days old.}
- {file} — last updated {date}, {X} days ago. Consider refreshing.

**Recommended actions:**
{Adapt recommendations based on user type. Use the skill chain filtering rules from the preamble.}
- {e.g., "Run /case-study to populate case-studies.md — 14 skills reference this file."}
- {e.g., "team.md was last updated 4 months ago — re-run /setup with 'Update specific file' → team.md"}

## Skill Chains

After setup or health check, suggest the most relevant next step based on user type:

- If brain is freshly set up → "Run `/ai-audit` to get an AI readiness snapshot now that your context is configured."
- If tone-of-voice is sparse → "Run `/update-voice` to refine your tone of voice with more detail."
- If case-studies.md is empty → "Run `/case-study` to start building your case study library."
- If freelancer and no case studies → "Run `/case-study` — it's the single most valuable thing for winning new work."

Only suggest 1-2 chains — pick the most relevant for their type.

## Edge Cases

- User gives very brief answers → work with what you have, don't push for more
- User wants to skip a section → create the file with a placeholder note
- User pastes a large document for tone of voice → extract the key patterns, don't store the whole doc
- User doesn't know their tone of voice → help them discover it by asking about examples they like
- CSV import has inconsistent formatting → do your best to parse, show the result for confirmation before writing
- Team roster has people who've left → ask if the roster is current or needs cleanup
- User picks "Other" type → ask for their custom descriptor and use it consistently throughout
- Freelancer tries to set up team → let them, but note it'll be stored as collaborators/contractors

---
*CreativeStack by Cameron Jones — jones.cam*
