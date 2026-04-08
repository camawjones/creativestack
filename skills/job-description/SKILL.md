---
name: job-description
description: Turn a vague hiring brief into an inclusive, well-structured job description for creative roles. Reads team.md to understand the actual gap, runs a pre-flight hiring sanity check (right level? right shape? unicorn risk? alternatives to a perm hire?), benchmarks salary against UK and US creative industry ranges with explicit flags, generates the JD using house tone of voice, scores it for inclusivity, surfaces hiring red flags, recommends posting channels weighted for candidate diversity, and writes the planned hire back to team.md so the agency tracks open roles in one place.
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

# /job-description

> Vague brief in, inclusive JD out. With a pre-flight check that asks the harder question first: should this hire even happen?

## Brain Files
- `profile.md` (for "About Us" content and culture — anti-generic source)
- `tone-of-voice.md` (for employer brand voice across the JD)
- `team.md` (for current team shape, gaps, day rates, and the planned-hires section this skill writes to)
- `clients.md` (only if the hire is being driven by a specific client engagement growth)
- `learnings.md` (for past hiring patterns — what worked, what backfired, time-to-fill)

## Reference Files

This skill loads detail on demand from `references/`. Read each only when relevant —
keeps SKILL.md lean and the context window honest:

- **`references/role-templates.md`** — read after the user picks a role template, for
  responsibilities by level, core skills, common tools, and what genuinely separates
  one level from the next
- **`references/salary-benchmarks.md`** — read at the salary anchoring step for the UK
  and US tables, regional adjustments, and the salary flag templates
- **`references/output-formats.md`** — read at generation time for the full JD
  template, inclusivity rubric, red flag rubric, posting channel recommendations,
  and the team.md write-back schema

## What This Skill Does

Takes a rough hiring brief — "we need a mid-weight designer who can do motion" — and
produces a well-structured, inclusive job description that accurately reflects the
role, distinguishes must-haves from nice-to-haves, and represents the studio's
culture honestly without resorting to "passionate team" filler.

Before generating, it runs a **pre-flight hiring sanity check** that surfaces the
harder questions: is this the right level? Is the role a unicorn? Does the salary
match the seniority? Could a contractor or restructure get the same outcome at
lower risk? Saying *no* or *not yet* protects the studio from a bad hire — which is
the most expensive mistake in any creative business.

Persists planned hires to `team.md` so future runs of `/resource-conflict`,
`/project-profitability`, and `/status-update` know
about open roles without having to be told twice.

## Conversation Flow

### Step 1: Brain check

Read `profile.md`, `tone-of-voice.md`, and `team.md` from `~/.creativestack/`. Pay
particular attention to `team.md`:

