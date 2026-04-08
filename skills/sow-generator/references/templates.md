# SOW Template Variations

Read this file when generating a SOW with no saved style, or when the user explicitly asks for a Project / Retainer / Discovery / Phased template.

If `sow-style.md` exists, the user's saved structure overrides anything below — use this file only as a fallback or to fill in sections the user hasn't customised.

## Default Project Template

The fallback structure when no style is saved.

```markdown
# Statement of Work

**Project:** {project name}
**Client:** {client name}
**{voice_us}:** {agency name from profile.md}
**Date:** {today}
**Reference:** {generated per user's reference_format, or {client-initials}-{project-code}-{YYYYMM}}
**Type:** Project

---

### 1. Project Overview
{Brief description, purpose, what success looks like.
If /creative-brief ran earlier, reference objectives and success metrics.}

### 2. Scope of Work
{Detailed description of what {voice_us} will do.
If /proposal-generator ran earlier, pull scope directly.}

#### In Scope
- {Specific deliverable or activity}

#### Out of Scope
- {Explicitly excluded items — items that would require a separate SOW}

### 3. Deliverables
| # | Deliverable | Description | Format | Due |
|---|---|---|---|---|
| 1 | {deliverable} | {description} | {format} | {date or phase} |

### 4. Timeline
| Phase | Description | Duration | Start | End |
|---|---|---|---|---|
| {phase} | {description} | {weeks} | {date} | {date} |

**Total project duration:** {weeks/months}

### 5. Investment & Payment Schedule
**Total project fee:** {amount}

{Insert table for chosen payment structure — see "Payment Structures" below}

**Payment terms:** {days} days from invoice date
**Late payment:** {terms from sow-style.md, or skip}

### 6. Revision Policy
{Insert per chosen revision policy — see "Revision Policies" below}

### 7. Client Responsibilities
- {Responsibility — e.g., "Provide brand assets within 5 business days of kick-off"}
- {Responsibility — e.g., "Designate a single point of contact for feedback"}
- {Responsibility — e.g., "Provide consolidated feedback within the revision window"}

**Delay clause:** If client-side delays exceed {days} business days, the timeline will be adjusted accordingly and {voice_us} reserves the right to reassign resources.

### 8. Intellectual Property
{Pull from sow-style.md clause library if present, otherwise use:}
- All IP transfers to {voice_them} upon final payment in full
- {voice_us} retains the right to use the work in portfolios and case studies
- Third-party assets (stock imagery, fonts, etc.) are licensed separately and subject to their own terms
- Work-in-progress and unused concepts remain the property of {voice_us}

### 9. Confidentiality
{Pull from sow-style.md if present, otherwise use:}
Both parties agree to keep project details confidential. Neither party will disclose proprietary information without written consent.

### 10. Termination
{Pull from sow-style.md if present, otherwise use:}
- Either party may terminate with {days} days' written notice
- Upon termination, {voice_them} pays for all work completed to date
- Work completed to date is delivered upon payment

### 11. General Terms
- This SOW constitutes the entire agreement for this project
- Amendments require written agreement from both parties

{Insert any custom sections from sow-style.md in their saved positions}
```

## Payment Structures

### 50/50 Upfront/Final
| Payment | Amount | % | Due |
|---|---|---|---|
| Upfront | {amount} | 50% | On execution |
| Final | {amount} | 50% | On completion |

### Milestone-based
| Milestone | Amount | % | Due |
|---|---|---|---|
| Upon signing | {amount} | {%} | On execution |
| {milestone} | {amount} | {%} | {trigger} |
| Final delivery | {amount} | {%} | On completion |

### Monthly
| Month | Amount | Deliverables covered |
|---|---|---|
| Month 1 | {amount} | {scope for this period} |

### Per phase
| Phase | Fee | Trigger |
|---|---|---|
| Phase 1 | {fee} | On execution |
| Phase 2 | {fee} | Phase 1 sign-off |

## Revision Policies

### Strict (1 round)
- **Rounds included:** 1 round of revisions per deliverable
- **Definition of a round:** Consolidated feedback addressed in a single pass
- **Additional rounds:** Charged at {rate} per round
- **Revision window:** {days} business days
- **Note:** Consolidated feedback is essential — partial feedback counts as the round

### Standard (2 rounds)
- **Rounds included:** 2 rounds of revisions per deliverable
- **Additional rounds:** Charged at {rate} per round
- **Revision window:** {days} business days per round

### Generous (3 rounds)
- **Rounds included:** 3 rounds of revisions per deliverable
- **Additional rounds:** Charged at {rate} per round
- **Revision window:** {days} business days per round

### Unlimited within timeframe
- **Revision window:** {days} business days from deliverable presentation
- **Within window:** Unlimited revisions at no additional cost
- **After window:** Revisions charged at {rate} per round
- **Note:** Requires responsive, consolidated feedback to work

## Retainer Template

Adjustments from the Project template:
- **Section 1:** Frame as ongoing partnership, not single project
- **Section 2:** Define monthly scope as hours or deliverable types, not fixed deliverables
- **Section 3:** Replace fixed deliverable table with monthly deliverable categories
- **Section 4:** Replace project timeline with contract term (start, end, renewal terms, notice period)
- **Section 5:** Monthly invoicing — include rollover/forfeit policy for unused hours
- **Section 6:** Revisions included within monthly scope, no separate round counting
- **Add — Monthly reporting:** What {voice_them} receives each month (hours used, work completed)
- **Add — Scope adjustment:** Process for changing monthly scope mid-contract
- **Add — Renewal:** Auto-renew vs. opt-in, notice period for non-renewal

## Discovery Template

Adjustments from the Project template:
- **Section 1:** Frame as time-boxed exploration with defined outputs, not committed deliverables
- **Section 2:** Scope is the discovery process and outputs, not final production work
- **Section 4:** Fixed duration (typically 2-4 weeks) with clear end date
- **Section 5:** Typically 100% upfront or 50/50
- **Add — Discovery outputs:** What {voice_them} receives at the end (findings doc, recommendations, next-phase proposal)
- **Add — Next steps:** How discovery feeds into a potential project SOW (without committing to it)
- **Section 6:** Often no formal revisions — discovery outputs are presented and discussed once

## Phased Template

Adjustments from the Project template:
- **Section 2:** Break scope into distinct phases with clear boundaries
- **Section 3:** Deliverables grouped by phase
- **Section 4:** Each phase has its own timeline
- **Section 5:** Payment per phase, triggered by phase gate approval
- **Add — Phase gates:** What needs to happen for the next phase to proceed (deliverable approval, written sign-off, payment received)
- **Add — Phase independence:** Each phase can be contracted independently; later phases are not guaranteed and require re-confirmation
- **Add — Off-ramp:** What happens if {voice_them} chooses not to proceed past a gate (final deliverables of completed phase, no penalty)
