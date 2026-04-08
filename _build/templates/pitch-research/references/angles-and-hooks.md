# Angles, Hooks, and the Warm Path In

This is the operational core of pitch-research. Three jobs:

1. **Fit scoring** — should the agency pursue this prospect at all?
2. **Angles ranked by fit** — which approaches have the strongest brain-backed evidence?
3. **The killer hook** — the single sentence designed to land in the first 60 seconds
4. **The warm path in** — surfacing adjacent connections from the brain

---

## 1. Fit scoring

Before deep research, compute a fit score 1-5. Save 1-2 days of work on bad
prospects. Run after the brand snapshot but before angle generation.

Score on **5 dimensions** (1 point each):

| Dimension | Award the point if... |
|---|---|
| **Specialism overlap** | The work they need maps to a specialism in `profile.md` |
| **Sector experience** | `case-studies.md` shows past work in their sector OR an adjacent sector |
| **Scale match** | The likely fee fits the agency's typical project size (not 10x bigger or smaller) |
| **Timing fit** | Their likely brief timing doesn't clash with major commitments — read `~/.creativestack/projects/_index.md` if available |
| **Win pattern match** | `learnings.md § Pitching` shows past wins on similar prospects (sector + scale) |

### Interpretation

| Score | Action |
|---|---|
| **5** | Strong fit. Pursue confidently. This is your sweet spot. |
| **4** | Good fit. Worth pursuing — minor stretch in one area. |
| **3** | Marginal. Pursue only if you have time and a strong angle. Use Refresh mode rather than starting fresh. |
| **2** | Weak fit. Pass unless there's a strategic reason (testing a new sector, learning project, network value). |
| **1** | Bad fit. Recommend passing. If pursued anyway, treat as a learning project — don't spend pitch-team senior time. |

### Output format

```markdown
## Fit Score: 4/5

| Dimension | Score | Reasoning |
|---|---|---|
| Specialism overlap | ✓ | Brand identity is a core specialism |
| Sector experience | ✓ | Three sport brand projects in case studies |
| Scale match | ✓ | £45-80k range matches typical work |
| Timing fit | ✗ | Likely brief Q3 — Tate refresh closes Q3 |
| Win pattern match | ✓ | Won 2/3 sport brand pitches in last 18 months |

**Verdict:** Strong pursue. Minor timing stretch — flag with team if it advances.
```

If `learnings.md § Pitching` doesn't exist yet, mark "Win pattern match" as
`?` and award 0.5. Note that the score will be sharper after a few outcome logs.

---

## 2. Angles ranked by fit

Generate 3-6 angles, each backed by specific brain evidence. Use the existing
**Strong Fit / Good Fit / Stretch** structure but make the bar for each clearer.

### Strong Fit
**Bar:** A specific, named case study from `case-studies.md` in the same or
directly adjacent sector, with a measurable outcome that matches what the
prospect likely cares about.

```markdown
1. **Performance heritage repositioning** — Nike's brand challenge maps directly
   to what we did for Adidas Originals.
   - **Brain evidence:** *Adidas Originals "Forever Sport" platform (2023)* —
     repositioned a heritage line for Gen Z without losing core consumer.
     30% lift in unaided awareness (case-studies.md).
   - **What to say:** "We've been here. We did it for Adidas Originals.
     The framework is proven. Want to see how we'd adapt it for Nike Air?"
```

### Good Fit
**Bar:** Adjacent case study (different sector, transferable challenge) OR
strong methodology match without the perfect case study.

```markdown
1. **System over hero** — They need a brand that scales across digital and
   in-store, not a hero campaign.
   - **Brain evidence:** *Volvo CE design system (2024)* — different sector,
     but the same "scalable system" challenge. We built a system that survived
     20+ touchpoints (case-studies.md).
   - **What to say:** "Most agencies will pitch you a hero campaign. We'll
     pitch you a system that lasts five years. Want to see how Volvo did it?"
```

### Stretch
**Bar:** Honest about the gap. Lead with perspective or thinking, not experience.
Worth including only if the prospect values fresh perspective or you want to
demonstrate range.

```markdown
1. **Cultural capital play** — Nike Air could be repositioned around a specific
   subculture rather than a demographic.
   - **Brain evidence:** No direct case study. Closest is the Tate Modern
     audience strategy work (different sector entirely).
   - **What to say:** "We don't have direct sport experience here, but we've
     thought about this for two months. Here's a perspective no one else is
     bringing." Use only if Marcus's communication style is "visionary" — see
     decision-maker profile.
```

### Filtering rules

- **Drop any angle without brain evidence.** Pitch-research is not for inventing
  positioning — it's for matching the prospect to your real strengths.
- **Drop any angle that contradicts a past loss reason.** If `learnings.md §
  Pitching` shows you've lost twice on "we'll think for you" framing, don't
  pitch that angle to the next prospect, no matter how clever.
- **Cap at 6 angles total.** More than 6 means the brain isn't filtering hard
  enough — pick the strongest.

---

## 3. The killer hook

The single sentence designed to land in the first 60 seconds of the pitch
meeting. This is **not** the elevator pitch. The elevator pitch is about the
agency. The killer hook is about **the prospect's specific situation**.

