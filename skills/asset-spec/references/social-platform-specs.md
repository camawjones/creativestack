# Social Platform Specs

> **Last verified: 2026-01.** Platforms ship spec changes quarterly. Always cross-check
> against the live platform docs (links below) before sending the spec to production.
> If you're reading this more than 90 days after the verified date, treat every number
> as suspect and re-verify.

## How to use this file

Pull the rows you need into the asset spec output. **Always include the verification
date and source URL** in the output's "Spec verification" footer so the production team
knows when to re-check.

If a client targets a platform not listed here, default to the closest analog and flag
it as needs-verification.

---

## Instagram

**Verify against:** https://help.instagram.com/1631821640426723

| Asset | Dimensions (px) | Aspect | Format | Max size | Safe zone notes |
|---|---|---|---|---|---|
| Feed (square) | 1080 × 1080 | 1:1 | JPG/PNG | 30MB | — |
| Feed (portrait) | 1080 × 1350 | 4:5 | JPG/PNG | 30MB | Max portrait ratio |
| Feed (landscape) | 1080 × 566 | 1.91:1 | JPG/PNG | 30MB | — |
| Story / Reel | 1080 × 1920 | 9:16 | JPG/PNG/MP4 | 4GB video | Top 250px and bottom 340px reserved for UI — keep text/logos out |
| Reel cover | 1080 × 1920 | 9:16 | JPG | — | Centre 1080×1080 area is what shows on grid |
| Carousel | 1080 × 1080 or 1080 × 1350 | 1:1 or 4:5 | JPG/PNG | 30MB/slide | All slides must share aspect; up to 10 slides |
| Profile photo | 320 × 320 | 1:1 | JPG/PNG | — | Displays as circle — keep subject centred |

**Caption limits:** 2,200 chars (truncates at ~125). Hashtags: max 30 (3-5 perform best).
**Reel duration:** up to 90s in feed, up to 3min for Reels native, 15min for video posts.

---

## TikTok

**Verify against:** https://ads.tiktok.com/help/article/tiktok-video-ad-specifications

| Asset | Dimensions (px) | Aspect | Format | Max size | Notes |
|---|---|---|---|---|---|
| Feed video | 1080 × 1920 | 9:16 | MP4/MOV | 500MB | Top 130px and bottom 484px reserved for UI on full-screen |
| Profile photo | 200 × 200 | 1:1 | JPG/PNG | — | Circular crop |
| Cover image | 1080 × 1920 | 9:16 | JPG | — | First frame or custom thumbnail |

**Duration:** 15s, 30s, 60s, or up to 10min. Sweet spot for organic: 21-34s. Paid: ≤15s.
**Caption:** 2,200 chars. First 100 chars critical.
**Audio:** Required for paid. Music must be licensed (TikTok Commercial Music Library for ads).

---

## YouTube

**Verify against:** https://support.google.com/youtube/answer/6375112

| Asset | Dimensions (px) | Aspect | Format | Notes |
|---|---|---|---|---|
| Long-form video | 1920 × 1080 (min) | 16:9 | MP4 (H.264) | 4K = 3840 × 2160 |
| Shorts | 1080 × 1920 | 9:16 | MP4 | ≤60s, vertical |
| Thumbnail | 1280 × 720 | 16:9 | JPG/PNG | <2MB; readable at 120×68 |
| Channel banner | 2560 × 1440 | 16:9 | JPG/PNG | Safe area: 1546 × 423 (visible on all devices) |
| Channel icon | 800 × 800 | 1:1 | JPG/PNG | Circular crop |
| End screen | 1920 × 1080 | 16:9 | — | Last 5-20s, leave element zones clear |

**Audio:** -14 LUFS integrated, true peak ≤ -1 dBTP.
**Captions:** SRT or VTT required for accessibility; auto-captions are not sufficient for client work.

---

## LinkedIn

**Verify against:** https://www.linkedin.com/help/linkedin/answer/a521928

| Asset | Dimensions (px) | Aspect | Format | Notes |
|---|---|---|---|---|
| Feed image (single) | 1200 × 627 | 1.91:1 | JPG/PNG | Or 1200 × 1200 for square |
| Feed image (square) | 1200 × 1200 | 1:1 | JPG/PNG | Often outperforms landscape |
| Feed video | 1920 × 1080 | 16:9 (or 1:1, 9:16) | MP4 | ≤10min, ≤5GB |
| Document post (PDF) | 1200 × 1200 to 1200 × 1500 | 1:1 or 4:5 | PDF | Up to 300 pages, ≤100MB |
| Company banner | 1128 × 191 | 5.91:1 | JPG/PNG | Top 50px obscured by profile pic on mobile |
| Profile banner | 1584 × 396 | 4:1 | JPG/PNG | — |

**Caption:** 3,000 chars (truncates at ~140 on mobile, ~210 on desktop).

---

## X (Twitter)

**Verify against:** https://help.x.com/en/rules-and-policies/x-image-quality

| Asset | Dimensions (px) | Aspect | Format | Notes |
|---|---|---|---|---|
| Feed image | 1600 × 900 | 16:9 | JPG/PNG | Single image; 1200 × 675 acceptable |
| Feed video | 1280 × 720 (min) | 16:9, 1:1, 9:16 | MP4 | ≤140s for standard, ≤10min Premium |
| Header | 1500 × 500 | 3:1 | JPG/PNG | Profile pic overlaps bottom-left |

**Caption:** 280 chars (free), 25,000 (Premium).

---

## Facebook

**Verify against:** https://www.facebook.com/business/ads-guide

| Asset | Dimensions (px) | Aspect | Format | Notes |
|---|---|---|---|---|
| Feed image | 1200 × 630 | 1.91:1 | JPG/PNG | — |
| Feed video | 1280 × 720 (min) | 16:9, 1:1, 4:5, 9:16 | MP4 | ≤240min, ≤4GB |
| Story | 1080 × 1920 | 9:16 | JPG/PNG/MP4 | Same UI safe zones as IG Story |
| Cover | 851 × 315 | 2.7:1 | JPG/PNG | Renders differently on mobile/desktop |

---

## Pinterest

**Verify against:** https://help.pinterest.com/en/business/article/pinterest-product-specs

| Asset | Dimensions (px) | Aspect | Format | Notes |
|---|---|---|---|---|
| Standard Pin | 1000 × 1500 | 2:3 | JPG/PNG | Vertical performs best |
| Idea Pin / Video | 1080 × 1920 | 9:16 | MP4 | Up to 60s |
| Square Pin | 1000 × 1000 | 1:1 | JPG/PNG | — |

---

## Threads

Inherits Instagram specs for image/video. Text: 500 chars.

---

## Snapchat

| Asset | Dimensions (px) | Aspect | Format | Notes |
|---|---|---|---|---|
| Snap Ad | 1080 × 1920 | 9:16 | MP4/MOV | ≤32MB, 3-180s |
| Story | 1080 × 1920 | 9:16 | JPG/MP4 | — |

---

## Spec verification footer (always include in output)

```
**Spec verification:**
- Specs in this document last verified: {YYYY-MM} (against references/social-platform-specs.md)
- Re-verify before production if more than 90 days old
- Sources: links above per platform
```
