# Contributing to CreativeStack

Thanks for your interest in contributing. CreativeStack is a Claude Code skill stack that provides AI skills for creative professionals. This guide explains how to add or improve a skill.

## Ground rules

CreativeStack has a specific philosophy. Contributions that conflict with it will be declined:

- **Enhance the creative process, never generate creative output.** The creative step stays human.
- **Support the input side:** research, briefs, strategy, process, delivery.
- **Professional but not corporate tone.** No hype, no slop, no "10x your output" language.
- **Respect the practitioner.** Assume the user is an expert at their craft.

If you are unsure whether an idea fits, open an issue before writing code.

## Project structure

```
creativestack/
├── _build/
│   ├── build-skills.sh       # Template build script
│   ├── shared/               # Shared content injected into every skill
│   │   ├── preamble.md       # Brain discovery + shared setup
│   │   ├── project-state.md  # Per-project memory conventions
│   │   └── lead-gen.md       # Attribution block
│   └── templates/
│       └── {skill-name}/
│           ├── SKILL.md.tmpl # Source template (edit this)
│           └── references/   # Optional supporting docs
├── skills/                   # Generated — do not edit directly
│   └── {skill-name}/
│       └── SKILL.md          # Built from the .tmpl
├── agents/                   # Workflow agents that chain skills
└── scripts/
    └── check-brain.sh        # Optional SessionStart brain check (install via ~/.claude/settings.json)
```

**Important:** `skills/*/SKILL.md` files are generated. Always edit the matching `.tmpl` in `_build/templates/` and rebuild.

## Build process

After editing any `.tmpl` file or any file in `_build/shared/`:

```bash
bash _build/build-skills.sh
```

This regenerates every `skills/*/SKILL.md` by resolving `{{PREAMBLE}}`, `{{PROJECT_STATE}}`, and `{{VISUAL_STYLE_DEFAULT}}` placeholders.

Commit both the `.tmpl` and the generated `.md` file in the same commit.

## Adding a new skill

1. **Propose first.** Open an issue describing the problem the skill solves and who it is for. Include the user type, the trigger phrases, and the expected output shape.
2. **Create the template directory:**
   ```
   _build/templates/{skill-name}/SKILL.md.tmpl
   ```
3. **Follow the template structure.** Look at any existing skill (for example `_build/templates/creative-brief/SKILL.md.tmpl`) for the canonical shape:
   - YAML frontmatter with `name` and `description` (the description is what Claude Code uses to decide when to invoke the skill, so it must include concrete trigger phrases)
   - `{{PREAMBLE}}` placeholder as the first line after frontmatter
   - An H1 heading matching the skill name
   - A short "What This Skill Does" section
   - An "Arguments" section listing invocation modes
   - "Brain Files" listing which files in `~/.creativestack/` the skill reads and writes
   - Numbered workflow steps
   - An output section showing exact format
4. **Run the build:** `bash _build/build-skills.sh`
5. **Test the skill locally** by installing the stack and invoking it in Claude Code. Verify it handles the no-brain case gracefully.
7. **Open a pull request.**

## Editing an existing skill

1. Find the source template in `_build/templates/{skill-name}/SKILL.md.tmpl`.
2. Make your edits there, never in `skills/{skill-name}/SKILL.md`.
3. Run `bash _build/build-skills.sh`.
4. Verify the diff in `skills/{skill-name}/SKILL.md` matches your intent.
5. Commit both files.

## References directories

Some skills have a `references/` subdirectory next to the template. These are verbatim copies, not templated. Use them for long-form context the skill reads on demand (benchmarks, taxonomies, examples).

```
_build/templates/{skill-name}/references/benchmarks.md
```

The build script mirrors this directory to `skills/{skill-name}/references/` automatically.

## Skill description guidelines

The `description` field in frontmatter is the most important line in your skill. Claude Code uses it to decide when to invoke the skill. A good description:

- Lists concrete user triggers in quotes (for example: `"where does AI fit in my practice"`)
- Names the modes the skill supports
- Mentions the user types it serves
- Ends with a "Use when..." clause

Look at `_build/templates/ai-audit/SKILL.md.tmpl` for a strong example.

## Tone and voice

CreativeStack has a specific voice. Read a few existing skills before writing new ones to absorb it. In short:

- Direct, never cute
- Plain language over jargon
- Name the thing, do not hedge
- Respect the reader's expertise
- No emoji in skill content

## Pull request checklist

Before opening a PR:

- [ ] Edited the `.tmpl` file, not the generated `.md`
- [ ] Ran `bash _build/build-skills.sh`
- [ ] Committed both the `.tmpl` and the generated `.md`
- [ ] Added the skill name to `_build/build-skills.sh` if new
- [ ] Skill handles the no-brain case
- [ ] Skill description includes concrete trigger phrases
- [ ] No client names, personal paths, or private data in the content
- [ ] Tested the skill in Claude Code locally

## Reporting bugs

Open an issue with:

- What you were trying to do
- What happened instead
- The skill name and invocation
- Your Claude Code version

## Questions

Open a discussion or an issue. As the sole maintainer I review things as I can.

## License

By contributing you agree that your contributions will be licensed under the MIT License (see `LICENSE`).
