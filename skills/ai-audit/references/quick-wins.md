# Quick Wins Library

## Contents
- [How to use this library](#how-to-use-this-library)
- [Selection rules](#selection-rules)
- [Wins by category](#wins-by-category)
  - [Ops & Admin](#ops--admin-wins)
  - [Creative Workflow](#creative-workflow-wins)
  - [Client / Stakeholder Comms](#client--stakeholder-comms-wins)
  - [Knowledge & IP](#knowledge--ip-wins)
  - [Commercials & Intelligence](#commercials--intelligence-wins)
- [Output format](#output-format-for-each-selected-win)

---

## How to use this library

When selecting quick wins for the audit output, **select from this
curated library** — do not invent wins fresh. Every win here has:

- A verified mapping to a real CreativeStack skill
- A time-to-value estimate
- An effort rating
- Applicable user types and disciplines
- A before/after one-liner for the output

Inventing fresh wins produces slop and often recommends skills that
don't exist. This library is the defense against that.

---

## Selection rules

When running the audit, pick 3-5 quick wins using this filter:

1. **Category match first** — prioritise wins that lift the user's
   lowest-scoring category (or lowest 2 categories if close)
2. **Discipline match second** — filter to wins where the user's
   discipline is listed (or "all")
3. **User type match third** — filter out wins that don't apply
   (e.g. resource-conflict wins for solo freelancers)
4. **Effort sort** — among eligible wins, prefer L-effort over
   M-effort over H-effort
5. **Skill diversity** — don't recommend the same skill twice
6. **Advanced-user filter** — if the user is AI-advanced (from
   the intake question), skip any win tagged `beginner-only` and
   pick from `intermediate` or `advanced` tier

**Maximum 5 wins in output.** More than 5 = paralysis.

If fewer than 3 wins match, widen the filter (drop discipline
match, then drop tier match) before giving up. If still fewer than
3, note it in the output and suggest brain setup as the first move.

---

## Wins by category

Each win has this schema:

```
### {Number}. {Win title}
- **What it looks like:** {one sentence}
- **Time to value:** {First value this week / This month / This quarter}
- **Effort:** L / M / H
- **Skill:** `/creativestack:{skill-name}`
- **User types:** {list or "all"}
- **Disciplines:** {list or "all"}
- **Tier:** beginner / intermediate / advanced / beginner-only
- **Before/after:** {one-liner for the output}
```

---

### Ops & Admin wins

#### 1. Automate SOW generation from your brand voice
- **What it looks like:** Turn a sharpened brief into a SOW with your standard terms, scope, and milestones in under 10 minutes
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:sow-generator`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** 2-hour SOW drafting → 10-minute review of a structured draft

#### 2. Turn raw time tracking into a profitability read
- **What it looks like:** Feed logged hours and get margin, burn rate, scope creep flags, and budget projection
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:timesheet-summary`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** "Are we profitable on this?" answered quarterly → answered weekly

#### 3. Stop double-booking the team
- **What it looks like:** Run a resource conflict check against your roster and upcoming work to catch overbooking before it bites
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:resource-conflict`
- **User types:** studio, agency, in-house, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Conflict discovered Monday morning → conflict flagged two weeks ahead

#### 4. Generate realistic project timelines in minutes
- **What it looks like:** Produce a timeline with milestones, dependencies, parallel workstreams, and slip scenarios from a brief
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:timeline-generator`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Timeline built in Excel by one person → timeline generated, reviewed, adjusted

#### 5. Kick off new projects properly in 15 minutes
- **What it looks like:** Generate a kickoff pack with RACI, timeline, risks, internal brief, workshop agenda, and Slack announcement
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:project-kickoff`
- **User types:** studio, agency, in-house, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Kickoff meeting organised ad hoc → structured kickoff pack every time

---

### Creative Workflow wins

#### 6. Sharpen incoming briefs before the team sees them
- **What it looks like:** Audit a client brief for gaps, assumptions, contradictions, and red flags; get a client clarification message drafted ready to send
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:brief-sharpener`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Team starts work on half-finished brief → team starts work on sharpened brief with client questions already answered

#### 7. Build real briefs from messy inputs
- **What it looks like:** Turn emails, Slack threads, and meeting notes into a properly structured creative brief with tension, real objective, audience depth, and a single-minded thought
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:creative-brief`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Brief written from scratch in 3 hours → brief drafted and edited in 30 minutes

#### 8. Consolidate feedback rounds without losing context
- **What it looks like:** Turn scattered feedback from multiple stakeholders into a deduplicated, ranked action list — with contradictions flagged
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:feedback-consolidator`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Conflicting feedback resolved by memory → conflicts surfaced explicitly, real ask extracted

#### 9. Research design territories without opening 40 browser tabs
- **What it looks like:** Structured design research across six modes — brand deep-dive, visual landscape, cultural territories, craft deep-dive, pattern research, audience visual diet
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:design-research`
- **User types:** all
- **Disciplines:** brand, digital, motion, illustration, multi-disciplinary
- **Tier:** intermediate
- **Before/after:** Half a day of browser tabs → structured research board with counter-references

#### 10. Build creative strategy that isn't theatre
- **What it looks like:** Pick a strategy framework, build a strategy on a page, run the anti-slop checklist
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:creative-strategy`
- **User types:** all
- **Disciplines:** brand, strategy, multi-disciplinary
- **Tier:** intermediate
- **Before/after:** Strategy deck that no one uses → one-page strategy the creative team actually references

---

### Client / Stakeholder Comms wins

#### 11. Draft client status updates in 5 minutes
- **What it looks like:** Generate client-ready, leadership-ready, and creative-team status updates with engagement health signals and trend tracking
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:status-update`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** 45 minutes drafting a status update → 5 minutes reviewing a drafted one

#### 12. Turn meeting transcripts into actionable notes
- **What it looks like:** Transform recordings into structured notes with actions, owners, scope change flags, tone detection, and timeline impact
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:meeting-notes`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** "I'll send notes later" that never arrives → structured notes out within 20 minutes of the call

#### 13. Generate proposals that don't feel boilerplate
- **What it looks like:** Turn a brief into a proposal with scope, approach, timeline, budget framework, and case study integration
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:proposal-generator`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Proposal written from scratch every time → proposal built from brain and adapted

#### 14. Respond to RFIs without losing weekends
- **What it looks like:** Draft RFI/EOI responses from case studies, bios, and methodology with word count tracking and compliance scoring
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:rfi-response`
- **User types:** studio, agency, company
- **Disciplines:** all
- **Tier:** intermediate
- **Before/after:** Two weekends on an RFI response → one working day

---

### Knowledge & IP wins

#### 15. Capture case studies while the work is fresh
- **What it looks like:** Turn raw project data into a structured case study with Challenge/Approach/Solution/Results and an SEO version
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:case-study`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Case studies written 6 months late or never → case studies captured within 2 weeks of close

#### 16. Run post-mortems that compound instead of rant
- **What it looks like:** Structured retrospective — what worked, what didn't, what to carry forward — written to the brain for future projects to inherit
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:post-mortem`
- **User types:** all
- **Disciplines:** all
- **Tier:** intermediate
- **Before/after:** "Lessons learned" that aren't → learnings captured to the brain and applied to the next project

#### 17. Document your tone of voice as a living asset
- **What it looks like:** Sharpen your tone of voice guidelines with consistency checking, voice spectrum positioning, and channel-specific examples
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:update-voice`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** intermediate
- **Before/after:** Tone of voice lives in someone's head → tone lives in the brain and drives every skill

#### 18. Build the brain that makes everything else compound
- **What it looks like:** Configure your CreativeStack Brain — profile, team, tone of voice, clients, and tools — so every skill produces personalised output
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:setup`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner-only
- **Before/after:** Generic skill outputs → every skill applies your context, voice, and history

#### 19. Turn brand guidelines into a working document
- **What it looks like:** Structured brand guidelines with completeness scoring, digital-first sections, and accessibility checks
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:brand-guidelines`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** brand, multi-disciplinary
- **Tier:** intermediate
- **Before/after:** Brand guidelines PDF nobody opens → living brand doc that the whole team uses

---

### Commercials & Intelligence wins

#### 20. See project profitability in real time
- **What it looks like:** Analyse project and retainer profitability from logged hours, rates, and fees with margin analysis and scenario modelling
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:project-profitability`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** intermediate
- **Before/after:** Profitability checked at year-end → known continuously, with scenario modelling

#### 21. Research prospects properly before the pitch
- **What it looks like:** Generate research packs on prospects — positioning, campaigns, decision-makers, pain points, fit-ranked angles
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:pitch-research`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** Pitch preparation by Googling for 2 hours → structured dossier with killer hook identified

#### 22. Detect resource conflicts before they bite
- **What it looks like:** Analyse team roster and upcoming commitments to flag overbooking, capacity gaps, and burnout indicators
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:resource-conflict`
- **User types:** studio, agency, in-house, company
- **Disciplines:** all
- **Tier:** intermediate
- **Before/after:** Resource conflicts discovered at crisis point → flagged two weeks ahead with rebalancing options

#### 23. Audit agency AI readiness quarterly (the compounding play)
- **What it looks like:** Re-run this skill every 3-6 months and compare delta against the last audit — measurable progress you can show leadership
- **Time to value:** First value this quarter
- **Effort:** L
- **Skill:** `/creativestack:ai-audit`
- **User types:** all
- **Disciplines:** all
- **Tier:** intermediate
- **Before/after:** "AI strategy" exists in vibes → measurable quarterly progress across 5 categories

---

### Cross-category wins

#### 24. Sharpen your agency tone of voice for AI
- **What it looks like:** Make your tone of voice explicit enough that AI-drafted client comms actually sound like you
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:update-voice`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** all
- **Tier:** advanced
- **Before/after:** AI comms that feel generic → AI comms that sound like you

#### 25. Consolidate multiple rounds of client feedback into one list
- **What it looks like:** Turn 3 rounds of conflicting feedback into a single deduplicated action list with stakeholder influence mapping
- **Time to value:** First value this week
- **Effort:** L
- **Skill:** `/creativestack:feedback-consolidator`
- **User types:** all
- **Disciplines:** all
- **Tier:** beginner
- **Before/after:** "Which feedback do I apply?" as a recurring question → one action list with contradictions flagged

#### 26. Run a brand competitor audit in an afternoon
- **What it looks like:** Positioning map, visual identity scoring, digital maturity assessment, messaging themes, and white space analysis
- **Time to value:** First value this week
- **Effort:** M
- **Skill:** `/creativestack:competitor-audit`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** brand, strategy, multi-disciplinary
- **Tier:** beginner
- **Before/after:** Competitive context guessed at → structured audit with evidence

#### 27. Build a trend report that isn't AI slop
- **What it looks like:** Research a category with visual evidence, velocity scoring, capability matching, and counter-trend analysis
- **Time to value:** First value this month
- **Effort:** M
- **Skill:** `/creativestack:trend-report`
- **User types:** freelancer, studio, agency, company
- **Disciplines:** brand, strategy, multi-disciplinary
- **Tier:** intermediate
- **Before/after:** Trend deck of screenshots → trend report with evidence, velocity, and counter-trends

---

## Output format for each selected win

When writing the quick wins into the audit output, use this shape
(don't dump the full schema — just the user-facing bits):

```markdown
### {Win title}
**Category lifted:** {category} | **Effort:** {L/M/H} | **Time to value:** {phase}

{Before/after one-liner}

**Run it now:** `/creativestack:{skill-name}`
```

Don't cite the tier label in output (it's for selection only).
Don't cite which wins were filtered out (noise).

---

## Maintenance

When a new CreativeStack skill ships, add its wins here so the
audit automatically learns to recommend it. This file is a growing
asset — the library getting richer makes the audit get better
without editing the main body.

**Adding a win:**
1. Pick the primary category it lifts
2. Write the schema block per the template above
3. Cross-check user types and disciplines against the skill's own metadata
4. Save a before/after one-liner that passes the "would a creative say this?" test
