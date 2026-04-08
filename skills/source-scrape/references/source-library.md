# Default Source Library

The fallback source library used when the user has no `~/.creativestack/sources.md`. Each entry is a publication or platform that creative professionals trust for research. Sources are tagged by category so the right ones get picked for each query.

This file is read on demand. When `sources.md` exists, prefer it — only fall back here for sources the user hasn't covered in their own library.

## Selection guide

When picking 6-10 sources for a scrape, use this priority:

1. **Mode-aligned sources** (see "By Mode" below)
2. **Category-aligned sources** (see "By Category" below)
3. **Always-include tier** (Authority 4-5 sources for the relevant mode)
4. Avoid duplicates of the same publication group

Cap at 10 sources per scrape unless `target_sources` is overridden.

## Industry Press & Commentary

Analysis, commentary, and reporting on creative work.

| Source | URL | Category | Authority | Notes |
|---|---|---|---|---|
| It's Nice That | itsnicethat.com | Design, illustration, creative culture | 5 | UK-leaning, strong on emerging talent |
| Creative Review | creativereview.co.uk | Advertising, branding, design | 5 | Industry standard for UK creative |
| The Drum | thedrum.com | Marketing, advertising, campaigns | 4 | Newsy, fast-moving |
| AdAge | adage.com | Advertising industry news | 5 | US industry standard, some paywall |
| Campaign | campaignlive.co.uk | UK advertising and marketing | 5 | UK industry standard, some paywall |
| Eye on Design (AIGA) | eyeondesign.aiga.org | Graphic design, design culture | 5 | Critical, well-written |
| Communication Arts | commarts.com | Design, advertising, illustration | 5 | Long-form, curated |
| Print Magazine | printmag.com | Graphic design, print culture | 4 | Heritage publication |
| Wallpaper* | wallpaper.com | Design, architecture, lifestyle | 5 | Premium-leaning, lifestyle |
| Fast Company Design | fastcompany.com/co-design | Design + business | 4 | Strategy-leaning |

## Award Sites & Portfolios

What's winning and being showcased.

| Source | URL | Category | Authority | Notes |
|---|---|---|---|---|
| Awwwards | awwwards.com | Web design, digital experiences | 5 | Daily new winners, useful for visual mode |
| Behance | behance.net | Portfolios, all disciplines | 4 | Self-uploaded, quality varies, strong for emerging |
| D&AD | dandad.org | Award-winning creative | 5 | Curated, prestigious |
| The FWA | thefwa.com | Digital innovation | 4 | Web-focused |
| CSS Design Awards | cssdesignawards.com | Web design | 4 | Daily winners |
| Cannes Lions | canneslions.com/awards | Global creative awards | 5 | Annual, prestigious, gated archive |
| Webby Awards | winners.webbyawards.com | Digital work | 4 | Broad categories |
| One Show | tdc.org / oneshow.org | Design + advertising | 5 | Curated, prestigious |
| Type Directors Club | tdc.org | Typography | 5 | For type-focused queries |

## Brand & Campaign Trackers

What brands are actually doing.

| Source | URL | Category | Authority | Notes |
|---|---|---|---|---|
| Ads of the World | adsoftheworld.com | Global campaign archive | 4 | Big archive, moderate curation |
| Brand New (Under Consideration) | underconsideration.com/brandnew | Identity and branding | 5 | Critical reviews, gold standard |
| The Dieline | thedieline.com | Packaging design | 5 | Category-defining for packaging |
| Dezeen | dezeen.com | Design, architecture, interiors | 5 | Heavy traffic, strong visual archive |
| Logo Design Love | logodesignlove.com | Identity, logos | 4 | Curated, smaller |
| Packaging of the World | packagingoftheworld.com | Packaging | 4 | Submission-based |
| Identity Designed | identitydesigned.com | Brand identity systems | 4 | Curated |

## Specialist Sources

For category-specific queries.

