# Microcopy Patterns

Microcopy is where most modern UX copy lives — button labels, error
messages, empty states, loading indicators, success confirmations,
form helpers, tooltips. It's also where most copy decks fail. Most
decks treat microcopy as an afterthought written at QA time. The
result is generic, confusing, or off-voice copy in the places users
actually read.

This file is the operational reference for **Microcopy mode**, which
is dedicated to UX microcopy specifically.

Every pattern here should pass through the standard voice, sharpness,
and ladder checks from `voice-sharpness-claims.md`. Microcopy is copy —
it's not exempt from the quality bar just because it's small.

---

## The microcopy atoms

### 1. Buttons

**Convention:** verb + object, action-oriented, voice-consistent.

**Hierarchy:**
- **Primary button:** the action we want the user to take
- **Secondary button:** an alternative path
- **Tertiary / ghost button:** low-commitment next step
- **Destructive button:** delete, remove, cancel — visually distinct, clearly labelled

**Vocabulary rules:**
- Start with a verb whenever possible
- Be specific about what the button does ("Save changes" beats "Save")
- Match the user's intent ("I want to ___" → button label)
- Never just "Submit" or "OK" — always describe the action

**Good:**
- "Save changes"
- "Add to cart"
- "Book a fitting"
- "Start your trial"
- "Download the guide"
- "Get results"

**Bad:**
- "Submit" (generic, scary)
- "OK" (ambiguous)
- "Click here" (never)
- "Yes" / "No" (out of context, meaningless)
- "Continue" (unclear what comes next)

**Destructive button labels:**
- "Delete account" (not "Delete")
- "Remove from team" (not "Remove")
- "Cancel subscription" (not "Cancel" — ambiguous with dismiss)

**Modal / dialog button pairs:**
- Don't default to "OK / Cancel"
- Match labels to the action: "Delete file / Keep file"
- The destructive action is never the default highlighted button

### 2. Error messages

**The error message formula:**

```
[What went wrong] + [Why it matters] (optional) + [What to do next] + [Voice touch] (optional)
```

**Rules:**
- Plain language, no technical jargon
- Identify the specific problem
- Offer a specific next action
- Never blame the user
- Tone matches the brand even under stress
- Never "Error 404" or "Something went wrong"

**Good:**
- "Couldn't find that email. Check for typos or try a different one."
- "Your password needs 8+ characters and at least one number."
- "We can't reach your account right now. Try again in a minute, or reach out to support@brand.com."
- "That card was declined. Try another, or call your bank for details."

**Bad:**
- "Invalid input."
- "Please fill in this field."
- "An error occurred. Please try again."
- "Authentication failed."
- "404 Not Found"

**Tone variants:**

| Brand voice | Error example |
|---|---|
| Warm / supportive | "Couldn't find that email — no worries, try again or sign up fresh." |
| Direct / practical | "Email not found. Try another, or sign up." |
| Playful | "Hmm, that email isn't in our system. Typo? Or ready to sign up?" |
| Premium / minimal | "Email not recognised." |

Match the voice to the brief's Brand Tone & Personality section.

### 3. Empty states

**The empty state formula:**

```
[Why it's empty] + [Action to change that] + [Optional: brand personality]
```

**Rules:**
- Never just "No items" or "Empty"
- Explain why it's empty (first time, filtered out, deleted)
- Offer a specific next action
- Empty states are high-visibility — use them for brand voice
- Tonal latitude here is bigger than other atoms

**Good:**
- "Nothing here yet. Add your first project and we'll get you running."
- "No results match your filters. Try widening your search."
- "Your team is empty. Invite your first teammate to get started."
- "Inbox zero. Rare, beautiful. Enjoy it."

**Bad:**
- "No results"
- "Empty"
- "No items found"
- "You have no projects"

**Empty state illustrations:**
When an empty state has an illustration, the copy should complement it,
not repeat it. If the illustration shows an empty folder, don't say
"Empty folder."

### 4. Loading states

**The loading copy formula:**

```
[What's happening] (specific) + [Reassurance] (optional) + [Voice touch] (optional)
```

