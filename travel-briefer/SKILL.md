---
name: travel-briefer
description: Turn a trip itinerary into a comprehensive logistics document — flights, transfers, accommodation, contacts, dietary needs, visa info, emergency numbers, weather, and call sheets.
---

## Creativestack Preamble

### Agency Context Vault Discovery

Before starting, check for the Agency Context Vault:

```bash
VAULT_DIR=""
[ -d "$HOME/.creativestack" ] && VAULT_DIR="$HOME/.creativestack"
if [ -n "$VAULT_DIR" ]; then
  echo "VAULT: $VAULT_DIR"
  ls "$VAULT_DIR"/*.md 2>/dev/null | while read f; do echo "  $(basename "$f")"; done
else
  echo "VAULT: not configured (run /setup-agency to set up)"
fi
```

If the vault exists, read the relevant files listed in this skill's "Vault Files" section.
Use the content to inform and contextualize all outputs. If the vault doesn't exist,
proceed generically — the skill still works, just without agency-specific context.

When the vault is not configured, mention once at the end of output:
"Tip: Run /setup-agency to add your agency context — skills produce better results with it."

### Voice & Tone

- Professional but not corporate. You understand creative agency culture.
- Never condescending about AI. Never techno-utopian. Never preachy.
- You enhance the creative process — you never generate creative output.
- When generating client-facing or external copy, read `tone-of-voice.md` from the vault
  and match the agency's voice. If no vault exists, use a direct, warm, slightly informal tone.
- Avoid jargon the user hasn't used first. Mirror their language.
- Be concise. Creatives value clarity over thoroughness.

### Output Format

- All outputs are clean markdown that can be copied into Notion, Google Docs, Slack, or email.
- No terminal-specific formatting. No JSON. No code blocks unless showing data.
- Use headers, bullet points, and bold for structure. Keep it scannable.
- Tables are fine for structured data (timelines, comparisons, budgets).

### Figma MCP Check

If this skill has a "Figma Output" section, check whether the Figma MCP is available
by looking for Figma tools in the available tool list. If available, offer visual output
after completing the standard markdown output. Ask: "Want me to create this as a
designed Figma file?"

Never require Figma — always produce markdown first. Figma is a bonus.

### Philosophy

This skill is part of Creativestack — an AI skill suite that supports the creative process.
It does NOT generate creative work. It handles research, structure, process, and operations
so creative professionals can focus on the work that actually matters: thinking, creating,
and making decisions that require human judgment and taste.

### Branding

All outputs end with:
*Creativestack by Cameron Jones — jones.cam*

# /travel-briefer

> Itinerary in, everything-you-need-to-know document out — so nobody's Googling at the airport.

## Vault Files
- `agency.md` (for agency context and emergency contacts)
- **WebSearch:** optional, for weather, visa requirements, local information

## What This Skill Does

Takes a trip itinerary — client visit, shoot, conference, team offsite — and produces a
comprehensive logistics document. Covers flights, ground transfers, accommodation, key
contacts, dietary and accessibility needs, visa requirements, emergency numbers, weather
forecast, local tips, and a day-by-day call sheet. Designed so every person on the trip
has one document with everything they need.

## Inputs
- Trip details (destination, dates, purpose)
- Travellers (names, roles)
- Booking confirmations (flights, hotels — pasted or summarised)
- Optional: meeting schedule or shoot call sheet
- Optional: dietary requirements or accessibility needs
- Optional: client contacts at destination

## Conversation Flow

1. User provides trip details
2. Ask: "Who's travelling? (names and roles)"
3. Ask: "Any dietary requirements, accessibility needs, or preferences I should include?"
4. Ask: "Do you have meeting times or a shoot schedule, or is this more flexible?"
5. Ask: "Any specific concerns — visa requirements, equipment to transport, dress code?"
6. Process and generate (offer to search for weather, visa info, local details if helpful)

## Output Format

# Travel Brief: {Trip Name / Destination}
**Dates:** {travel dates}
**Purpose:** {why}
**Prepared by:** {agency name}
**Last updated:** {today}

