# Production Tracker CSV

> The killer artifact of this skill. A row-per-asset CSV that pastes directly into
> Google Sheets, Airtable, Notion, or Monday. Production teams stop managing assets
> in Word docs the moment they see this.

## How to use this file

Always generate a production tracker CSV as part of the asset spec output. Put it in
a fenced code block so the user can copy it cleanly. Quote any field that contains a
comma, newline, or double quote.

---

## CSV schema (columns, in order)

```
ID,Category,Asset Name,Concept,Message,Audience,Placement,Aspect,Dimensions,Format,Duration,Language,Variant,Weight Limit,Safe Zones,Deliverable,Source File,Naming,Rights,Owner,Status,Due,Notes
```

### Column definitions

| Column | What goes in it | Example |
|---|---|---|
| **ID** | Unique per asset, prefixed by category | `SOC-001`, `DIS-012`, `VID-003`, `PRN-001` |
| **Category** | Broad category | `Social`, `Display`, `Video`, `Print`, `OOH`, `DOOH`, `Email`, `Web`, `Packaging` |
| **Asset Name** | Short human-readable name | `Hero feed post`, `Launch reel`, `48-sheet poster` |
| **Concept** | Creative concept/route | `Hero`, `Testimonial`, `Product demo` |
| **Message** | Message variant | `Feature-led`, `Benefit-led`, `Social proof` |
| **Audience** | Target audience segment | `Acquisition`, `Retention`, `All` |
| **Placement** | Where it runs | `Meta Feed`, `TikTok`, `DV360`, `ITV` |
| **Aspect** | Aspect ratio | `1:1`, `4:5`, `9:16`, `16:9`, `2:3`, `3:1` |
| **Dimensions** | Pixel or mm dimensions | `1080×1080`, `1920×1080`, `148×210mm` |
| **Format** | File format | `JPG`, `PNG`, `MP4`, `PDF/X-1a`, `HTML5` |
| **Duration** | Video/animation length | `15s`, `30s`, `static`, `6s bumper` |
| **Language** | Target language/locale | `EN`, `FR`, `DE`, `AR`, `JP` |
| **Variant** | Version/iteration identifier | `v1`, `v2`, `v1a` |
| **Weight Limit** | Max file weight (network cap) | `150KB initial`, `30MB`, `—` |
| **Safe Zones** | Platform UI safe zone note | `Top 250px, bottom 340px clear`, `Title safe 80%` |
| **Deliverable** | Final delivery format | `JPG 72dpi sRGB`, `MP4 H.264`, `PDF/X-1a CMYK` |
| **Source File** | Working file that should also ship | `.psd`, `.aep`, `.indd package`, `.fig`, `—` |
| **Naming** | Final filename per the convention | `acme_summer25_hero_1x1_en_v1.jpg` |
| **Rights** | Talent/music/stock rights note | `Talent window: 12mo from 2026-04-01` |
| **Owner** | Who's building it | `Design — {name}`, `Motion — {name}`, `Print — {partner}` |
| **Status** | Production status | `TBD`, `Brief`, `WIP`, `Review`, `Amends`, `Approved`, `Delivered` |
| **Due** | Delivery date | `2026-05-12` |
| **Notes** | Anything else | — |

---

## Filling the CSV

- **One row per shipped asset.** A 1:1 and a 4:5 of the same hero are two rows.
- **ID prefixes** make the sheet sortable: SOC for social, VID for video, DIS for display, PRN for print, OOH for out-of-home, WEB for web, EML for email, PKG for packaging.
- **Leave blank** rather than guess. The user will fill in Owner, Status, Due, and Notes.
- **Quote fields** that contain commas: `"Top 250px clear, bottom 340px clear"`.
- **Escape double quotes** inside quoted fields by doubling them: `"He said ""hi"""`.

---

## Example rows

```csv
ID,Category,Asset Name,Concept,Message,Audience,Placement,Aspect,Dimensions,Format,Duration,Language,Variant,Weight Limit,Safe Zones,Deliverable,Source File,Naming,Rights,Owner,Status,Due,Notes
SOC-001,Social,Hero feed post,Hero,Feature-led,Acquisition,Meta Feed,1:1,1080×1080,JPG,static,EN,v1,30MB,—,JPG 72dpi sRGB,.psd,acme_summer25_hero_metafeed_1x1_en_v1.jpg,Talent Tier A 12mo,,TBD,,—
SOC-002,Social,Hero feed post,Hero,Feature-led,Acquisition,Meta Feed,4:5,1080×1350,JPG,static,EN,v1,30MB,—,JPG 72dpi sRGB,.psd,acme_summer25_hero_metafeed_4x5_en_v1.jpg,Talent Tier A 12mo,,TBD,,—
SOC-003,Social,Hero story,Hero,Feature-led,Acquisition,Meta Story,9:16,1080×1920,MP4,15s,EN,v1,4GB,"Top 250px clear, bottom 340px clear",MP4 H.264 -14 LUFS,.aep,acme_summer25_hero_metastory_9x16_en_v1.mp4,Talent Tier A 12mo + Music sync,,TBD,,Silent-first design with captions
VID-001,Video,TVC 30,Hero,Feature-led,Broadcast,ITV,16:9,1920×1080,MXF OP1a,30s,EN,v1,—,Title safe 80%,ProRes 422 HQ + MXF OP1a -23 LUFS,.aep,acme_summer25_tvc30_16x9_en_v1.mxf,Talent Tier A 12mo UK Broadcast,,TBD,,Deliver via Adstream
DIS-001,Display,MPU banner,Hero,Feature-led,Acquisition,DV360,300×250,300×250,HTML5,15s animation,EN,v1,150KB initial / 2.2MB polite,—,HTML5 + backup JPG,.fla,acme_summer25_mpu_300x250_en_v1.zip,—,,TBD,,clickTag as variable
PRN-001,Print,48-sheet billboard,Hero,Feature-led,All,Clear Channel roadside,16:9,6096×3048mm,PDF/X-1a,—,EN,v1,—,25mm bleed 50mm safe,CMYK 50dpi PDF/X-1a,.indd package,acme_summer25_48sheet_en_v1.pdf,—,,TBD,,Confirm bleed with CC
```

---

## Offering the CSV as a file (optional)

If the user's environment supports file output, also offer to save the CSV as
`{campaign-slug}-production-tracker.csv` in the project folder or `~/.creativestack/projects/{slug}/`.

Otherwise, the fenced CSV block in the output is the primary delivery — users copy it
into their tool of choice.

---

## Tools that import this CSV cleanly

- **Google Sheets** — Paste directly, will ask about comma separation
- **Airtable** — Import CSV → Create table → map fields
- **Notion** — Import → CSV → Creates a database automatically
- **Monday.com** — Import CSV, map columns
- **Excel / Numbers** — Paste, may need "Text to columns" for Excel
- **Linear / ClickUp / Asana** — Most support CSV import of tasks (each row = task)
