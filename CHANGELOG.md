# Changelog

All notable changes to CreativeStack will be documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

## [Unreleased]

### Changed
- Converted from Claude Code plugin to flat skill stack. Skills now invoked as `/skill-name` instead of `/creativestack:skill-name`.
- Removed `.claude-plugin/` manifest and `hooks/` directory (plugin-only).
- `scripts/check-brain.sh` self-locates instead of relying on `$CLAUDE_PLUGIN_ROOT`; install manually as a SessionStart hook via `~/.claude/settings.json` if desired.

### Added
- `CONTRIBUTING.md` with build process, skill template guidance, and PR checklist
- `CODE_OF_CONDUCT.md` based on Contributor Covenant 2.1
- GitHub issue and pull request templates

## [0.1.0] — 2026-04-02

### Added
- Initial public release
- 29 skills across 10 categories (research, strategy, briefs, delivery, operations, lead gen, ops, brand, comms, kickoff)
- 4 workflow agents: pitch-prep, project-setup, delivery-review, research-deep-dive
- Build system for generating `skills/*/SKILL.md` from `_build/templates/*.tmpl`
- Shared preamble with Brain discovery at `~/.creativestack/`