### What makes a killer hook

1. **Names something true about them** — not a flattery line, a real observation
2. **Implies you've done the work** — references specific knowledge that signals research
3. **Opens a conversation, doesn't close one** — invites their response
4. **15-25 words** — short enough to remember, long enough to be specific
5. **Uses their language, not yours** — pulled from public statements (see decision-maker profiles)

### Killer hook templates

These are starting points, not formulas. Adapt to the prospect.

**Template 1: The reframe**
> "Most agencies will pitch you {expected approach}. We think the actual question is {reframed approach}."

> Example: "Most agencies will pitch you a Nike Air refresh. We think the actual question is whether Air can be a culture brand inside Nike's performance house."

**Template 2: The specific observation**
> "We noticed {specific public signal} — and it makes us think {hypothesis}. Are we right?"

> Example: "We noticed Marcus said in the AdAge piece that the brand felt 'safe' — and it made us think the next move isn't bigger, it's stranger. Are we right?"

**Template 3: The proof-first**
> "We did {specific case study} for {comparable client}. We think we could do {specific outcome} for you. Want to see how?"

> Example: "We did the Adidas Originals 'Forever Sport' platform — 30% lift in unaided awareness in nine months. We think we could do the same for Nike Air. Want to see the framework?"

**Template 4: The risk de-escalator** (use when decision-maker is "politically careful")
> "We know {sector} pitches are full of {generic thing}. Here's the small, specific thing we'd do first to prove the bigger idea."

> Example: "We know rebrand pitches are full of grand promises. Here's the small, specific thing we'd do first — a one-week diagnostic on Nike Air's current consumer language — to prove the bigger idea."

### Pressure-test the hook

Before locking it in, run it through 3 checks:

1. **Could this hook be said by any other agency?** If yes, it's not specific enough. Add a fact only you could have noticed.
2. **Would this hook earn a question from the room?** If it lands flat, it's not provocative enough. Add a contrarian edge.
3. **Does it match the decision-maker's communication style?** A craft-driven CMO won't respond to a data-led hook. Match the frame to the person.

If the hook fails any check, rewrite. The hook is the single most-rewritten
line in the dossier — that's correct, not a failure.

### What NOT to do

- **Don't open with the agency's name** — the prospect doesn't care
- **Don't open with credentials** — credentials live in the deck, not the first sentence
- **Don't open with a question without an opinion** — "What's your biggest brand challenge?" wastes the moment
- **Don't open with a quote from someone famous** — it signals lack of original thinking
- **Don't open with a stat unless it's about them** — generic stats are filler

---

## 4. The warm path in

Agencies live and die by who-knows-who. The brain has the data — surface it.

### Sources to check (in order)

1. **`clients.md` — direct relationships**
   - Has the agency worked directly with this prospect before? Even years ago?
   - Has the agency worked with a sister company / parent / acquired brand?

2. **`clients.md` — sector overlap**
   - Has the agency worked with their **competitors**? Flag carefully — this can be a strength (proven sector knowledge) or a weakness (conflict of interest concern)
   - Has the agency worked with their **complementary** brands (suppliers, partners, retailers)?

3. **`team.md` — team backgrounds**
   - Does anyone on the team have a previous job at this prospect, or at a sister company, or at a known supplier?
   - Does anyone on the team have a publicly-known personal relationship (per their LinkedIn or profile.md notes)?

4. **`learnings.md § Pitching`** — has anyone in the team pitched this prospect before, even at a previous agency?

5. **`profile.md`** — does the agency have a stated relationship with a network this prospect is part of (industry body, awards circuit, conference speaker pool)?

### Output format

```markdown
## Warm Path In

**Direct relationship:** None
**Sector overlap:** Worked with Adidas Originals (2023). Direct competitor —
flag during outreach. May trigger conflict-of-interest concern but also proves
sector competence.
**Team adjacency:**
- Sarah Chen worked at JD Sports 2018-2020 (per team.md). Sport retail
  experience is credible signal.
- Mike Torres has a personal contact at Wieden+Kennedy per profile.md notes.

**Warmest path in:** Mike's W+K contact. W+K is Nike's incumbent — a coffee
with the contact gives intel on the current relationship before any direct
outreach.

**Suggested next move:** Mike → coffee with W+K contact this week. Then
direct outreach via Sarah, leading with the JD Sports background.
```

If no warm path exists, say so plainly:

> **Warm Path In:** Cold. No direct or adjacent connections in the brain.
> Approach via direct outreach. Lead with the strongest case study match
> (Adidas Originals).

Don't fabricate warmth. A cold prospect approached cold but with an
honest framing beats a fake claim of connection.

---

## How these sections fit together in the dossier

Order matters. The dossier should flow:

1. Brand snapshot
2. **Fit score** ← decision point: pursue or pass
3. Adjacency check / Warm path in ← informs outreach strategy
4. Decision-maker profiles ← informs pitch framing
5. Angles ranked by fit ← what to actually pitch
6. **Killer hook** ← the first 60 seconds
7. Past pitch learnings overlay ← what to avoid based on past losses

The killer hook should be informed by everything above it. Generate it last.