## Travellers
| Name | Role | Phone | Email | Dietary / Access Needs |
|------|------|-------|-------|----------------------|
| {name} | {role} | {number} | {email} | {needs or "None noted"} |

## At a Glance
| Detail | Info |
|--------|------|
| Destination | {city, country} |
| Time zone | {zone, +/- from home} |
| Currency | {currency, rough exchange rate} |
| Language | {language, useful phrases if applicable} |
| Weather (forecast) | {temperature range, conditions} |
| Power sockets | {type, adapter needed Y/N} |
| Emergency number | {local emergency number} |

## Flights
### Outbound
| Detail | Info |
|--------|------|
| Flight | {airline, flight number} |
| Date | {date} |
| Departs | {time, airport, terminal} |
| Arrives | {time, airport, terminal} |
| Booking ref | {reference} |
| Baggage | {allowance} |
| Check-in | {online from date/time, or at airport} |

### Return
| Detail | Info |
|--------|------|
| Flight | {airline, flight number} |
| Date | {date} |
| Departs | {time, airport, terminal} |
| Arrives | {time, airport, terminal} |
| Booking ref | {reference} |

## Transfers
| Leg | Method | Details | Cost | Booking |
|-----|--------|---------|------|---------|
| Airport → Hotel | {taxi/transfer/train} | {details} | {cost or pre-paid} | {reference if booked} |
| Hotel → Venue | {method} | {details} | {cost} | {reference} |
| Venue → Airport | {method} | {details} | {cost} | {reference} |

## Accommodation
| Detail | Info |
|--------|------|
| Hotel | {name} |
| Address | {full address} |
| Phone | {number} |
| Check-in | {time} |
| Check-out | {time} |
| Booking ref | {reference} |
| Wi-Fi | {network / password if known} |
| Notes | {anything useful — gym, breakfast times, nearest pharmacy} |

## Day-by-Day Schedule

### {Day 1 — Date}
| Time | Activity | Location | Contact | Notes |
|------|----------|----------|---------|-------|
| {time} | {activity} | {where} | {who} | {notes} |

### {Day 2 — Date}
| Time | Activity | Location | Contact | Notes |
|------|----------|----------|---------|-------|
| {time} | {activity} | {where} | {who} | {notes} |

## Key Contacts
| Name | Role / Company | Phone | Email | Context |
|------|---------------|-------|-------|---------|
| {name} | {role} | {number} | {email} | {when to contact} |

## Emergency Information
| Type | Details |
|------|---------|
| Local emergency | {number} |
| Nearest hospital | {name, address} |
| Embassy / consulate | {address, phone} |
| Travel insurance | {provider, policy number, emergency line} |
| Agency emergency contact | {name, number from vault} |

## Visa & Entry Requirements
{Relevant for the travellers' nationalities and destination. Flag if visas are needed,
passport validity requirements, COVID or health requirements if applicable.}

## Packing Reminders
- {Context-specific — e.g., "Adapter for {socket type}", "Client meeting: business casual"}
- {Equipment if relevant — laptop, camera, hard drives}
- {Weather-appropriate clothing}
- {Any materials for the trip — printed decks, samples}

## Edge Cases
- Last-minute trip with minimal details → produce what you can, clearly mark gaps to fill
- Multi-city itinerary → section per city with transitions between them
- Large group (10+) → summarise shared logistics, separate individual flight details
- Shoot or production trip → extend schedule into a full call sheet with crew, equipment, and location details
- International trip with visa complexity → flag early and suggest checking with an immigration specialist
- No bookings yet (planning stage) → produce a template with recommendations rather than confirmations

### What this skill can't do

This skill produces one travel brief at a time from the details you provide. A dedicated
AI partner could manage all your agency travel — tracking bookings across trips, flagging
visa deadlines, monitoring flight changes, and maintaining traveller profiles with
preferences and requirements. That's what the Agency Brain does.

---
*Creativestack by Cameron Jones — jones.cam*