- What does the current team look like? Disciplines, levels, capacity?
- Is there an existing `## Planned Hires` section? Is the role the user is asking
  about already in it (meaning they're refining a previous JD, not starting fresh)?
- Are there obvious gaps that the user *isn't* asking about — but should be?

If `team.md` has rich data, use it. If it's sparse, ask the user to fill the gap
verbally — don't block on it, but flag at the end: *"Run `/setup-agency`
to capture your team properly. Future hires will be better informed."*

### Step 2: User provides the brief

The user describes who they want to hire. Could be a single sentence ("we need a
mid-weight designer who can do motion") or a longer brief. Parse actively. Extract:

- **Role and level** (or what the user thinks they want — these are often wrong)
- **Discipline overlap** (any signs of unicorn risk — "design and development",
  "strategy and copy", "AM and producer")
- **Salary signal** (number, range, "TBC", or no mention)
- **Type** (perm, contract, freelance, fractional)
- **Driver** (replacing someone, growth, new capability, client demand)
- **Constraints** (location, remote policy, start date, who they report to)
- **What's missing** — note the gaps for the pre-flight check

### Step 3: Pre-flight hiring sanity check

Before asking any clarifying questions, run an honest assessment of the hire and
surface it as a short report. Don't bury it. Don't refuse to continue if the news
is bad — make the recommendation, then let the user decide.

```
## Pre-flight check

**Hiring quality:** {Strong / Mixed / Weak} — {one-sentence reason}

**What's clear:**
- {clear thing 1 — e.g., "Genuine capacity gap in senior design — current team has
  no one above mid-weight."}
- {clear thing 2}

**What's missing or vague:**
- {missing thing — e.g., "No salary signal. Will block applicants and applicants
  will block you."}
- {missing thing — e.g., "Reports-to line not clear. If this is your first design
  hire, who's holding the bar?"}

**Red flags:** {only if any}
- {flag — e.g., "This role describes a designer + a developer + a strategist. Three
  jobs in one. Pick the primary discipline or the JD will attract no one."}
- {flag — e.g., "Senior responsibilities described, mid-weight salary signaled. The
  band you're offering won't attract the people you want."}
- {flag — e.g., "Hiring perm to cover a 3-month overflow on one project — a
  freelance contract may be the right tool here."}

**Alternatives worth considering:** {only if relevant}
- {alternative — e.g., "Two senior freelancers for 3 months may be cheaper and
  faster than a perm hire that takes 8 weeks to find."}
- {alternative — e.g., "Promoting your strongest mid-weight to senior + backfilling
  the mid-weight is often cheaper than a senior hire from outside."}

**Worth hiring?** {Yes / Yes with caveats / Pause and reconsider — here's why}
```

If the answer is "Pause and reconsider", ask via `AskUserQuestion`:

> "I'd push back on this hire — see above. Continue and draft the JD anyway, or
> pause and rethink the shape of the role first?"

Respect the user's call. Their judgment beats yours.

### Step 4: Clarifying questions (only what isn't covered)

Batch into a single `AskUserQuestion` where bounded. Skip anything already answered
by the brief or pre-flight.

1. [SELECT] "Which role template is closest?"
   - Designer
   - Art Director
   - Copywriter
   - Strategist
   - Account Manager / Account Director
   - Producer
   - Developer
   - Motion Designer
   - Other (free text)

2. [SELECT] "What level?"
   - Junior (0–2 years)
   - Mid-weight (2–5 years)
   - Senior (5–8 years)
   - Lead (8+ years)
   - Head of / Director

3. [SELECT] "Employment type?"
   - Permanent, full-time
   - Permanent, part-time
   - Fixed-term contract
   - Freelance / contract

4. [SELECT] "Working pattern?"
   - On-site
   - Hybrid (specify days)
   - Fully remote
   - Flexible

Then in free text only when needed:

5. "Salary range? (I'll flag if it doesn't match the market — and if you genuinely
   can't share one, I'll tell you what the cost of that is.)"
6. "Any tools, skills, or experience that are *genuine* requirements vs nice-to-haves?
   I'll be ruthless about cutting the inflation."
7. "What makes this a good place to work for this role specifically? (Not generic
   benefits — the things this person will actually care about.)"

After picking a role template, **read `references/role-templates.md`** for that role
and pull the level-appropriate scaffolding.

### Step 5: Salary anchoring

**Read `references/salary-benchmarks.md`** for the UK or US tables (or both if the
agency hires across both markets — check `profile.md` for location).

Compare the user's offered salary against the band for the role + level + region.
Apply one of the flag templates from the reference file:
- Below band → **Salary flag** (specific, with the cost framed plainly)
- Within band → confirm the position in the band
- Above band → highlight as a differentiator
- Missing entirely → **Transparency note** with the trade-off explained

If the level the user picked doesn't match the responsibilities they described, flag
this in the pre-flight section, not the salary section. They're different problems.

### Step 6: Generate the JD

**Read `references/output-formats.md`** for the full JD template, inclusivity rubric,
red flag rubric, and the posting channels guide.

Build the JD using:
- Tone from `tone-of-voice.md` for prose sections (About Us, The Role)
- Concrete content from `profile.md` for "About Us" — anti-generic, specific
- Role template scaffolding from `references/role-templates.md`
- Salary band notation from `references/salary-benchmarks.md`

Always include:

- **Salary band**, never a single number, never "competitive"
- **Application process** broken into numbered steps with realistic timing
- **Take-home task policy** stated explicitly — paid or not, scope, and the rate
- **Accessibility & accommodations statement** with a real named contact, not a
  generic inbox
- **"You don't need" section** to lower self-selection barriers (degree, agency
  experience, exact tool experience)
- **Closing line:** "We welcome applications from people who don't tick every box"
  or equivalent

Apply the **anti-slop check** as you write:

