# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## ⚠️ CRITICAL CONSTRAINTS

**Before executing ANY command or script:**
- **DO NOT** run shell commands, bash scripts, or any executable files unless explicitly prompted by the user
- **ALWAYS** await user permission before executing build, test, lint, or deployment commands
- After implementing any feature or change, **VERIFY** that the implementation adheres to all rules in `docs/rules.md` and `docs/architecture.md`

**Reference Documentation:**
- **MANDATORY:** Review `docs/rules.md`, `docs/prd.md`, and `docs/architecture.md` before making any code changes
- These documents define the non-negotiable architectural principles and must be followed precisely

---

## 📁 Project Structure

This is a **VidyaRas** Flutter application - a bilingual (Hindi + English) learning ecosystem for traditional arts, wellness, and personal development.

**Project Root:**
- `vidyaras_app/` - Main Flutter application
- `docs/` - Architecture, rules, and PRD documentation
- `term_docs/` - Additional documentation
- `preview/` - Preview assets

**Flutter App Location:** `/vidyaras_app/`

---

## 🏗️ Architecture: Feature-First Layered Approach

The codebase follows a **strict Feature-First Layered Architecture** inspired by Clean Architecture.

### Dependency Rule
Dependencies **must always flow inwards:**
```
Presentation Layer ➡️ Application Layer ➡️ Domain Layer ⬅️ Data Layer
```

### Required Directory Structure for Each Feature
```
lib/
└── src/
    └── features/
        └── feature_name/
            ├── 1_presentation/  # UI (Widgets & State managed by Riverpod)
            ├── 2_application/   # Business Logic (Use Cases/Services)
            ├── 3_domain/        # Core Models & Repository Interfaces
            └── 4_data/          # Data Sources & Repository Implementations
```

### Layer Responsibilities

**1. Presentation Layer (1_presentation/)**
- Contains all UI widgets, screens, and Riverpod providers
- Displays data from Application Layer
- Passes user events to Application Layer
- **NO business logic allowed**

**2. Application Layer (2_application/)**
- Orchestrates data flow and executes business rules
- Responds to UI events
- Fetches data via repository interfaces
- Provides state to Presentation Layer

**3. Domain Layer (3_domain/)**
- Defines core data structures (models/entities)
- Defines repository contracts (abstract classes)
- Completely independent of frameworks
- Defines "what" not "how"

**4. Data Layer (4_data/)**
- Implements repository contracts from Domain Layer
- Handles API calls, local database operations
- Transforms raw data into domain models
- **Must return `Future<Either<Failure, SuccessType>>`** - no exceptions allowed

---

## 🛠️ Technology Stack

### Core Libraries (Mandatory Usage)

**UI & Theming:**
- `shadcn_ui` - Primary UI component library (use instead of building custom components)
- `flutter_svg` - SVG rendering (assets in `assets/svgs`)
- `cached_network_image` - Network image display with caching
- `fl_chart` - Data visualization and charts

**State Management:**
- `riverpod` & `riverpod_generator` - **ALWAYS use `@riverpod` annotations** (no manual providers)
- Providers belong in Presentation Layer
- Use `.autoDispose` by default (`@riverpod`) unless state must persist globally

**Data Modeling:**
- `freezed` & `json_serializable` - **ALL models must use freezed for immutability**
- `equatable` - For custom objects requiring value-based equality

**Navigation:**
- `go_router` - All routing centralized in single configuration file
- Use named routes (e.g., `context.go('/course/123')`)

**Networking & Storage:**
- `dio` - HTTP client (**ONLY in Data Layer**)
- `hive` - Local key-value storage (**ONLY in Data Layer**)

**Error Handling:**
- `fpdart` - Functional programming patterns
- Repository methods **MUST** return `Future<Either<Failure, SuccessType>>`

**Utilities:**
- `intl` - Internationalization (no hardcoded strings in UI)
- `url_launcher` & `permission_handler` - Wrap in Application Layer services

**Testing:**
- `mocktail` - Primary mocking library for unit and widget tests

---

## 🎨 Reusable UI Components

**CRITICAL:** The project has **28 pre-built reusable components** extracted from mockups. You **MUST** use these components instead of creating new ones.

### Component Library Location
```
vidyaras_app/lib/src/shared/presentation/components/
├── buttons/        # 6 button components
├── inputs/         # 3 input field components
├── typography/     # 3 typography components
├── layout/         # 4 layout components
├── cards/          # 5 card components
├── navigation/     # 3 navigation components
└── progress/       # 4 progress indicator components
```

### Available Components (28 Total)

