# Sentiment Detection & Pattern Capture

Two related but distinct jobs:

1. **Sentiment** for this single meeting — what was the tone, what shifted
2. **Patterns** across meetings — recurring tones, recurring phrases, recurring
   behaviours specific to this client or person

The first is captured every meeting. The second compounds over time and gets
saved to `learnings.md § Client Patterns`.

---

## 1. Sentiment detection

### What sentiment means in a creative agency context

Sentiment in creative work isn't binary positive/negative. The meaningful axes:

- **Engagement:** are they leaning in or checking out?
- **Trust:** do they believe the team can deliver?
- **Alignment:** do they see the work the same way the team does?
- **Risk tolerance:** are they becoming more or less open to ambition?

A meeting can be *positive* on engagement and *negative* on risk tolerance —
that's a "client wants safe work" signal that's more useful than "meeting
went well."

### Signals to look for

| Signal type | Examples | What it suggests |
|---|---|---|
| **Hedging language** | "we'll think about it", "interesting", "let me come back on that" | Soft no, deferral, or genuine uncertainty — context-dependent |
| **Diminishing language** | "could you just", "small change", "quick tweak", "while you're at it" | Scope creep being framed as casual |
| **Stakeholder invocations** | "I need to check with X", "the board will want", "legal said" | Decision is going up the chain — slower process ahead |
| **Revisitation** | "going back to the earlier point", "I'm still not sure about" | Unresolved tension — flag as a recurring concern |
| **Contradictions within meeting** | Same person agreeing then qualifying | Internal conflict — they're not bought in yet |
| **Enthusiasm markers** | "love this", "yes exactly", "this is what we needed" | Genuine alignment — capture and replicate the framing |
| **Silence on important items** | Big slide, no reaction, move on | Concerning — silence often means polite confusion or disagreement |
| **Anchor language** | "for me, the most important thing is..." | What they actually care about — write this down verbatim |

### How to score sentiment for the meeting

Three categories, each on a 1-5 scale:

| Dimension | 1 | 3 | 5 |
|---|---|---|---|
| **Engagement** | Disengaged, distracted, brief | Polite, transactional | Active, leaning in, generative |
| **Trust** | Defensive, scrutinising every detail | Neutral, cautious | Confident, "you've got this" |
| **Alignment** | Diverging interpretations | Mostly aligned | Same page, completing each other's sentences |

Aggregate score: 3-15. **Don't surface the numbers in the output** — translate
them into language. The score is for internal trajectory tracking.

### Output format for sentiment

```markdown
## Tone & Sentiment

**Overall:** {one-line read — e.g., "Cautiously positive — engaged but raising
risk concerns about timeline"}

**Notable signals:**
- "{verbatim phrase from transcript}" — {what it suggests, who said it}
- "{verbatim phrase}" — {what it suggests}

**Trajectory:** {only if past meetings exist — see below}
```

Verbatim phrases are critical. Don't paraphrase what's worth quoting.
Recording tools can give you transcripts; this skill should give you the
**3 quotes that matter**, not all of them.

### Sentiment trajectory across meetings

If `projects/{slug}-meetings.md` has 2+ past meetings, compute a trajectory.

Read each past meeting's sentiment scores, plot the trend:

```markdown
**Trajectory:** Engagement ↓ from 4 → 4 → 3 → 2 over the last 4 meetings.
This is a steady decline. Worth a check-in conversation outside the regular
review cadence.
```

Trajectory states:

| State | Trigger | Action |
|---|---|---|
| **STABLE** | All scores within ±1 across meetings | No action |
| **IMPROVING** | Aggregate score up 2+ points across meetings | Identify what changed and replicate |
| **DECLINING** | Aggregate score down 2+ points across meetings | Flag for attention |
| **CRITICAL** | Score below 7 OR engagement at 1-2 | Escalate now — relationship at risk |
| **VOLATILE** | Scores swing 3+ points between meetings | Inconsistency suggests internal client politics |

A declining trajectory should appear in "What Only the Brain Caught" as a
high-priority finding, not buried in the sentiment section.

---

## 2. Pattern capture

Patterns are sentiment signals that **repeat across meetings** with the same
person or client. They become valuable when saved.

### What counts as a pattern

