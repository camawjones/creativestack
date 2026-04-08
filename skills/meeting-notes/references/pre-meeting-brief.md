# Pre-Meeting Brief

The inverse of meeting notes. **Notes mode** documents what happened.
**Pre-meeting mode** prepares the team for what's about to happen — built
entirely from the brain, with no transcript needed.

This is the second half of the value proposition. Walking out of a meeting
documented is good. Walking *in* prepared is better.

## When to use this mode

- Day before a client review or QBR
- Morning of a workshop with the client team
- Hour before a tense conversation
- Before a meeting with a new stakeholder you haven't met
- After a long gap where the project has been quiet

## What it reads from the brain

| Source | Why |
|---|---|
| `projects/{slug}.md` | Current state, open decisions, risks, current phase |
| `projects/{slug}-meetings.md` | Last 1-3 meetings — what was decided, what's outstanding |
| `learnings.md § Client Patterns` | Patterns for everyone expected in the meeting |
| `clients.md` | Relationship context |
| `tone-of-voice.md` | Voice for any client-facing material in the brief |
| Brief content (project state) | Original deliverables and constraints to anchor the meeting against |

If recent skills produced relevant context (e.g. resource-conflict shows team
is stretched, project-profitability shows margin is thinning), pull those in.

## Format

One page. Designed to be read in 5 minutes the morning of the meeting.

```markdown
# Pre-Meeting Brief — {Project} — {Date of meeting}
**Meeting type:** {client_review / workshop / qbr / kickoff / etc.}
**Duration planned:** {if known}
**Attendees:** {expected list}
**Last meeting on this project:** {date} ({N days ago})

---

## Where We Are

{2-3 sentences on the current project state. Pull from project state file:
phase, status, headline trend.}

> Example: "Phase 2 (Concept Development), week 4 of 6. Status: At Risk —
> client deferred typography decision in last review, and Sarah is at 92%
> utilisation per last resource-conflict run. Two open decisions and one
> overdue action from last meeting still outstanding."

## What's Outstanding

### Open decisions (from project state)
- {decision} — open since {date}
- {decision} — open since {date}

### Outstanding actions (from last meetings)
- {action} — owned by {person}, {N days overdue / due {date}}
- {action} — owned by {person}, due {date}

### Open risks
- {risk} — severity {H/M/L}

## Who's In The Room

For each expected attendee with brain context:

### {Name} — {Role}
- **Recent activity:** {what they did or said in past meetings}
- **Pattern alert:** {if `learnings.md § Client Patterns` has a relevant entry}
- **Watch for:** {specific thing to listen for based on patterns}

> Example:
> ### Marcus Liu — CMO, Nike
> - **Recent activity:** In the last review, said "we'll think about it" on
>   typography (logged as a pattern — followed by no in 2 of 2 past instances)
> - **Pattern alert:** Marcus declines through deferral, not directly. If he
>   defers today, treat it as a soft no and follow up.
> - **Watch for:** Engagement level — has been declining (4→4→3→3 over last
>   4 meetings). Today's meeting needs to re-engage him.

If no brain context exists for a named attendee, write a one-line "no
context — first meeting" and skip the rest.

## What To Bring

### The 3 things to land
The most important outcomes for this meeting. Be specific.

1. **{Outcome}** — {why this matters now}
2. **{Outcome}** — {why this matters now}
3. **{Outcome}** — {why this matters now}

### What to lead with
{Specific opening recommendation based on the meeting context, the people in the room, and any pattern alerts.}

> Example: "Lead with the typography options Marcus deferred last time.
> Don't open with the strategy framework — Marcus tunes out of those.
> Use Priya's KPI framing pattern: open with one number that proves the
> work is on track."

### What to avoid
- {specific thing}
- {specific thing}

## Cross-Project Heads-Up

{If anything from other active projects affects this meeting — e.g. a team
member is also on a competing deadline, or a similar client made a similar
request last week — surface it here.}

> Example: "Sarah is also on the Adidas pitch this week — if a tight
> deadline is requested today, factor that in. Don't commit to anything
> before Friday without checking her capacity."

## Sentiment Trajectory

{Only if 3+ past meetings exist. Pull from {slug}-meetings.md sentiment scores.}

```
Last 4 meetings, aggregate sentiment:
2026-02-22: 12/15 ████████████░░░
2026-03-08: 12/15 ████████████░░░
2026-03-22: 11/15 ███████████░░░░
2026-04-08: 10/15 ██████████░░░░░
```

**Trajectory: DECLINING** — engagement and alignment both down 1 point each
over the last 3 meetings. Today's meeting is a chance to reverse the trend
or confirm a real problem.

## Open Questions for the Room

The 3 questions worth getting answered today:

1. {question — based on outstanding decisions}
2. {question — based on pattern alerts}
3. {question — based on project risks}

## What Success Looks Like

**One sentence:** {What does winning this meeting look like? Be specific.}

> Example: "Walking out with typography locked, Sarah unblocked on
> refinements, and a re-engaged Marcus."

---

*This brief was generated from project state, past meetings, and client
patterns. Read it once before the meeting. Don't carry it in the room — that's
what the killer hook is for.*
```

## Generation rules

1. **One printed page maximum.** If it doesn't fit, cut the lowest-priority
   section.

2. **Brain-only.** No live research, no upstream skills required. The whole
   point is that the brief is generated from what the agency already knows.

3. **Force choices.** 3 things to land, not 8. 3 questions, not 10. 1 success
   sentence, not a paragraph. The constraints make it usable.

4. **Pull patterns aggressively.** Every named attendee should be checked
   against `learnings.md § Client Patterns`. The brief's biggest value is the
   "watch for" line per person.

5. **Sentiment trajectory only if data supports it.** With <3 past meetings,
   skip the trajectory section. With 3+, include it — it's one of the
   highest-value views in the brief.

6. **Lead with state, not history.** The first section is "where we are now,"
   not "everything that happened." Recent meetings are referenced to support
   the current state.

7. **Don't repeat the project state file.** Reference its content but don't
   duplicate it. Risks, open decisions, and current phase get one-line
   summaries, not full re-listings.

8. **Match the tone-of-voice.** This brief is internal but it should sound
   like the agency, not generic AI.

## What NOT to include

- Full meeting history (it's in `{slug}-meetings.md`)
- Full attendee bios (it's in past dossiers if applicable)
- Long analysis of why the project is where it is
- Predictions framed as certainties
- Anything that would be embarrassing if forwarded to the client

## When to refuse

If `projects/{slug}-meetings.md` doesn't exist and `projects/{slug}.md` is
empty/minimal, the brief will be thin. In that case:

> "I don't have enough context for a useful pre-meeting brief — no past meetings
> logged for this project and the project state is sparse. Want me to:
> (a) generate a basic 'first meeting' brief from the brand brief, or
> (b) wait until you've logged a meeting or two?"

Don't generate a padded brief. The whole value is brain depth — without
brain depth, the brief is fluff.

## Output rules summary

| Element | Hard rule |
|---|---|
| Length | 1 printed page |
| Things to land | Exactly 3 |
| Open questions | Exactly 3 |
| Success sentence | Exactly 1 |
| Pattern alerts | Only from confirmed patterns in learnings.md |
| Sentiment trajectory | Only if 3+ past meetings exist |
| Cross-project heads-up | Only if relevant — skip the section if not |
