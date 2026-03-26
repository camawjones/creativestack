# Creativestack

**The AI skill suite for creative professionals.** 44 Claude Code skills built specifically for creative agencies, branding agencies, and creative freelancers.

Every skill supports the creative process — research, briefs, strategy, project management, business operations — without ever generating creative output. The creative leap stays human.

## Install

```bash
git clone https://github.com/camawjones/creativestack ~/.claude/skills/creativestack
```

## Quick Start

1. Set up your agency context (optional but recommended):
   - Type `/setup-agency` in Claude Code
   - Answer questions about your agency, team, and tone of voice
   - This creates your Agency Context Vault at `~/.creativestack/`

2. Start using skills:
   - `/meeting-notes` — paste a transcript, get structured notes with actions
   - `/brief-sharpener` — sharpen a client brief with gap analysis
   - `/timeline-generator` — generate a project timeline (with optional Figma output)

## Skills

### Setup
| Skill | What it does |
|-------|-------------|
| `/setup-agency` | Set up your Agency Context Vault — company info, team, tone of voice |
| `/update-voice` | Update your agency's tone of voice guidelines |

### Daily Operations
| Skill | What it does |
|-------|-------------|
| `/meeting-notes` | Transcript → structured notes, actions, scope change flags |
| `/status-update` | Project context → formatted updates for clients, leadership, and creative team |
| `/copy-deck` | Messy inputs → clean, structured copy deck with version tracking |

### Project Kickoff
| Skill | What it does |
|-------|-------------|
| `/brief-sharpener` | Client brief → gap analysis, clarifying questions, sharpened brief |
| `/timeline-generator` | Project scope → realistic timeline with Figma output option |
| `/project-kickoff` | Project type → complete kickoff pack with roles, risks, dates |

### Strategic & Creative
| Skill | What it does |
|-------|-------------|
| `/creative-strategy` | Brief → cultural research, competitor analysis, strategic provocations |
| `/design-research` | Design brief → cultural references, inspiration, historical precedents |
| `/client-feedback` | Vague feedback → specific interpretations and clarifying questions |

### Business Development
| Skill | What it does |
|-------|-------------|
| `/pitch-research` | Prospect name → comprehensive research pack with angles |
| `/case-study` | Raw project data → structured case study |
| `/agency-audit` | Interactive AI readiness assessment for agency leaders |
| `/credentials-deck` | Master creds + prospect → tailored credentials deck |
| `/rfi-response` | RFI document → drafted responses from existing materials |
| `/churn-warning` | Client data → early warning flags for at-risk accounts |

### Document Production
| Skill | What it does |
|-------|-------------|
| `/proposal-generator` | Brief/RFP → structured proposal with scope, timeline, budget |
| `/creative-brief` | Messy notes → proper creative brief |
| `/brand-guidelines` | Scattered assets → structured brand guidelines document |
| `/social-calendar` | Brand voice + campaigns → content calendar with draft copy |
| `/asset-spec` | Campaign concept → full deliverable specification |
| `/design-feedback` | Multiple feedback rounds → consolidated, deduplicated document |
| `/sow-generator` | Project parameters → structured Statement of Work |

### Research & Strategy
| Skill | What it does |
|-------|-------------|
| `/competitor-audit` | Brand + category → competitive landscape document |
| `/trend-report` | Category → formatted trend report with evidence |

### Financial & Commercial
| Skill | What it does |
|-------|-------------|
| `/freelancer-rate-benchmarker` | Role + market → current day rate research |
| `/project-profitability` | Hours + rates + fee → margin analysis |
| `/invoice-chaser` | Overdue invoices → escalating follow-up emails |

### Legal & Contracts
| Skill | What it does |
|-------|-------------|
| `/usage-rights` | Licensing scenario → plain-English rights explanation |
| `/contract-reviewer` | Client contract → highlighted risks in non-legal language |
| `/gdpr-audit` | Data collection description → compliance checklist |

### People & Culture
| Skill | What it does |
|-------|-------------|
| `/job-description` | Vague brief → inclusive, creative-industry job description |
| `/performance-review` | Notes + contributions → structured review document |
| `/onboarding-pack` | Company info → new starter pack |

### Project & Resource Management
| Skill | What it does |
|-------|-------------|
| `/resource-conflict` | Team allocations → conflict flags and rebalancing suggestions |
| `/retainer-tracker` | Retainer + activity → over-servicing flags and talking points |
| `/timesheet-summary` | Raw time data → client-ready breakdown |

### Knowledge & IP
| Skill | What it does |
|-------|-------------|
| `/post-mortem` | Project reflections → structured retrospective |
| `/methodology-documenter` | Process description → documented, repeatable methodology |

### Admin & Operations
| Skill | What it does |
|-------|-------------|
| `/expense-report` | Receipts → formatted expense report |
| `/travel-briefer` | Itinerary → comprehensive logistics document |
| `/insurance-renewal` | Agency stats → insurer information pack |

## Agency Context Vault

Skills work without any setup, but they work dramatically better with context about your agency. Run `/setup-agency` to create your vault at `~/.creativestack/` with:

- **agency.md** — company name, size, location, specialisms
- **tone-of-voice.md** — how your agency sounds (do/don't, vocabulary, examples)
- **team.md** — who does what
- **clients.md** — active clients and key contacts
- **case-studies.md** — index of past work
- **methodology.md** — how you run your processes
- **tools.md** — your software stack
- **learnings.md** — accumulated project learnings

## Figma Integration

11 skills can optionally render their output as designed Figma artifacts via the Figma MCP. When available, skills will ask if you want visual output — the markdown version always works as a fallback.

## About

Built by **Cameron Jones** — AI partner for creative companies.

If you need custom AI workflows, embedded tooling, or strategic AI adoption for your agency, get in touch: **jones.cam**

## License

MIT
