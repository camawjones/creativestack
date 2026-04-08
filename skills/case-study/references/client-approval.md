# Client Approval Workflow

**Where most case studies die.** The team writes it, the client sits on it
for two months, the case study never gets published. This is a known,
recurring failure mode that most case study tools ignore entirely.

This skill closes the loop by producing a **client approval package**
alongside the case study itself. The package includes:

1. An approval-safe version of the case study (different from the full
   version)
2. A draft email to the client asking for approval
3. A sign-off checklist that pre-empts the client's likely objections
4. A list of specific items the client needs to confirm

The goal is to make it as frictionless as possible for the client to say
yes — not to protect the agency from the client's sensitivities.

---

## 1. Approval-safe version vs full version

The full version of the case study is for the agency's editorial use. The
approval-safe version is what the client actually sees. They differ in
several ways:

### What changes in the approval-safe version

| Element | Full version | Approval-safe version |
|---|---|---|
| **"What was hard" section** | Included with honest framing | Softened or moved to internal notes only |
| **Strategic rationale** | Frank — "we thought the client was wrong about X" | Reframed — "we explored several directions together" |
| **Client sentiment arc** | Specific, including dips | Smoothed, positive overall |
| **Unexpected outcomes** | Included | Included but framed as shared insight |
| **Methodology transparency** | Includes agency's proprietary framing | Excludes proprietary methodology references the client might find presumptuous |
| **Metrics** | All available | Only metrics the client is comfortable sharing (some may be commercially sensitive) |
| **Team credits** | Full agency team | Client team credited alongside agency team |
| **Client quotes** | Candidate quotes extracted from meeting logs | Only quotes the client explicitly approves |
| **Pull quotes from client** | Draft suggestions (bracketed as TBC) | Only client-approved wording |

### The principle

The approval-safe version isn't a censored version — it's a **collaboratively
framed** version. The agency and the client are sharing credit for the
work, not competing for it. The framing should make the client look good,
the agency look competent, and the partnership look strong.

### When the two versions diverge significantly

If the full version contains important material that the approval-safe
version must cut (e.g. a "what was hard" moment that the client won't
sign off on, or a commercially sensitive metric), the skill should flag
this clearly:

> "⚠️ The full version includes a 'what was hard' section describing a
> mid-project direction shift. The approval-safe version softens this to
> 'we explored several directions together.' If the full version is
> important for the internal portfolio, keep both — publish the
> approval-safe version externally and retain the full version internally."

---

## 2. Draft client approval email

After generating both versions, the skill produces a draft email the user
can send to the client asking for approval.

### Email structure

```markdown
### Draft: Case Study Approval Request

**To:** {client contact — from project state stakeholders}
**From:** {user's name from profile.md}
**Subject:** Case study draft — {Project name}

Hi {client contact first name},

I'm putting together a case study for our portfolio on the {project name}
work. Wanted to share the draft before it goes anywhere — want to make
sure you're comfortable with how we've framed everything.

Attached (or below) is the approval version. A few specific things I'd
love your thumbs-up on:

1. **The quote on page {page/section}** — I pulled this from {our final
   review meeting on {date} / our conversation after launch / your email
   to us on {date}}. If you'd rather rephrase it or use a different quote,
   just let me know what you'd prefer.

2. **The metrics we've referenced** — {list specific metrics}. Are these
   numbers you're comfortable having in public? If any of them need to
   stay internal, I'll strip them.

3. **Your title and attribution** — I've used "{client title}" — is that
   how you'd like to be credited?

4. **Project timeline reference** — I've described the project as taking
   {duration}. Let me know if there's anything you'd prefer I not mention
   about the timeline.

{If there are any other specific items from the sign-off checklist:}
5. **{Item}** — {what to confirm}

No rush on a response — take whatever time you need. And if anything in
the draft doesn't feel right, even a small thing, just tell me — we can
rework it. I'd rather get it right than get it fast.

Thanks again for the work we've done together on this.

{user's sign-off — matching the agency's tone-of-voice.md}
```

### Email framing principles

The email should:

1. **Reduce perceived effort** — "a few specific things" is easier than
   "please review"
2. **Pre-empt the most common concerns** (quotes, metrics, attribution,
   timeline) so the client doesn't have to think of them
3. **Give explicit permission to say no** — "if any of them need to stay
   internal" is easier than "please approve"
4. **Remove time pressure** — clients delay when they feel pushed;
   explicit "no rush" usually speeds up responses
5. **Credit the relationship** — the closing line positions the case
   study as a shared artifact, not an agency promotional piece
6. **Match the client's register** — formal/warm/direct per the
   `tone-of-voice.md` the agency uses with this client

### Customisation per client relationship

The skill should read `clients.md` (if it has relationship depth data)
and `learnings.md § Client Patterns` (for communication style) to
customise the email:

- **Formal client** → more structured email, less casual phrasing
- **Warm client** → more personal, reference specific shared moments
- **Data-driven client (per learnings)** → include the specific metrics
  in the email body so they can sign off efficiently
- **Craft-driven client** → mention the craft specifically in the framing
- **Politically-careful client** → add reassurance that nothing is final
  and edits are welcome

---

