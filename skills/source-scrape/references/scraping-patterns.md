# Per-Source Scraping Patterns

Read this when scraping a source you haven't hit before in the current session. Has the practical tips that make the scrape work — search URL patterns, where to find dates, paywall behaviour, layout quirks.

## General principles

1. **Use the site's own search** when available — better than Google site: search
2. **Capture publication dates** — they drive freshness scoring
3. **Strip noise** — page chrome, sidebars, footers, related-content blocks, ad units. Focus on the article body and main visual.
4. **Follow only 1-2 deep links per source** — depth, not breadth, for the most relevant items
5. **Screenshot the most visually-distinctive moment** — hero image, key visual, full layout — not the homepage

## Per-source notes

### It's Nice That
- Search URL: `itsnicethat.com/search?q={query}`
- Dates: top of every article, format "DD Month YYYY"
- Categories filter: `itsnicethat.com/{category}` for category-specific browsing
- Best for: emerging talent, illustration, design culture
- No paywall

### Creative Review
- Search URL: `creativereview.co.uk/?s={query}`
- Dates: byline area
- Some content is members-only — flag and capture preview
- Best for: branding, advertising, editorial-quality analysis
- Partial paywall

### The Drum
- Search URL: `thedrum.com/search?q={query}`
- Dates: top of article
- Heavy pop-ups — wait for them to dismiss
- Best for: campaign news, fast-moving industry events
- No paywall

### Eye on Design (AIGA)
- Search URL: `eyeondesign.aiga.org/?s={query}`
- Dates: byline
- Long-form, screenshot the headline + first image
- Best for: critical commentary, design culture, profiles
- No paywall

### Brand New (Under Consideration)
- Search URL: `underconsideration.com/brandnew/?s={query}`
- Dates: post header
- Layout: before/after identity comparisons are the gold — capture those specifically
- Best for: identity rebrands with critical analysis
- No paywall, very dense pages

### The Dieline
- Search URL: `thedieline.com/?s={query}`
- Dates: post header
- Heavy on hero images — capture the main packaging shot
- Best for: packaging design, sustainable packaging, premium category
- No paywall

### Dezeen
- Search URL: `dezeen.com/?s={query}`
- Dates: byline
- Filter by category: `dezeen.com/tag/{tag}/`
- Best for: broad design sweep, architecture, interiors
- No paywall, heavy ads

### Awwwards
- Search URL: `awwwards.com/search?text={query}` or browse `/websites/{tag}/`
- Dates: site card shows submission date
- Score visible on each entry — capture as quality signal
- Best for: web design, digital experiences, interaction design
- Capture the screenshot directly from the site card or click through to the full preview

### Behance
- Search URL: `behance.net/search/projects?search={query}`
- Dates: project page sidebar
- Quality varies wildly — bias toward "Featured" tag and high-appreciation counts
- Best for: emerging work, full project case studies
- Capture the hero image and 1-2 key project shots

### Dribbble
- Search URL: `dribbble.com/search/{query}`
- Dates: shot detail page
- Often single-frame mockups, not full systems
- Best for: UI patterns, micro-interactions
- Quality lower than Behance — flag if used as primary source

### Brand New / Under Consideration
- Already covered above

### AdAge
- Search URL: `adage.com/search/{query}`
- Some content is paywalled — capture preview, score Depth as 1 if behind paywall
- Best for: US advertising industry analysis
- Partial paywall

### Campaign
- Search URL: `campaignlive.co.uk/search?searchTerm={query}`
- Some content paywalled
- Best for: UK advertising industry
- Partial paywall

### Communication Arts
- Search URL: `commarts.com/search?q={query}`
- Long-form profiles and case studies
- Some content members-only
- Best for: in-depth case studies, illustration, advertising
- Partial paywall

### Wallpaper*
- Search URL: `wallpaper.com/search?q={query}`
- Dates: byline
- Best for: premium-leaning design, lifestyle, architecture
- No paywall

### Typewolf
- Browse: `typewolf.com/site-of-the-day/{year}/{month}` or category pages
- No traditional search — browse by date or by typeface
- Best for: typography pairing, current type trends in the wild
- No paywall

### Fonts In Use
- Browse: `fontsinuse.com/in-use/{industry}/` for industry filtering
- Search: `fontsinuse.com/search?query={query}`
- Best for: typography by industry, real-world type usage
- No paywall

### Cannes Lions
- Search: `canneslions.com/awards/winners-archive/`
- Annual archive — great for "what won" but slower for current trends
- Some content is members-only
- Best for: prestige reference, what the industry validates
- Partial paywall

### LinkedIn (people mode only)
- Search: `linkedin.com/search/results/people/?keywords={query}`
- **Public profiles only** — don't try to access content behind login walls
- Best for: current roles, recent moves, professional background
- Wall-heavy, may need to score Depth as 2-3 even for relevant results

### WARC, Kantar, Interbrand, Nielsen (evidence mode)
- These are industry data sources
- Mostly paywalled — focus on free reports and summary pages
- Capture the headline finding + the source URL — caller skills will cite
- Best for: stats, brand value, effectiveness data

### Pew Research
- Search: `pewresearch.org/search/?query={query}`
- Free, well-sourced, dates clearly displayed
- Best for: cultural and consumer data points
- No paywall

## Anti-patterns

Don't:
- Screenshot the entire homepage of a site — useless to caller skills
- Capture results without dates — kills freshness scoring
- Paraphrase quotes — capture them verbatim with attribution
- Skip the source if the first result isn't great — try 2-3 results before giving up
- Re-screenshot the same campaign across sources — deduplicate
- Trust the site's "trending" section as evidence of trends — it often reflects clicks, not significance

## When a site changes its layout

The patterns above will go stale. When a documented pattern doesn't work:
1. Try the site's main search
2. Try a Google `site:{domain} {query}` search
3. If still nothing, mark the source as "layout changed" in the source quality table notes and skip it
4. Don't waste time fighting the site — move to the next source

## Paywall handling

- **Soft paywall (preview visible):** Capture the preview, headline, and first paragraph. Score Depth as 1-2. Note `paywalled` in the source notes column.
- **Hard paywall (no preview):** Skip, list in Coverage Gaps.
- **Members-only with login required:** Skip, list in Coverage Gaps.
- **Paywalled but article URL is shareable:** Include the URL — caller skills or users may have access.

Never try to circumvent a paywall.
