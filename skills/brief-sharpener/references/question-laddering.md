# Question Laddering

How to generate the right clarifying questions, rank them by
deal-breaker risk, and phrase them so the client will actually
answer. The sharpener's output is only as useful as the questions
it generates — bad questions waste the client's time and train
them to ignore the agency.

---

## The three tiers

### Tier 1: Project Killers
Questions where the answer *fundamentally changes the project*.
If the team starts work without these answers, the work will be
thrown out and re-done. Resolve before creative work begins.

**Typical Tier 1 patterns:**
- Budget range (when no budget is stated)
- Real ask vs stated ask (when the stated ask is a deliverable)
- Decision-maker identity (when "the team" will decide)
- Success definition (when it's "we'll know it when we see it")
- Scope priority (when the deliverable list exceeds the budget)
- Timeline feasibility (when the date is impossible given scope + approvals)
- Audience primary pick (when "everyone" is the audience)

**Volume:** 1-3 Tier 1 questions max. If you have more than 3,
the brief isn't ready for creative and the output should recommend
a discovery conversation, not a question list.

---

### Tier 2: Direction Changers
Questions where the answer *significantly redirects the creative
work* but doesn't kill it. The team can start on speculative
directions but will lock in the answer before concept review.

**Typical Tier 2 patterns:**
- Audience depth (behaviour, context, desire layers)
- Competitive positioning ("premium" vs which competitor?)
- Tone contradictions ("bold but safe" → which wins?)
- Deliverable specifics (formats, platforms, specifications)
- Brand guideline latitude (strict adherence or room to evolve?)
- Mandatory elements (must-includes, must-excludes)
- Stakeholder involvement (who sees what, when)

**Volume:** 3-6 Tier 2 questions is normal.

---

### Tier 3: Refinements
Questions that *strengthen the brief* but won't derail the project
if unanswered. Can be resolved during the work itself.

**Typical Tier 3 patterns:**
- Historical context (past campaigns, previous agencies)
- Asset availability (photography, video, copy)
- Research availability (insights, data, studies)
- Reference material (moodboards, inspiration)
- Internal politics (who to avoid, who to involve)
- Budget breakdown by phase

**Volume:** As many as useful, but de-emphasise in output.

---

## How to generate questions

### From the rubric
Every dimension scoring 1-6 should produce at least one question.
Red dimensions (1-3) are almost always Tier 1. Amber (4-6) are
typically Tier 2.

### From red flags
Every red flag match in `red-flags.md` produces a question. The
tier depends on the flag:
- Budget/timeline impossibilities → Tier 1
- Contradictions → Tier 2 (usually)
- Process flags → Tier 1 or 2 depending on severity

### From missing context
Gaps where the brief is silent but context implies something
matters. Example: brief for a food brand with no mention of
dietary claims — almost certainly a Tier 2 question (legal will
come up eventually).

### From upstream data conflicts
If `/competitor-audit` or `/trend-report` ran and their findings
contradict the brief's assumptions, those conflicts become Tier 2
questions: "The brief assumes X, but the competitor audit shows Y.
Which is right?"

### From learnings.md § Client Patterns
If past projects with this client had recurring feedback issues
on a specific dimension, pre-emptively ask about it: "Past briefs
with this client have struggled with stakeholder clarity. Can you
confirm who has final sign-off?"

---

## The 5-whys ladder (for extracting the real ask)

When the brief is at the deliverable level ("we need a rebrand"),
apply the 5-whys ladder to find the real ask. Each why climbs
toward business outcome.

**Example: "We need a new website"**
1. Why a new website? → "The current one is dated."
2. Why does dated matter? → "We look less credible than competitors."
3. Why does credibility matter? → "We're losing deals in the sales pipeline."
4. Why are we losing deals? → "Buyers compare us on the site and move on."
5. Why do they move on? → "They can't tell what we actually do."

**Real ask:** "Make what we actually do instantly clear on the
homepage so we stop losing buyers at the top of funnel."

That's a fundamentally different brief than "new website".

**How to use the ladder in practice:** Don't actually ask 5 whys
in sequence — that makes the client feel interrogated. Instead,
ask one strategic question that exposes the chain:

> "If the new website does everything you hope, what changes in
> the business in 6 months that wouldn't happen otherwise?"

That question does the climbing work for you.

---

## Phrasing rules

### Make it easy to answer

**Bad:** "What is your target audience?"
**Good:** "When you picture the single person this needs to work
hardest for, who are they and what are they doing in the moment
they'd see this?"

The second question is longer but gives the client something
concrete to answer. Open questions force thinking; closed questions
force picking.

### Offer options where possible

**Bad:** "What's your budget?"
**Good:** "What's the ballpark budget we should plan against — is
this more in the £20k, £50k, £100k, or £250k+ range?"

A range is much easier to answer than a number. Clients will
share a range even when they refuse to share a specific figure.

### Frame questions as protecting the client

**Bad:** "Who has final sign-off?"
**Good:** "So we can make sure the right people see the work at
the right stage, who has final creative sign-off?"

Questions framed around the client's benefit (saving them time,
avoiding rework, protecting outcomes) get answered. Questions
framed around the agency's needs get deflected.

### Never ask multiple things in one question

**Bad:** "What's the budget, timeline, and approval process?"
**Good:** Three separate questions.

Multi-questions get partial answers and leave the hardest one
unanswered.

### Cite the source when flagging a contradiction

**Bad:** "These things contradict each other."
**Good:** "The brief mentions 'premium positioning' in the
objectives section and 'price-sensitive audience' in the audience
section — which should take priority if they conflict in the work?"

Specific citations are harder to dismiss than abstract claims.

### Avoid jargon

**Bad:** "What's the brand's current equity position vs category
benchmarks?"
**Good:** "How do you think your brand is currently perceived
vs competitors — stronger, weaker, different?"

Clients often don't know agency jargon and won't ask — they'll
just not answer.

---

## Per-question structure in the output

Every question in the output should include:
- **The question itself** (phrased per the rules above)
- **Why it matters** — one sentence about the risk if unanswered
- **Where it comes from** — the dimension, red flag, or contradiction that surfaced it

Example:

> **Tier 1 — Who has final creative sign-off?**
> **Why it matters:** Without a named decision-maker, the work
> will be designed by committee and approval will stall in round 3.
> **Surfaced by:** Dimension 7 (Stakeholders & Approvals) scored
> Red — "The team will review" is not a process.

---

## The "what I won't ask" rule

Every sharpener output should include a short "not asking about"
list. These are things the brief doesn't cover but the sharpener
is *deliberately* not putting in the question list because they'd
be noise. Usually:
- Nice-to-have deliverable specs (save for scope call)
- Stylistic preferences (that's the team's job)
- Budget breakdown by line item (too early)
- Legal detail (legal team handles this later)

Listing what you're *not* asking shows the client you've been
deliberate, and saves their patience for the questions that matter.

---

## Ceiling: 10 questions total

Any sharpener output with more than 10 total questions across all
tiers has failed at ranking. If the list is longer than 10:

1. Are there multi-questions that should be split? Fine to split.
2. Are there Tier 3 questions that could wait? Cut or defer.
3. Is this actually a discovery conversation, not a question list?
   If yes, output that recommendation instead.

Clients will answer 5 good questions. They won't answer 25 okay ones.
