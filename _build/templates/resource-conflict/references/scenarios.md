# Scenario Mode

Scenario mode answers "what if" questions without committing to a change.
The user runs Analyse first to get the baseline, then runs Scenario to model
a hypothetical against it.

## When to use scenario mode

Trigger when the user asks anything in the form:
- "What happens if we win {pitch}?"
- "What if {person} leaves for {duration}?"
- "Can we take on {new project}?"
- "What if {client} brings forward the deadline?"
- "What's the impact of {team change}?"

If they describe one of these without using the word "scenario", offer it
explicitly: "Sounds like a scenario question. Want me to model it against
the current resource picture?"

## The scenario mode flow

1. **Baseline check** — confirm there's a recent Analyse output in the
   conversation OR run a fresh one
2. **Scenario type** — pick from the patterns below or accept a free-text
   description
3. **Model the change** — apply it to the baseline, recompute conflicts
4. **Diff output** — show what changes vs. the baseline, not a full re-report
5. **Recommendation** — go / no-go / go-with-mitigation

## Scenario patterns

### Pattern A: Pitch win

**Trigger:** "What if we win the {client} pitch?"

**Inputs needed:**
- Pitch start date (when work would begin)
- Estimated team needs (roles + days/week)
- Duration
- Confidence (50/50, likely, almost certain)

**Model:**
- Add the pitch as a new project at the start date
- Allocate the requested roles
- Recompute utilisation
- Identify which existing projects get squeezed

**Output:**
- **Green:** "Yes — {N} people gain capacity needed, no existing projects move into red. Safe to win."
- **Amber:** "Manageable with mitigation. {N} people move into stretched. Specific moves: {list 2-3 plays from rebalancing-patterns.md}."
- **Red:** "Not without trade-offs. {Person} hits 110%, {project} blocks. Either: (a) push pitch start by {N} weeks, (b) bring freelance for {role} from week 1, (c) deprioritise {project}."

### Pattern B: Pitch loss / pitch effort cost

**Trigger:** "What does losing the pitch cost us?" or "What's the cost of pitching?"

**Inputs needed:**
- Pitch team and current allocation %
- Pitch duration

**Model:**
- Calculate days × people × day_rate (if available) for the pitch effort
- Identify what existing work was deferred during the pitch
- Recovery time after the pitch

**Output:**
- The hard cost (days × people × rate)
- The opportunity cost (what work was paused)
- The recovery period (how long until team is back to baseline)
- "If you don't win this, the cost is {N} days of senior creative time, {project} slipped by {N} weeks, and {person} needs a 1-week decompression. Worth understanding before you commit."

### Pattern C: Person leaves (temporary)

**Trigger:** "What if {person} is out for {duration}?" (leave, sick, sabbatical)

**Inputs needed:**
- Who, when, how long
- Reason (affects whether work can be rescheduled around them or must be reassigned)

**Model:**
- Remove their allocation from all projects for the period
- For each affected project, apply substitution rules from `rebalancing-patterns.md`
- Flag any project where substitution fails

**Output:**
- Per-project impact: "Nike pitch — Sarah covers (substitution rule 2). Adidas refresh — no substitute, scope must reduce or deadline slip."
- Knock-on effects on the substitutes
- Cumulative cost across the period

### Pattern D: Person leaves (permanent)

**Trigger:** "What if {person} resigns / leaves at end of month?"

**Inputs needed:**
- Notice period
- Whether replacement is planned

**Model:**
- Same as temporary, but extend to "indefinite" until replacement
- Identify single points of failure that become structural
- Recommend hire timing

**Output:**
- Immediate (notice period) — what they finish, what handovers need to happen
- Gap period — what the team can absorb, what needs freelance/contract cover
- Hire timing — earliest workable replacement start
- Long-term — what knowledge / relationships are lost permanently and need
  to be rebuilt

### Pattern E: New project lands

**Trigger:** "Can we take on {project}?" or "We just won {project}, can we deliver?"

**Inputs needed:**
- Start date, duration, team needs
- Whether it's confirmed or still being discussed

**Model:**
- Add as a new project at the start date
- Recompute conflicts
- Distinguish "yes with current team" from "yes with freelance" from "no"

**Output:**
- Capacity verdict: yes / yes-with-conditions / no
- If yes-with-conditions: list the conditions clearly (freelance, deadline shift, scope reduction on something else)
- If no: what would have to change to make it yes

### Pattern F: Deadline pulled forward

**Trigger:** "Client wants {project} 2 weeks earlier — can we?"

**Inputs needed:**
- Project, original deadline, new deadline
- Whether scope is also reducing

**Model:**
- Compress the project's allocation curve into the shorter window
- Recompute peak utilisation for the affected people
- Identify what else they're on that gets crushed

**Output:**
- Peak utilisation under the new timeline
- Quality risk assessment (does this push people into 90%+ territory)
- Mitigation: scope reduction, freelance, deprioritise other work
- If unsafe: what to push back on (scope, deadline, or both)

### Pattern G: Client escalation

**Trigger:** "{Client} is upset — we need to put senior eyes on it this week"

**Inputs needed:**
- Which project
- Who needs to be on it
- For how long

**Model:**
- Treat as an emergency reallocation
- Senior gets pulled, identify what they were supposed to be doing
- Cascade the displacement

**Output:**
- Emergency reallocation (who moves where)
- What this displaces and how to manage the displacement
- Recovery timeline
- Flag for `learnings.md` § Capacity: client escalations are a recurring tax,
  worth tracking the frequency

## Scenario diff output format

Scenario mode does **not** re-print the full Resource Conflict Report.
It prints a diff:

```markdown
# Scenario: {Scenario Name}
**Baseline:** {date of last Analyse run, or "fresh"}
**Verdict:** {Green / Amber / Red}

## What changes

| Person | Baseline | Scenario | Delta |
|---|---|---|---|
| Sarah | 78% (optimal) | 95% (burnout risk) | +17% |
| Mike | 65% (healthy) | 82% (stretched) | +17% |
| Jade | 88% (at risk) | 88% (at risk) | 0 |

## New conflicts
- {Project} now at risk because {person} hits 95%
- {Single point of failure surfaced because {person} is the only one with {skill}}

## Resolved conflicts
- {None / list any}

## Verdict
{Green / Amber / Red explanation in 2-3 sentences}

## Mitigations
{If Amber or Red, list specific plays from rebalancing-patterns.md}

## Recommendation
{Go / Go-with-mitigation / No-go, with one-line reasoning}
```

## Saving scenarios

After modeling, offer: "Want me to save this scenario? I'll add it to
`learnings.md` so future runs remember the trade-off you considered."

Format in learnings.md:

```markdown
## Capacity

### {2026-04-07} — {Scenario: Nike pitch win}
- Decision: Pursued
- Trade-off accepted: Adidas refresh delayed 2 weeks
- Mitigation: Booked Alex Rivera (bench) for week 1 of pitch
- Outcome: {to be filled in via Calibrate mode}
```
