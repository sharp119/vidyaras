# VidyaRas Flutter App

A bilingual learning ecosystem for traditional arts, wellness, and personal development.

## Quick Start

### Prerequisites
- Flutter SDK 3.35.5+
- Dart 3.9.2+

### Setup
```bash
cd vidyaras_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run
```bash
flutter run
```

## Architecture

This app follows **Feature-First Layered Architecture**:

```
lib/src/
├── shared/          # Shared components, theme, utilities
└── features/        # Feature modules
    └── feature_name/
        ├── 1_presentation/   # UI (screens, widgets)
        ├── 2_application/    # Business logic (providers, controllers)
        ├── 3_domain/         # Models, interfaces
        └── 4_data/           # Data sources, repositories
```

**Dependency Rule**: `Presentation → Application → Domain ← Data`

## Key Features

- ✅ **28 Reusable UI Components** - Consistent design system
- ✅ **Quiz System** - Full quiz taking with Supabase integration
- ✅ **Course Learning** - Video lectures, materials, progress tracking
- ✅ **Real-time Chat** - Community discussions with Supabase Realtime
- ✅ **Auth & Profile** - Hybrid Supabase Auth + Custom API
- ✅ **Bilingual Support** - Hindi + English (In Progress)

## Tech Stack

- **UI**: Flutter with shadcn_ui components
- **State**: Riverpod (with code generation)
- **Data**: Freezed models, fpdart Either for error handling
- **Backend**: Supabase (PostgreSQL + Realtime) + Custom API
- **Local Storage**: Hive

## Documentation

📚 **Full documentation**: See [`../docs/`](../docs/)

**Must Read**:
- [`../docs/README.md`](../docs/README.md) - Documentation index
- [`../docs/architecture.md`](../docs/architecture.md) - Architecture spec (MANDATORY)
- [`../docs/rules.md`](../docs/rules.md) - Coding standards (MANDATORY)
- [`../docs/component_usage_guide.md`](../docs/component_usage_guide.md) - UI components

**Feature Guides**:
- [`ENROLLMENT_FEATURE_GUIDE.md`](./ENROLLMENT_FEATURE_GUIDE.md) - Enrollment via native share

## Development

### Code Generation
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Run this after changes to:
- `@freezed` models
- `@riverpod` providers
- `@JsonSerializable` classes

### Static Analysis
```bash
flutter analyze
```

### Build APK
```bash
# Debug
flutter build apk --debug

# Release
flutter build apk --release
```

## Project Status

**Current**: Production-ready features include quizzes, learning, chat. Home/courses use stub data.

See [`../docs/audits/category-filtering-audit-2025-12.md`](../docs/audits/category-filtering-audit-2025-12.md) for detailed status.

## Contributing

Before implementing features:
1. Read `docs/architecture.md` and `docs/rules.md`
2. Check `docs/component_usage_guide.md` for existing components
3. Follow the 4-layer architecture strictly
4. Use existing components (don't recreate)
5. Always use theme tokens (no hardcoded colors/spacing)

## Support

For development questions, refer to documentation in `docs/`.
