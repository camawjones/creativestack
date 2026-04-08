# Usage Rights & Clearance Tracking

> The thing that comes back to bite agencies six months later. Talent windows expire,
> music licenses run out, stock photos get pulled, archive footage rights lapse.
> Track it from day one or pay the legal cost.

## How to use this file

When the campaign uses talent, music, stock, archive, or any third-party content,
include a Usage Rights section in the asset spec. Set up a calendar reminder for the
earliest expiry. Make this visible to the producer and the client.

---

## What needs tracking

| Asset | What expires | Typical window |
|---|---|---|
| **Talent (actor/model on camera)** | Image rights for use | 6 months — 2 years; rolling renewals possible |
| **Talent (voiceover)** | Audio rights | Same as above |
| **Talent (extras / non-principal)** | Buyout or session-based | Often shorter |
| **Music — sync license** | Use of recording in synced content | 1 year — perpetual; per-use vs blanket |
| **Music — master license** | Use of the specific recording | Usually paired with sync |
| **Music — production library** | Licensed via library subscription | Tied to subscription term |
| **Stock photo / video** | Per-license terms | Royalty-free vs rights-managed |
| **Archive footage / news clips** | Per-license terms | Often time-limited and territory-limited |
| **User-generated content (UGC)** | Permission from creator | Get a signed release; often unlimited but creator can revoke |
| **Brand IP (logos, characters)** | Brand licensing agreement | Per the agreement |
| **Photographer / illustrator commissions** | Usage rights in the contract | Confirm what was bought |

---

## Talent rights — the trap

Most agencies underestimate talent rights cost and complexity.

### Standard talent rights structure (UK / Equity context)

| Right | What it covers | Typical cost basis |
|---|---|---|
| **Session fee** | The shoot day itself | Day rate |
| **Use fee** | The right to use the talent's image in the agreed media | % of session, or fixed |
| **Territory** | Where the asset can run (UK only / EU / Worldwide) | Multiplier |
| **Term** | How long the asset can run | Multiplier |
| **Media** | Which media (TV / OOH / Digital / In-store / Cinema) | Per-media fee |
| **Cuts** | Number of asset variants | Sometimes capped |
| **Buyout** | All rights, all media, perpetual | Most expensive option, not always offered |

### Track per talent

| Talent name | Role | Session date | Use start | Use end | Territory | Media | Buyout? | Notes |
|---|---|---|---|---|---|---|---|---|
| {name} | Lead | YYYY-MM-DD | YYYY-MM-DD | YYYY-MM-DD | UK + EU | OOH + Digital | No | Renewable +12mo |

### Renewal triggers

- **30 days before expiry** — flag to client; decide renew or replace
- **At expiry** — pull all live media. Continued use = breach + claim
- **6 months before expiry** — for high-profile talent, start renewal negotiation early

---

## Music rights — sync vs master

Music has two rights you usually need:

1. **Sync** — the right to synchronise the composition with picture (publisher controls this)
2. **Master** — the right to use the specific recording (label controls this)

You need **both** to use a known recording. Production library tracks bundle them. Original
score is owned by the agency or composer per agreement.

### Music tracking template

| Track | Composer | Publisher | Master rights | Sync rights | Term | Territory | Media | Cost | Notes |
|---|---|---|---|---|---|---|---|---|---|
| {title} | {composer} | {publisher} | {label} | ✓ cleared {date} | 12 months | UK | Digital + OOH | £{n} | Renewable |
| {library track} | {composer} | {library} | {library} | ✓ subscription | per sub | Worldwide | All | included | — |

### Music cue sheet (broadcast)

For broadcast TV, deliver a music cue sheet to the broadcaster:
- Track title
- Composer(s)
- Publisher(s) and PRS share
- Duration used
- Type of use (background, featured, theme)

---

## Stock and archive

| Type | Watch out for |
|---|---|
| Royalty-free stock (Adobe Stock, Shutterstock, iStock, Unsplash+) | Read the license — "editorial only" stock can't be used in ads. UGC stock may have additional restrictions. AI-generated stock has murky rights. |
| Rights-managed stock | Per-use, per-territory, per-term — like talent. Renew or replace at expiry. |
| Archive footage (Getty, AP, Reuters) | Often time-limited and territory-limited. News footage usually has news-only or editorial-only restrictions. |
| Free-to-use (Unsplash, Pexels, Pixabay) | Usually fine for commercial — but verify per image. Some have model/property release issues. |

### Stock log template

| Asset ID | Source | License ID | Type | Term | Territory | Cost | Notes |
|---|---|---|---|---|---|---|---|
| STK-001 | Adobe Stock | 123456789 | Standard | Perpetual | Worldwide | £30 | — |
| STK-002 | Getty | RM-789 | Rights-managed | 2 years | UK | £450 | Renew {date} |

---

## AI-generated content

If any asset includes AI-generated imagery, audio, or video:

- **Document the model and prompt** for traceability
- **Document the source training data assertion** (some clients prohibit AI imagery from models trained on copyrighted data without consent)
- **Confirm commercial use rights** of the model output (varies — Midjourney, OpenAI, Stable Diffusion, Adobe Firefly all have different terms)
- **Disclose if required** — some clients, broadcasters, or regulators require disclosure
- **Confirm with legal** for any campaign over £X — this area is changing fast

---

## Usage rights template (for the asset spec output)

```markdown
## Usage Rights & Clearance

**Window:** Campaign live {start} → {end}
**Earliest expiry:** {date} ({asset / talent / music})
**Calendar reminder set:** {Y/N}

### Talent
| Talent | Role | Use start | Use end | Territory | Media | Renewal |
|---|---|---|---|---|---|---|
| {name} | {role} | {date} | {date} | {region} | {media} | {Y/N — date} |

### Music
| Track | Type | Cleared | Term | Cost | Renewal |
|---|---|---|---|---|---|
| {title} | {sync/master/library} | ✓ {date} | {term} | £{n} | {date} |

### Stock & archive
| Asset | Source | License | Term | Cost |
|---|---|---|---|---|
| {ID} | {source} | {license ID} | {term} | £{n} |

### AI-generated content
| Asset | Model | Use case | Commercial rights confirmed | Disclosure required |
|---|---|---|---|---|

### Action items
- [ ] All talent releases signed and stored in {location}
- [ ] All music sync + master cleared and stored
- [ ] Stock licenses logged
- [ ] Calendar reminders set 30 days before each expiry
- [ ] Producer and client both have a copy of this section
```

---

## Common mistakes

- Letting talent rights lapse on a still-live OOH placement (the agency carries the liability)
- Using "editorial use only" stock in a paid ad
- Using a library track that's only cleared for "online" in a TV cut
- Not getting a signed release for a UGC repost
- Letting the asset live on the client's website past the agreed term
- Forgetting that "perpetual" doesn't mean "everywhere" (territory still applies)
- Not getting separate clearance for each variant when the deal was per-asset
