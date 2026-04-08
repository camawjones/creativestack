# Print, OOH & Packaging Specs

> Print specs are stable; OOH operator specs change less than digital but vary widely
> by site. Always confirm with the print house or OOH operator before output.

## How to use this file

Pull the relevant section into the asset spec output. For OOH, **always confirm specs
with the operator** (JCDecaux, Clear Channel, Global, Ocean Outdoor, Wildstone, etc.)
because each site can have different bleed, viewing distance, and resolution rules.

---

## Print fundamentals

### Colour modes
- **CMYK** for everything that prints. Never deliver RGB to a printer.
- **Spot colours** (Pantone) for brand-critical solids. Confirm Pantone book year (Solid
  Coated/Uncoated, Pantone+ Solid Coated 2024, etc.) — printers reject mixed editions.
- **Mixed CMYK + Spot** for hybrid jobs (e.g., black text in K only, brand colour in spot).

### Resolution
- **300dpi at final print size** is the minimum for offset/digital print.
- **150dpi** acceptable for large-format display where viewing distance ≥3m.
- **72dpi at output size** acceptable for billboards (viewing distance >10m) — verify with operator.

### Bleed and safe area

| Print type | Bleed | Inside safe area |
|---|---|---|
| Standard print (business cards, flyers, brochures) | 3mm all sides | 3-5mm from trim |
| Magazine ads | 3-5mm | 5mm from trim |
| Large format banners | 10-25mm | 10mm from trim or grommet line |
| Packaging (after dieline) | 3mm | 3mm from cut/fold |
| Books (perfect-bound) | 3mm | 13mm gutter inside (grows with page count) |

**Always confirm with the printer** — these are defaults, not gospel.

### File formats
- **PDF/X-1a:2001** — universal print standard, fonts embedded, CMYK only, no transparency
- **PDF/X-4:2010** — supports transparency and ICC profiles, modern workflows
- **EPS** — legacy, only when explicitly requested
- **TIFF (LZW or no compression)** — for raster-only delivery
- **InDesign Package (.indd + Links + Document Fonts)** — for source delivery to print partners

### Fonts
- **Outline all type** for delivery (or package fonts in InDesign Package)
- **Don't outline body copy** if the printer needs to make minor edits — confirm first

---

## Common print formats — UK / EU (mm)

| Format | Trim size | Bleed size | Notes |
|---|---|---|---|
| Business card | 85 × 55 | 91 × 61 | Standard UK; US is 89 × 51 |
| A6 (postcard) | 105 × 148 | 111 × 154 | — |
| A5 | 148 × 210 | 154 × 216 | — |
| A4 | 210 × 297 | 216 × 303 | — |
| A3 | 297 × 420 | 303 × 426 | — |
| A2 poster | 420 × 594 | 426 × 600 | — |
| A1 poster | 594 × 841 | 600 × 847 | — |
| A0 poster | 841 × 1189 | 847 × 1195 | — |
| DL flyer | 99 × 210 | 105 × 216 | Fits in #10 envelope |

## US print formats (inches)

| Format | Trim | Bleed |
|---|---|---|
| Business card | 3.5 × 2 | 3.625 × 2.125 |
| Postcard | 6 × 4 | 6.125 × 4.125 |
| Letter | 8.5 × 11 | 8.625 × 11.125 |
| Tabloid | 11 × 17 | 11.125 × 17.125 |

---

## Paper stocks (terminology to know)

| Term | What it means |
|---|---|
| **GSM** | Grams per square metre — paper weight |
| **Coated** | Glossy/matte/silk surface coating; better colour fidelity |
| **Uncoated** | Natural paper feel; absorbs ink — colours appear duller |
| **Silk / satin** | Coated but lower sheen than gloss |
| **FSC** | Forest Stewardship Council certified — sustainability claim |
| **Recycled %** | Post-consumer waste content |

**Common stock weights:**
- Letterhead: 100-120 GSM uncoated
- Flyer: 130-170 GSM gloss/silk
- Brochure cover: 250-350 GSM
- Business card: 350-400 GSM
- Postcard: 300-400 GSM
- Magazine cover: 200-250 GSM

