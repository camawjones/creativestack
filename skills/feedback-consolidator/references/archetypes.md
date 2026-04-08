# Feedback Archetypes

Creative feedback follows recognisable patterns. Experienced PMs and creative
directors learn to spot them; everyone else gets hit by them. This file
catalogues 8 archetypes, with detection signals and response playbooks.

The skill should run archetype detection **automatically** on every Consolidate
run. A detected archetype is one of the most valuable outputs in the skill —
naming the pattern helps the team respond correctly, not reactively.

Archetypes are not mutually exclusive. A single feedback round can exhibit
2-3 simultaneously. Surface all detected archetypes, ordered by severity.

---

## The 8 archetypes

### 1. The Swerve

**What it is:** Client changes their mind fundamentally mid-project. The direction
they agreed to in the brief or kickoff is no longer the direction they want.

**Detection signals:**
- Feedback contradicts an explicitly agreed decision from a previous round
  or kickoff meeting (cross-reference `projects/{slug}-meetings.md`)
- Language like "I've been thinking", "coming back to this with fresh eyes",
  "after talking to [new person]"
- New stakeholder voice appearing for the first time in round 2+
- Complete topic shift from previous rounds (e.g. rounds 1-2 were all about
  typography, round 3 is suddenly about messaging)

**Severity:** High. A swerve almost always means scope change, timeline impact,
and budget impact.

**Response playbook:**

1. **Name it, don't fight it.** Reply acknowledging that the direction has
   shifted: "We're hearing a new direction — want to confirm before we commit
   the team?" Don't pretend it's continuous with the previous rounds.
2. **Quantify the cost.** Use rate-card.md to price what the swerve implies.
   Present as a fee + timeline impact, not as a complaint.
3. **Offer two paths.** A) Execute the swerve with an updated fee and timeline.
   B) Stay on the agreed direction. Let the client decide explicitly.
4. **Get the new direction in writing.** If A), get an email confirming the
   new scope before any work begins.
5. **Don't absorb the cost silently.** Swerves absorbed silently become
   resentment that poisons the relationship.

**What NOT to do:**
- Don't just do the new thing and hope it works
- Don't argue that it contradicts the brief without offering a path forward
- Don't frame the swerve as the client being difficult — they often don't
  realise they've swerved

---

### 2. The Committee

**What it is:** Too many voices, no clear direction. Multiple stakeholders with
conflicting feedback and no one empowered to resolve.

**Detection signals:**
- Feedback comes from 4+ different people in a single round
- Stakeholders contradict each other directly ("make it louder" vs "too shouty")
- No single person has last-word authority in the feedback chain
- Feedback phrased as "we think..." or "the team feels..." without attribution
- Different people prioritise different things (one focused on messaging,
  one on colour, one on format)

**Severity:** High when it repeats. Medium on first occurrence.

**Response playbook:**

1. **Do NOT try to satisfy everyone.** Every attempt to reconcile committee
   feedback produces worse work. Name the problem.
2. **Ask for a decision-maker.** "To move forward efficiently we need one
   voice on creative decisions — who holds that authority from your side?"
3. **Use the Stakeholder Influence Map** to recommend who the agency should
   prioritise in the meantime. Escalate to the known decision-maker if one
   exists.
4. **Propose a single review meeting** instead of async feedback. Committee
   dynamics dissolve when people are in the same room and forced to agree
   out loud.
5. **Document the conflicting feedback explicitly in the internal output.**
   Don't water it down to "mixed feedback" — be specific about who said what.

**What NOT to do:**
- Don't silently try to satisfy all voices at once
- Don't blame the client for being disorganised
- Don't ask each stakeholder individually for clarification (it multiplies
  the problem)

---

### 3. Compound Notes

**What it is:** A long list of "small tweaks" that collectively amount to a
redesign. Each item sounds minor; together they're 3 days of senior work.

**Detection signals:**
- 15+ individual feedback items in a single round
- Each item is framed as "just" or "small" or "quick"
- Items touch multiple systems (colour, type, layout, messaging, hierarchy)
  — changing one implies changing others
- Hours estimate (using rate-card) > 15% of original project budget

**Severity:** Medium at first occurrence, High if recurring.

**Response playbook:**

1. **Price the round.** Use rate-card.md. Surface the total in £ or hours,
   not item count. "These 18 items add up to approximately 22 hours of senior
   design time, ~£2,200."
2. **Check the revision cap** in the SOW (or `projects/{slug}.md`). If this
   round would exceed the contracted cap, flag immediately.
