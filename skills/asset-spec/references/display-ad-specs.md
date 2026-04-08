# Display Advertising Specs

> **Last verified: 2026-01.** Network specs change. Always cross-check the live network
> docs (linked) before final delivery.

## How to use this file

When the campaign includes paid display, programmatic, or DSP-served ads, load this
file and pull the relevant network rows. **File-weight budgets are the most-violated
spec** — get them wrong and the ad gets rejected at upload.

---

## IAB Standard Display Units

**Verify against:** https://www.iab.com/guidelines/new-ad-portfolio/

| Unit | Dimensions (px) | Common name |
|---|---|---|
| Medium Rectangle | 300 × 250 | MPU |
| Large Rectangle | 336 × 280 | — |
| Leaderboard | 728 × 90 | — |
| Wide Skyscraper | 160 × 600 | — |
| Half Page | 300 × 600 | — |
| Large Mobile Banner | 320 × 100 | — |
| Mobile Banner | 320 × 50 | — |
| Billboard | 970 × 250 | — |
| Filmstrip | 300 × 600 | — |
| Portrait | 300 × 1050 | — |
| Pushdown | 970 × 90 | Expandable |
| Half-Page Tablet | 300 × 600 | — |
| Square | 250 × 250 | — |

**Standard formats:** JPG, PNG, GIF, HTML5.
**Animation:** Max 15 seconds total, max 3 loops, no looping after 15s.
**Border:** 1px contrasting border required if creative is white-on-white edge.

---

## File-weight budgets by network

**This is the table production teams need most.** Networks reject creatives that exceed
these weights at upload.

### Google Display Network / DV360

**Verify against:** https://support.google.com/displayvideo/answer/2696380

| Asset type | Initial load | Polite load (full) | Notes |
|---|---|---|---|
| Standard banner (JPG/PNG/GIF) | 150KB | — | Single file |
| HTML5 (single file) | 150KB | 2.2MB total | Polite load = lazy-loaded assets |
| Video (in-stream) | — | 1080p ≤ 1GB | Use VAST 4.0+ tag |
| Mobile rich media | 150KB | 5MB | — |

### Meta (Facebook / Instagram Ads)

**Verify against:** https://www.facebook.com/business/help/980593475366490

| Asset type | Max file size | Notes |
|---|---|---|
| Image | 30MB | JPG/PNG |
| Video | 4GB | MP4/MOV/GIF, max 241 min |
| Carousel image | 30MB per card | Up to 10 cards |
| Stories video | 4GB | 9:16, ≤60s for in-feed, ≤2min for placement |

### The Trade Desk (TTD)

**Verify against:** https://partner.thetradedesk.com/v3/portal/data/doc/CrtvCreativeFormats

| Asset type | Initial load | Polite load |
|---|---|---|
| HTML5 standard | 200KB | 2.2MB |
| HTML5 expandable | 250KB | 2.5MB |
| Video (VAST) | — | 200MB max |

### Amazon DSP

| Asset type | Max size | Notes |
|---|---|---|
| Static display | 200KB | JPG/PNG/GIF |
| HTML5 | 200KB initial / 2.2MB polite | — |
| Video | 200MB | VAST 2.0/3.0/4.0 |

### Programmatic (general OpenRTB)

| Asset type | Recommended max |
|---|---|
| Static banner | 150KB |
| HTML5 | 200KB initial / 2.2MB polite |
| Video | 30MB (mobile-friendly) |

---

## HTML5 banner requirements

When delivering HTML5 (Google Web Designer, Adobe Animate, hand-coded):

- **clickTag** must be implemented as a variable, not hard-coded URL
- **Backup image** (JPG or GIF) at the same dimensions, ≤150KB, required by most networks
- **Border** 1px if creative has white edges
- **Audio** must be user-initiated, never autoplay with sound
- **CPU usage** keep animation <40% CPU on mid-tier devices
- **No external font loading** unless explicitly approved by the network
- **No document.write** — most networks reject creatives that use it
- **Fallback** include a static fallback frame for environments that don't support HTML5

### File structure (typical)

```
banner_300x250/
├── index.html
├── images/
│   ├── frame_01.png
│   └── ...
├── js/
│   └── animation.js
└── backup.jpg
```

---

## Animation rules (most networks)

- **Max duration:** 15 seconds (some allow 30s for video)
- **Max loops:** 3 (or stop after 15s, whichever first)
- **Frame rate:** 24-30fps recommended; 60fps may inflate file weight
- **Last frame:** Must include a clear end-card with brand + CTA visible

---

## Programmatic considerations

- **Viewability target:** 70%+ in-view (MRC standard: 50% of pixels for ≥1s display, ≥2s video)
- **Brand safety:** Provide safe URL/keyword exclusion list to ad ops
- **Frequency capping:** Recommend per-user caps in campaign brief
- **Creative rotation:** Provide ≥3 variants per placement to avoid creative fatigue (and for A/B)

---

## Pre-flight checklist for display

- [ ] All units sized to exact pixel dimensions
- [ ] File weights under network limits (initial AND polite)
- [ ] HTML5 clickTag implemented as variable
- [ ] Backup image included for every HTML5 banner
- [ ] Animation ≤15s, ≤3 loops
- [ ] End-card has brand + CTA visible at frame 0 and frame -1
- [ ] No autoplay audio
- [ ] Border added if creative has white edges
- [ ] Tested on Chrome, Safari, Firefox, mobile Safari, mobile Chrome
- [ ] Click-through URL confirmed and tracked