**Rules:**
- Specific beats generic ("Fetching your orders" beats "Loading...")
- If loading takes >3 seconds, explain why
- Never apologise for loading (it makes it feel slower)
- Short loading states don't need copy — a spinner is enough
- Long loading states benefit from brand voice

**Good:**
- "Fetching your orders..."
- "Counting the results... there are a lot."
- "Thinking..." (for AI responses)
- "Saving your changes — hang on."

**Bad:**
- "Loading..." (generic)
- "Please wait" (scolding)
- "This may take a while" (no action, vague)

**Long loading patterns:**
For operations >10 seconds, explain progress:

> "Analysing 2,400 items — this takes about 30 seconds."
>
> "Generating your report — we'll email when it's ready."

### 5. Success / confirmation

**The success copy formula:**

```
[Confirmation of action] + [What happens next] (if not obvious) + [Optional: next step]
```

**Rules:**
- Confirm specifically what was saved / sent / done
- If the action triggers another process, explain it
- Tone can be celebratory but should match brand register
- Don't overstate — "Amazing! Your email is saved!" is patronising

**Good:**
- "Saved. Your changes go live in 2 minutes."
- "Order placed. We'll send a confirmation email shortly."
- "Sent. They'll get it in their inbox within an hour."
- "Published. Your post is now live at [link]."

**Bad:**
- "Success!" (vague)
- "Done" (flat)
- "Thank you for your submission" (corporate)
- "Woohoo!" (patronising)

### 6. Form labels and placeholders

**Label rules:**
- Clear, specific, never cute
- Say what the field is for, not what it's called internally
- "Your name" beats "Full name" (warmer, clearer)
- "Work email" beats "Email address" (specific)

**Placeholder rules:**
- Show format, not instructions
- Placeholders disappear when the user types — don't put critical info there
- No "Enter your email here" (redundant with the label)

**Helper text rules:**
- Below the field, not inside
- Explains why or how
- Stays visible as the user types
- Short — one line max

**Good:**

```
Label: Work email
Placeholder: you@company.com
Helper: We'll send the invoice here.
```

**Bad:**

```
Label: Email
Placeholder: Enter your email
Helper: (empty)
```

### 7. Tooltips and inline help

