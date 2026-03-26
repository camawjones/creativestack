# Creativestack

AI skill suite for creative professionals. 44 skills across 14 categories.

## Project structure

- Each skill lives in its own directory with a `SKILL.md.tmpl` (source) and `SKILL.md` (generated)
- Shared content lives in `_shared/` (preamble, lead gen templates)
- `bin/build-skills.sh` resolves templates into SKILL.md files
- User data (Agency Context Vault) lives at `~/.creativestack/` — never in this repo

## Building

After editing any `.tmpl` file or shared content:

```bash
bash bin/build-skills.sh
```

This regenerates all SKILL.md files. Commit both `.tmpl` and `.md` files.

## Skill template

Every skill follows the pattern in `_shared/preamble.md`. See any existing skill's `.tmpl` file for the structure.

## Philosophy

- Enhance the creative process, never generate creative output
- The creative leap stays human
- Support the INPUT side: research, briefs, strategy, process
- Professional but not corporate tone