3. **Separate refinement from redesign.** Use the brief cross-reference.
   Items that refine the agreed direction are in scope; items that change
   the agreed direction are scope.
4. **Offer a triage conversation.** "Before we work through all 18, can we
   talk about which 5 you'd prioritise? Some of these will force others to
   change, so we want to make sure we're spending time on the right ones."
5. **Propose a cut-off.** "We'll action the top 8 in this round and discuss
   the remainder separately."

**What NOT to do:**
- Don't action the list blindly
- Don't pick and choose silently
- Don't treat all items as equal weight

---

### 4. The Ego Note

**What it is:** Feedback driven by internal politics or personal taste, not the
brief. Often comes from a stakeholder who wants visible influence on the work.

**Detection signals:**
- Feedback contradicts the brief without acknowledging the conflict
- Feedback contradicts past approved decisions
- Language like "in my experience", "I personally think", "when I was at [past company]"
- Comes from a stakeholder who wasn't involved in the brief or kickoff
- The note feels like it's trying to leave a fingerprint on the work rather
  than improve it

**Severity:** Medium. Low if the stakeholder is low-influence; High if they're
the decision-maker.

**Response playbook:**

1. **Don't call it out as ego.** The feedback is real; treat it with respect.
2. **Cross-reference against the brief.** If it contradicts, flag diplomatically:
   "This would change the objective we agreed in the brief — want to update
   the brief, or should we stay on the original direction?"
3. **Surface the trade-off.** Ego notes almost always come at the expense of
   something the client previously cared about. Name the trade-off explicitly.
4. **Use the Stakeholder Influence Map.** If the note is from a passive reviewer
   or along-for-the-ride stakeholder, note it and proceed without actioning.
   If it's from a decision-maker, action selectively and protect the core.
5. **Never capitulate on principle.** Ego-driven feedback tends to escalate
   when agreed to without pushback. Small resistance early prevents large
   fights later.

**What NOT to do:**
- Don't pretend the feedback is strategic when it's clearly taste
- Don't escalate publicly — protect the stakeholder's face
- Don't refuse outright if they're the decision-maker — that's a dead end

---

### 5. The Safe Retreat

**What it is:** Client had courage in the brief, lost it in the review.
Feedback pulls the work toward category norms and away from the ambition
that won the pitch.

**Detection signals:**
- Language like "what if we were more like [competitor]", "is this too
  different", "I'm worried people won't get it"
- References to category conventions ("brands in this space usually...")
- Stakeholder invocations ("the board", "our agency", "my CFO")
- Retreat from specific bold choices that were explicitly agreed
- Often follows a moment of external pressure (board meeting, competitor move,
  press cycle)

**Severity:** High. Safe retreat kills the work's distinctiveness and the
agency's ability to defend it.

**Response playbook:**

1. **Diagnose the real fear.** Safe retreats are almost always driven by a
   specific external trigger. Ask: "What prompted this? Did something come
   up internally?"
2. **Re-anchor to the brief.** Quote the brief's own language about boldness,
   distinctiveness, or ambition. The brief was the pitch's promise — hold it
   up.
3. **Offer a risk mitigation, not a retreat.** "We can add a more
   conservative version for [specific use case] without losing the core idea."
4. **Show the cost of retreat.** If there's room, reference case studies where
   category-norm work failed to differentiate.
5. **Protect the creative team.** A safe retreat crushes morale fast. Name
   it internally so the team knows what's happening.
6. **Escalate if the retreat is from the decision-maker.** This is the right
   time for a principals' conversation.

**What NOT to do:**
- Don't just agree to the retreat because it's easier
- Don't fight without offering an alternative
- Don't weaponise the brief as a "gotcha" — use it as a shared commitment

---

### 6. Bait & Switch

**What it is:** The client agreed to direction A in a previous round, now says
they want direction B. Often framed as "we always wanted B" or "we didn't
really like A."

**Detection signals:**
- Current feedback contradicts explicitly approved previous-round decisions
  (cross-reference `projects/{slug}-meetings.md`)
- Language like "on reflection", "we actually wanted", "we should have said"
- New direction closely matches a route the agency presented but the client
  rejected earlier
- Often happens after the client has seen direction A in a more real context
  (comp, mockup, etc.)

**Severity:** High when budget is committed to direction A; Medium before
production.

**Response playbook:**

1. **Reference the prior approval.** "We have you approving direction A on
   [date] — want to confirm we're changing course?" Non-confrontational but
   firm.
2. **Treat it as a swerve.** Bait & switch is a specific type of swerve and
   gets the same playbook: name it, price it, offer two paths, get the new
   direction in writing.
