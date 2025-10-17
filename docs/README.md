# VidyaRas Project Documentation

Complete documentation for the VidyaRas Flutter application - a bilingual learning ecosystem for traditional arts, wellness, and personal development.

---

## 📚 Core Documentation (MANDATORY READING)

### 1. Architecture Specification
**File:** `architecture.md`

Defines the Feature-First Layered Architecture that MUST be followed.

**Key Topics:**
- Feature-First organization
- 4-layer architecture (Presentation, Application, Domain, Data)
- Dependency Rule
- Layer responsibilities
- Technology stack usage guidelines

**Status:** ⚠️ **NON-NEGOTIABLE** - Must be followed precisely

---

### 2. Coding Rules & Standards
**File:** `rules.md`

Official coding guidelines and architectural rules.

**Key Topics:**
- Code generation requirements
- Separation of concerns
- State management patterns
- Data modeling standards
- Testing requirements

**Status:** ⚠️ **NON-NEGOTIABLE** - Violations are unacceptable

---

### 3. Product Requirements Document (PRD)
**File:** `prd.md`

Complete product specification, features, and roadmap.

**Key Topics:**
- Product vision and mission
- Target audience
- Core features
- Technical requirements
- Success metrics

**Status:** ℹ️ **REFERENCE** - Understand product context

---

## 🎨 UI Component Documentation

### 4. Component Usage Guide
**File:** `component_usage_guide.md`

**⚠️ MANDATORY before implementing any UI screens**

Complete guide for all 28 reusable components with examples.

**Contents:**
- Import statements for each component
- Usage examples with code
- Property descriptions
- Theme system (colors, gradients)
- Best practices and common mistakes
- Complete example screens (Login, Onboarding, etc.)
- Architecture compliance guidelines

**Components Covered:**
- 6 Button components
- 3 Input Field components
- 3 Typography components
- 4 Layout components
- 5 Card components
- 3 Navigation components
- 4 Progress & Indicator components

**Status:** ⚠️ **MANDATORY** - Review before building UI

---

### 5. Component Compliance Report
**File:** `component_compliance_report.md`

Verification that all components comply with architecture rules.

**Contents:**
- Architecture compliance verification
- Component-by-component checklist
- Code quality results
- Dependency verification
- Zero violations confirmation

**Status:** ✅ **VERIFIED** - All components approved

---

## 🚀 Quick Start Guide

### For New Developers

**1. Read in this order:**
```
1. docs/architecture.md    (Understand the architecture)
2. docs/rules.md          (Learn coding standards)
3. docs/prd.md            (Understand product context)
4. docs/component_usage_guide.md  (Learn available components)
```

**2. Set up development environment:**
```bash
cd vidyaras_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**3. Before implementing ANY feature:**
- Review `component_usage_guide.md` for available components
- Check `architecture.md` for layer structure
- Verify `rules.md` for coding standards
- Use existing components (don't create new ones if they exist)

---

## 📁 Documentation File Structure

```
docs/
├── README.md                        # This file - Documentation index
├── architecture.md                  # Architecture specification (MANDATORY)
├── rules.md                         # Coding rules and standards (MANDATORY)
├── prd.md                          # Product requirements
├── component_usage_guide.md        # Component library guide (MANDATORY)
└── component_compliance_report.md  # Compliance verification

mockups/
├── intro.png                       # Intro screen mockup
├── intro2.png                      # Intro screen 2 mockup
├── login.png                       # Login screen mockup
├── onboarding.png                  # Onboarding screen mockup
└── home.png                        # Home screen mockup
```

---

## 🏗️ Architecture Quick Reference

### Feature-First Layered Structure
```
lib/src/
├── shared/
│   ├── presentation/
│   │   ├── components/    # 28 reusable components
│   │   └── theme/         # Theme configuration
│   ├── application/       # Shared business logic
│   ├── domain/            # Shared models & interfaces
│   └── data/              # Shared data sources
└── features/
    └── feature_name/
        ├── 1_presentation/  # UI widgets & screens
        ├── 2_application/   # Use cases & services
        ├── 3_domain/        # Models & repository interfaces
        └── 4_data/          # Repository implementations
