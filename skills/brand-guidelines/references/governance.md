# Brand Guidelines Governance

The most under-included section in brand guidelines, and the reason most
guidelines documents die on the vine. Without governance, the document is a
PDF in a folder somewhere; with governance, it's a living system that gets
updated, used, and respected.

This file is read at generation time when the user includes the Governance
section (recommended for every guidelines document beyond a one-pager).

---

## What governance covers

A governance section answers six questions:

1. **Who owns the brand?** A named role, ideally a named person.
2. **How is it updated?** What's the process to change a rule?
3. **How do you request an exception?** What happens when a designer needs to
   break a rule for a legitimate reason?
4. **How often is it audited?** When does someone review whether the
   guidelines are still right?
5. **How is it distributed?** Who gets the document, in what format, with what
   training?
6. **What happens when it's wrong?** How is the brand corrected when something
   ships off-brand?

If any of these questions don't have answers, the brand will drift.

---

## Standard governance section

```markdown
## Governance

### Who owns these guidelines
- **Brand owner:** {Role / Name / Email}
- **Design system owner:** {Role / Name / Email} *(if separate)*
- **Approver for exceptions:** {Role / Name / Email}
- **Approver for major updates:** {Role / Name / Email}

### How to use this document
- Read the section relevant to your task
- Apply the rules
- Where the rules are unclear, apply the principle and the "when in doubt"
  heuristic
- If you're still stuck, contact the owner above *before* shipping

### How to request an exception
Sometimes the rules don't fit the situation. That's expected. Here's the
process:

1. State the rule you want to break and the reason
2. Propose the alternative
3. Send to {approver email / channel} with subject: "Brand exception request:
   {short description}"
4. Approval is usually returned within {timeframe — e.g., 2 working days}
5. If urgent, escalate to {role}

Approved exceptions are logged in the exception register *(see below)* so the
brand can learn from them. Repeated exceptions to the same rule mean the rule
needs revising.

### How to request a change to the guidelines
1. Identify the specific section and rule you want to change
2. Explain why — citing the failure of the current rule, not just preference
3. Propose the new wording
4. Send to {brand owner} with subject: "Guidelines change proposal: {section}"
5. Brand owner reviews monthly and decides what makes the next version

### Versioning
- Major version (e.g., 1.0 → 2.0): a fundamental brand change (rebrand,
  positioning shift, new visual system)
- Minor version (e.g., 1.0 → 1.1): meaningful updates (new rules, new
  sections, deprecated rules)
- Patch version (e.g., 1.1 → 1.1.1): typos, broken links, asset updates

The current version is in the document header. The full version history is at
the back of the document.

### Audit cadence
- **Quarterly:** light audit of which rules are being followed and which are
  routinely broken
- **Annually:** full audit, with explicit review of every section. Rules that
  are routinely broken either get enforced more strictly or get rewritten
- **On significant business change:** ad-hoc audit (new market, new product
  line, new co-branding partner, new accessibility requirements)

### Distribution
- Internal team: {channel — e.g., "linked from the company wiki + onboarding
  pack"}
- Agency partners: {channel — e.g., "shared via brand portal at the start of
  each engagement, with a 30-min walkthrough"}
- Licensees: {channel — e.g., "annual training + signed acknowledgement"}
- Public: {channel — e.g., "open at brand.{company}.com"}

### Training
- New joiners: {process — e.g., "30-min brand intro in week 1, with the brand
  owner"}
- Agency partners: {process}
- Designers and writers across the business: {process}

### When something ships off-brand
1. The brand owner is notified
2. The off-brand asset is logged in the exception register *(was this
   approved? if not, what happened?)*
3. If the asset is in the wild, it's corrected at the next reasonable update
4. If the failure was caused by an unclear rule, the rule is revised at the
   next minor version

### Exception register *(internal only)*
A log of approved exceptions and learned lessons. Format: date, requester,
rule, exception granted, reason. Reviewed at the quarterly audit.

| Date | Requester | Rule | Exception | Reason | Outcome |
|------|-----------|------|-----------|--------|---------|
| {date} | {name} | {rule} | {what was allowed} | {why} | {how it landed} |
```

---

## Modulating governance by audience

The governance section flexes by audience:

**Internal team:** full governance section. Names, channels, processes —
everything. The owner is named.

**Agency partner:** governance section is shorter. Includes who to contact for
exceptions, the audit cadence (so they know when guidelines might change), and
the change-request process. Skips the exception register and the internal
training plans.

**Licensee:** governance section is *strictest*. Heavy on what requires
approval, what doesn't, and what the consequences of off-brand work are
(including financial penalties or licence suspension if relevant). Light on
"how to request changes" — licensees rarely have that right.

**Public:** governance section is minimal. A single line on who owns the brand
and where to direct questions. The internal exception register and audit
cadence aren't shared publicly.

---

## When the governance section can't be filled

If the user can't answer the basic governance questions, this is a real signal.
The brand probably needs governance work *before* it needs better guidelines.
Surface this honestly in the gaps list:

> **Gap:** No named brand owner. Without a clear owner, this document will not
> be maintained and will drift within 6 months. Recommend assigning ownership
> *before* publishing the guidelines externally.

Don't paper over missing governance with vague language. The whole point of
this section is to make the brand maintainable.
