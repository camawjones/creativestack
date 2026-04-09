# AI Maturity Rubric

5 categories, each scored 1-5 using the CMMI-inspired maturity
ladder. Board-ready and built for radar-chart output. Each category
has a **Protected Zone** column — the things in that category that
should stay human, not a scoring blank.

**Rubric version:** `v2.0` (update when categories, definitions, or
levels change — audits saved to the brain record the rubric version
so delta comparisons stay honest).

---

## The 5 categories

### 1. Ops & Admin

**What it measures:** The business of running the business — quoting,
invoicing, timesheets, scheduling, the friction layer that isn't
creative work.

**Why it matters:** This is where creative professionals lose the
most hours to non-billable drag. It's also the safest category to
automate because it's furthest from the creative step.

**What good looks like:** Clear process for quoting and proposals,
automated or templated invoicing, time tracked consistently enough
to inform decisions, scheduling that doesn't depend on one person
holding it in their head.

**Protected zone:**
- Pricing judgment on ambiguous briefs
- Client relationship calls (who to take on, who to decline)
- Decisions about team structure and roles

**Maps to skills:** `/sow-generator`, `/project-profitability`, `/timesheet-summary`, `/resource-conflict`, `/proposal-generator`

---

### 2. Creative Workflow

**What it measures:** The path from brief landing to work delivered
— brief intake, concept development, iteration, review, handoff.
Excludes the creative step itself.

**Why it matters:** This is where creatives are most protective,
and rightly so. The goal isn't to automate the work — it's to remove
the friction *around* the work so more time is available for the
creative step.

**What good looks like:** Briefs are sharpened before the team
starts. Concept reviews are structured. Feedback is captured and
deduplicated. Handoffs between disciplines are clean. Nobody is
doing the same thinking twice because prior work wasn't documented.

**Protected zone:**
- Concept development
- Craft decisions — typography, composition, motion, voice
- Taste-level judgments
- The critique/review conversation itself (AI captures, humans decide)

**Maps to skills:** `/brief-sharpener`, `/creative-brief`, `/feedback-consolidator`, `/creative-strategy`, `/design-research`

---

### 3. Client / Stakeholder Communication

**What it measures:** Proposals, status updates, presentations,
feedback loops, reporting. Everything that happens between the
creative team and the people they answer to.

**Why it matters:** Communication drag is the silent killer of
creative projects. A 5-minute status update that takes 45 minutes
to write happens 40 times a year per project. The math is brutal
and the fix is easy.

**What good looks like:** Proposals built from a template with
client-specific overlays. Status updates drafted quickly and
consistently. Meeting notes captured and shared without a separate
write-up step. Feedback rounds don't lose context between sessions.

**Protected zone:**
- The actual conversations — pitches, difficult calls, creative
  presentations
- Relationship judgment on what to share vs. hold back
- Tone calibration for sensitive situations

**Maps to skills:** `/status-update`, `/meeting-notes`, `/proposal-generator`, `/rfi-response`, `/feedback-consolidator`

**Note for in-house teams:** This category becomes "Stakeholder
Communication" — replace "client" with "stakeholder" throughout.

---

### 4. Knowledge & IP

**What it measures:** Case studies, methodology, tone of voice,
process documentation, institutional memory. The stuff that makes
the *next* project easier because of what you learned on the last.

**Why it matters:** This is the most underinvested category in the
creative industry, and also the highest-leverage. A creative
business that captures and reuses its learning compounds; one that
doesn't restarts from zero every project.

**What good looks like:** Case studies written within 2 weeks of
project close. Methodology documented enough that new team members
can follow it. Tone of voice captured as a live document. Learnings
fed back into briefs, pitches, and proposals automatically.

**Protected zone:**
- The actual creative methodology (what AI captures is the
  description of it, not the methodology itself)
- Taste archives and inspiration libraries (AI can organise, humans
  curate)
