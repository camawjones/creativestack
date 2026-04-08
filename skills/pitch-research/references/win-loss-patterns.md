# Win/Loss Capture and Aggregation

The single most valuable data an agency can collect is **why pitches were
won or lost**. Most agencies don't capture it. The ones that do compound
faster than the ones that don't.

This file defines:
1. How to capture outcomes in **Log outcome** mode
2. How to write them to `learnings.md § Pitching`
3. How to aggregate across past dossiers to surface patterns
4. How to apply learnings to future Research runs

---

## 1. Capturing the outcome (Log outcome mode)

When the user picks Log outcome mode, walk them through structured questions.
The interview should take 5 minutes — short enough to actually do every time.

### Required questions

**1. What was the outcome?**
[SELECT]
- Won
- Lost
- Stalled (no decision yet, gone quiet >60 days)
- Withdrew (we pulled out)
- Passed (they passed without pitching)
- Pending (still in progress)

**2. What was the timeline?**
- "When did we first engage?"
- "When was the decision?"
- "How many meetings/touchpoints in total?"

**3. What was the fee / scope?**
- "Project type? (use stable vocabulary from rate-card-schema)"
- "Estimated fee at pitch time"
- "If won: actual fee. If lost: known winning fee if available"

**4. Who else was pitching?**
- "Did you know who you were pitching against?"
- "If known: who won (if you lost)?"

**5. The outcome reason — in their words**

This is the most important question. Push for the **specific words the prospect
or champion used**, not the team's interpretation.

- "What did they tell you was the reason?"
- "Did anyone on their side give you off-the-record context?"
- If no information was given: note that explicitly. "Reason not communicated"
  is itself valuable data.

**6. The outcome reason — in your honest assessment**

The team's read on what really happened, separate from what was said.

- "What do you think actually decided it?"
- "Was there a moment in the process where you felt it shift?"
- "What would you do differently?"

The two answers should be captured separately. They often disagree, and the
gap between them is where the learning lives.

**7. The killer hook in retrospect**

- "Did the killer hook land? How could you tell?"
- "If you had to rewrite the hook today, what would it be?"

If the hook clearly landed and the pitch was won, save it as a template in
`learnings.md`. If it clearly missed, save the gap as a lesson.

### Optional questions (ask if relevant)

- "Was there a single decision-maker comment that shifted things?"
- "Did the warm path in (or lack of one) matter in retrospect?"
- "Did the team's seniority match the room?"
- "Was the pre-meeting prep aligned with what actually happened?"

## 2. Writing to the dossier

After Log outcome, append to `prospects/{slug}.md` § Outcome:

```markdown
## Outcome

**Result:** Lost
**Logged:** 2026-04-08
**Timeline:** First contact 2026-02-15 → decision 2026-04-05 (7 weeks, 4 meetings)
**Type:** brand_identity
**Estimated fee:** £55k
**Winning fee (known):** £62k
**Won by:** Pentagram (incumbent for sister brand)

### Their stated reason
"You were the strongest creative answer but we needed someone with deeper
sport heritage." — Marcus Liu, CMO

### Our assessment
The Adidas Originals work was a double-edged sword — it proved sector
competence but raised conflict-of-interest questions internally that we
didn't address until the final meeting. The hook landed in the first
meeting but the strategy slides in the second meeting felt heavy and
Marcus tuned out.

### What we'd do differently
1. Address the Adidas relationship in the first meeting, not the third.
2. Cut the strategy framework slides — Marcus is craft-driven, not theory-driven.
3. Lead with the case study, defend with the framework.

### Hook retrospective
The hook ("Most agencies will pitch you a refresh — we think the question is
whether Air can be a culture brand inside Nike's performance house") landed
in meeting 1. Marcus quoted it back to us in meeting 3. The hook wasn't the
problem; the second-meeting heaviness was.
```

Then update the `_index.md` row:
- `Status: Lost`
- `Outcome: Lost — sector heritage concern`

## 3. Writing to learnings.md

After the dossier is updated, also append a structured entry to
`~/.creativestack/learnings.md` § Pitching. This is where aggregation reads from.

If the section doesn't exist, create it. Never overwrite existing entries.

