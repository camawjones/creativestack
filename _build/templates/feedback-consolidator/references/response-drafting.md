# Response Drafting

Respond mode drafts the client-facing reply after feedback has been
consolidated or translated. The output is an email or message the user can
send with minor edits.

This is the missing step in most feedback workflows: the team processes the
feedback internally but still has to find words to respond to the client.
The skill closes that loop using the agency's tone of voice.

---

## When to use this mode

- After a Translate run that surfaced clarifying questions
- After a Consolidate run that surfaced contradictions, scope creep, or
  archetypes that need addressing
- Before the next round of work begins, to confirm direction with the client
- After a difficult review, to document what was agreed

## When NOT to use this mode

- For casual Slack replies that don't need formal structure
- When the response is "we're on it, thanks" and doesn't need drafting
- When the client conversation needs a call, not a written reply

---

## Input

The skill reads the output of the preceding Translate or Consolidate run
(same session). It does not re-ask for the feedback content.

If Respond mode is invoked without prior Translate/Consolidate context:

> "I don't have a recent feedback analysis to draft from. Paste the feedback
> first and I'll consolidate it, then draft the response."

---

## Tone discovery

Read `tone-of-voice.md` from the brain. Key fields to apply:

- **Register** — formal / warm / direct / conversational
- **Contractions** — yes or no
- **Hedging** — does the agency soften or speak plainly?
- **First person** — "we" vs "the studio" vs "I"
- **Forbidden words/phrases** — anything the agency avoids (e.g. "reach out",
  "circle back", "exciting opportunity")

If `tone-of-voice.md` doesn't exist, use a neutral agency-professional tone:
direct, warm, no corporate jargon, contractions OK. Note in the output:

> "Tone guide not configured — drafted in neutral agency-professional tone.
> Run /update-voice to configure your voice for future drafts."

---

## Response archetypes

The response shape depends on what the feedback surfaced. The skill picks the
right response archetype based on the preceding analysis.

### Archetype A: Clarification request

**When to use:** Translate surfaced Low-confidence meanings; Consolidate found
unclear or contradictory feedback that needs client resolution.

**Shape:**

```
{Warm open — 1 sentence}

{Quick summary of what the team has understood — 2-3 bullets, not the full consolidation}

{The specific clarifying questions — numbered, proposing specific interpretations}

{Closing — one sentence confirming next step and timeline}
```

**Example:**

> Hi Marcus,
>
> Thanks for the feedback on round 2 — we've pulled it together and have a
> clear picture of most of it. Before we dive into the next round, we want
> to check a couple of things:
>
> - We're reading the "bolder" note as wanting more brand confidence rather
>   than louder colour — is that right?
> - On the hero composition, you mentioned "more energy" — are you reacting
>   to the layout feeling static, or to the overall mood?
> - The timeline note (pulling to Friday) affects the typography lockdown —
>   we can make it work but want to confirm it's a hard deadline, not a
>   stretch target.
>
> Happy to jump on a 15-minute call tomorrow if that's faster than email.
> Otherwise we'll pick up as soon as we hear back.

### Archetype B: Scope/cost flag

**When to use:** Consolidate detected Compound Notes or Swerve archetypes,
or the round crosses the revision cap, or new scope was introduced.

**Shape:**

```
{Warm open}

{Acknowledge the feedback was thorough and useful}

{Flag the scope/cost implication in business terms, not as a complaint}

{Offer 2 paths forward — usually A) reduced scope at current fee, B) full
scope at adjusted fee and timeline}

{Closing — ask for a decision, propose a meeting if needed}
```

The tone is critical here. It should never sound like a complaint or a
gotcha. It should sound like the agency is helping the client make an
informed decision.

**Example:**

> Hi Marcus,
>
> Thanks for the detailed round 3 notes — there's a lot of useful direction
> in there.
>
> Before we action everything, I want to flag something. Rounds 1 and 2 were
> within the revision scope we agreed. Round 3's list is larger — by our
> estimate, it adds about 22 hours of senior design time to the project.
> At our standard rate that's in the £2,000-2,500 range.
>
> Two options on how to proceed:
>
> 1. We prioritise the top 8 items from round 3 (the ones that refine the
>    agreed direction) within the current fee. The remainder would need a
>    separate conversation.
>
> 2. We action the full list and adjust the fee and timeline accordingly.
>    That'd move our final delivery from {date} to {date} and add {fee}.
>
> Both are fine by us — just want to make sure we're making the call
> together. Happy to hop on a call to talk it through.

### Archetype C: Contradiction resolution

**When to use:** Consolidate found contradictions between stakeholders or
against the brief.

**Shape:**

```
{Warm open}

{State the contradiction plainly — who said what, when}

{Recommend a resolution path — usually a single decision-maker or a meeting}

{Offer the agency's view if appropriate, framed as "our read"}

{Closing — ask for the resolution mechanism, not the resolution itself}
```

**Example:**