## 3. Sign-off checklist

A bulleted list the user can use to track client responses:

```markdown
### Sign-off Checklist

Required before publication:

- [ ] Client quote: "{exact quote}" — attribution: {name, title}
- [ ] Metric 1: {specific metric} — confirmed publishable
- [ ] Metric 2: {specific metric} — confirmed publishable
- [ ] Client attribution: {name, title, company}
- [ ] Timeline reference: "{specific phrase}" — OK to use
- [ ] Any images of client team or executives — OK to use
- [ ] Mention of {specific initiative or product} — OK to name publicly

Optional (nice to have but not blocking):

- [ ] Long-form interview quote for extended version
- [ ] Permission to name the internal team at the client
- [ ] Permission to reference the commercial outcome (revenue, margin)
- [ ] Permission to share the brief or strategy documents

Published version:

- [ ] Final version approved
- [ ] Images and assets final
- [ ] Legal sign-off (if applicable)
- [ ] Publication date agreed
```

### Checklist prioritisation

Not every item needs approval before publication. The skill should
distinguish:

- **Required** — items that can't go public without explicit yes
- **Optional** — items that would strengthen the case study but can be
  dropped if the client declines
- **Published version** — final sign-off before the case study goes live

### Handling partial approval

If the client approves some items and declines others:

1. Produce a **partial-approval version** that only includes the approved
   items
2. Flag what was dropped and why in internal notes (not in the public
   version)
3. Offer to follow up on specific items if the client's reason for
   declining might change ("the metric is commercially sensitive right
   now but OK to share in 6 months")

### Handling silence

If the client doesn't respond within 2 weeks, the skill can suggest a
follow-up:

> "No response yet? Here's a draft follow-up — warm, no pressure, just a
> nudge."

---

## 4. Pre-empted client questions

The email above pre-empts the most common questions. But specific
projects have specific concerns. The skill should scan the project's
brain files and pre-empt any that apply to this project specifically.

### Common client concerns and pre-empts

| Client concern | How to pre-empt |
|---|---|
| "Is this making my company sound bad?" | Lead the email with "I think this makes {client} look great — but tell me if any framing doesn't sit right." |
| "Am I saying something I shouldn't?" | Explicitly call out any quote and ask for confirmation, with an easy out ("if you'd rather rephrase") |
| "Are the metrics commercially sensitive?" | List specific metrics and ask for per-metric confirmation |
| "Will this go to press or just the website?" | Name the intended publication channels upfront |
| "Will competitors see this?" | Acknowledge it — "this will be on our site and in proposals for similar work" — and let the client decide |
| "Is the timing right?" | Ask directly — "is there a specific launch date or quiet period you'd like us to avoid?" |
| "Did you clear this with legal?" | For regulated industries, proactively mention that the draft can go to client legal before publication |
| "Will my name be on this?" | Ask directly about attribution preferences |

### Project-specific pre-empts

Some projects have specific sensitivities the skill should detect:

- **Rebrand project** → pre-empt "does this say we were broken before?"
  by framing the before state as "the brand had evolved, and the system
  hadn't caught up"
- **Digital product** → pre-empt "are you revealing our strategy?" by
  asking what level of product detail is shareable
- **Regulated industry** → pre-empt "does this need legal review?" by
  offering the draft for their legal team
- **Recently-public campaign** → pre-empt "is it too early to publish?"
  by asking about an embargo or quiet period

Read the project type from `projects/{slug}-brief.md` frontmatter and
apply the relevant pre-empts to the email automatically.

---

## 5. When client approval isn't needed

Some case studies don't need client approval:

- **Internal-only case studies** (for the portfolio, not public)
- **Anonymised case studies** (no client name, no specific identifiers)
- **Case studies using only publicly available information** (campaigns that
  ran in public, products that shipped)
- **Awards submissions** (some awards don't require client sign-off)

In these cases, the skill should skip the approval package but note it:

> "This is an anonymised case study — no client approval required. The
> published version uses [Client] placeholders. If you later decide to
> de-anonymise and publish with the client's name, re-run this skill in
> Update mode and I'll generate the approval package then."

---

## 6. The approval package output

When a case study is generated in Write or Awards mode, the approval
package is produced as a separate section after the full case study:

```markdown
---

## Client Approval Package

{Generated in Write mode, when the case study names a specific client.}

### Approval-safe version

{The case study, modified per the "approval-safe vs full" rules above.
Formatted as a copy-paste-ready document the user can attach to an email
or share as a link.}

### Draft email

{The email per the format above, with fields filled in from project state.}

### Sign-off checklist

{The checklist per the format above, with items populated from the
specific case study content.}

### Items flagged as sensitive

{Any items the skill flagged during generation that need extra attention.
Could be specific quotes, metrics, or framing that the skill isn't sure
the client will approve.}

### Suggested timing

{When to send the email, based on learnings.md § Client Patterns for this
client if available. "This client typically takes 2 weeks to respond to
approval requests; send with that timeline in mind."}

### Follow-up draft (for use in 2 weeks if no response)

{A shorter follow-up email, warm and low-pressure.}

---
```

The approval package is the most practical output of the whole skill.
It's what turns a written case study into a published one.