```

### Dependency Rule
```
Presentation → Application → Domain ← Data
```

---

## 🎨 Available UI Components (28 Total)

### Quick Component Reference

**Buttons:**
- PrimaryButton, SecondaryButton, AppTextButton
- SocialLoginButton, AppIconButton, AppBackButton

**Input Fields:**
- TextInputField, PasswordInputField, CheckboxWithLabel

**Typography:**
- BilingualText, BadgeLabel, LanguageToggle

**Layout:**
- FeatureIconContainer, DividerWithText, SectionHeader, AvatarWithBadge

**Cards:**
- ProfileCard, ReferralCard, CourseCard, SelectableOptionCard, StatsRow

**Navigation:**
- BottomNavBar, AppHeader, GradientHeader

**Progress & Indicators:**
- ProgressBar, CarouselDots, StepIndicator, StarRating

**Full details:** See `component_usage_guide.md`

---

## ✅ Pre-Implementation Checklist

Before implementing any feature, verify:

- [ ] Read `architecture.md` - understand layer structure
- [ ] Read `rules.md` - know coding standards
- [ ] Read `component_usage_guide.md` - see available components
- [ ] Verified architecture compliance requirements
- [ ] Understood Dependency Rule
- [ ] Know which layer code belongs in
- [ ] Checked if reusable component already exists
- [ ] Understood bilingual support requirements (Hindi + English)

---

## 🚨 Critical Rules

### NON-NEGOTIABLE

1. **Architecture:** Follow Feature-First Layered Architecture exactly
2. **Components:** Use existing components from `shared/presentation/components/`
3. **Theme:** Use `AppColors` and `AppGradients` (no hardcoded colors)
4. **Business Logic:** NEVER in Presentation Layer
5. **Bilingual:** All user-facing text must support Hindi + English
6. **Data Layer:** Must return `Future<Either<Failure, Success>>`
7. **Code Gen:** Use `@riverpod`, `@freezed`, `@JsonSerializable`
8. **Testing:** Write tests for each layer

### VIOLATIONS ARE UNACCEPTABLE

Any violation of rules in `architecture.md` or `rules.md` must be corrected immediately.

---

## 📞 Getting Help

### Common Questions

**Q: Where do UI components go?**
A: Always in `lib/src/shared/presentation/components/` or feature's `1_presentation/` layer

**Q: Can I create a new button component?**
A: NO - Use existing buttons from `component_usage_guide.md`. Only create if truly unique.

**Q: Where does business logic go?**
A: NEVER in Presentation Layer. Always in Application Layer (`2_application/`).

**Q: Can I hardcode colors?**
A: NO - Always use `AppColors.*` or `AppGradients.*` from theme.

**Q: Do I need bilingual support?**
A: YES - All user-facing text must support both Hindi and English.

**Q: What if I'm not sure which layer?**
A: Review `architecture.md` section 2 (Layer Responsibilities).

---

## 🎯 Success Criteria

A feature is complete when:

1. ✅ Follows Feature-First Layered Architecture
2. ✅ All layers respect Dependency Rule
3. ✅ Uses existing reusable components
4. ✅ Uses theme colors/gradients (no hardcoded)
5. ✅ Bilingual support implemented (Hindi + English)
6. ✅ No business logic in Presentation Layer
7. ✅ Data Layer returns `Either<Failure, Success>`
8. ✅ Models use Freezed
9. ✅ Providers use `@riverpod`
10. ✅ Tests written and passing
11. ✅ Code follows Dart formatting
12. ✅ `flutter analyze` shows no errors

---

## 📊 Project Status

**Current Phase:** Feature Implementation

**Completed:**
- ✅ 28 reusable components implemented
- ✅ Theme system configured
- ✅ Architecture documentation & rules defined
- ✅ Component usage guide & compliance report
- ✅ **Quiz Feature UI Workflow**: The entire flow for taking a quiz, viewing results, and reviewing answers is complete and functional with mock data.

**Next Steps:**
1.  Implement Auth Flow (Login, Signup, Onboarding).
2.  Implement Home Screen and Course Listing using components.
3.  Connect features to a live backend API instead of mock data.
4.  Add widget tests for components and features.
5.  Implement localization (ARB files for Hindi/English).

---

## 🔗 External Resources

- **Flutter SDK:** 3.35.5 (Dart 3.9.2)
- **Flutter Docs:** https://flutter.dev/docs
- **Riverpod Docs:** https://riverpod.dev
- **Freezed Docs:** https://pub.dev/packages/freezed
- **shadcn_ui:** https://pub.dev/packages/shadcn_ui

---

## 📝 Document Maintenance

**Last Updated:** 2025-10-14

**Maintainers:** VidyaRas Development Team

**Update Frequency:**
- Architecture docs: As needed (notify team)
- Component guide: When components added/changed
- Compliance report: After major changes

---

**Remember:** The architecture is **non-negotiable**. Follow the rules in `architecture.md` and `rules.md` precisely.