- Personal craft rituals

**Maps to skills:** `/case-study`, `/post-mortem`, `/update-voice`, `/setup-brain`, `/brand-guidelines`

---

### 5. Commercials & Intelligence

**What it measures:** Profitability tracking, resource planning,
pipeline visibility, decision data. The financial and operational
intelligence layer.

**Why it matters:** Most creative businesses are flying blind on
profitability until quarterly reviews. By then the damage is done.
AI makes continuous visibility cheap for the first time.

**What good looks like:** Project profitability is known in real
time, not at year-end. Pipeline is tracked as more than a list of
hopes. Resource capacity is forecast, not reacted to. Decisions
about taking on work are informed by data, not vibes.

**Protected zone:**
- Strategic business decisions (growth, hiring, positioning)
- Client selection judgment
- Pricing as a creative decision, not a spreadsheet output

**Maps to skills:** `/project-profitability`, `/timesheet-summary`, `/resource-conflict`, `/pitch-research`

**Note for in-house teams:** This category shifts to "Operational
Intelligence" — pipeline becomes "backlog of stakeholder requests",
profitability becomes "cost-per-output or team capacity efficiency".

---

## Scoring ladder

Each category is scored 1-5 using the CMMI-inspired maturity model:

| Score | Level | Definition |
|---|---|---|
| 1 | **Manual** | No systems. Everything depends on individual effort and memory. One person leaving breaks the workflow. |
| 2 | **Ad hoc** | Some tools or templates exist but are used inconsistently. The approach varies by project and by person. |
| 3 | **Defined** | Clear processes exist and are mostly followed. Someone new could learn the approach from documentation. |
| 4 | **Managed** | Processes are tracked and measured. Decisions are informed by data, not anecdote. |
| 5 | **Optimised** | Continuous improvement loop. Data-driven refinement. The system gets better over time without a person manually tuning it. |

### Scoring discipline

- **Don't grade generously.** Most creative businesses score 2-3 on
  most categories. Scoring everything 4+ makes the audit useless.
- **Don't grade harshly.** A freelancer who has a spreadsheet they
  actually use is at least a 3, not a 1, on Ops & Admin.
- **Calibrate to reality.** A 5-person studio at level 5 is different
  from a 50-person agency at level 5. Use the benchmarks file to
  anchor scores against realistic expectations for the user's
  discipline and size.
- **Base scores on evidence from the conversation.** If the user
  said "we track hours on a spreadsheet but nobody looks at it",
  that's a 2 on Commercials & Intelligence, not a 3.
- **Ask "is this repeatable?" for every category.** Level 3+ requires
  that someone new could pick up the process without inventing it.

---

## Protected Zone scoring

Each category has a second column: **Protected Zone Strength**
(Strong / Partial / Weak).

**Strong:** The user has clearly articulated what they won't
automate and why. Their creative culture has a defended perimeter.

**Partial:** The user has instincts about what to protect but
hasn't named them. They're vulnerable to slope — creep toward
automating things that should have stayed human.

**Weak:** The user has no explicit protected zone. They're at risk
of automating the wrong things and losing the creative culture
that makes them competitive.

**Why this matters:** The "protect your creative step" framing is
what separates CreativeStack from tools that just promise 10x
output. Making Protected Zone part of the scoring reinforces this
on every audit. A user with strong automation but weak protected
zones is in more danger than a user with weaker automation but
strong protected zones.

---

## Aggregate score

**Overall maturity:** average of the 5 category scores, to 1 decimal

**Maturity level:**
- 1.0-1.9 → **Starting** (most creative practices without explicit
  process)
- 2.0-2.9 → **Emerging** (has tools, inconsistent use)
- 3.0-3.9 → **Established** (repeatable processes, some data)
- 4.0-4.9 → **Advanced** (tracked, measured, optimised in parts)
- 5.0 → **Leading** (continuous improvement across the board — rare)