```markdown
## Pitching

### {2026-04-08} — Nike (Air division) — LOST
- **Sector:** Sport
- **Type:** brand_identity
- **Fee bracket:** £45-65k
- **Stated reason:** Sector heritage concern
- **Our read:** Adidas conflict not addressed early; second meeting too theory-heavy
- **Lesson:** Address competitive relationships in first meeting, not third
- **Hook retrospective:** Landed (Marcus quoted it back)
- **Won by:** Pentagram (incumbent for sister brand)

### {2026-03-12} — Tate Modern — WON
- **Sector:** Culture
- **Type:** brand_refresh
- **Fee:** £85k
- **Their stated reason:** "You understood the institutional politics"
- **Our read:** Pre-meeting research on the trustee committee dynamics paid off
- **Lesson:** For institutional clients, profile the board not just the brand team
- **Hook retrospective:** Landed but they cited the trustee insight more
```

## 4. Aggregation across past dossiers

When a Research run starts for a new prospect, the skill should automatically
read `learnings.md § Pitching` and surface relevant patterns.

### Match dimensions

For each past pitch, check whether it shares any of:
- **Sector** (e.g. both "Sport")
- **Type** (e.g. both "brand_identity")
- **Fee bracket** (within ±30%)
- **Adjacency pattern** (e.g. both involved a competitor relationship)

### Aggregation outputs

Surface these in the dossier under "Past Pitch Learnings":

#### Pattern A: Sector win/loss record

```markdown
**Sport sector record:** 1 won, 3 lost (last 18 months)

Loss reasons cited:
- "Too small" (×2)
- "Sector heritage concern" (×1)

**Implication:** Address scale and sector heritage in the first meeting.
The pattern is consistent — these aren't one-offs.
```

If wins outnumber losses, frame positively but still surface the loss reasons.

#### Pattern B: Type win/loss record

```markdown
**Brand identity record:** 5 won, 2 lost (last 18 months)

Strongest hook patterns from wins:
- "Reframe the question" approach (3 wins)
- "Specific public observation" approach (2 wins)

**Implication:** Lead with a reframe hook for this prospect — it's your
highest-converting pattern in this work type.
```

#### Pattern C: Recurring loss reasons

```markdown
**Top loss reasons across all pitches (last 24 months):**
1. "Too small" (4 instances) → address scale upfront
2. "Sector heritage" (2 instances) → emphasise transferable case studies
3. "Pricing concern" (2 instances) → consider value-led framing
```

#### Pattern D: Decision-maker style mismatches

If past losses cluster around particular communication styles:

```markdown
**Style alert:** You've lost 3 pitches to "data-driven" decision-makers in
the last 12 months. The killer hooks in those pitches all led with creative
ambition rather than proof. For data-driven decision-makers, lead with the
metric, not the idea.
```

### Where to surface aggregations in the dossier

Insert under "Past Pitch Learnings (overlay)" in the dossier — between Decision-
Maker Profiles and Angles. The angles should be informed by the patterns,
not just brain evidence.

If there are no relevant past patterns, write:

> **Past Pitch Learnings:** No directly comparable past pitches in the brain.
> This is your first pitch in this combination of sector + type + scale.
> Worth logging carefully — outcomes here will inform future runs.

## 5. Aggregation queries the user can ask

In Aggregate mode (or just by asking the skill directly), the brain can answer:

| Question | What it reads | What it returns |
|---|---|---|
| "Why are we losing sport pitches?" | learnings.md § Pitching, filter by sector | Pattern of loss reasons + hook retrospectives |
| "What's our win rate by type?" | learnings.md § Pitching, group by type | Win/loss table by type |
| "Which decision-maker style do we win with most?" | learnings.md § Pitching, cross-reference dossier styles | Style match analysis |
| "What's working in our hooks?" | learnings.md § Pitching, filter wins | Pattern of winning hook templates |
| "Should we pitch {sector + type + scale}?" | All of the above | Fit recommendation with evidence |

## 6. Privacy and discretion

Outcome reasons can be sensitive. Specifically:

- **Don't quote losing competitor names or fees** unless they're publicly known
- **Don't quote off-the-record comments** with attribution beyond initials
- **Don't write anything you wouldn't want forwarded to the prospect**
- **Don't make personal observations about decision-makers** beyond their
  public statements and behaviour in meetings

The dossier may be read by anyone with brain access — including someone who
later shares it accidentally. Write accordingly.

## 7. Calibration discipline

Win/loss capture only works if it's done. Habits that help:

- **Log every outcome within 48 hours** of the decision — memory degrades fast
- **Capture losses more carefully than wins** — losses contain more information
- **Don't sanitise** — the team's honest read matters more than the prospect's diplomatic version
- **Update the hook retrospective** — even a "the hook landed" line is useful data
- **Set a recurring 90-day aggregate review** — the patterns only emerge over time

The skill should prompt for outcome capture whenever a Research-mode dossier
shows status="Pitching" but no outcome has been logged after the expected
decision date.
