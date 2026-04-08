# Transcript Parsing

The skill accepts input from any source — Granola, Otter, Fireflies, Zoom auto-
transcript, Read.ai, or pasted raw notes from a notebook. Each source has
quirks. This file documents how to parse each format and what to extract.

The goal is **never to compete on transcription**. The goal is to extract the
structured signals (decisions, actions, scope changes, sentiment markers, names)
that the brain layer can then cross-reference.

## Universal extraction targets

Regardless of input format, the parser is looking for:

| Target | What it is | Why it matters |
|---|---|---|
| **Speakers** | Named individuals | Maps to attendees, action ownership, decision-maker style |
| **Decisions** | Statements that resolve an open question | Cross-referenced against brief, methodology, past meetings |
| **Actions** | Commitments to do something with an owner and ideally a date | Tracked across meetings for completion rates |
| **Scope changes** | Anything that adds, removes, or shifts deliverables | Priced via rate-card, flagged against brief |
| **Sentiment markers** | Phrases that signal tone (frustration, enthusiasm, hesitation, agreement) | Sentiment trajectory across meetings |
| **Open questions** | Things raised that didn't get resolved | Become open decisions in project state |
| **Risks** | Concerns raised, dependencies flagged | Updated in project state risks section |
| **Patterns** | Phrases that match known client communication patterns | Cross-referenced against learnings.md § Client Patterns |
| **Dates** | Any date mentioned, especially deadlines | Used for action deadlines and timeline impact |
| **Numbers** | Budget, hours, headcount mentions | Used for scope cost estimation and capacity flags |

## Source format quirks

### Granola

Granola produces structured notes with attendee names attached to speech.
Format is usually:

```
Sarah Chen: We should move the deadline to Friday.
Mike Torres: I'm not sure that's possible — Jade is on leave Thursday.
```

**Quirks:**
- Granola often pre-summarises in its own AI layer — the user may paste the
  summary, the raw transcript, or both. Ask which they pasted if unclear.
- Granola sometimes attributes speech incorrectly when speakers overlap.
  Don't anchor too hard on attribution — focus on the content.
- Granola produces "highlight" sections that pre-extract decisions and actions.
  These are useful but should be **cross-checked**, not trusted blindly.

**Parser strategy:**
- Treat speaker labels as authoritative for attribution
- Treat Granola's pre-extracted highlights as a starting point, then re-extract
  to catch what it missed (especially scope changes and sentiment)
- If only the Granola summary is pasted (no transcript), note that fewer
  signals will be extractable

### Otter.ai

Otter produces verbose transcripts with timestamps and speaker labels:

```
[00:02:15] Sarah Chen: So I think the priority for this round is the brand mark itself, and we can come back to the secondary marks next week if that works for everyone.

[00:02:38] Marcus Liu: Yeah, that works. Just make sure the typography decisions are locked before we get to secondary — I don't want to revisit that.
```

**Quirks:**
- Otter is very verbose. Decisions are often buried in long speech turns.
- Speaker labels are usually accurate but can mis-name participants (e.g. labelling all unidentified speakers as "Speaker 1", "Speaker 2"). Confirm against the user's stated attendee list.
- Transcripts often include filler words and false starts. Ignore these for extraction.
- Otter sometimes produces "key takeaways" — same as Granola, treat as starting points.

**Parser strategy:**
- Strip filler words and false starts before extraction
- Watch for decisions buried in long speech turns — they're often signposted by
  "let's", "we should", "I think we're agreeing that", "ok so the plan is"
- Cross-reference Speaker N labels against the stated attendee list to fix names

### Fireflies.ai

Similar to Otter but often includes auto-generated summaries with bullet points
for action items, decisions, and questions.

**Parser strategy:**
- Use Fireflies' bullet extractions as a starting point
- Re-extract for scope changes specifically — Fireflies misses these often
  because they're framed as casual additions, not formal decisions
- Cross-check action ownership — Fireflies sometimes assigns actions to the
  wrong speaker

### Zoom auto-transcript / Read.ai

Less structured. Sometimes just plaintext with timestamps, no speaker labels.

**Parser strategy:**
- If there are no speaker labels, ask the user once: "There are no speaker labels — should I attribute actions and decisions to specific people, or just capture them generically?"
- Without speaker labels, action ownership becomes generic ("the team", "us", "client")
- Sentiment detection is harder without speaker context — flag confidence as Low

### Raw / hand-typed notes

This is the highest-trust input — the human has already filtered the signal.
But it's also the lowest-context — the parser has to take the user's word for
what was a decision vs a discussion.

**Parser strategy:**
- Trust the user's structuring (if they used bullet points, treat each as a
  potential signal)
- Ask once if anything is ambiguous: "I see 'discussed budget' — was that a
  decision, an open question, or just context?"
- Don't over-extract from raw notes. The user has already done filtering work
  — respect it.

## Pre-summarised input

If the user pastes a Granola/Otter/Fireflies summary instead of the raw
transcript, the skill should:

1. Acknowledge: "This looks like a pre-summarised version. I can work with it
   but I'll have less raw material for cross-referencing."
2. Treat the summary as a structured input — actions and decisions are
   pre-extracted, but sentiment and scope changes will be limited
3. Lower the confidence label on sentiment detection
4. Skip the scope change detection if no specific phrases are present

## Multi-meeting input

If the user pastes multiple meetings at once (e.g. "here are the last 3 client
reviews"), ask:

> "I see multiple meetings here. Process them as one combined record, or as
> separate meetings? Separate gives better cross-meeting pattern detection."

Default to separate. Process each through the full pipeline and write each as
its own entry in the project meeting log.

## Length limits

Very long transcripts (>20k words) should be processed in sections:

1. Parse the full transcript for speaker labels and structural markers
2. Process in 5k-word chunks for extraction
3. Aggregate the extracted signals
4. Generate output from the aggregated signals, not the full transcript

## What NOT to extract

The skill does NOT extract:
- **Verbatim dialogue** — except for short quoted phrases that justify a sentiment flag or pattern detection
- **Personal information** about attendees beyond their names and roles
- **Off-topic chat** at the start or end of the meeting
- **Internal team venting** that the client wouldn't want to see in the
  client-facing output (this is filtered separately)

## Confidence labels by source

| Source | Default confidence | Why |
|---|---|---|
| Granola raw transcript | High | Good structure, accurate attribution |
| Otter full transcript | High | Verbose but reliable |
| Fireflies transcript | High | Reliable with light cross-checking |
| Zoom auto-transcript | Medium | No speaker labels |
| Read.ai | Medium | Variable quality |
| Granola/Otter/Fireflies summary only | Medium | Lossy, less raw material |
| Raw hand-typed notes | High for content, Low for sentiment | User filtered already |
| Mix of summary + transcript | High | Best of both |

Apply the confidence label to the output. If sentiment detection is downgraded,
say so explicitly.

## Confirmation step

After extraction, before generating output, briefly confirm what was found:

> "I extracted: 6 decisions, 4 actions (3 with owners, 1 unassigned), 2 scope
> change indicators, 1 risk, 0 explicit deadlines. Sentiment: cautiously positive.
> Want me to flag anything I missed before I generate the notes?"

This is fast and gives the user a chance to correct attribution or add
context the transcript didn't capture (e.g. body language, side conversations).
