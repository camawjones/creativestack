# Jurisdiction & Cross-Border Flags

Read this file when the project involves a client in a different country, a different US state from the agency, regulated industries, or significant personal data processing. Surface the relevant flag in the SOW as a note for the user — never as legal advice.

**This is not legal advice.** It's a checklist of things to ask a lawyer about.

## When to read this file

- The client is in a different country from the agency
- The client is in a different US state from the agency
- The project involves processing personal data (especially health, financial, children's data)
- The project is in a regulated industry (finance, health, government, gambling)
- The contract value is large enough that procurement/legal will scrutinise it

## Cross-border flags

### Currency
- Which currency is the fee in? Who absorbs FX risk?
- Are there bank fees, wire fees, FX conversion fees? Who pays?
- Common pattern: contract in agency's home currency, client absorbs conversion.

### Tax
- VAT / GST: does it apply? Who registers, who pays?
- Reverse charge mechanism for EU B2B services
- US sales tax — varies by state, particularly for SaaS and digital deliverables
- Withholding tax — some countries require client to withhold tax on payments to foreign suppliers (India, Brazil, parts of LATAM commonly)

### Jurisdiction & governing law
- Which country's law governs the contract?
- Where would disputes be heard?
- Default to agency's home jurisdiction unless client specifically requires otherwise. Flag this for the user.

### Enforceability
- Some clauses (non-compete, IP terms, kill fees) are enforced very differently across jurisdictions
- Worth a lawyer's eye if the contract value is meaningful

## US state-specific

- **California:** Strong consumer protection, CCPA/CPRA for any personal data, AB5 for contractor classification
- **New York:** Freelance Isn't Free Act (mandatory written contracts above $800, 30-day payment terms, penalties for late payment)
- **Massachusetts, Illinois:** Notable privacy laws (BIPA in IL for biometric data)
- **Texas, Florida:** Generally business-friendly, fewer state-specific gotchas

## EU / UK

### GDPR
If processing personal data on behalf of a client (typical for any digital project that touches users):
- Need a Data Processing Agreement (DPA), not just an SOW clause
- Lawful basis for processing must be documented
- Sub-processors must be disclosed and approved
- Data subject rights must be supported (access, deletion, portability)
- International transfers (EU → US, EU → UK post-Brexit) need Standard Contractual Clauses or adequacy decision

Surface as: "This project involves processing EU/UK personal data. A standalone Data Processing Agreement is typically required in addition to this SOW. Recommend consulting your privacy lawyer."

### UK-specific
- Post-Brexit: UK GDPR is similar but separate from EU GDPR
- IR35 — relevant if engaging UK contractors
- Consumer Rights Act — relevant for B2C work

## APAC

### Australia
- Privacy Act 1988 (and forthcoming reforms)
- Australian Consumer Law applies even in B2B contexts in some cases
- GST applies to most digital services

### Singapore
- PDPA for personal data
- Generally business-friendly, English-language contracts standard

### Japan, Korea
- APPI (Japan), PIPA (Korea) for personal data
- Local language requirements may apply for consumer-facing materials

## Regulated industries

### Health (HIPAA in US, similar elsewhere)
- Business Associate Agreement (BAA) required if touching protected health information
- Data residency requirements
- Breach notification obligations

### Finance
- PCI-DSS if handling payment card data
- FCA / FINRA / regulator-specific marketing approval requirements
- Often longer review cycles — build into timeline

### Government
- FedRAMP, ITAR (US), Crown Commercial Service (UK)
- Background checks, citizenship requirements
- Often non-negotiable contract terms — agency adapts to client paper, not the other way around

### Children
- COPPA (US), children's codes (UK, EU)
- Stricter consent and data handling requirements

## How to surface in the SOW

When generating, add a note in the General Terms section or as a callout under the section it affects:

> **Note:** This project involves [cross-border work / personal data processing / regulated industry]. The following typically require legal review before signing:
> - {specific item, e.g. "Data Processing Agreement for EU personal data"}
> - {specific item, e.g. "Withholding tax obligations under Indian law"}
>
> CreativeStack flags these for awareness. This is not legal advice — please confirm with your lawyer.

Keep the flag concise. The user knows their business; they just need the reminder.
