# VidyaRas Student App — Design System (Mobile)

This folder contains the **source-of-truth design system docs** for the **VidyaRas learner (student) Flutter app** (Android-first, bilingual Hindi+English), created to fix the current lack of visual cohesion across screens.

## Scope

- **In scope**: Learner app (Flutter) UI foundations, tokens, components, patterns, accessibility, content (bilingual) rules, and governance.
- **Out of scope**: Admin/Teacher web dashboard UI (see `docs/design_system.md` and `docs/plans/ui_style_guidelines.md`).

## Why this exists

Screens currently use different header styles, gradients, spacing, radii, typography, and card treatments. A design system gives us:

- **Consistency**: One visual language across Home/Learning/Community/Tests/Profile.
- **Speed**: Compose screens from shared components instead of re-inventing UI per feature.
- **Quality**: Better accessibility, readability, and UX for a broad audience.

## Reading order (recommended)

1. `00_product_and_audience.md` — Target audience and design direction
2. `01_design_system_architecture.md` — System structure and layers
3. `02_foundations_tokens.md` — Color, typography, spacing, radius, elevation
4. `03_components.md` — Component contracts and variants
5. `04_patterns_and_templates.md` — Screen templates and layout patterns
6. `05_content_and_i18n.md` — Bilingual content rules
7. `06_accessibility.md` — Touch targets, contrast, semantics
8. `07_cohesion_audit_and_migration.md` — Migration checklist
9. `08_governance_and_versioning.md` — Change management
10. `09_pr_checklist_and_guardrails.md` — **PR checklist to prevent UI drift**
11. `MIGRATION_PATTERNS.md` — **Common patterns and fixes (read before migrating code)**

## Relationship to existing repo docs

- **PRD**: `docs/prd.md` (vision, audience, UX principles).
- **Flutter component inventory**: `docs/component_usage_guide.md` (what exists today).
- **Web/admin design tokens**: `docs/design_system.md`, `docs/plans/ui_style_guidelines.md` (different platform + different constraints).