3. **Assess what can be salvaged.** Direction A work may be partially reusable
   in direction B. Quantify what's reusable and what's scrap.
4. **Protect the team's morale.** The creative team invested in direction A.
   Acknowledge that work internally even if it doesn't ship.
5. **Document the pattern** in `learnings.md § Feedback` under this client.
   Bait & switch is often a client habit — future projects should budget for
   the pattern.

**What NOT to do:**
- Don't pretend direction A didn't happen
- Don't refuse to change direction (that's not your call)
- Don't absorb the cost of rebuilding silently

---

### 7. Relitigation

**What it is:** Client brings back a closed decision from an earlier round.
"Can we revisit the logo mark?" when the logo mark was locked in round 1.

**Detection signals:**
- Feedback item references something marked `Already Approved (Do Not Change)`
  in past consolidations
- Specific phrases: "revisiting", "just one more look at", "I was thinking
  about [closed topic] again"
- Often comes from a stakeholder who wasn't in the meeting where the
  decision was made
- Sometimes comes from the same stakeholder who approved it originally

**Severity:** Medium. High if repeated across multiple rounds on the same item.

**Response playbook:**

1. **Pull the approval trail.** "This was locked in round 1 by [person] on
   [date]. Can we confirm what's changed?"
2. **Ask for a trigger.** What made this come up again? New stakeholder,
   new information, external pressure, cold feet?
3. **If trigger is legitimate, treat as a contained change.** Scope the
   revisiting work, price it, and make it formal.
4. **If trigger is vague** ("just wanted to take another look"), gently
   resist: "We can, but it'll cost [X] and delay [Y] — is that worth it?"
5. **Set a re-lock expectation.** "If we revisit this, it needs to re-close
   before we go back to [current workstream]."

**What NOT to do:**
- Don't silently re-open closed topics
- Don't refuse without offering a path
- Don't let relitigation spread to other closed topics

---

### 8. Preference vs Principle

**What it is:** Personal taste framed as strategic judgement. "I don't think
blue works for a bank" — unclear if that's a real insight or a preference.

**Detection signals:**
- Feedback uses definitive language ("this doesn't work", "you can't do this",
  "nobody does this") without evidence
- The "principle" doesn't appear in the brief or any past research
- The feedback contradicts known category conventions or agency experience
- The feedback is from one person and not echoed by others
- "In my experience" or "as a designer myself" qualifiers

**Severity:** Low to Medium. High only if from the decision-maker.

**Response playbook:**

1. **Separate preference from principle in the output.** Write two lines:
   "Stated as:" (verbatim) and "Likely:" (preference / principle / either).
2. **Ask for the basis.** "Want to tell us more about what's informing that
   view? It'll help us respond." Non-confrontational — it just asks the
   client to explain themselves.
3. **Offer evidence if you have it.** Case studies, brand research,
   competitor examples. Don't win the argument — shift it to facts.
4. **If it's clearly preference, treat it as such.** "We hear you on the
   blue — want us to explore a warmer palette, or keep exploring this one?"
5. **Don't capitulate on principle you can defend.** If the feedback
   contradicts the brief or the strategy, flag it.

**What NOT to do:**
- Don't treat every preference as principle
- Don't treat every principle as preference
- Don't get into an argument about whose taste is better

---

## Archetype detection output

For each detected archetype, the skill should produce:

```markdown
### 🎯 Archetype: {Name}

**Why this is what's happening:** {2-3 detection signals from the specific
feedback, with quotes}

**Severity:** {Low / Medium / High}

**Response playbook:**
{Numbered list from the archetype's playbook, adapted to this specific situation}

**What to avoid:** {Relevant "what NOT to do" items}
```

Surface at most the top 2-3 archetypes. Surfacing all 8 dilutes the signal.

## Cross-project archetype history

Read `learnings.md § Feedback` to see whether this client has exhibited
specific archetypes before:

> "**Pattern alert:** This client has done the Committee archetype on 3 of 4
> past projects (per learnings.md). The playbook worked last time — ask for
> a single decision-maker early."

When an archetype repeats, the skill should offer to save it to learnings.md
so future projects with this client can anticipate it.

## Priority order when multiple archetypes appear

If the same feedback round shows multiple archetypes, order the response by
which playbook has the strongest action:

1. Swerve or Bait & Switch (highest — fundamental direction change)
2. Compound Notes (priced scope impact)
3. Committee (structural problem)
4. Safe Retreat (strategic risk)
5. Ego Note (political risk)
6. Relitigation (scope risk)
7. Preference vs Principle (tactical)

Lead with the highest-severity archetype; the others get shorter treatments.
