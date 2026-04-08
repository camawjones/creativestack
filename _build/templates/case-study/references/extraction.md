# Extraction from the Brain

This is the operational core of the skill. Most case studies don't get
written because the **inputs** don't exist in one place. They're scattered
across the brief, meeting notes, Slack, the team's memory, the work itself,
and the client's thank-you email.

If the project ran through CreativeStack, the material is already there —
in the brain. This file defines how to extract it.

The extraction happens in **one pass, in a strict order**. If a source
doesn't exist, the skill notes the gap and moves on. At the end, the
skill tells the user what it found and what's missing, so the user can
fill specific gaps rather than re-entering everything.

---

## Extraction order

Read files in this order. Each source contributes to specific case study
sections. Gaps trigger fallback prompts only for what's missing.

### 1. `projects/{slug}-brief.md` — THE CHALLENGE SOURCE

**Primary source for: Challenge, Approach framing, Objective, Audience**

The brief is where the case study Challenge literally lives. The Tension
section of the brief, the Real Objective, the Insight, and the Desired
Response map directly onto the Challenge and Approach sections of the
case study.

**What to extract:**

| Brief section | Feeds case study section |
|---|---|
| § The Tension | Challenge — the gap that drove the project |
| § Real objective (not stated) | Challenge — what the client was actually trying to achieve |
| § Target audience — Insight | Challenge — the non-obvious truth that unlocked the work |
| § Single-minded thought | Approach — the central idea the work was built around |
| § Desired response | Approach — what the work needed to achieve |
| § Brand tone & personality | Approach — creative direction context |
| § Reasons to believe | Results — what the audience was given to believe |
| § Stakeholders | Approval workflow targets |

If the brief has a clear Tension and Single-Minded Thought, the Challenge
and Approach sections of the case study are 70% written.

**If no brief file exists:** flag it as the biggest gap. The case study
Challenge section will need manual input. Suggest running
`/creative-brief` retrospectively if the project is recent
enough that the info is still fresh.

### 2. `projects/{slug}.md` — project state

**Primary source for: Stakeholders, Timeline, Project scope, Activity arc**

**What to extract:**

| State section | Feeds case study section |
|---|---|
| Frontmatter: created → closed dates | Project duration, timeline |
| Stakeholders | Client team credits, approvers |
| Team list | Agency team credits |
| Deliverables | Solution — what was made |
| Budget & Pace | Commercial context (for internal-only case studies) |
| Engagement Health history | Client sentiment arc ("started enthusiastic, stayed engaged through delivery") |
| Recent Activity log | Timeline of key moments |
| Open → Resolved Decisions | The hard calls the team made |
| Risks → flagged → resolved | What was hard (with evidence) |

**Engagement Health trajectory is gold.** A project that shows
`enthusiastic → enthusiastic → cautious → enthusiastic` tells a story: the
team navigated a difficult middle period. That's the "what was hard"
section, sourced directly from the trajectory.

### 3. `projects/{slug}-meetings.md` — client quotes and sentiment

**Primary source for: Client quotes, sentiment trajectory, decision moments**

**What to extract:**

