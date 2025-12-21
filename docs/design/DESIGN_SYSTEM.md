# VidyaRas Design System - Complete Reference

This document consolidates design system documentation for both platforms of VidyaRas:
- **Part 1**: Mobile App (Flutter - Student Interface)
- **Part 2**: Web Dashboard (Next.js - Admin/Teacher Interface)

---

# Part 1: Mobile App Design System (Flutter)

**Platform**: Flutter (Android-first)  
**Audience**: Students/Learners  
**Languages**: Bilingual (Hindi + English)  
**Status**: Partially Implemented - Migration In Progress

---

## Foundation Tokens ✅

### Colors
**Implemented** in `app_colors.dart`:
- ✅ Surfaces: `background`, `surface`, `surfaceLight`, `surfaceTint`
- ✅ Text: `textPrimary`, `textSecondary`, `textTertiary`, `textOnBrand`
- ✅ Borders: `borderSubtle`, `border`, `divider`
- ✅ Actions: `primary`, `primaryPressed`, `accent`, `accentPressed`, `disabled`
- ✅ Status: `success`, `warning`, `error`, `info`
- ✅ Categories: `categoryMusic`, `categoryWellness`, etc.

**Missing**:
- ❌ `color.focus.ring` - Focus ring with opacity
- ❌ `color.surface.raised` - Semantic alias

### Spacing
**Implemented** in `app_spacing.dart`:
- 4dp baseline: `xxs=4, xs=8, sm=12, md=16, lg=20, xl=24, xxl=32, xxxl=40, huge=48, massive=64`
- Screen gutters: `screenPadding=20`, `screenPaddingCompact=16`
- Section: `sectionGap=24`, `itemGap=12`, `itemGapTight=8`
- Card: `cardPadding=16`, `cardPaddingLarge=20`

### Radius
**Implemented** in `app_spacing.dart` (AppRadius):
- Scale: `sm=8, md=12, lg=16, xl=20, xxl=24, full=999`
- Semantic: `card=16`, `button=12`, `input=12`, `chip=8`, `bottomSheet=20`

### Elevation
**Implemented** in `app_spacing.dart` (AppElevation):
- `none`, `card`, `cardRaised`, `overlay`, `fab`

### Typography
**Implemented** via Material `textTheme`:
- Display: `displayLarge` (32/40, 700)
- Headlines: `headlineLarge` (24/32, 700), `headlineMedium` (20/28, 700), `headlineSmall` (18/26, 600)
- Titles: `titleLarge` (16/24, 600), `titleMedium` (14/20, 600), `titleSmall` (12/16, 600)
- Body: `bodyLarge` (16/24, 400), `bodyMedium` (14/20, 400), `bodySmall` (12/16, 400)
- Labels: `labelLarge` (14/20, 600), `labelMedium` (12/16, 500), `labelSmall` (10/12, 500)

**Missing**:
- ❌ **Devanagari Font**: Need `Hind` or `Noto Sans Devanagari` for Hindi

### Gradients
**Implemented** in `app_gradients.dart`:
- Hero: `hero` (Indigo→Violet), `heroWarm` (Saffron→Orange)
- CTA: `cta` (Indigo→Violet), `ctaAccent` (Saffron→Orange)

### Motion
**Implemented** in `app_spacing.dart`:
- Duration: `micro=120ms`, `standard=200ms`, `page=320ms`, `slow=500ms`
- Curves: `enter`, `exit`, `standard`, `bounce`

### Icon Sizes
**Implemented** in `app_spacing.dart`:
- `xs=16, sm=20, md=24, lg=32, xl=40, xxl=48, hero=64`

---

## Components ✅ **28 Total**

### Buttons (6/6)
- ✅ `PrimaryButton`, `SecondaryButton`, `AppTextButton`
- ✅ `SocialLoginButton`, `AppIconButton`, `AppBackButton`

### Inputs (3/3)
- ✅ `TextInputField`, `PasswordInputField`, `CheckboxWithLabel`

### Typography (3/3)
- ✅ `BilingualText`, `BadgeLabel`, `LanguageToggle`

### Layout (4/4)
- ✅ `FeatureIconContainer`, `DividerWithText`, `SectionHeader`, `AvatarWithBadge`

### Cards (6/6)
- ✅ `ProfileCard`, `ReferralCard`, `CourseCard`
- ✅ `SelectableOptionCard`, `StatsRow`, `StatsCard`

### Navigation (3/3)
- ✅ `BottomNavBar`, `AppHeader`, `GradientHeader`

### Progress (4/4)
- ✅ `ProgressBar`, `CarouselDots`, `StepIndicator`, `StarRating`

---

## Patterns ✅

### Pattern Widgets
- ✅ `HeroHeader`, `HeroHeaderCompact`
- ✅ `AppSectionHeader`
- ✅ `AppEmptyState`, `AppEmptyStateInline`
- ✅ `AppLoadingState`, `AppLoadingInline`
- ✅ `AppErrorState`
- ✅ `AppSegmentedControl`

**Missing**:
- ❌ `AppSkeleton` - Incomplete implementation

