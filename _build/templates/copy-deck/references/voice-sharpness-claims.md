# Voice, Sharpness, Claims, and the SMT Ladder

The operational core of the skill. Four pressure-points that separate a
copy deck from a copy spec:

1. **Voice match** — does every atom match the brand's tone and personality?
2. **Sharpness** — is the copy specific and earned, or flat and generic?
3. **Claim/proof discipline** — are claims paired with reasons-to-believe?
4. **The SMT ladder** — does every atom connect back to the brief's
   single-minded thought?

Every atom the skill generates passes through all four. A copy deck that
aces voice but fails sharpness is a deck full of pleasant fluff. A deck that
aces sharpness but fails the SMT ladder is a deck of clever lines that
don't add up.

---

## 1. Brand voice (NOT agency voice)

### The most important distinction in this whole skill

The brand's voice is **not** the agency's voice. The agency's voice lives
in `tone-of-voice.md` and is the register used when writing the deck
document itself — the intro, the rationale, the section headers. The
**brand's** voice lives in the brief, specifically in:

- `projects/{slug}-brief.md § Brand Tone & Personality` (primary source)
- `projects/{slug}-brief.md § The Single-Minded Thought` (voice cue)
- `projects/{slug}-brief.md § Desired Response` (emotional register)

### Brand voice source hierarchy

When the skill is asked to write copy, it reads the brand voice in this
order:

1. **`projects/{slug}-brief.md § Brand Tone & Personality`** — if a brief
   exists for this project, this is the authoritative source. The tone
   adjectives, the "they would / they would never" lines, the personality
   description.

2. **`learnings.md § Feedback` Vocabulary (for this client)** — the per-client
   translation table. If Marcus uses "bold" to mean "brand-confident", then
   copy marked "bold" in the brief should be written as "brand-confident,"
   not as "louder."

3. **Previous `projects/{slug}-copy-deck-v*.md`** — the most recently-signed-off
   copy deck for this client is the practical example of what their voice
   looks like in production. Use the previous deck's vocabulary, cadence,
   and rhythms as a reference point.

4. **`clients.md` — the client's stated brand guidelines** — if the agency
   has logged brand voice notes per client, apply them.

5. **`tone-of-voice.md` (fallback only)** — only if the project has no
   brief, no previous deck, and no client voice notes. This is the
   agency's default voice, applied as a fallback.

### Voice scoring per atom

For every atom the skill generates or audits, score voice match 1-5:

| Score | What it means |
|---|---|
| 5 | Could only be this brand. Distinctive, ownable. |
| 4 | On voice, strong. Recognisable as this brand with minor tells. |
| 3 | On voice but generic. Could be this brand or a close neighbour. |
| 2 | Drifts off voice. Sounds like the category, not the brand. |
| 1 | Off voice entirely. Could be any brand in any category. |

### Voice scoring rules

**Rule 1:** The brand voice from the brief is the rubric, not the agency's
default. A "premium but accessible" brand should be scored against
"premium but accessible," not against the agency's house style.

**Rule 2:** Voice failures are specific, not general. "Off voice" is not
a useful note. "Uses 'delight' which contradicts the brief's 'no corporate
words' rule" is useful.

**Rule 3:** Score the words, not the intent. Good intent can still produce
off-voice copy if the words don't land.

**Rule 4:** A brand can have voice variation across atoms — a CTA might
be punchier than a manifesto. That's fine, as long as the variation is
consistent with the brief's personality description.

### Voice check output format

```markdown
**Voice match: 4/5** — On voice. Minor drift on the subhead ("transformative"
is corporate speak, brief explicitly calls out "no corporate words"). Rewrite
suggestion: "The first shoe tested in real races by real ultra runners."
```

---

## 2. Sharpness

### What sharpness is

Sharpness is the quality that separates great copy from pleasant copy.
It's specificity, teeth, earned claims, concrete language. The absence of
filler words. The confidence to leave things unsaid.

You can have 5/5 voice match and still be flat. Flat copy is the single
most common failure mode of brand copy written by AI, junior copywriters,
or committees.

### Sharpness detection signals

**Flat copy signals (lowered sharpness score):**

