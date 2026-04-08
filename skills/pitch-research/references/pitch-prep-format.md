# Pitch Prep Format

The Research output is a research report. The **Pitch Prep** output is a
different document — a single-page brief designed to be **held in the room**
during the meeting itself. Different audience, different purpose, different shape.

This file defines what Pitch Prep mode produces.

## Audience and use

- **Reader:** the people walking into the meeting (CD, MD, account lead)
- **When read:** 30 minutes before the meeting, then glanced at during it
- **Use:** quick recall of names, framing, hook, and what to avoid
- **Length:** strict one page. If it doesn't fit, cut.

## Source

Pitch Prep mode reads the existing dossier at `~/.creativestack/prospects/{slug}.md`.
It does NOT do new research. It synthesises and compresses what's already there
into a different shape.

If no dossier exists, refuse and route to Research mode first:
> "No dossier for {prospect} yet. Run Research mode first, then come back for
> Pitch Prep."

## The format

```markdown
# Pitch Prep — {Prospect Name}
**Meeting:** {date, time, location/format}
**Status:** {dossier status from _index.md}
**Dossier last updated:** {date — flag if >14 days old}

---

## In the Room

| Name | Role | Style | Watch For |
|------|------|-------|-----------|
| {Name} | {Role} | {one word: data / craft / story / careful / visionary / operator} | {one-line — what tells you they're with you or against you} |

## The Killer Hook

> **"{One sentence — pulled directly from the dossier}"**

(Said in the first 60 seconds. Don't bury it after the credentials slide.)

## The 3 Things They'll Take Away

If they remember nothing else from this meeting, they should remember:

1. **{Single point}** — {why this matters to THEM specifically}
2. **{Single point}** — {why this matters to THEM specifically}
3. **{Single point}** — {why this matters to THEM specifically}

## What to Lead With

**Open with:** {Specific opening — story / observation / case study reference}

**Don't open with:** Credentials, agency history, or framework slides.
{Decision-maker name} will tune out.

## The 1 Case Study

Pick the **single strongest** case study from the dossier's Strong Fit angles.
One. Not three.

> **{Case study name}** — {one-line outcome that maps to their challenge}

When they ask follow-ups, you have more — but don't show it unless asked.

## What to Avoid

Pulled from `learnings.md § Pitching` and dossier observations:
- **Don't:** {specific thing — based on past losses or this prospect's signals}
- **Don't:** {specific thing}
- **Don't:** {specific thing}

## Their Likely Objections

For each, the one-sentence pre-empt:

| Objection | Pre-empt |
|---|---|
| "You're too small" | {specific counter from case studies} |
| "You don't know our sector" | {specific counter} |
| "What about {incumbent}?" | {acknowledgement + differentiation, not attack} |

## Warm Path Reminder

{One line on the warmest connection — who introduced you, who you both know,
what gave you the meeting in the first place}

## Open Questions

The 3 questions you're trying to get answered in this meeting:

1. {What's the real budget?}
2. {Who else are they talking to?}
3. {What does success look like for {decision-maker name} personally?}

## Next Step Goal

**What does winning this meeting look like?**
{One sentence — the specific next step that constitutes success. Examples:
"A tissue session in the next 3 weeks." "An RFP invitation." "An intro to the CMO."}

---

*Print this. Read it once before the meeting. Carry it in the room.*
```

## Generation rules

1. **One page maximum.** If it doesn't fit on one printed page, cut. The Pitch
   Prep is for the room, not for documentation.

2. **No new research.** Everything comes from the existing dossier. If the
   dossier is missing a field needed for Pitch Prep (e.g. no killer hook
   yet, no decision-maker profiles), prompt the user to run Research or
   Refresh first to fill the gap.

3. **Choose, don't list.** The Pitch Prep is a series of choices:
   - One killer hook (not three options)
   - Three takeaways (not seven)
   - One case study (not three)
   - Three things to avoid (not a long list)
   The whole point is to force the team to commit before walking in.

4. **Speak in the team's voice.** Read `tone-of-voice.md` and write the prep
   in the same register. This is not a formal document — it should sound
   like it was written by the CD on the train to the meeting.

5. **Surface staleness.** If the dossier hasn't been updated in 14+ days, add
   a banner: "⚠️ Dossier is {N} days old. Recent news may not be reflected.
   Consider Refresh before the meeting."

6. **Match decision-maker styles.** The opening, the case study choice, and
   the things to avoid should all be informed by who's in the room. If the
   in-the-room people skew "data-driven", the case study should lead with
   numbers; if they skew "craft-driven", lead with the work itself.

## What NOT to include

- Background research (it's in the dossier — don't duplicate)
- Long analysis (this is for action, not understanding)
- Slide deck content (this is a prep doc, not the deck)
- Agency credentials (the team knows them)
- General industry context (only context specific to this room)
- Multiple options for anything (force the choice)

## How Pitch Prep evolves with multiple meetings

If the dossier has multiple meetings logged, Pitch Prep mode should take
context from the **most recent** meeting and adapt:

- If the prep is for a follow-up meeting → reference what was agreed last time
- If it's for a final pitch → focus on objection handling and the close
- If it's for an unexpected re-engagement → start with a recap line: "Last
  time we met, {what happened}. This meeting follows {trigger}."

## Output rules summary

| Element | Hard rule |
|---|---|
| Length | 1 printed page |
| Killer hook | Exactly 1 |
| Takeaways | Exactly 3 |
| Case study | Exactly 1 |
| "Don't" items | Max 3 |
| Likely objections | Max 3 |
| Open questions | Exactly 3 |
| Next step goal | Exactly 1 sentence |

The constraints ARE the value. Don't relax them.