- No "rockstar", "ninja", "guru", "wizard", "passionate"
- No "fast-paced environment" (always reads as "long hours")
- No "wear many hats" (always reads as "we expect three jobs from one person")
- No "competitive salary" (always reads as "we're not paying market rate")
- No "we're like a family" (almost always reads as "boundaries don't exist here")
- The first sentence of "About Us" should be specific to *this* studio. Cut anything
  a competitor could honestly copy verbatim.

### Step 7: Score, flag, and recommend

Generate the **inclusivity rubric** (six dimensions, scored 1–10) using the schema
in `references/output-formats.md`. For any dimension below 8, give specific
improvements — not generic advice.

Generate the **red flag report** for the JD using the schema in
`references/output-formats.md`. Surface only the flags that apply. If none, say so.

Generate **posting channel recommendations** — pick 3–5 channels weighted by role
type from the posting channels guide in `references/output-formats.md`. Always
include at least one diversity-first board. State each channel with one line on why
it's relevant for this specific role. Don't dump the whole list.

### Step 8: Write back to team.md

Append (or update) a `## Planned Hires` entry in `~/.creativestack/team.md` using
the schema in `references/output-formats.md`. If the role is already in there as a
draft, update it. If it's not, append it with `Status: Drafted JD`.

Confirm to the user: *"Added to team.md under Planned Hires. Update the status as
the role progresses — it's read by `/resource-conflict` and
`/project-profitability` so they know about open capacity."*

## Gotchas

The mistakes that actually waste hiring budget, lose good candidates, or end up
producing a hire who doesn't last six months. Read these every time.

### Pre-flight / shape of the hire
- **Hiring perm to plug a temporary gap.** A 3-month overflow on one project is
  what freelance contracts are for. A perm hire takes 8+ weeks to find, costs the
  studio for the life of their tenure, and doesn't help the immediate problem.
- **Hiring senior when you really want a mid + a lead conversation.** Often the
  studio needs *direction*, not another senior pair of hands. A coaching engagement
  with an external CD is sometimes the right answer.
- **Hiring instead of restructuring.** If your best mid-weight is ready to be a
  senior, promoting + backfilling is almost always cheaper, faster, and better for
  morale than a senior hire from outside.
- **Unicorn JDs that try to combine three disciplines.** Designer + developer +
  strategist is three jobs. Pick the primary discipline. The candidates who
  honestly tick all three boxes don't exist; the ones who claim to are bluffing.
- **Hiring without a clear reports-to line.** If this is the first hire in a new
  discipline, who's holding the bar? Who's giving feedback? Without an answer,
  the hire fails by month three.

### Salary
- **No salary band in the listing.** Reduces applications by ~30% and
  disproportionately deters women and underrepresented candidates. It also wastes
  everyone's time at offer stage. Always include a band.
- **Salary/seniority mismatch.** Senior responsibilities at mid-weight pay attracts
  mid-weights or frustrates seniors. Either raise the offer or re-level the role.
- **"Competitive salary" as code for below-market.** Candidates know. Be explicit
  or be honest about why you can't be.
- **Forgetting non-cash compensation.** Equity, profit share, learning budget,
  holiday, hours flexibility — these matter, especially for senior candidates.
  Name them and the numbers, don't allude to them.
- **City pay assumed without saying so.** "London-based" at £45k for a senior
  designer is a no. State the band *and* the location assumption explicitly.

### Requirements & inclusivity
- **Requirements inflation.** 10+ must-haves filters out the candidates you most
  want. Research is consistent: women apply when they meet ~100% of requirements,
  men at ~60%. Every must-have is a self-selection event.
- **Listing tools as years of experience.** "5+ years Figma" — Figma was barely
  adopted by agencies before 2020. Use proficiency, not years.
- **Degree requirements for craft roles.** Filters out career changers and
  underrepresented candidates without adding signal. Cut unless legally required.
- **Unpaid take-home tasks.** Filters for financial security, not talent. If the
  task adds genuine signal, pay for it at a freelance day rate. If it doesn't,
  don't ask for it.
- **Multiple in-person interviews in a single city.** Real cost on candidates.
  Either offer remote-first interviews or compensate for travel.
- **No accessibility statement.** Signals you haven't thought about it. Even a
  short, sincere one with a named contact is a 10x improvement on nothing.

