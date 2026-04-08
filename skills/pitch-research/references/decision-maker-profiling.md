# Decision-Maker Profiling

How to build useful profiles of the people who'll be in the room (or making the
decision) — using only public sources. The goal is not a dossier on the person;
it's enough understanding to **frame the pitch in language that lands**.

## Who to profile

Aim for 2-4 people, not the entire org chart. Prioritise:

1. **The decision-maker** — the person whose yes is required (CMO, CD, founder, brand director)
2. **The champion** — the person likely to advocate internally (often a brand or marketing manager)
3. **The blocker** — the person who can kill it for the wrong reasons (often a CFO, head of procurement, or legal lead)
4. **The chemistry voice** — someone in the room whose comfort matters but who isn't the decider (often a senior creative or product owner)

If the org is small (founder-led, agency, scale-up), the decision-maker is often
also the champion. Profile them deeply and skip the rest.

## What sources to use (in order)

1. **LinkedIn** — career history, public posts, articles they've written or shared, recommendations
2. **Company blog / press releases** — quotes attributed to them, leadership pages
3. **Conference talks / podcasts** — direct words, thinking style, what they emphasise
4. **Published articles** — Medium, industry press, op-eds — strongest signal of values
5. **Press interviews** — coverage of company moments where they were quoted
6. **Twitter/X (where active)** — public posts, what they reshare
7. **Acquired or notable past companies** — context for their reference points

If `/source-scrape` was called in `people` mode earlier in the
session, that data is already available — use it as primary evidence.

## What to look for

For each person, the profile should answer **5 questions**:

### 1. Where have they been?

Career trajectory matters more than current title. Someone who came from a
challenger brand thinks differently from someone who came from a holding company.

- Look for: jumps between sectors (signals appetite for change), tenure length
  (long tenure = institutional thinker; short = portfolio thinker), agency
  vs in-house (in-house people think more about internal politics, agency
  people think more about craft)

### 2. What do they say in public?

Public statements reveal what they want others to think they care about.
That's not necessarily what they actually care about, but it's what they'll
respond well to in a pitch.

- Look for: repeated phrases or frameworks (they'll use them in the meeting),
  what they criticise (signals their definition of "bad work"), what they
  praise (signals their definition of "good work")

### 3. How do they communicate?

This is the most important field for pitch framing. Are they:

- **Data-driven** — references metrics, ROI, attribution in every interview?
  → Frame the pitch in performance language. Lead with proof.
- **Craft-driven** — talks about craft, type, materials, details?
  → Lead with the work. Walk through references. Don't open with strategy slides.
- **Story-driven** — tells anecdotes, references brand history, talks about feeling?
  → Open with a narrative. The first slide should be a story, not a logo grid.
- **Politically careful** — measured, uses corporate language, avoids opinion?
  → Lower the temperature. Make it easy to say yes by reducing perceived risk.
- **Visionary** — talks about category transformation, future state, ambition?
  → Match their altitude. Don't pitch tactics.

### 4. What do they likely care about?

Triangulate from background + public statements. This is **inferred**, label it
clearly.

Examples:
- "Former designer turned CMO — likely to value craft and have opinions on type"
- "Came from a CPG background — likely to think in terms of share, not narrative"
- "Founder still in the role — emotional investment in the brand, may take feedback personally"
- "Recently joined from a competitor — may want to differentiate from old employer's playbook"

### 5. What are the risks of saying yes (for them)?

Decision-makers are people whose careers are on the line. They're not just
buying creative — they're betting their reputation on it.

- Look for: recent failures (not theirs ideally), board scrutiny, public commitments
  they've made that this work has to support, cultural moment they're navigating

The pitch should make it easy for them to defend the choice internally.
Profile-aware pitching means knowing what their first internal conversation
will be and pre-empting the objection.

## Profile structure (what to write into the dossier)

Use this format in the dossier:

```markdown
### {Name} — {Role}
- **Background:** {career history in 1-2 sentences}
- **Public statements on creative/brand:** {1-3 direct quotes with sources}
- **Communication style:** {one-line classification with evidence}
- **What they likely care about:** {inferred — labelled as inference}
- **Risk of saying yes:** {what they have to defend internally}
- **In the room:** {1-2 lines on how to frame for this person specifically}
- **Sources:** {list of URLs}
- **Last updated:** {date}
```

The "In the room" line is the unique value of the profile. It's the bridge from
research to action.

## Confidence labels

Always label confidence:

- **High:** 5+ public sources, recent (last 6 months), consistent signals
- **Medium:** 2-4 sources, mixed signals or older
- **Low:** <2 sources, mostly inferred

For Low confidence profiles, lead with: "Limited public information found —
profile is largely inferred. Treat as a starting hypothesis to test in the
first meeting, not as fact."

## When to skip a profile entirely

- **No public footprint at all** → write a one-line "no public info; treat as unknown" entry rather than padding with speculation
- **Person is too junior to matter** → skip
- **Person just joined the company** → note the move, but skip the rest until they have a public footprint in the new role
- **Person is a known industry figure** → write the profile but note that they likely have media training and public statements may be more performance than substance

## Communication style cheat sheet

| Style | Tells | Pitch frame |
|---|---|---|
| Data-driven | "ROI", "attribution", "performance", references metrics | Lead with proof, attach numbers to every claim |
| Craft-driven | Type, materials, details, references designers | Lead with the work, dwell on references, defend craft choices |
| Story-driven | Narratives, brand history, "feel", emotional language | Open with a story, build the strategy through narrative |
| Politically careful | Measured, corporate, hedged, references stakeholders | Lower risk perception, make consensus-building easy |
| Visionary | Category, transformation, "future", "where we're going" | Match altitude, pitch the idea not the execution |
| Operator | Process, timelines, deliverables, "how" | Show the plan, prove you can execute, de-emphasise creative theory |

If a person shows multiple styles, lead with the dominant one but acknowledge
the secondary in framing notes.

## How this connects to "How to use this in the room"

After all profiles are written, generate a single line at the end of the
Decision-Maker section:

> **How to use this in the room:** Lead with creative ambition for {CMO name},
> but anchor in measurability for {CFO name}. Reference their Q3 brand refresh
> as proof you've done homework. Avoid framework-heavy strategy slides — Marcus
> tunes out of those.

This line is what the pitch team actually uses. Make it specific.
