# Team Brain Schema

This skill reads from and (with permission) writes to three Brain files:

1. `~/.creativestack/team.md` — internal team roster, **extended schema**
2. `~/.creativestack/freelance-bench.md` — trusted freelance roster
3. `~/.creativestack/learnings.md` — appended `## Capacity` section

All three are designed to be **backwards compatible** and **hand-editable**. The
skill works with the minimum (just a name and a role) but gets sharper with each
field that's filled in.

---

## team.md — Extended schema

The base `team.md` from `/setup-cs` looks like this:

```markdown
---
headcount: 12
last_updated: 2025-12-01
---

## Creative
- **Sarah Chen** — Creative Director
- **Mike Torres** — Design Lead
```

The extended schema adds optional indented bullets per person. Every field is
optional. The skill uses what's there and ignores what isn't.

```markdown
---
headcount: 12
last_updated: 2026-04-07
type: agency
default_target_utilisation: 75
---

## Creative
- **Sarah Chen** — Creative Director
  - seniority: senior
  - contracted_hours: 40
  - day_rate: 750
  - specialisms: brand strategy, identity, campaign direction
  - can_substitute_for: senior designer, design lead
  - notes: Strongest on premium / sport. Avoid putting on FMCG.
  - leave_pattern: Always takes school holidays off
- **Mike Torres** — Design Lead
  - seniority: senior
  - contracted_hours: 32
  - day_rate: 600
  - specialisms: identity, type, editorial
  - can_substitute_for: senior designer, art direction
  - notes: Part-time Fridays. Don't book past Thursday lunch.
- **Jade Park** — Senior Designer
  - seniority: mid
  - contracted_hours: 40
  - specialisms: digital product, motion
  - can_substitute_for: mid designer
```

### Field reference

| Field | Type | What it does |
|---|---|---|
| `seniority` | `junior` / `mid` / `senior` / `lead` / `principal` | Drives substitution rules and target utilisation |
| `contracted_hours` | number (per week) | Defaults to 40. Part-timers must set this. |
| `day_rate` | number (in profile currency) | Used for cost-out comparisons against freelance |
| `specialisms` | comma list | Free-text. Used for skill-matching in rebalancing |
| `can_substitute_for` | comma list | Roles this person can credibly cover. Single most useful field. |
| `notes` | free text | Anything the skill should remember (project fit, client allergies, working style) |
| `leave_pattern` | free text | Recurring availability constraints (school holidays, religious observance, regular off-day) |

### Frontmatter additions

| Field | What it does |
|---|---|
| `default_target_utilisation` | Skips the [SELECT] question on every run |
| `type` | Already set by `/setup-cs`; used for language adaptation |

### Upgrade flow (when team.md exists but is minimal)

When the skill detects `team.md` has names but no extended fields, it offers
**Setup team** mode. The flow:

1. List people without extended fields
2. Ask the user to enrich them in batches of 3-5 (not all at once)
3. For each person, ask the **single most valuable field first**: `seniority` and
   `can_substitute_for`. Everything else is optional.
4. Write back, preserving any existing structure (departments, ordering)
5. Confirm: "Updated 8 people. Run /resource-conflict again — every suggestion will now be specific."

**Never overwrite** existing fields without confirmation. **Never delete** people.
The skill is additive.

---

## freelance-bench.md — Trusted freelance roster

Created and maintained by this skill. Lives at `~/.creativestack/freelance-bench.md`.

```markdown
---
last_updated: 2026-04-07
bench_size: 8
currency: GBP
---

## Designers
- **Alex Rivera** — Senior Designer (motion + brand)
  - day_rate: 550
  - lead_time: 1 week
  - last_engaged: 2025-09
  - rating: A
  - status: active
  - specialisms: motion, brand identity, pitch work
  - notes: Great on tight pitches. Confident with client. Limited capacity in summer.
- **Priya Mehta** — Mid Designer (digital)
  - day_rate: 425
  - lead_time: 3 days
  - last_engaged: 2026-02
  - rating: A
  - status: active
  - specialisms: digital product, web, prototyping
  - notes: Fast and reliable. Best on defined briefs, less so on ambiguous strategy work.

## Strategists
- **Jamie Liu** — Brand Strategist
  - day_rate: 700
  - lead_time: 2 weeks
  - last_engaged: 2024-11
  - rating: A+
  - status: active
  - specialisms: brand strategy, naming, positioning
  - notes: Premium pricing but worth it. Best on category-defining work.

## On-hold / archive
- **Tom Whitfield** — Illustrator
  - day_rate: 500
  - last_engaged: 2023-06
  - rating: B
  - status: archived
  - notes: Quality drop on last engagement. Don't re-book without checking work.
```

### Field reference

| Field | What it does |
|---|---|
| `day_rate` | Used for cost comparisons in Freelance Recommendations |
| `lead_time` | How fast can they start. Critical for crunch responses |
| `last_engaged` | YYYY-MM. Helps the user remember the relationship state |
| `rating` | A+ / A / B / C — informal performance memory |
| `status` | `active` / `on-hold` / `archived` — only `active` shows up in suggestions by default |
| `specialisms` | Drives matching against the role gap in the analyse output |
| `notes` | Anything that affects the next booking decision |

### Setup bench mode

When the skill detects no `freelance-bench.md` and the user opts in to freelance
suggestions, offer **Setup bench**:

1. "Who do you trust on freelance? Even 3-5 people is enough to start."
2. For each person, ask name + role + day rate + 1-2 sentence notes. Skip the rest.
3. Write the file. Tell the user they can edit it directly any time.
4. Future runs will use it automatically.

---

## learnings.md — Capacity section

This skill **appends** to the existing `learnings.md` (created by `/setup-cs`)
under a `## Capacity` heading. It does not create a separate file.

```markdown
## Capacity

### {2026-04-07} — {Project: Nike Air Pitch}
- Planned allocation: Sarah 40%, Mike 60%, Jade 100%
- Actual: Sarah 65%, Mike 80%, Jade 110%
- Delta: All three under-allocated by ~25%
- Reason: Client revision rounds doubled. Jade absorbed most of the overrun.
- Lesson: For pitch work with this client, plan +30% on senior creative.

### {2026-03-15} — {Pattern}
- Sarah's actual capacity is closer to 65% than the 80% she's been planned at
- Reason: Carries 8h/week of mentoring + leadership meetings not counted in allocations
- Lesson: Plan Sarah at 65% target, treat 70%+ as red flag
```

### Calibrate mode

After a project ends or a major milestone, the skill offers **Calibrate**:

1. "What actually happened on {project}? Who was over/under?"
2. Capture in the format above
3. Append (never overwrite) to `learnings.md`
4. Future Analyse runs read this section and apply the lessons:
   - "Sarah's planned at 80% but past learnings say 65% is her real ceiling — flagging this as already at risk"

This is the compounding loop. Three calibrations and the skill knows your team's
real shape.

---

## Read order

When the skill starts an Analyse run:

1. Read `team.md` — get the roster + extended fields
2. Read `learnings.md` § Capacity — apply known calibrations
3. Read `freelance-bench.md` — only if user opts into freelance suggestions
4. Read project state (`~/.creativestack/projects/_index.md` and individual project files) — get current allocations

Missing files are non-fatal. Note what's missing in the output and offer Setup
modes to fill the gaps.