**Buttons:**
1. `PrimaryButton` - Gradient buttons for CTAs (Sign In, Next, Get Started)
2. `SecondaryButton` - Outlined buttons for secondary actions
3. `AppTextButton` - Text-only buttons (Skip, Forgot Password, View All)
4. `SocialLoginButton` - Google/Facebook login buttons
5. `AppIconButton` - Icon-only buttons (Settings, Close)
6. `AppBackButton` - Navigation back button with icon + text

**Input Fields:**
7. `TextInputField` - Text input with label and optional leading icon
8. `PasswordInputField` - Password input with show/hide toggle
9. `CheckboxWithLabel` - Checkbox with clickable text label

**Typography:**
10. `BilingualText` - Display English + Hindi text together
11. `BadgeLabel` - Status badges (Premium Member, difficulty levels)
12. `LanguageToggle` - Switch between Hindi/English

**Layout:**
13. `FeatureIconContainer` - Large circular gradient icons for feature showcases
14. `DividerWithText` - "OR CONTINUE WITH" style divider
15. `SectionHeader` - Section title with "View All" action link
16. `AvatarWithBadge` - Profile picture with edit icon overlay

**Cards:**
17. `ProfileCard` - User profile with avatar, stats, premium badge
18. `ReferralCard` - Referral points with invite CTA
19. `CourseCard` - Course listing with thumbnail, rating, progress
20. `SelectableOptionCard` - Selectable options for onboarding
21. `StatsRow` - Display multiple statistics (Enrolled/Completed/Certificates)

**Navigation:**
22. `BottomNavBar` - 5-tab bottom navigation
23. `AppHeader` - Simple header with title and action button
24. `GradientHeader` - Gradient background header (Profile screen)

**Progress & Indicators:**
25. `ProgressBar` - Linear progress with optional percentage
26. `CarouselDots` - Page indicator dots for intro/onboarding
27. `StepIndicator` - "Step X of Y" with progress bar
28. `StarRating` - Star rating display for courses

### Theme System

**Colors:** `lib/src/shared/presentation/theme/app_colors.dart`
- Primary, secondary, accent colors
- Text colors (primary, secondary, tertiary)
- Status colors (success, error, warning)
- Feature colors (music, wellness, yoga, arts, life skills)

**Gradients:** `lib/src/shared/presentation/theme/app_gradients.dart`
- Primary gradient (Blue → Purple)
- Orange gradient
- Purple, Blue, Referral gradients

**Theme:** `lib/src/shared/presentation/theme/app_theme.dart`
- Material Design theme configuration
- Typography scale
- Component theme overrides

### Component Usage Rules

**✅ MUST DO:**
- Use existing components from `shared/presentation/components/`
- Import theme colors from `app_colors.dart`
- Use predefined gradients from `app_gradients.dart`
- Follow bilingual pattern (Hindi + English) for all user-facing text
- Keep components in Presentation Layer only

**❌ MUST NOT DO:**
- Create new button/input/card components if one already exists
- Place UI components in Application/Domain/Data layers
- Hardcode colors or create inline gradients
- Add business logic to components
- Use English-only text without Hindi translation

### Full Documentation

**Comprehensive usage guide with examples:** `docs/component_usage_guide.md`

This documentation includes:
- Import statements for each component
- Complete usage examples
- Property descriptions
- Best practices and common mistakes
- Complete example screens (Login, Onboarding, etc.)
- Architecture compliance guidelines

**MANDATORY:** Review `docs/component_usage_guide.md` before implementing any UI screens.

---

## 🚀 Development Commands

### Setup & Dependencies
```bash
cd vidyaras_app
flutter pub get
```

### Code Generation
```bash
# Run code generation for Riverpod, Freezed, JSON serialization
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Running the App
```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices  # List available devices
flutter run -d <device_id>

# Run with hot reload support
flutter run --hot
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Run tests with coverage
flutter test --coverage
```

### Building
```bash
# Build APK (Android)
flutter build apk --release

# Build App Bundle (Android)
flutter build appbundle --release

# Build for iOS (requires macOS)
flutter build ios --release
```

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
dart format lib/ test/

# Check formatting
dart format --output=none --set-exit-if-changed lib/ test/
```

### Cleaning
```bash
# Clean build artifacts
flutter clean

# Full clean and dependency reinstall
flutter clean && flutter pub get
```

---

## 🎯 Key Development Rules