**Rules:**
- Tooltips are for secondary info, not primary
- Never critical info in a tooltip (they're invisible on mobile)
- One sentence max
- Written to be read in one breath

**Good:**
- "Used for your invoice only."
- "This is how others see your name."
- "You can change this later in Settings."

**Bad:**
- Long paragraphs
- Critical legal info
- Repeating the label

### 8. Onboarding copy

**Rules:**
- Greet, don't explain
- One message per screen
- Never a wall of text
- Reference the user's goal, not the product's features

**Good:**
- "Hi Sarah. Let's get your first project running."
- "This is where your work lives. We'll show you around."
- "Two more steps and you're set."

**Bad:**
- "Welcome to the platform. Let us show you our 14 features."
- "Click next to begin the tutorial."

### 9. Notifications

**Rules:**
- Subject-verb-object
- Specific about who / what
- Never marketing disguised as notification
- Shorter is better — notifications are interruptions

**Good:**
- "Sarah approved your design."
- "Your order ships tomorrow."
- "3 new comments on your post."

**Bad:**
- "You have an update!"
- "Check your dashboard for news."
- "New activity"

---

## Voice calibration per microcopy type

Not every microcopy atom has the same voice latitude:

| Atom | Voice latitude | Why |
|---|---|---|
| Buttons | Low | Clarity > personality |
| Errors | Medium | Tone helps, clarity is paramount |
| Empty states | High | Brand personality shines here |
| Loading | High | Users are waiting — charm helps |
| Success | Medium | Confirmation > personality |
| Form labels | Low | Clarity > personality |
| Tooltips | Low | Brevity > voice |
| Onboarding | Medium | Warmth helps, clarity essential |
| Notifications | Low | Specificity > personality |

When scoring voice match for microcopy, weight the score by the latitude.
A button with flat voice is less of a failure than an empty state with
flat voice.

---

## Microcopy checklist per product

When running Microcopy mode, work through this checklist for the product:

### Buttons (inventory)
- [ ] Primary action on every key screen
- [ ] Secondary actions with clear labels
- [ ] Destructive actions labelled specifically
- [ ] No generic "Submit" or "OK" anywhere
- [ ] Cancel/dismiss distinct from destructive

### Error states
- [ ] Every form field has a custom error message
- [ ] Every API failure has a user-facing message
- [ ] Auth errors (login, password, session)
- [ ] Network errors
- [ ] Payment errors
- [ ] Permission errors (403)
- [ ] Not found (404)

### Empty states
- [ ] First-time user states
- [ ] Filtered-to-zero states
- [ ] Deleted-all states
- [ ] Search-no-results states

### Loading states
- [ ] Fast loads (spinner, no copy)
- [ ] Medium loads (2-5s, short copy)
- [ ] Long loads (5s+, explanation + progress)
- [ ] Background loads (toast or badge)

### Success / confirmation
- [ ] Save success
- [ ] Submission success
- [ ] Payment success
- [ ] Share success
- [ ] Delete confirmation (before + after)

### Form helpers
- [ ] Every label is clear
- [ ] Every complex field has helper text
- [ ] Placeholders show format
- [ ] Password rules shown inline, not only on error

### Onboarding
- [ ] First screen greeting
- [ ] Value prop in one sentence
- [ ] Clear first action
- [ ] Skippable

### Notifications
- [ ] Transactional notifications (order, delivery, account)
- [ ] Social notifications (mentions, comments, follows)
- [ ] System notifications (maintenance, updates)

---

## Output format for Microcopy mode

```markdown
# Microcopy Deck: {Product / Project}

## Buttons

### Primary actions
| Key | Label | Context | Voice | Sharpness |
|---|---|---|---|---|
| BTN_SAVE | "Save changes" | Settings page | 5/5 | 4/5 |
| BTN_PUBLISH | "Publish post" | Editor | 5/5 | 5/5 |
| BTN_CHECKOUT | "Complete order" | Cart | 4/5 | 5/5 |

### Destructive actions
| Key | Label | Context | Notes |
|---|---|---|---|
| BTN_DELETE_ACCOUNT | "Delete account" | Settings | Requires 2-step confirmation |
| BTN_REMOVE_TEAM | "Remove from team" | Team page | |

## Error states

### Form validation errors
| Key | Message | Voice | Context |
|---|---|---|---|
| ERR_INVALID_EMAIL | "Couldn't find that email. Check for typos or try a different one." | 5/5 | Login |
| ERR_WEAK_PASSWORD | "Your password needs 8+ characters and at least one number." | 4/5 | Signup |

{...continue for each category...}

## Empty states
| Key | Copy | Voice latitude applied |
|---|---|---|
| EMPTY_PROJECTS | "Nothing here yet. Add your first project and we'll get you running." | High |

## Checklist status
- ✅ Buttons: 18/18 covered
- ⚠️ Errors: 24/30 covered (6 missing — see gap list)
- ✅ Empty states: 8/8 covered
- ⚠️ Loading: 3/6 covered
- ✅ Success: 12/12 covered
- ⚠️ Form helpers: 15/20 covered

## Gaps (missing microcopy)
- Loading state for bulk import
- Loading state for file upload progress
- Helper text for billing address fields
- Error for expired session
```

---

## Microcopy and accessibility

Microcopy is accessibility copy. Screen readers read button labels,
error messages, form labels. Bad microcopy fails accessibility.

Rules:
- Button labels must describe the action (screen readers read labels)
- Form labels must be associated with fields (not just visually adjacent)
- Error messages must be programmatically linked to the field they apply to
- Placeholder text is NOT a substitute for a label
- Empty state illustrations need alt text
- Loading states need ARIA live regions so screen readers announce them

The skill should flag microcopy that fails these rules even if the words
themselves are good.

---

## When Microcopy mode doesn't fit

Some projects don't need Microcopy mode:

- Print / OOH / packaging — no interactive elements
- Campaign brand work — microcopy comes later, from the dev team
- Identity / brand only — no product surface

For these, the skill should skip microcopy and note it:

> "This is a brand project — no microcopy layer yet. When the product
> scope comes in, run Microcopy mode to cover buttons, errors, empty
> states, and forms."
