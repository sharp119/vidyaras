# Repository Guidelines

## Project Structure & Module Organization
- Flutter app lives in `vidyaras_app/`.
- Source follows feature‑first layered architecture in `vidyaras_app/lib/src/`:
  - `shared/` (reusable components, theme, routing)
  - `features/<feature>/[1_presentation, 2_application, 3_domain, 4_data]/`
- Tests in `vidyaras_app/test/` (`*_test.dart`).
- Documentation in `docs/` (read `docs/architecture.md` and `docs/rules.md` first). Reference materials in `inspiration/` and agreements in `term_docs/`.

## Build, Test, and Development Commands
```bash
cd vidyaras_app
flutter pub get                                   # install deps
flutter pub run build_runner build --delete-conflicting-outputs  # generate code
flutter analyze                                   # lints
flutter test                                      # run tests
flutter run                                       # run app (select a device)
```
Tip: For coverage, `flutter test --coverage` creates `coverage/lcov.info`.

## Coding Style & Naming Conventions
- Dart/Flutter with `flutter_lints` (see `analysis_options.yaml`). Run `flutter analyze` locally.
- Formatting: `dart format .` (CI should not reformat your code).
- Naming: files `lower_snake_case.dart`; classes/types `UpperCamelCase`; members `lowerCamelCase`.
- Architecture: follow `docs/architecture.md` (Presentation → Application → Domain → Data). Do not violate dependency direction.
- Imports: prefer `package:vidyaras_app/...` over deep relative paths.

## Testing Guidelines
- Use `flutter_test`; name files `*_test.dart` under `vidyaras_app/test/`.
- Write widget tests for UI and unit tests for application/domain logic.
- Keep tests fast and deterministic; avoid real network—mock Supabase and storage.

## Commit & Pull Request Guidelines
- Commits: imperative, concise subjects (≤72 chars). Prefer Conventional Commits where practical: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.
- PRs must include: summary, linked issues, screenshots/GIFs for UI, test coverage note, and a checklist confirming `build_runner`, `analyze`, and `test` pass.

## Security & Configuration Tips (Optional but Recommended)
- Do not commit secrets. For local overrides use `--dart-define`/env files; keep SQL in `vidyaras_app/supabase_setup.sql` for onboarding only.
- Validate inputs and handle failures via the repository/use‑case layers; surface user‑friendly errors in presentation.

## Agent-Specific Notes
- Obey this file and the docs/ scope for all changes. If editing code, ensure architecture and lint rules remain green (`flutter analyze`).