| Source | URL | Category | Authority | Notes |
|---|---|---|---|---|
| Dribbble | dribbble.com | UI/UX, digital design | 3 | Self-uploaded, useful for visual mode |
| Typewolf | typewolf.com | Typography trends | 5 | The reference for type pairing |
| Fonts In Use | fontsinuse.com | Typography in the wild | 5 | Categorised by industry |
| Muzli | muz.li | Design inspiration aggregator | 3 | Aggregator, useful for sweep |
| Mindsparkle Mag | mindsparklemag.com | Branding, web, video | 4 | Curated |
| Sidebar | sidebar.io | Design industry news links | 3 | Aggregator |
| Hover States | hoverstat.es | Editorial web design | 4 | Niche, curated |
| Siteinspire | siteinspire.com | Web design showcase | 4 | Curated |
| The Brand Identity | the-brandidentity.com | Branding case studies | 4 | Long-form |

## People & Voices Sources

For `people` mode — finding creative directors, founders, decision-makers.

| Source | URL | Category | Notes |
|---|---|---|---|
| It's Nice That | itsnicethat.com | Profiles, interviews | "People" tag |
| Creative Review | creativereview.co.uk | Profiles, opinion pieces | |
| Eye on Design | eyeondesign.aiga.org | Long-form profiles | |
| Offscreen Magazine | offscreenmag.com | Long-form interviews | |
| Working Not Working | workingnotworking.com | Freelance directory + profiles | |
| LinkedIn (public) | linkedin.com | Professional moves, current roles | Public profiles only |

## Evidence & Data Sources

For `evidence` mode — stats, reports, data points.

| Source | URL | Category | Notes |
|---|---|---|---|
| Kantar BrandZ | kantar.com/campaigns/brandz | Brand value rankings | Annual reports |
| Interbrand | interbrand.com | Best Global Brands | Annual rankings + analysis |
| WARC | warc.com | Marketing effectiveness | Mostly paywalled, free summaries |
| Nielsen | nielsen.com | Media + consumer behaviour | Free reports |
| Edelman Trust Barometer | edelman.com/trust | Trust and brand reputation | Annual |
| Statista | statista.com | Data points across categories | Some paywall |
| Pew Research | pewresearch.org | Consumer + cultural data | Free, well-sourced |
| Ofcom Reports | ofcom.org.uk | UK media consumption | Free, UK-focused |

## By Mode

Default source picks per mode (when no other guidance):

- **`trends`**: It's Nice That, Creative Review, Eye on Design, Brand New, Dezeen, The Drum, Communication Arts, Awwwards
- **`brands`**: Brand New, Creative Review, Ads of the World, AdAge, Campaign, The Drum, Dezeen, The Dieline
- **`landscape`**: It's Nice That, Dezeen, Brand New, Creative Review, The Dieline, Wallpaper*, Communication Arts, Eye on Design, Behance
- **`visual`**: Awwwards, Brand New, The Dieline, Dezeen, Behance, Dribbble, Mindsparkle Mag, Siteinspire, Typewolf
- **`evidence`**: WARC, Kantar, Interbrand, Edelman Trust Barometer, Pew Research, AdAge, Campaign, Statista
- **`people`**: It's Nice That, Eye on Design, Creative Review, Offscreen Magazine, LinkedIn, Working Not Working

## By Category

When the query implies a category, prioritise these sources:

- **Packaging**: The Dieline, Dezeen, Brand New, Packaging of the World, Behance
- **Web/digital**: Awwwards, The FWA, CSS Design Awards, Siteinspire, Hover States, Sidebar
- **Branding/identity**: Brand New, Identity Designed, The Brand Identity, Logo Design Love, Behance
- **Editorial/print**: Eye on Design, Print Magazine, Hover States, Communication Arts
- **Typography**: Typewolf, Fonts In Use, Type Directors Club, Eye on Design
- **Advertising/campaigns**: Ads of the World, Campaign, AdAge, The Drum, Cannes Lions, Brand New
- **Architecture/spatial**: Dezeen, Wallpaper*, Communication Arts
- **Illustration**: It's Nice That, Communication Arts, Eye on Design, Behance
- **Motion/film**: Dezeen, The Drum, Vimeo Staff Picks (vimeo.com/staffpicks), Cannes Lions

## Adding sources for the user

When the user runs "manage sources" mode, sources they add go into `~/.creativestack/sources.md` with their own priority and category tagging. The Brain file overrides anything in this default library.