### Voice / employer brand
- **Generic "About Us" filler.** "Passionate team of creators delivering
  world-class work" — every studio writes this. Cut it. Say something specific to
  *this* studio in the first sentence.
- **"We're like a family."** Almost always reads as "boundaries don't exist here".
  Use "team" or just describe how you actually work.
- **"Wear many hats."** Reads as "we expect three jobs from one person at one
  salary." Be specific about the role's actual remit.
- **"Fast-paced environment."** Reads as "long hours, no boundaries". If you mean
  the work changes shape often, say that.
- **Buzzword bingo.** "Rockstar", "ninja", "guru", "wizard", "passionate" — all
  signal a JD that doesn't know what it's looking for. Cut them all.

### Process
- **Vague application process.** "Send us your CV and portfolio and we'll be in
  touch." Candidates want to know what they're signing up for. Number the steps,
  give realistic timings, name the people.
- **Ghosting after stage 2.** Damages employer brand for years. State your
  feedback policy and stick to it.
- **Posting only on LinkedIn.** Misses entire pools of candidates, especially
  underrepresented ones. Always include at least one diversity-first board and at
  least one craft-specific board for the role.
- **Reusing an old JD without re-checking the salary band.** Salary bands shift
  yearly. A JD posted with last year's band quietly underpays the hire and
  undercuts the team's perception of fairness.

## Skill Chains

### Upstream

If these would have helped but weren't run, suggest 1–2:

- No `team.md` populated → "Run `/setup-agency` to capture your team properly. Future hires will be better informed."
- No `tone-of-voice.md` → "Run `/update-voice` to nail down the studio's voice. The 'About Us' section will stop sounding generic."
- Driven by capacity pressure → "Run `/resource-conflict` first to confirm a hire is the right answer rather than a freelance bridge."
- Driven by a specific client engagement → "Run `/project-profitability` on the engagement first — the JD changes if the role is being funded by client work."

### Downstream

After generating, suggest 1–2:

- "Run `/resource-conflict` to model how this hire (or its absence) affects your capacity over the next quarter."
- "Once the role is filled, update `team.md` directly or re-run `/setup-agency` to refresh your team data."
- "If you're hiring multiple roles together, re-run this skill for each — they should all reference the same `team.md` so capacity stays coherent."

Pick the most relevant 1–2.

## Edge Cases

- **Very vague brief ("we need someone")** — don't guess. Ask just enough to distinguish discipline, level, and driver. Run the pre-flight check on what little you have and surface the gaps loudly.
- **Role spans two disciplines** — flag as unicorn risk in the pre-flight. Ask the user to pick the primary discipline. Don't paper over it in the JD.
- **Salary clearly below market** — flag in pre-flight, then again in the salary section, then offer to re-level the role or recommend non-cash compensation.
- **Freelance vs perm confusion** — clarify the implications for both parties (notice periods, day rate vs salary, IR35 if UK, equipment, holiday pay).
- **Internal promotion being backfilled** — adjust tone to reflect what the outgoing person did vs what the new role needs. They're rarely the same.
- **No salary provided** — apply the transparency note from `salary-benchmarks.md` and include the band anyway. Don't post without one.
- **Non-standard role title (Creative Technologist, Brand Designer, AI Engineer, Service Designer, Content Designer)** — map to closest 1–2 templates, combine relevant scaffolding, note explicitly what's unique.
- **Hiring during a freeze or for a hypothetical future role** — generate the JD but don't write to `team.md` until the user confirms the role is real and budgeted.
- **Replacing a much-loved person** — call this out gently. The JD should describe the role, not eulogise the person. The new hire needs to be themselves.

### What this skill can't do

This skill writes one job description at a time. It can't run interviews, assess
portfolios, build a structured scorecard, run diversity audits across your full
hiring funnel, or track time-to-fill across the agency. A dedicated AI partner
could manage your entire hiring pipeline — tracking open roles against team
capacity, suggesting when to hire based on pipeline forecasts, and keeping JDs
updated as roles evolve. That's what the Brain — and the rest of the CreativeStack
suite — is heading toward. For now, it makes the first step (writing the JD) much
faster, much more honest, and much harder to ship a bad version of.

It also can't tell you whether to hire a specific person. The pre-flight check
surfaces the question of whether the *role* makes sense. The call on the
*candidate* is yours.

---
*CreativeStack by Cameron Jones — jones.cam*
