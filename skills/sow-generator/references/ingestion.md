# SOW Ingestion Heuristics

Read this file when the user is in **Ingest mode** and has pasted an existing SOW. Your job is to extract their format into the `sow-style.md` schema.

## Goal

Extract these fields from the pasted document:

| Field | What to look for |
|---|---|
| `voice_us` | How the agency refers to itself: "the Provider", "the Agency", "the Studio", "we", or the agency name. Count occurrences in clause sections (IP, termination) — those are usually the most consistent. |
| `voice_them` | How the client is referred to: "the Client", "you", or the client name. |
| `tone` | Formal legal (lots of "shall", "hereinafter", "party of the first part") → `formal`. Mixed register, "will" + "agrees to" → `professional`. Plain English, contractions, second person → `conversational`. |
| `default_revision_policy` | Look for revision/round counts. "2 rounds of revisions" → `standard`. "1 round" → `strict`. "3 rounds" → `generous`. "Unlimited within X days" → `unlimited-windowed`. Anything else → `custom`. |
| `default_revision_window_days` | Number of business days for client feedback per round. |
| `default_payment_structure` | "50% upon signing, 50% on completion" → `50-50`. "Milestone 1, Milestone 2..." → `milestone`. "Monthly fee" → `monthly`. "Phase 1 payment, Phase 2 payment" → `per-phase`. |
| `default_payment_terms_days` | "NET 30", "30 days from invoice", "due within 14 days" → number. |
| `late_payment_terms` | Late fee language, interest rate. Often missing — that's fine. |
| `reference_format` | Look at the SOW header for a reference number. Generalise: "ACME-REBRAND-202410" → `{CLIENT}-{PROJECT}-{YYYYMM}`. |

## Section extraction

Parse top-level headings (h1/h2 in markdown, "Section N." or numbered headings in plain text). The order matters — capture it as the section order.

**Standard sections to recognise** (and their common alternative names):

| Standard name | Common alternatives |
|---|---|
| Project Overview | Background, Introduction, Project Summary, Engagement Overview |
| Scope of Work | Scope, Services, Engagement Scope, Work Description |
| Deliverables | Outputs, What You'll Receive, Deliverables List |
| Timeline | Schedule, Project Schedule, Duration, Term |
| Investment & Payment Schedule | Fees, Pricing, Investment, Compensation, Payment Terms |
| Revision Policy | Revisions, Feedback, Change Requests |
| Client Responsibilities | Client Obligations, Your Responsibilities, Client Requirements |
| Intellectual Property | IP, Ownership, Rights, IP Rights |
| Confidentiality | NDA, Confidential Information, Non-Disclosure |
| Termination | Cancellation, Ending the Agreement |
| General Terms | Miscellaneous, Other Terms, General Provisions |

**Custom sections to flag separately:** Anything that doesn't map to a standard section. Common ones:
- AI Usage Policy / AI Disclosure
- Sustainability / Environmental Commitments
- DEI Rider / Inclusive Practice
- Accessibility Commitments
- Data Handling / Privacy / GDPR
- Brand Safety
- Subcontractor Disclosure
- Force Majeure (sometimes pulled out as its own section)
- Kill Fee (sometimes its own section)
- Insurance Requirements
- Indemnification

Save these to `sow-style.md` under `## Custom Sections` with their position in the order and the verbatim content.

## Clause extraction

For each of the standard "boilerplate" sections (IP, Confidentiality, Termination, plus any custom sections), capture the **verbatim text** as a clause in the library. Don't paraphrase. Don't "improve" the wording.

For each clause, save:
- **Clause name:** Auto-generated from the section title (or sub-heading if present)
- **Section:** Which section it belongs to
- **Text:** The exact text, preserving paragraphs

If a section contains multiple distinct clauses (e.g., the IP section has "IP transfer", "Portfolio rights", "Third-party assets" as separate paragraphs), save them as separate clauses in the library. This makes them individually swappable later.

## What to skip

- Project-specific data (this client's name, this project's fee, this timeline) — that's not style, that's project parameters
- Signature blocks
- Page numbers, headers, footers from a Word/PDF export
- Table of contents
- Cover page boilerplate ("Prepared by...", "Confidential", logos)

## What to flag, not extract

These need user input:
- Conflicting versions of the same clause across the SOW (rare but happens with copy-paste docs)
- Sections marked "TBD" or "[INSERT X HERE]"
- Currency or jurisdiction-specific terms — flag these so the user knows they were captured
- Anything that looks like it was copy-pasted from a different agency's SOW (mismatched voice, references to a different agency name)

## Confidence reporting

After extraction, present the results in this format:

```
Extracted from your SOW:

✓ Confident:
  - Voice: "the Provider" / "the Client", professional tone
  - Sections in order: Overview → Scope → Deliverables → Fees → Revisions → IP → Confidentiality → Termination
  - Default revision policy: 2 rounds, 5 business days per round
  - Default payment: 50/50, NET 30
  - 4 standard clauses captured (IP transfer, mutual NDA, kill fee, force majeure)

⚠ Detected but needs your check:
  - Reference format: ACME-REBRAND-202410 → I generalised this as {CLIENT}-{PROJECT}-{YYYYMM}. Right?
  - Custom section: "AI Usage Policy" — I captured the wording verbatim, but it mentions GPT-4 specifically. Want to keep that or generalise?

✗ Couldn't extract:
  - Late payment terms — not mentioned in this SOW. Want to add one now?
  - This SOW had no Force Majeure clause. Want me to suggest one from the clause library?

Save as your SOW style? (yes / let me edit / discard)
```

Let the user say yes/edit/discard before writing to `sow-style.md`.

## If they already have a saved style

Ask: replace, merge, or compare.

- **Replace:** Overwrite `sow-style.md` entirely.
- **Merge:** Add new clauses to the library (don't duplicate). Keep existing defaults unless ingested SOW explicitly differs. Add custom sections that aren't already there.
- **Compare:** Show a side-by-side of what's different. Let the user pick which version of each field to keep.

Default to **compare** if you're unsure — it's the safest.