---

## Migration Status ⚠️

### Code Quality Issues

**Hardcoded Colors**: 🔴 20 files still have `Color(0x...)` instead of `AppColors.*`

**Magic Number Spacing**: 🔴 23 matches of hardcoded `EdgeInsets` instead of `AppSpacing.*`

**Inconsistent States**: Multiple screens use custom error/loading instead of pattern widgets

### Screen Migration Status

**Tab Roots (Priority 1)**:
- ⚠️ Home - Partially migrated
- ⚠️ Learning - Needs audit
- ⚠️ Community - Needs audit
- ⚠️ Tests - Needs audit
- ⚠️ Profile - Uses legacy `GradientHeader`, should use `HeroHeader`

---

## Immediate Action Items

### Critical ⚠️: Import Requirements

**When using tokens, ALWAYS add imports**:
```dart
import '../theme/app_colors.dart';      // For AppColors.*
import '../theme/app_spacing.dart';     // For AppSpacing.*
import '../theme/app_gradients.dart';   // For AppGradients.*
```

**Common Error**: `The getter 'AppColors' isn't defined` → Missing import

### High Priority
1. **Fix 20 files with hardcoded colors** → Use `AppColors.*` + add imports
2. **Fix 23 magic number spacing** → Use `AppSpacing.*` + add imports
3. **Standardize error states** → Use `AppErrorState`
4. **Configure Devanagari font** → Add `Hind`/`Noto Sans Devanagari`

### Medium Priority
5. **Complete tab root migration** → All use `HeroHeader`
6. **Add focus ring token** → `color.focus.ring`
7. **Complete skeleton loader** → Finish `AppSkeleton`

---

## Completion Metrics

| Category | Status | Completion |
|----------|--------|------------|
| Foundation Tokens | ✅ Complete | 95% |
| Components | ✅ Complete | 100% |
| Patterns | ✅ Mostly Complete | 90% |
| Screen Migration | ⚠️ In Progress | 30% |
| Code Quality | 🔴 Needs Work | 60% |
| **Overall** | ⚠️ **In Progress** | **75%** |

---

# Part 2: Web Dashboard Design System (Next.js)

**Platform**: Next.js 14+ (Web)  
**Audience**: Admin/Teachers  
**Stack**: Tailwind CSS v4 + shadcn/ui  
**Status**: Implemented

---

## Core Principles

- **Consistency**: Use shared components and tokens (no hardcoded values)
- **Simplicity**: Stick to defined palette and typography
- **Accessibility**: Sufficient contrast + keyboard navigation

---

## Colors

All colors defined as CSS variables in `index.css` and mapped in `tailwind.config.ts`.

### Primary
- `bg-primary` - Main brand (Purple/Violet)
- `text-primary-foreground` - Text on primary

### Secondary
- `bg-secondary` - Secondary actions/backgrounds
- `text-secondary-foreground` - Text on secondary

### Backgrounds
- `bg-background` - Page background
- `bg-card` - Card background (white/dark gray)
- `bg-muted` - Muted background for inactive

### Text
- `text-foreground` - Primary text
- `text-muted-foreground` - Secondary/helper text

---

## Typography

**Font Family**: `Inter` (sans-serif)

**Headings**: `font-bold`, `tracking-tight`
- H1: `text-3xl` or `text-2xl`
- H2: `text-xl`

**Body**: `text-sm` or `text-base`

**Small**: `text-xs`, `text-muted-foreground`

---

## Spacing

Use Tailwind's default spacing scale:
- Layout padding: `p-4` or `p-6`
- Component gap: `gap-4` or `gap-2`
- Section spacing: `space-y-6`

---

## Components

Use shadcn/ui components from `@/components/ui`.

### Buttons
```tsx
<Button>Action</Button>
<Button variant="secondary">Cancel</Button>
<Button variant="ghost">Icon</Button>
<Button variant="destructive">Delete</Button>
```

### Cards
```tsx
<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
  </CardHeader>
  <CardContent>
    Content
  </CardContent>
</Card>
```

### Inputs
Use `Input`, `Label`, `Textarea`. Always wrap inputs with `Label`.

---

## Layout

Dashboard uses Sidebar layout:
- **Page Wrapper**: Pages rendered inside `SidebarInset`
- **Header**: Standard dashboard header or consistent page header
- **Content**: Wrap in container (e.g., `max-w-4xl mx-auto`)

---

## Course Builder Specifics

Course Builder should align with dashboard:
- Remove custom full-screen headers that conflict with sidebar
- Use standard breadcrumb navigation
- Use `StepWizard` for multi-step, but within content area

---

## References

**Mobile App (Flutter)**:
- Full design docs: `docs/design/`
- Component guide: `docs/component_usage_guide.md`
- PR checklist: `docs/design/09_pr_checklist_and_guardrails.md`
- Migration patterns: `docs/design/MIG RATION_PATTERNS.md`

**Web Dashboard (Next.js)**:
- UI specifications: `docs/plans/ui_specs_README.md`
- Style guidelines: `docs/plans/ui_style_guidelines.md`
