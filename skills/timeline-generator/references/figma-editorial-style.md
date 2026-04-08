# Figma Timeline — Gantt Application of House Visual Style

This file applies the agency's house visual style to a Gantt-style timeline rendered in
Figma. **Read `~/.creativestack/visual-style.md` first** — that's where the global
aesthetic principles, typography pairings, color palettes, spacing system, and
anti-slop checklist live. This file only adds the timeline-specific bits on top.

If `~/.creativestack/visual-style.md` doesn't exist, fall back to the defaults baked
into the setup skill (Pairing A — Editorial Modern, Palette 1 — Paper & Ink). Either
way, the global rules apply: hairlines only, one accent, no gradients, no shadows,
no rounded corners, asymmetric grid-anchored composition, generous margins.

---

## Frame setup

The timeline lives in a single parent frame.

- **Frame size:** 1600px wide × variable height. 1600 fits a 16-week project at
  comfortable spacing. For longer projects, scale `COL_W` down rather than scaling
  the frame up.
- **Outer padding:** 96px on all sides.
- **Title block:** Top-left, takes the top 200px. Project name in display font (56–72px,
  regular weight, tight leading). Below the title, a metadata strip in mono caps
  separated by `·`: `DURATION · TEAM · GENERATED`.
- **Header rule:** A 1px hairline (primary text color) sits 32px below the metadata
  strip, spanning the full content width. This is the only horizontal rule in the
  header.

## Gantt grid construction (critical for alignment)

The Gantt chart MUST use a single parent frame with absolute-positioned children.
**Never** auto-layout rows. Auto-layout drift is the single most common reason a
generated timeline looks wrong.

### Grid constants
- `LABEL_W = 240` — left column for phase names
- `COL_W = 72` — width per week column (drop to 48 for projects > 20 weeks)
- `ROW_H = 40` — height per phase row
- `WEEKS = N` — total number of weeks

### Construction order
1. **Vertical hairlines first.** For each `i` from `0` to `WEEKS`, draw a 1px rectangle
   at `x = LABEL_W + i * COL_W`, full chart height, primary text color. These are the
   editorial grid — they must be visible.
2. **Week header row.** Above the chart, render `"W01"`, `"W02"`, … in mono 11px
   medium, centered in each column: `x = LABEL_W + i * COL_W + (COL_W - textW) / 2`.
   Add the actual date (`"04 May"` etc.) in mono 9px secondary-color directly beneath.
3. **Phase labels (left column).** Right-aligned at `x = LABEL_W - 16`, vertically
   centered in the row. Body font, 12px, medium weight.
4. **Phase bars.**
   - `x = LABEL_W + startWeek * COL_W + 4`
   - `width = durationWeeks * COL_W - 8`
   - `height = ROW_H - 16`
   - vertically centered in the row
   - **Corner radius: 0**
   - Fill: monochrome at the workstream's opacity tier (100% / 70% / 40%)
5. **Critical-path bars.** Same geometry, but fill = accent color, plus a 1px
   hairline directly beneath the bar spanning its full width. The underline marks
   "this is on the critical path" — never use a glow or border.
6. **Workstream section dividers.** A 1px hairline above the first row of each
   workstream, with the workstream name in tracked uppercase 11px sitting on the
   rule, left-aligned to `LABEL_W - 16`.
7. **Review-window markers.** Vertical accent-color blocks at 20% opacity spanning
   the full chart height (top to bottom of all rows) at the review-window weeks.
   Label them at the top with the round number (e.g., "R1") in mono caps.
8. **Internal crit markers.** Smaller vertical bars (8px wide), accent color at 60%
   opacity, sitting just before each client review window. Label "CRIT" in mono 9px
   above the chart.
9. **Milestones lane.** Reserve a 32px-tall lane above the chart labelled
   "MILESTONES" in tracked uppercase. Render each milestone as a small filled diamond
   (8×8px, rotated 45°) in accent color, centered on its week column. Label each
   milestone in display-italic 12px immediately to the right of the diamond.
10. **Lock milestones.** Render lock moments (Concept Lock, Design System Lock, etc.)
    as larger filled diamonds (12×12px) with the lock name in display-italic 13px,
    bold weight if available, plus a 1px vertical hairline dropping from the diamond
    to the bottom of the chart. The dropped hairline is the visual signal that
    "everything below this line depends on this lock."

### Truncation and edge cases
- If a phase label is longer than `LABEL_W - 32`, truncate with an ellipsis.
- If `durationWeeks === 1` and an internal bar label would clip, omit the internal
  label and rely on the left-column label.
- If a phase spans more than 8 weeks, render the bar as a 1px-bordered outline
  (sharp corners, no fill) instead of a solid fill, so it doesn't visually dominate
  the chart.

## Composition: internal vs client frames

Generate **two frames** in the same Figma file, stacked vertically with a 200px gap.

### Frame 1: INTERNAL
- Section header above the title: `"INTERNAL — DO NOT SHARE"` in tracked uppercase
  11px, accent color.
- Includes: phases, critical path, review windows, internal crits, milestones, lock
  moments, **risk flags as marginalia** in the right margin (italic 10px, with a thin
  leader line pointing to the relevant phase).
- **Slip Scenarios block** beneath the chart, styled as a three-column editorial
  layout (one column per scenario, separated by hairline rules). Each column has a
  scenario title in display-italic, followed by impact bullets in body 11px, and a
  "Mitigation" line in mono caps + body sentence-case beneath.
- Buffer days within phases shown as a hatched fill at the end of each bar (use a
  pattern fill if available, else a lighter opacity tier with a hairline border).

### Frame 2: CLIENT
- Section header: `"PROJECT TIMELINE"` in tracked uppercase 11px, primary text color.
- Includes: phases (renamed to client-friendly language), milestones, review windows,
  lock moments.
- **Excludes:** risk flags, slip scenarios, buffer hatching, internal crits, internal
  annotations, the critical-path underline (the accent color alone is enough).
- "Your input needed" callout at the bottom: a small block listing the dates the
  client owes feedback, styled as the metadata strip in the header (mono caps labels +
  values).

## Timeline-specific anti-slop additions

In addition to the global anti-slop checklist in `visual-style.md`, verify these
timeline-specific items before finishing:

- [ ] No timeline rendered as a giant arrow or as a chain of connected pills.
      Bars on a grid only.
- [ ] No "swimlane" backgrounds (alternating colored row backgrounds). Hairline
      dividers do the work.
- [ ] No date labels stacked vertically inside bars. Dates live in the header row.
- [ ] No icons on phase bars (gear, lightning bolt, checkmark, etc.).
- [ ] Critical path is marked by accent color + underline, not by being made
      chunkier or wider than other bars.
- [ ] Workstreams are differentiated by opacity tier of the same color, not by
      different hues.
- [ ] Review windows are vertical bands across the whole chart, not horizontal
      bars in their own row.
- [ ] Lock moments have a vertical dropped hairline — they should be the most
      visually prominent thing in the chart after the title.