> Hi Priya,
>
> Working through the round 2 feedback and we've hit a contradiction we need
> help resolving.
>
> Sarah's email on Tuesday said "make the typography quieter — we want this
> to feel confident not shouty." Marcus's note on Wednesday said "let's push
> the headline bigger for more impact." Both are valid directions but they
> pull opposite ways.
>
> Our read: the project objectives lean toward the "confident, not shouty"
> direction — that's closer to the brand strategy we agreed. But we don't
> want to pick one without your input.
>
> Could we get a 15-minute call with you and Marcus this week to align? We
> can bring both treatments for a live comparison. Let me know what works.

### Archetype D: Confirmation of agreed direction

**When to use:** After a successful review where no major issues surfaced.
The goal is to close off the round on paper.

**Shape:**

```
{Warm open}

{Summarise what was agreed, in clear language}

{Confirm the next round's scope and timeline}

{Close — simple, brief}
```

**Example:**

> Hi Marcus,
>
> Quick recap of what we agreed in today's review:
>
> - Direction B is locked as the primary route
> - Typography lockdown by end of next week
> - Secondary marks to come in round 4, not round 3
> - Launch date holds at {date}
>
> We'll come back on {date} with the next round. Shout if any of this doesn't
> match your recollection.

### Archetype E: Safe Retreat response

**When to use:** Consolidate detected the Safe Retreat archetype — the client
is pulling back from the ambition that was agreed.

**Shape:**

```
{Warm open — don't open with disagreement}

{Acknowledge the concern is legitimate — whatever's driving the retreat,
treat it with respect}

{Re-anchor to the brief's own language about boldness}

{Offer a risk mitigation, not a retreat — "we can address [concern] without
losing [core idea]"}

{Closing — propose a conversation, not a written back-and-forth}
```

This is the most delicate archetype to respond to. The creative team has
something to defend and the client has a real fear. The response should
hold the line without confrontation.

**Example:**

> Hi Marcus,
>
> Thanks for the notes on round 2. Want to talk through a few of them before
> we action anything — specifically the typography direction.
>
> I hear the concern about the current treatment feeling "too different" from
> what competitors are doing. That's fair to raise. But I want to flag that
> the boldness in the type was one of the things you specifically asked for
> in the brief — you said you wanted something that "couldn't be mistaken for
> anyone else in the category."
>
> We can absolutely address what's worrying you without retreating from that.
> For example, we could keep the distinctive headline treatment but tighten
> the body copy to feel more conventional and readable. That'd give you the
> differentiation you asked for without the risk of feeling too alien.
>
> Can we jump on a call tomorrow to talk through it? I'd rather explore this
> live than in email.

---

## Drafting rules

1. **Never passive-aggressive.** Even when the feedback is maddening, the
   response should never leak frustration. Tone of voice is the agency's
   professional signature.

2. **Never blame the client.** Bad feedback is a shared problem, not their
   fault. The response should help the client give better feedback next time
   without ever saying so.

3. **Never quote the SOW contractually.** Even when flagging over-servicing,
   use the language of informed decision-making, not contractual enforcement.
   "By our estimate that's an extra X hours" beats "Per section 3 of the SOW".

4. **Always offer a path forward.** Never leave the client with just a
   problem. Every response should include at least one option for how to
   move ahead.

5. **Match the agency's voice.** If `tone-of-voice.md` says no contractions,
   draft without them. If it says direct, don't hedge. The draft should sound
   like it was written by the agency, not by AI.

6. **Be shorter than feels natural.** Clients scan emails. The response
   should fit in a screen. If it's longer than 250 words, cut.

7. **Propose calls for high-stakes responses.** Contradictions, scope
   conversations, and safe retreats should never be resolved entirely in
   writing. Offer a call.

8. **End with one clear ask.** Every response should end with a specific
   action the client needs to take: confirm, decide, schedule a call.
   Never leave ambiguity at the close.

---

## Output format

```markdown
## Drafted Response

**Archetype:** {A / B / C / D / E}
**Tone applied:** {from tone-of-voice.md, or "neutral default"}
**Recommended channel:** {email / Slack / in-person / call}
**Length:** {word count}

---

{The drafted response itself, ready to copy-paste}

---

### Edits suggested before sending

- {Any specific personalisation the user should add — e.g., specific dates,
  names, attachments}
- {Any confidence flags — "The tone on [paragraph] is firm, soften if the
  relationship is sensitive"}

### Alternate openings (if the default feels off)

{2-3 alternate first sentences for the user to pick from, in different
registers}

1. (Warmer) "Hi Marcus — hope you had a good weekend. Wanted to follow up on the round 2 notes..."
2. (More direct) "Marcus — we've been through the round 2 feedback. A few things to flag..."
3. (More formal) "Hi Marcus, Thank you for the comprehensive round 2 feedback. We've consolidated the team's..."
```

The alternate openings let the user tune the tone without rewriting the
whole response.

---

## What NOT to draft

The skill refuses to draft responses that would:
- Blame the client for the situation
- Make commitments the agency can't keep (specific dates, specific fees)
- Threaten or imply scope policing
- Quote the SOW as an enforcement mechanism
- Create a paper trail for legal/contract disputes (that's a lawyer's job)
- Respond to a crisis or complaint without the user's explicit oversight

If the user asks for a response that crosses these lines, refuse and suggest
a human-drafted reply with specific talking points instead.