| Signal | Example | Why it's flat |
|---|---|---|
| Abstract verbs | "empower", "elevate", "transform", "unlock", "drive", "enable" | Could mean anything; mean nothing |
| Category-generic openers | "In today's fast-paced world...", "Now more than ever..." | Template openers |
| Hedging | "helps you", "can be", "may", "strives to" | Undercuts the claim |
| Buzzword stacking | "next-generation cutting-edge innovative" | Reads as desperate |
| Passive construction | "Results are achieved by..." | Removes the subject |
| Universal claims | "for everyone", "anywhere", "anytime" | Unfocusable |
| Empty adjectives | "great", "amazing", "incredible", "unique" | Add nothing |
| Aspirational without proof | "The best running shoe ever" | Claim without backing |

**Sharp copy signals (raised sharpness score):**

| Signal | Example | Why it's sharp |
|---|---|---|
| Concrete nouns | "the Patagonia trail", "100 ultra runners", "94 personal bests" | Specific beats abstract |
| Active construction | "We tested it in six continents." | Short, direct |
| Earned claims with proof | "94 of 100 broke their personal bests." | Claim backed by proof |
| Specific numbers | "6 weeks", "£45", "3am" | Numbers anchor the claim |
| Concrete actions | "Lace them up", "Run it", "Feel it" | Physical verbs |
| Confidence without hedging | "It works." (not "We think it works.") | Voice tells |
| Unexpected specificity | "At mile 82, most shoes fail." | Specific = memorable |

### Sharpness scoring per atom

Score 1-5:

| Score | What it means |
|---|---|
| 5 | Every word earns its place. Specific, active, confident. Memorable. |
| 4 | Mostly sharp. 1-2 small softenings. |
| 3 | Competent but flat. Nothing wrong; nothing striking either. |
| 2 | Padded. Filler words, hedging, abstract verbs. |
| 1 | Template copy. Could be generated by any AI from any brief. |

### Sharpness check output format

```markdown
**Sharpness: 3/5** — Competent but flat. The body uses "empower", "unlock",
and "transform" in three consecutive paragraphs. Rewrite to replace abstract
verbs with concrete actions. Suggested: "Lace them up. Run them. Feel the
difference at mile 20." (concrete, active, rhythmic).
```

### The sharpness rule for AI-generated copy

AI-generated copy fails sharpness by default. The skill should be
**aggressive about flagging flatness** rather than generous. A 5/5 sharpness
score should be rare — it's the bar for genuinely memorable copy.

If the skill finds itself wanting to write "empower", "transform", "elevate",
or "unlock", stop and rewrite. Those words are almost always filler.

---

## 3. Claims and proof

### The claim/proof discipline

Every claim made in copy should be paired with a reason-to-believe. Claims
without proof are advertising; claims with proof are content.

The brief's **Reasons to Believe** section is the primary source for proof
points. The skill reads this and pairs claims to proofs as it generates
atoms.

### Claim detection

A claim is any assertion that the audience might reasonably ask "says who?"
about:

- "The best running shoe" → says who?
- "Built for ultra runners" → evidence?
- "30% faster" → compared to what?
- "Loved by athletes" → how many, measured how?

### Proof sources, in order

1. **`projects/{slug}-brief.md § Reasons to Believe`** — the brief's
   explicit proof list
2. **`projects/{slug}.md § Background`** — business context, track record,
   history
3. **`case-studies.md`** — past work that proves the agency's (not the
   client's) capability
4. **Upstream skill outputs** — `source-scrape` evidence mode, `trend-report`
   data, `competitor-audit` positioning analysis

### Claim/proof pairing output

Every claim in the deck should have an attached proof or be flagged as
unbacked:

```markdown
**BODY — Hero body**
"We didn't test this shoe in a lab.*¹* We tested it on 100 ultra runners across
six continents.*²* 94 of them broke their personal bests in the first race.*³*"

**Proofs attached:**
- *¹* Lab rejection claim — proof: from brief § Reasons to Believe, the team's
  documented rejection of lab testing in favour of real-world testing
- *²* 100 ultra runners claim — proof: from brief § Reasons to Believe,
  the testing program spec
- *³* 94% PB claim — proof: from brief § Reasons to Believe, the testing results

**Unbacked claims:** None detected.
```

If a claim has no proof in any source:

```markdown
**UNBACKED CLAIM FLAGGED:**
- "The most comfortable shoe ever made." — no supporting evidence in
  brief, project state, or upstream research. Rewrite with a specific
  comfort claim that can be backed, or remove.
```

### Claims that don't need proof

Some statements look like claims but aren't:

- Calls to action ("Get yours now") — not a claim, an instruction
- Opinions framed as opinions ("We think this is a better way") — not a claim, a perspective
- Questions ("What's holding you back?") — not a claim
- Commands ("Run faster") — not a claim in most contexts

The skill shouldn't over-flag these.

---

## 4. The SMT ladder

### What the SMT ladder is

Every atom in the deck should ladder up to the brief's **Single-Minded
Thought**. If an atom doesn't connect to the SMT, it's either off-brief or
it's decoration.

Laddering doesn't mean every atom says the same thing. A headline can be
playful, a body can be explanatory, a CTA can be direct — but all three
should, when read together, add up to the SMT.

### The ladder check

For each atom, ask: *"If I read only this atom, would it be consistent
with the SMT?"*

The SMT is the reference point. Consistency is the test. An atom that
contradicts or drifts from the SMT should be flagged.

### Example

**SMT (from brief):** "To runners training for their first ultra, Nike Air
is the shoe brand that honours their ambition without asking them to prove
it yet."

**Atom check:**
- **Headline:** "Run your first ultra without the shoes you have to coach." → **LADDER MATCH** — honours ambition, implies no need to "prove" expertise
- **Body:** "Our shoes are perfect for runners of all levels, from beginners to professionals." → **LADDER MISS** — universal positioning contradicts the specific SMT audience
- **CTA:** "Find your pair." → **LADDER MATCH (neutral)** — doesn't contradict, doesn't actively support

### Ladder scoring

Score 1-5 per atom:

| Score | What it means |
|---|---|
| 5 | Actively supports the SMT — the atom would be weaker without it |
| 4 | Consistent with the SMT — the atom fits cleanly |
| 3 | Neutral — doesn't support or contradict |
| 2 | Drifts — the atom is on brief but not on thought |
| 1 | Contradicts the SMT — the atom fights the thought |

### Ladder check output format

```markdown
**SMT ladder: 4/5** — Consistent with the thought. Headline actively supports
"honours ambition." Body is neutral — could be sharpened to reference the
first-ultra audience specifically.
```

### When no SMT exists

If the project has no brief or the brief has no single-minded thought, the
skill can't run the ladder check. In that case:

> "No single-minded thought in the brief — ladder check skipped. Consider
> running `/creative-brief` to establish an SMT before
> generating copy, or the deck will be structured around deliverables
> rather than a thought."

Don't fabricate an SMT to satisfy the check. Flag honestly.

---

## Combined atom score

Every atom gets 4 dimension scores (Voice, Sharpness, Claims/Proof, SMT
Ladder). The atom's overall score is the average, rounded to one decimal.

**Overall deck health:**
- Every atom scored
- Atoms grouped by section or by atom type
- Red flags surfaced for any atom scoring 1-2 on any dimension
- Overall deck score = average across all atoms
- Readiness state driven by the overall score AND the red flag count

| Overall | Red flags | State |
|---|---|---|
| 4.5+ | 0 | **Ready** — ship it |
| 4.0-4.4 | 0-1 | **Ready with minor edits** |
| 3.5-3.9 | 0-2 | **Needs tightening** — refine the weakest atoms |
| <3.5 | Any | **Not ready** — rewrite the weakest sections |
| Any | 3+ red flags | **Not ready regardless of average** |

---

## Scoring discipline

1. **Score at atom level, not section level.** A section can be "mostly
   good" while specific atoms fail. Atom scoring catches this.

2. **Don't grade generously.** If every atom scores 5, the rubric isn't
   being applied honestly. Great copy is rare.

3. **Give concrete rewrites, not critique.** "The headline is weak" is not
   useful. "Rewrite: 'Run your first ultra without the shoes you have to
   coach'" is useful.

4. **Flag, don't silently rewrite.** The skill's job is to surface issues;
   the human decides whether to accept the rewrite.

5. **Respect the client vocabulary.** If `learnings.md § Feedback` says
   Marcus uses "bold" to mean "brand-confident", don't flag the word
   "bold" as flat — it has a specific meaning for this client.

---

## Check mode — audit without rewriting

When the skill is in **Check mode**, it scores copy the team has already
written without generating new atoms. The output is the scoring rubric
only, plus rewrite suggestions flagged as "optional."

Check mode is useful as a sign-off gate or a QA pass. It doesn't try to
replace the writer's judgment — it surfaces what the 4-dimension scoring
catches.
