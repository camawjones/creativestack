# Naming Conventions

> Agencies either have a rock-solid naming system or they don't. If they do, adopt it.
> If they don't, propose one and write it to the brain so every future spec matches.

## How to use this file

Before imposing a naming convention, check:

1. **Brain** — does `tools.md` or `profile.md` contain a naming pattern?
2. **Project state** — does the current project's state file mention a convention?
3. **User confirmation** — ask the user if they have an existing convention to match

If none exists, propose the default below and offer to save it to the brain for future runs.

---

## Detection: spot an existing convention

If the user provides existing files, try to reverse-engineer their convention:

- Look at delimiter usage: `_` vs `-` vs camelCase
- Look for date formats: `YYMMDD`, `YYYY-MM-DD`, `24Q2`
- Look for version suffixes: `_v1`, `_V1`, `_rev1`, `-final`
- Look for ordering: `{client}_{project}_{asset}` or `{project}_{client}_{asset}`

Mirror their existing pattern. Don't force the default.

---

## Default convention (when none exists)

```
{client}_{campaign}_{asset-type}_{placement}_{aspect}_{lang}_{version}.{ext}
```

**Rules:**
- All lowercase
- Word separator: `-` (hyphen) within a segment
- Segment separator: `_` (underscore) between segments
- No spaces, no special characters
- `{client}` is 3-8 chars, client shortcode agreed with client
- `{campaign}` is the campaign slug (e.g., `summer25`, `launch`, `always-on-q2`)
- `{asset-type}` describes the creative (`hero`, `testimonial`, `product-demo`, `tvc-30`, `48sheet`)
- `{placement}` is the platform/destination (`metafeed`, `metastory`, `tiktok`, `dv360`, `itv`, `ccsroadside`)
- `{aspect}` is the ratio as `WxH` (`1x1`, `4x5`, `9x16`, `16x9`, `2x3`)
- `{lang}` is ISO 639-1 (`en`, `fr`, `de`, `es`, `ar`, `ja`, `zh-cn`)
- `{version}` is `v1`, `v2`, `v1a`, `v2-final`, etc.

**Example:**
```
acme_summer25_hero_metafeed_1x1_en_v1.jpg
acme_summer25_hero_metastory_9x16_en_v1.mp4
acme_summer25_tvc30_itv_16x9_en_v2-final.mxf
```

---

## Version / round suffixes

| Suffix | Meaning | Example |
|---|---|---|
| `_v1`, `_v2` | Major revision rounds (full client review) | `_v1.jpg` |
| `_v1a`, `_v1b` | Minor amends within a round | `_v1a.jpg` |
| `_v2-final` | Approved and signed off | `_v2-final.jpg` |
| `_v2-final-print` | Print-ready version (CMYK, bleed) | `_v2-final-print.pdf` |
| `_v2-master` | Master file for further variants | `_v2-master.psd` |
| `_wip` | Work in progress — not for review | `_v2-wip.psd` |

**Golden rules:**
- Never overwrite a previous version — always increment
- `final` means client-approved. If changes come after `final`, it becomes `v3`
- Source files keep the same convention with `-master` or `-source` suffix
- The file in `_wip` state is never sent for review — it's a working copy

---

## Agency-wide vs per-client

Some agencies use one convention globally; others let each client dictate. If the
client has a system, adopt it. If the agency has a system, adopt it. Only propose a
new one if neither exists.

**When the user confirms a convention, offer to save it:**
- To the brain (`tools.md` or a new `naming-convention.md`) — for agency-wide use
- To the project state's Skill Memory — for this one client/project

This way the next asset-spec run doesn't re-ask.

---

## Common agency conventions (for reference)

### By date first (good for rolling always-on)
```
{yymmdd}_{client}_{channel}_{asset}_{variant}.{ext}
240815_acme_ig_feed_hero-v1.jpg
```

### By project first (good for campaigns)
```
{client}{yymm}_{project}_{asset}_{variant}.{ext}
acme2405_summer_hero-feed_v1.jpg
```

### By category-prefixed ID (good for large campaigns)
```
{client}-{campaign}-{id}-{variant}.{ext}
acme-summer25-soc001-v1.jpg
```

The CSV production tracker's `ID` column can drive this — SOC-001, DIS-012, VID-003.

---

## Folder structure alongside naming

A good naming convention + folder structure means you can find anything in 10 seconds.

### Default folder structure

```
/{client}-{campaign}
  /00-brief-and-references
  /01-concepts-and-routes
  /02-master-files
    /source
    /fonts
    /stock-and-assets
  /03-deliverables
    /social
      /meta
      /tiktok
      /linkedin
    /display
    /video
    /print
    /ooh
    /packaging
    /web
    /email
  /04-approved-final
  /05-archive
  /06-rights-and-clearances
```

### Rules
- `02-master-files` holds the source files — never send these to clients
- `03-deliverables` holds exports organized by category
- `04-approved-final` holds only signed-off final files
- `05-archive` holds superseded versions (don't delete, archive)
- `06-rights-and-clearances` holds signed releases and license docs

---

## Detecting and persisting

If the user says something like "we usually use YYMMDD_client_asset", capture it:

1. Confirm the exact pattern and delimiters
2. Save to the brain or project state
3. Generate all subsequent filenames using it
4. Reference it in the spec output so the production team follows suit

This is the kind of operational continuity that makes this skill actually useful
on run #2.
