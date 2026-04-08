# Video & Broadcast Specs

> **Last verified: 2026-01.** Codec/bitrate/LUFS standards are stable but platform
> wrappers and trafficking specs change. Verify against the broadcaster or platform doc
> before delivery.

## How to use this file

When the campaign includes video — TVC, OLV, social video, broadcast — pull the
relevant rows. Three things production teams forget most often: **LUFS targets**,
**caption file format**, and **safe areas for TV broadcast**.

---

## Online video — codec defaults

| Use | Codec | Container | Bitrate | Audio |
|---|---|---|---|---|
| Web / social (1080p) | H.264 High Profile | MP4 | 8-12 Mbps | AAC 128-320 kbps stereo |
| Web / social (4K) | H.264 or H.265 | MP4 | 35-45 Mbps | AAC 320 kbps stereo |
| Vertical 9:16 (1080×1920) | H.264 | MP4 | 8-10 Mbps | AAC 128-256 kbps |
| Master / archive | ProRes 422 HQ or DNxHR HQ | MOV | — | PCM 24-bit 48kHz |

**Frame rate:** 24, 25, or 30fps. Match the source. Don't mix. 50/60fps for sport or motion-heavy.

---

## Loudness (LUFS) — non-negotiable

**Mixing video to wrong loudness is the most common reason a perfect-looking ad gets
rejected at delivery.**

| Distribution | Target | True peak |
|---|---|---|
| YouTube / Vimeo / web | -14 LUFS integrated | -1 dBTP |
| Meta (Facebook/Instagram) | -14 LUFS integrated | -1 dBTP |
| TikTok | -10 to -14 LUFS | -1 dBTP |
| Spotify (audio ads) | -14 LUFS integrated | -1 dBTP |
| UK broadcast (ITV, C4, Sky) | -23 LUFS integrated (EBU R128) | -1 dBTP |
| US broadcast (CALM Act / ATSC A/85) | -24 LUFS (±2) | -2 dBTP |
| Cinema | Reference level (Leq -31 dB / 85 dB SPL) | — |
| Podcast (Apple/Spotify) | -16 LUFS | -1 dBTP |

If unsure, default to the destination's standard. Never deliver "as loud as possible".

---

## Captions, subtitles, audio description

| Format | Use | Notes |
|---|---|---|
| **SRT** | Web/social — open or closed | Plain text, simple timing |
| **VTT (WebVTT)** | YouTube, web players | Supports basic styling |
| **SCC** | US broadcast (608) | Required for FCC compliance |
| **STL** (EBU) | EU broadcast (708/teletext) | Required for UK/EU broadcast |
| **iTT** (iTunes Timed Text) | Apple platforms | — |
| **Burned-in (open)** | Social autoplay (silent) | Always provide a separate captions file too if delivery requires it |

**Languages:** Provide English captions for all video. For multi-market, deliver one
caption file per language. RTL languages need the player to handle direction.

**Audio Description (AD):** Required for ≥7-day broadcast slots in many UK/EU contracts
and for accessibility-compliant streaming. Delivered as a separate audio stem (mono or
stereo) timed to the video.

---

## Safe areas for broadcast

**16:9 HD (1920×1080):**
- Action safe: 90% (96px inset all sides at 1920×1080)
- Title safe: 80% (192px inset all sides at 1920×1080)

Keep all logos, super, end-card text inside title safe. Old CRT-era standards still
apply because broadcast STBs and chains crop differently.

**Vertical (1080×1920) — social UI safe zones:**
- Top: 250-340px reserved for handle/UI
- Bottom: 340-484px reserved for caption/CTA UI
- Centre 1080×1080 area is the "always-visible" zone

---

## TVC delivery — common UK / EU specs

| Spec | Value |
|---|---|
| Container | MXF (OP1a) or ProRes 422 HQ |
| Resolution | 1920×1080 progressive |
| Frame rate | 25fps (UK/EU) or 23.976/29.97 (US) |
| Aspect | 16:9 |
| Audio | 24-bit 48kHz, EBU R128 (-23 LUFS) |
| Audio channels | Stereo or 5.1 — confirm with broadcaster |
| Slate / clock | Required by some broadcasters (10s slate, 2s black, action, 1s tail black) |
| Duration tolerance | ±1 frame |
| Captions | STL file separately |

**Always confirm with the trafficking house** (e.g., Adstream, Peach, IMD) — they hold
the broadcaster's exact spec sheets and reject incorrect deliveries.

---

## Common video durations by use

| Use | Standard durations |
|---|---|
| Pre-roll (skippable) | 6s, 15s, 30s, 60s |
| Pre-roll (non-skip) | 6s, 15s |
| Bumper (YouTube) | 6s exactly |
| Social feed | 15s, 30s, 60s |
| Stories / Reels / TikTok | 15s, 30s (sweet spot 21-34s organic) |
| TVC | 10s, 15s, 20s, 30s, 45s, 60s, 90s |
| Cinema | 30s, 60s, 90s |
| Long-form (YouTube/web) | 2-10min for editorial; no fixed standard |

---

## Video delivery checklist

- [ ] Master codec/container correct for destination
- [ ] LUFS measured and within target ±0.5
- [ ] True peak ≤ -1 dBTP (or destination spec)
- [ ] Frame rate matches source — no conversion artefacts
- [ ] Audio levels checked (no clipping, no silent channels)
- [ ] Captions delivered in correct format(s)
- [ ] Audio description delivered if required
- [ ] Title safe respected for broadcast
- [ ] UI safe zones respected for vertical/social
- [ ] End-card / CTA frame held for ≥2s
- [ ] Slate/clock added if broadcaster requires
- [ ] Music cue sheet completed if for broadcast
- [ ] Talent rights window confirmed against usage period
- [ ] All variants (lengths, ratios, language cuts) accounted for
