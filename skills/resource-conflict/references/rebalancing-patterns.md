# Rebalancing Patterns

How to turn a conflict map into specific, actionable plays. The goal is to
suggest moves a producer could make today, not generic advice like "consider
hiring."

## The substitution rules

Use these in order. Stop at the first that produces a viable play.

### Rule 1: Direct substitution (same role, available capacity)

If someone in the same role is below target, move work to them.

> "Move 1 day/week of {project} from Sarah (92%) to Mike (68%). Same role,
> available capacity, no skill gap."

### Rule 2: `can_substitute_for` match

Read each free person's `can_substitute_for` field from `team.md`. If it
includes the overbooked person's role, they can credibly cover.

> "Mike's brain says he can substitute for senior designer. Jade is overbooked
> as senior designer on {project}. Move the brand identity workstream to Mike
> (currently 65%)."

### Rule 3: Seniority + specialism overlap

If `can_substitute_for` isn't set, fall back to: same or higher seniority +
overlapping specialism = credible substitute.

> "No explicit substitution rules set. Falling back to seniority + specialism:
> {name} is the same seniority as {overbooked} and shares {specialism}.
> They could plausibly cover {workstream}, but confirm with them first."

### Rule 4: Asymmetric offload (different role, unblocking)

You can't always swap like-for-like. Sometimes the play is to offload the
*adjacent* work that's eating the overbooked person's time:

- **Overbooked senior, free producer:** Producer takes on coordination,
  client comms, status updates. Senior gets back to judgement work.
- **Overbooked CD, free senior designer:** Senior designer covers design
  reviews of mid/junior work. CD only gets escalations.
- **Overbooked designer, free strategist:** Strategist front-loads more
  thinking so the designer doesn't have to discover the brief through pixels.

### Rule 5: Time-shift before person-shift

Before reassigning people, ask: can the deadline move?

> "Delay {project} kickoff by one week. Sarah finishes {current project} on
> Friday and starts fresh Monday. No reassignment needed, no quality risk."

This is the cheapest move. Always check feasibility first.

### Rule 6: Scope reduction

If no person move and no time move works, the question is **what to drop**:

> "Both projects need senior creative oversight in week 12 and there is none.
> Either: (a) drop the third concept route on {project A}, or (b) reduce
> {project B} to a single-route presentation. Talk to the client owners
> about which is more defensible."

### Rule 7: Freelance backstop

Only after rules 1-6 fail. See "Freelance vs internal decision tree" below.

## Freelance vs internal decision tree

```
Is the gap >2 weeks AND >50% allocation?
├── Yes → Freelance is viable. Continue.
└── No → Too small. Use rules 1-6 or accept the stretch.

Is there a known-good freelancer in freelance-bench.md with the right specialism?
├── Yes → Recommend by name with rate, lead time, last engaged.
└── No → Recommend "trusted freelancer in {specialism}" generically + suggest /resource-conflict's Setup bench mode for next time.

Can the trusted freelancer start in time?
├── Yes → Recommend.
└── No → Lead time conflicts with need date. Either: (a) start them late on a reduced scope, (b) find someone else, (c) reduce scope so internal team can absorb.

Does the freelance day rate × duration justify the relief?
├── Day rate is in freelance-bench.md AND in team.md → Calculate the cost-out.
│   Freelance cost = day_rate × days needed
│   Internal cost = (overbooked person's day_rate × overrun days) + quality risk
│   If freelance < 1.3× internal → Recommend.
│   If freelance > 1.3× internal → Recommend only if quality risk is High/Critical.
└── No rates available → Recommend qualitatively, flag that cost-out needs the user's judgement.
```

## Common conflict patterns and plays

These come up repeatedly. Recognise them and offer the standard play first.

### Pattern: "The senior bottleneck"

- One senior on 4+ projects, all of them needing their input in the same week
- Symptoms: Senior at 90%+, multiple projects amber, quality complaints
  starting on the third project
- **Play:** Triage the four projects by stage. Senior focuses fully on the
  one in concept (where their judgement is irreplaceable). Mid-weight covers
  the two in execution (where direction is set). Fourth project gets a
  one-week pause.

### Pattern: "The pitch tornado"

- A pitch lands on Monday. Pitch team of 4 gets pulled to 100% for 2 weeks.
  Their existing projects all slip.
- Symptoms: Four people instantly red, four projects instantly at risk
- **Play:** Don't try to backfill everyone. Identify the **critical paths** on
  each existing project. Protect those (1-2 days/week of the assigned person).
  Let the non-critical workstreams drift for 2 weeks and recover after pitch.
  Communicate the slip to client owners proactively, not after the fact.

### Pattern: "The hidden meeting load"

- Person looks 70% allocated on paper but is at 95% in reality
- Cause: 15+ hours/week of meetings not counted in allocation
- Symptoms: Repeated "I had no time to do the actual work" complaints
- **Play:** This isn't a resource problem, it's a meeting hygiene problem.
  Recommend a meeting audit (which can be deferred to client owners) and
  flag in `learnings.md` § Capacity that this person's real ceiling is
  ~75% on-paper allocation.

### Pattern: "The stretched principal"

- CD/principal at 85%+ across 5+ projects
- Symptoms: Reviews getting pushed, juniors waiting for direction, work
  shipping without senior eyes
- **Play:** Move the CD to **review-only** on 2 of the 5 projects. They get
  scheduled review windows (Tue/Thu mornings) and don't do any production
  work on those projects. Frees ~30% of their time. Reassign the production
  work to a senior designer who can hold the line.

### Pattern: "The summer hole"

- Multiple people on leave in the same fortnight, projects don't pause
- Symptoms: Predictable but ignored every year
- **Play:** Surfaced 6 weeks ahead, freelance-bench booked early (better rates,
  better people). Surfaced 1 week ahead = panic and premium rates.
  Always check `leave_pattern` field in `team.md` for recurring conflicts.

### Pattern: "The single point of failure"

- One person knows {motion / 3D / specific tool / specific client relationship}
- They're booked solid AND they're the only path
- Symptoms: Project blocks the moment they're sick
- **Play:** Short-term: protect their time on the SPOF project, offload
  everything else. Long-term: flag in output as a structural risk and
  suggest cross-training in `learnings.md`.

## What to write in the Rebalancing Suggestions section

For each suggestion, include:

1. **The move** — specific person, specific project, specific change
2. **The reasoning** — which rule applies (substitution / time-shift / etc.)
3. **The cost** — what gets sacrificed (always something)
4. **Confidence** — High if explicit substitution rules, Medium if inferred,
   Low if requires the user to check feasibility

> 1. **Move Mike to senior cover on Nike pitch (Mon-Wed)**
>    *Rule 2 — Mike's brain says he can substitute for senior designer.*
>    *Cost: Loses 2 days from Adidas refresh (currently low-pressure phase).*
>    *Confidence: High*
>
> 2. **Delay Tate kickoff by one week**
>    *Rule 5 — Sarah finishes Adidas on Friday. One-week delay frees her cleanly.*
>    *Cost: Tate launch slips by one week — confirm with client owner.*
>    *Confidence: Medium — depends on client flexibility.*