**Stock affects colour reproduction.** Always request a printer proof on the actual stock.

---

## OOH (Out-of-Home) specs

OOH varies massively by operator and site. **Always request the spec sheet from the
operator's media owner before designing.**

### Common large-format OOH (UK)

| Format | Dimensions (mm) | Common operators | Notes |
|---|---|---|---|
| 6-sheet | 1200 × 1800 (portrait) | JCDecaux, Clear Channel, Global | Bus stop, mall — 100% scale, 25mm bleed, 25mm safe |
| 48-sheet | 6096 × 3048 (landscape) | All major | Roadside billboard — 25-50mm bleed, 50mm safe |
| 96-sheet | 12192 × 3048 (landscape) | All major | Roadside super-size |
| Bus T-side | varies by operator | Global, JCDecaux | Confirm with operator |
| Tube car panel | 1016 × 152 (UK Underground) | Exterion / Global | — |
| Tube cross-track | 1524 × 1016 | Exterion | — |

### DOOH (Digital Out-of-Home)

DOOH dimensions match the screen exactly. Common ones:

| Format | Pixel dimensions | Notes |
|---|---|---|
| Bus stop digital (6-sheet) | 1080 × 1920 | Vertical, 6-10s loop |
| Mall LCD | 1920 × 1080 | Horizontal, 10-15s loop |
| Roadside digital billboard | varies | Often 1280 × 384 or higher; confirm |
| Times Square supersize | varies | Confirm with operator (Branded Cities, Outfront, etc.) |
| Piccadilly Lights (Ocean Outdoor) | 10752 × 4480 | Custom — Ocean handles delivery spec |

**DOOH file formats:**
- Static: JPG/PNG (RGB, 72dpi at native resolution)
- Animation: MP4 (H.264, no audio — DOOH is silent), or HTML5 for interactive sites
- **Duration:** Most slots are 6-10 seconds in a 60-90 second loop
- **Audio:** Almost never permitted

### OOH viewing distance affects resolution

| Viewing distance | Min DPI at output |
|---|---|
| ≤1m (tube panel, lift) | 200-300 dpi |
| 1-5m (bus stop, mall) | 150 dpi |
| 5-10m (small billboard) | 100 dpi |
| 10-30m (large billboard) | 50-72 dpi |
| 30m+ (motorway/super-size) | 25-50 dpi |

---

## Packaging

Packaging is its own discipline. Key things to spec:

### Dieline
- Provided by the printer or structural designer
- Layered Illustrator file with:
  - **Cut lines** (usually solid)
  - **Crease/fold lines** (usually dashed)
  - **Bleed area** (typically 3mm beyond cut)
  - **Safe area** (3-5mm inside cut and fold)
  - **Glue/tab areas** (clearly marked, no print)

### Print considerations for packaging
- **CMYK + Spot** mix is common (especially for brand colours and metallics)
- **White ink** needed for transparent or non-white substrates (specify as separate layer)
- **Spot UV / foil / emboss** require separate spec layers
- **Barcode** must be readable — minimum size 80% of standard EAN-13, contrast critical
- **Compliance marks** (recycling, FSC, country of origin, ingredients, allergens) must be at minimum legal size
- **Ingredient legibility** typically requires ≥6pt for body, ≥1pt linespacing

### Sustainability claims
- **FSC** — requires chain of custody certification, mark must be approved
- **Recycled %** — must be substantiated
- **Recyclable** — must reflect actual material composition

### Packaging delivery checklist
- [ ] Dieline matches structural sample
- [ ] Bleed extends beyond cut
- [ ] Safe area respected for all type and logos
- [ ] Spot colours specified with Pantone reference (year confirmed)
- [ ] White ink layer separate if substrate requires
- [ ] Special finishes (foil, UV, emboss) on separate layers, marked
- [ ] Barcode at correct size and contrast
- [ ] Compliance marks at legal minimum size
- [ ] Print-ready PDF generated (PDF/X-1a or PDF/X-4)
- [ ] Source files (Illustrator) packaged with fonts and links
- [ ] Printer-confirmed proofing route (digital proof, contract proof, press check)