**Protected zone headline:**
- 5/5 Strong → "Defended"
- 3-4/5 Strong → "Mostly defended, one or two gaps"
- 1-2/5 Strong → "Exposed — explicit protected zone work needed"

The overall maturity and protected zone headline together give a
two-dimensional read: "you're at Established/Exposed, which means
your systems are good but your creative culture is at risk."

---

## Delta tracking

When a prior audit exists in `audits/`, the skill should:

1. Read the most recent audit's per-category scores and rubric version
2. If the rubric version matches, show a delta column per category
3. If the rubric version differs, note the mismatch and show absolute
   scores only with a note that direct comparison isn't possible
4. Highlight categories that moved 2+ points (positive or negative)
5. Note the time gap between audits

Delta is the single most valuable output for returning users. A
creative who sees measurable progress over two runs is the most
qualified consulting lead you can generate.

**Output format for delta:**

```
| Category | Prior | Current | Δ |
|---|---|---|---|
| Ops & Admin | 2.0 | 3.0 | ↑ +1.0 |
| Creative Workflow | 3.0 | 3.0 | → 0 |
| ... |
```

---

## Per-discipline weighting (optional overlay)

For some disciplines, certain categories matter more than others.
This overlay adjusts which categories are highlighted in the output
without changing the scoring itself:

| Discipline | Emphasised categories |
|---|---|
| Brand / identity | Knowledge & IP, Creative Workflow |
| Digital product | Creative Workflow, Commercials & Intelligence |
| Motion / animation | Ops & Admin (asset pipelines), Creative Workflow |
| Copy / content | Knowledge & IP, Client Comms |
| Illustration | Ops & Admin (reference mgmt), Knowledge & IP |
| Strategy / research | Knowledge & IP, Client Comms |
| Multi-disciplinary | All weighted equally |

"Emphasised" means the output leads with these categories and the
quick-wins library prioritises wins that lift them. Lower-scoring
categories outside the emphasised set still get flagged but as
secondary priorities.

---

## Output format for the rubric

```markdown
## Maturity Scoring

**Overall maturity: {X.X}/5** — {level label}
**Protected zone: {headline}**

| Category | Score | Level | Protected Zone | Summary |
|---|---|---|---|---|
| **Ops & Admin** | {1-5}/5 | {level} | {Strong/Partial/Weak} | {one line, using user's own words} |
| **Creative Workflow** | {1-5}/5 | {level} | {Strong/Partial/Weak} | {one line} |
| **{Client/Stakeholder} Communication** | {1-5}/5 | {level} | {Strong/Partial/Weak} | {one line} |
| **Knowledge & IP** | {1-5}/5 | {level} | {Strong/Partial/Weak} | {one line} |
| **Commercials & Intelligence** | {1-5}/5 | {level} | {Strong/Partial/Weak} | {one line} |

{If prior audit exists and rubric version matches, add the delta column.}

**Radar summary:**
```
Ops & Admin       {bar: ███░░} 3/5
Creative Workflow {bar: ████░} 4/5
Client Comms      {bar: ██░░░} 2/5
Knowledge & IP    {bar: ██░░░} 2/5
Commercials       {bar: ███░░} 3/5
```
```

---

## When to skip the rubric

Only skip the rubric in these cases:
1. **Triage mode of another skill** is calling ai-audit for a
   one-category check (e.g. "just tell me about Knowledge & IP")
2. **User explicitly asks for opportunities only** without scoring
   (rare but valid)

Never skip silently. If scoring is skipped, note it in the output
and offer to run a full audit later.

---

## Confidence labels

If the conversation produced thin evidence (user gave very short
answers or the brain has no context), the scoring is directional
only. Flag with:

> **Confidence:** Low — based on brief answers without brain
> context. Treat scores as directional. Running `/setup-brain`
> first would sharpen the next audit significantly.

Never score confidently off thin evidence.