### Code Generation & Architecture
1. **Non-negotiable architecture** - Feature-First Layered structure must be followed
2. **Strict separation of concerns** - Each layer has a specific role
3. **No business logic in Presentation Layer** - UI only displays and delegates
4. **No exceptions in Data Layer** - Use `Either<Failure, Success>` pattern
5. **All models must use Freezed** - Enforces immutability
6. **Use code generation** - Always use `riverpod_generator`, never manual providers

### UI Development
1. **Prefer shadcn_ui components** over custom widgets
2. **Centralize theme configuration** - No one-off inline styles
3. **Always provide placeholder and error widgets** for network images
4. **No hardcoded strings** - Use `AppLocalizations` for all user-facing text
5. **Bilingual support** - Hindi + English for all content

### Data & State Management
1. **Single Dio instance** - Provided via Riverpod, configured centrally
2. **Hive usage confined to Data Layer** - Rest of app unaware of Hive
3. **Providers in Presentation Layer only** - They fetch from Application Layer
4. **Default to `.autoDispose`** - Unless global persistence required

### Testing
1. **Mock repository interfaces** when testing Application Layer
2. **Mock Application Layer services** when testing Presentation Layer
3. **Keep tests fast and isolated** - Use mocks liberally

### Feature Implementation Workflow
1. Read `docs/architecture.md` and `docs/rules.md` before starting
2. Create feature directory with 4-layer structure
3. Define domain models and repository interfaces first
4. Implement repository in Data Layer
5. Create use cases/services in Application Layer
6. Build UI in Presentation Layer with Riverpod providers
7. **Verify compliance with architecture rules** after implementation
8. Write tests for each layer

---

## 📋 Product Context

**VidyaRas Mission:** Holistic learning ecosystem for traditional Indian arts, wellness, and personal development.

**Target:** 500 paid active learners in Year 1

**Core Features (from PRD):**
- User onboarding with personalized recommendations
- Live & recorded courses with gated progression
- Zoom integration for live classes
- Two-tier community chat (batch-specific + global)
- Payment processing with EMI support
- Admin & teacher web dashboards
- Progress tracking and certificates
- Bilingual interface (Hindi/English)

**Tech Stack:**
- Student app: Flutter (Android-first, iOS later)
- Backend integration via REST APIs
- Video streaming via Zoom
- Role-based access control (RBAC)

---

## 🎨 Design Principles

- **Minimal, bilingual, responsive layout**
- **Personalized dashboards** with algorithmic curation
- **Cultural authenticity** blended with modern digital clarity
- **Seamless hybrid content delivery** (live + on-demand)
- **Optimized video delivery** for smooth playback

---

## 🔍 Validation Checklist

After implementing any feature or change:
- [ ] Code follows Feature-First Layered Architecture
- [ ] All layers respect the Dependency Rule
- [ ] Domain Layer has no framework dependencies
- [ ] Data Layer uses `Either<Failure, Success>` pattern
- [ ] Models use Freezed for immutability
- [ ] Providers use `riverpod_generator` annotations
- [ ] **Used existing reusable components from `shared/presentation/components/`**
- [ ] **Used theme colors from `app_colors.dart` (no hardcoded colors)**
- [ ] **Used predefined gradients from `app_gradients.dart`**
- [ ] **Bilingual support (Hindi + English) for all user-facing text**
- [ ] No hardcoded strings (using localization)
- [ ] No business logic in Presentation Layer
- [ ] Dio and Hive usage confined to Data Layer
- [ ] Tests written and passing
- [ ] Code follows Dart formatting standards

---

## 📚 Additional Resources

- **Architecture Details:** `docs/architecture.md` - Complete architecture specification
- **Coding Rules:** `docs/rules.md` - Non-negotiable coding standards
- **Product Requirements:** `docs/prd.md` - Product roadmap and features
- **Component Usage Guide:** `docs/component_usage_guide.md` - **MANDATORY** - Complete guide for all 28 reusable components
- **Flutter SDK:** 3.35.5 (Dart 3.9.2)
- **Target SDK:** ^3.9.2

---

## 🚨 Critical Reminders

**BEFORE implementing any UI screen:**
1. **Review** `docs/component_usage_guide.md` to see available components
2. **Use existing components** - Do NOT create new buttons/inputs/cards if they exist
3. **Verify** architecture compliance with `docs/architecture.md` and `docs/rules.md`
4. **Ensure** bilingual support (Hindi + English) for all text
5. **Check** that no business logic exists in Presentation Layer

**The architectural rules in `docs/` are NON-NEGOTIABLE and MUST be followed precisely.**

Any violation of the rules in `docs/architecture.md` or `docs/rules.md` is **UNACCEPTABLE** and must be corrected immediately.