A pattern is:
- A specific phrase or behaviour
- Used by a specific named person (or consistently by the client side)
- Observed in 2+ meetings
- Followed by a predictable outcome

Examples of valid patterns:

> **Pattern:** Marcus says "we'll think about it"
> **Followed by:** No (2 of 2 instances)
> **Confidence:** Medium (small sample)
>
> **Pattern:** Priya always asks about KPIs in the first 5 minutes
> **Followed by:** Pitch lands better when KPIs are pre-emptively addressed
> **Confidence:** High (4 of 4 instances)
>
> **Pattern:** Client team goes silent on creative routes B and C
> **Followed by:** They want route A but don't want to seem decisive too early
> **Confidence:** Medium

What does NOT count as a pattern:
- One-off observations (need 2+ instances minimum)
- Generic stuff ("clients ask questions") — must be specific
- Style preferences without behavioural evidence
- Speculation without instances to back it up

### Pattern capture flow

After every meeting, run a pattern check:

1. For each notable signal in this meeting, check `learnings.md § Client Patterns`
2. If the signal matches an existing pattern → increment confidence and add the
   instance date
3. If the signal is new → flag as a *candidate* pattern (not saved yet)
4. After 2+ instances of the same candidate → offer to save it

### Saving patterns to learnings.md

The compounding loop is where this happens. After the meeting output, if a
new pattern was detected with 2+ instances:

> "I noticed Marcus has now used 'we'll think about it' twice (today and on
> 2026-03-15). Last time it preceded a no. Want me to save this as a client
> pattern? It'll be checked automatically in future meetings with him."

If the user confirms, append to `learnings.md § Client Patterns`:

```markdown
## Client Patterns

### Marcus Liu (Nike) — "we'll think about it"
- **Pattern:** Says "we'll think about it" or "let me come back on that"
- **Followed by:** Soft no
- **Instances:** 2026-03-15, 2026-04-08
- **Confidence:** Medium (2 instances)
- **Action:** Treat as soft no, follow up within a week to confirm
- **Last updated:** 2026-04-08
```

### Updating an existing pattern

When the same pattern recurs in a later meeting:

1. Read the existing entry
2. Append the new instance date
3. Update the confidence level if it crosses a threshold
4. Update `last_updated`
5. Tell the user: "Pattern confirmed — Marcus's 'we'll think about it' is now
   3 instances. Confidence raised to High."

### Confidence thresholds

| Instances | Confidence |
|---|---|
| 1 | None — candidate only, don't save |
| 2 | Low |
| 3-4 | Medium |
| 5+ | High |

A High-confidence pattern should be surfaced in "What Only the Brain Caught"
as a strong call. A Low-confidence pattern should be hedged.

### Pattern decay

Patterns that haven't been seen in 6+ months should be flagged as stale:

> "Pattern: Marcus's 'we'll think about it' — last seen 2025-09. Stale. Either
> the pattern stopped or the client relationship has changed. Confirm before
> applying."

The skill should not silently discard stale patterns. Surface them and let
the user decide.

### Privacy

Client Patterns can be sensitive — they describe how to read individual
people. Apply the same rules as the prospect dossier:

- Don't write anything you wouldn't want forwarded to that person
- Stick to behavioural observations, not personal characterisations
- Use neutral language ("says", "responds with") not loaded language
  ("dodges", "evades", "manipulates")
- Pattern entries should help the team work with this person better, not
  judge them

---

## 3. How sentiment and patterns flow into output

### In single-meeting output (Notes mode)

- **Sentiment** appears in the standard "Tone & Sentiment" section with the
  3 most notable verbatim quotes
- **Trajectory** appears in "Tone & Sentiment" if past meetings exist
- **Pattern matches** (existing patterns confirmed in this meeting) appear in
  "What Only the Brain Caught"
- **Pattern candidates** (new patterns detected with 2+ instances) appear in
  the compounding loop offer at the end, not in the main output

### In Patterns mode (cross-meeting analysis)

A separate output focused entirely on patterns and trajectories. See the
Patterns mode section in SKILL.md for the format.

### In Pre-meeting brief mode

Patterns are surfaced as warnings: "Last 3 meetings showed Marcus declining
in engagement. Today's meeting needs to re-engage him — consider opening
with [the thing that worked in meeting 1]."
