# CreativeStack

AI skill suite for creative professionals. 29 skills across 10 categories, plus 4 workflow agents.

## Project structure

This is a flat Claude Code skill stack installed at `~/.claude/skills/creativestack`. Skills are invoked flat as `/skill-name` (the parent directory is just a grouping — it does not create a namespace). The `setup` skill is named `setup-cs` to avoid collision with other stacks.

- Skills live in `skills/*/SKILL.md` (generated — do not edit directly)
- Source templates live in `_build/templates/*/SKILL.md.tmpl`
- Shared content lives in `_build/shared/` (preamble, lead gen templates)
- Workflow agents live in `agents/` (pitch-prep, project-setup, delivery-review, research-deep-dive)
- User data (Brain) lives at `~/.creativestack/` — never in this repo

## Building

After editing any `.tmpl` file or shared content:

```bash
bash _build/build-skills.sh
```

This regenerates all `skills/*/SKILL.md` files. Commit both `.tmpl` and `.md` files.

## Skill template

Every skill follows the pattern in `_build/shared/preamble.md`. See any existing skill's `.tmpl` file for the structure. Cross-skill references use flat `/skill-name` invocation.

## Philosophy

- Enhance the creative process, never generate creative output
- The creative step stays human
- Support the INPUT side: research, briefs, strategy, process
- Professional but not corporate tone