| Meeting log element | Feeds case study section |
|---|---|
| Verbatim client quotes (marked in meeting logs) | Pull quotes (the #1 scarce resource in case studies) |
| Sentiment scores per meeting | Sentiment trajectory → story arc |
| Key decisions | Approach — the pivotal calls |
| "What only the brain caught" section | Unexpected insights that made it into the work |
| Patterns matched from learnings | Client relationship depth signals |

**Hero quote extraction:**

Scan all meetings for client quotes. Score each candidate on:
- **Specificity** — does it name the work or the impact?
- **Emotional weight** — does it convey feeling, not just approval?
- **Brandedness** — could only this client say this?
- **Length** — 15-30 words is the sweet spot for a pull quote

Rank the top 3-5 candidate quotes. The highest-scoring one becomes the
**hero quote** for the case study. The others become secondary pull quotes.

**If no meeting log:** this is the biggest gap after the brief. Pull
quotes are the hardest thing to fabricate and the most valuable. Prompt
the user: "I couldn't find any client quotes in the meeting log. Do you
have any quotes from emails, Slack, or the post-mortem? Even rough
paraphrases help — I can suggest them for the client to sign off on."

### 4. `projects/{slug}-copy-deck-v*.md` — the work that shipped

**Primary source for: Solution — description of what was made**

If there are multiple versions, use the highest version (the one that
shipped). The copy deck tells you exactly what the audience saw.

**What to extract:**

| Copy deck element | Feeds case study section |
|---|---|
| Frontmatter: atoms_total, overall_score | Scope of the deliverable |
| The single-minded thought | Confirms the thread from brief → work |
| Hero headline | Opens the Solution description — quote it directly |
| Body samples | Solution — what the audience read |
| Voice analysis | Solution — craft detail |
| Claims/proof pairing | Results context — what the audience was given to believe |

**Direct quotes from the work itself** are powerful in case studies.
Instead of paraphrasing what the work did, quote the actual headline that
shipped. "The campaign ran under the headline: 'Run faster. Without the
shoes you have to coach.'"

### 5. `projects/{slug}-competitor-audit.md` — category context

**Primary source for: Challenge framing, why the work mattered**

The audit tells you what the category looked like when the work entered
it. That's context the reader needs to appreciate the work.

**What to extract:**

| Audit section | Feeds case study section |
|---|---|
| Category codes analysis | Challenge framing — "most brands in this category did X, we did Y" |
| The 3 brands to watch | Challenge context — what the competitive landscape looked like |
| Vulnerability archetypes | Challenge framing — what opportunities existed |
| Code-break opportunities | Approach — if the work took a code-break, name it explicitly |

A case study that opens with "at the time, every brand in this category
was doing X" and then shows how the work broke that code is far more
compelling than a case study that describes the work in isolation.

### 6. `post-mortem` output (if in the session or logged)

**Primary source for: What was hard, what the team learned, unexpected outcomes**

If `/post-mortem` was run for this project, the material is
in the session or in `learnings.md`. Pull:

| Post-mortem element | Feeds case study section |
|---|---|
| What worked | Results + Approach |
| What didn't work | What was hard (the honesty section) |
| Key results | Results |
| Lessons | Context for the narrative |
| Client relationship assessment | Tone of the case study (warm vs formal) |

### 7. `/project-profitability` output (if available)

**Primary source for: Commercial metrics (for internal case studies or
investor-facing work; usually excluded from public case studies)**

| Profitability element | Feeds case study section |
|---|---|
| Margin | Internal case study only — rarely published |
| Fee vs industry benchmark | Value positioning (carefully framed) |
| Delivery efficiency | Craft signal — under-budget or on-budget |

**Privacy rule:** never include fee, margin, or commercial metrics in a
public case study without explicit user confirmation. Surface them for
internal case studies only.

### 8. `feedback-consolidator` outputs (if any)

**Primary source for: Sentiment arc, decision moments, client voice**

If the project ran through feedback consolidation, the outputs contain:
- The real ask (useful for narrative framing)
- Archetype detection (useful for describing the client relationship)
- Stakeholder influence map (useful for crediting the right people)
- Round-by-round sentiment

### 9. `case-studies.md` — existing portfolio

**Primary source for: Style inference, portfolio gap analysis**

Read ALL existing case studies in the portfolio. Extract:

**Style signals:**
- Sentence length (average)
- Vocabulary level (technical vs plain)
- Voice (first person vs third, active vs passive)
- Structural conventions (which sections are longest, heading style)
- How metrics are framed
- How quotes are introduced
- How the agency refers to itself ("we" / "the studio" / "the team")

Match the new case study to the existing style so the portfolio reads as
a cohesive body of work, not a patchwork.

**Portfolio gap analysis:**

For this project's type, check coverage in the existing portfolio:

- **How many case studies exist for this project type?**
- **How many in this client's industry?**
- **How many using similar services?**

Three states:
- **Underrepresented** (0-1 case studies of this type) → this case study fills a gap, prioritise it
- **Balanced** (2-3 of this type) → useful addition, no priority
- **Overrepresented** (4+ of this type) → the portfolio already over-indexes here. Consider whether a different project would be a better use of the effort.

Flag overrepresentation explicitly:

> "Your portfolio already has 5 brand identity case studies and 0 campaign case studies. This project is brand identity. It's a good project but not a portfolio-balancing one. If you have a recent campaign project, writing that one first would strengthen your portfolio more. Continue with this one anyway?"

### 10. `tone-of-voice.md` — writing voice

**Primary source for: How the case study itself is written**

This is how the skill writes, not how the brand speaks. Applied throughout
the case study's own prose.

If the brain also contains previous case studies, the case studies take
**precedence for structure and pacing** — tone-of-voice governs word
choice and personality.

### 11. `methodology.md` — agency framing

**Primary source for: How the Approach section is described**

If the agency has a named methodology (Discover/Define/Design/Deliver, or
similar), the Approach section should structure around it. Make the
methodology visible — it's part of the agency's IP.

### 12. `clients.md` — relationship context

**Primary source for: Relationship framing**

Check how long the client has been with the agency. Use this to frame the
case study appropriately:

- **First project** — frame as "when {client} approached us"
- **Long relationship** — frame as "as {client}'s brand partners since {year}"
- **Returning client** — frame as "after the success of {previous work}"

### 13. `team.md` — team credits

**Primary source for: Team credits section**

Pull the team members who worked on this project from the project state
file's team list, and cross-reference against `team.md` for correct
titles and role descriptions. Ensure credits are accurate.

---

## Extraction output format

After running the extraction, the skill should produce a **coverage
report** before writing the case study:

```markdown
## Extraction Coverage

| Source | Found? | What it contributed |
|---|---|---|
| Brief | ✓ | Challenge, tension, SMT, audience, desired response |
| Project state | ✓ | Stakeholders, timeline, sentiment trajectory |
| Meeting log | ✓ | 4 candidate client quotes (top quote: "...") |
| Copy deck (v1.3) | ✓ | Final headline, body samples |
| Competitor audit | ✗ | No audit for this category |
| Post-mortem | ✓ | What was hard, key learnings |
| Profitability data | ✗ | Not run for this project |
| Existing portfolio | ✓ | 3 previous case studies analysed for style (avg sentence 15 words, first-person voice, metrics-as-pull-quotes convention) |
| Tone of voice | ✓ | Applied to writing |
| Methodology | ✓ | Approach structured as Discover → Define → Design → Deliver |

**Gaps:**
- No competitor audit — Challenge framing will be lighter on category context
- No profitability data — no commercial metrics in the case study (usually fine for public case studies)

**Ready to write:** Yes. The brain has enough material. Proceeding.
```

If the extraction finds **critical gaps** (no brief, no client quotes, no
description of the work), the skill should pause and ask before proceeding:

> "I couldn't find enough material to write a real case study:
> - No brief for this project → Challenge is blank
> - No meeting log → no client quotes
> - No copy deck → I don't know what the work looks like
>
> Two options:
> 1. Run `/creative-brief` and `/meeting-notes` retrospectively for this project to populate the brain
> 2. Paste what you have (rough brief, client quotes, description of the work) and I'll work from that — but the case study will be shorter and less rich
>
> Which do you want?"

---

## Fallback extraction

If no project exists in the brain (standalone case study request):

1. Ask the user to name the project and client
2. Ask for: project type, the brief summary, the challenge in 1-2 sentences,
   what was delivered, key results, any client quotes available
3. Run the standard extraction against `case-studies.md` for style and gap
   analysis
4. Produce the case study from pasted inputs

This is the **From inputs** fallback — the current behaviour of the skill.
It's the fallback, not the default.

---

## Handling of partial information

Most real projects don't have complete brain coverage. Handle partial
information gracefully:

- **Brief exists but no tension surfaced** → write the challenge from the brief's background and objectives; note the missing tension as a soft gap
- **Meeting log exists but no quotes** → suggest 2-3 placeholder quotes the team could propose to the client
- **Project state exists but no engagement health** → skip the sentiment arc; write the case study flatly
- **Copy deck exists but old version** → check the frontmatter version; if old, ask whether it's the shipped version
- **Post-mortem ran but was thin** → use what's there; don't invent struggles that didn't happen

The principle: **extract what exists, flag what's missing, never fabricate**.
