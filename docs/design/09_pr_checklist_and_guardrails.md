# PR Checklist & Design System Guardrails

This document defines the rules and checklists to **prevent UI drift** after the design system is established.

## PR Checklist for UI Changes

Before merging any PR that touches presentation layer code, verify:

### Imports (Critical - Prevents Compilation Errors)

**⚠️ CRITICAL:** Missing imports cause compilation errors. Always verify imports when using design system tokens.

- [ ] **All design system imports are present** when using tokens
- [ ] `AppColors.*` usage requires: `import '../theme/app_colors.dart'` (or relative path)
- [ ] `AppSpacing.*` usage requires: `import '../theme/app_spacing.dart'` (or relative path)
- [ ] `AppRadius.*` usage requires: `import '../theme/app_spacing.dart'` (same file as AppSpacing)
- [ ] `AppGradients.*` usage requires: `import '../theme/app_gradients.dart'` (or relative path)
- [ ] Pattern widgets require: `import '../patterns/app_*.dart'` (or relative path)

**Common Compilation Errors Fixed:**

1. **Missing AppSpacing import:**
   ```dart
   // ❌ ERROR: The getter 'AppSpacing' isn't defined
   padding: AppSpacing.screenAll,
   
   // ✅ FIX: Add import
   import '../theme/app_spacing.dart';
   padding: AppSpacing.screenAll,
   ```

2. **Missing AppColors import:**
   ```dart
   // ❌ ERROR: The getter 'AppColors' isn't defined
   color: AppColors.secondary,
   
   // ✅ FIX: Add import
   import '../theme/app_colors.dart';
   color: AppColors.secondary,
   ```

**Complete Example:**
```dart
// ❌ BAD - Missing imports cause compilation errors
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,  // Error: AppColors not defined
      padding: AppSpacing.screenAll,  // Error: AppSpacing not defined
    );
  }
}

// ✅ GOOD - All required imports present
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,  // Works!
      padding: AppSpacing.screenAll,  // Works!
    );
  }
}
```

**Migration Checklist:**
When migrating code to use design system tokens:
1. Replace hardcoded values with tokens (`Color(0x...)` → `AppColors.*`)
2. **IMMEDIATELY add the required import** for the token class
3. Verify the file compiles before moving to the next file
4. Test the screen to ensure visual appearance is unchanged

### Colors
- [ ] **No hardcoded hex colors** in presentation files
- [ ] All colors use `AppColors.*` semantic tokens
- [ ] Status colors use `AppColors.success/warning/error/info`
- [ ] Category colors use `AppColors.category*` tokens

### Gradients
- [ ] No new gradients introduced
- [ ] Only `AppGradients.hero` or `AppGradients.heroWarm` used for headers
- [ ] Only `AppGradients.cta` or `AppGradients.ctaAccent` used for buttons

### Spacing
- [ ] All padding/margin values use `AppSpacing.*` tokens
- [ ] Screen horizontal padding uses `AppSpacing.screenPadding` (20dp)
- [ ] Section gaps use `AppSpacing.sectionGap` (24dp)
- [ ] Item gaps use `AppSpacing.itemGap` (12dp)

### Border Radius
- [ ] All border radii use `AppRadius.*` tokens
- [ ] Cards use `AppRadius.card` (16dp)
- [ ] Buttons use `AppRadius.button` (12dp)
- [ ] Chips use `AppRadius.chip` (8dp)

### Typography
- [ ] Text styles come from `Theme.of(context).textTheme.*`
- [ ] Custom styles use `AppColors.text*` for colors
- [ ] Font weights are from the defined scale (400, 500, 600, 700)

### Components
- [ ] Uses shared components from `lib/src/shared/presentation/components/`
- [ ] Uses pattern widgets from `lib/src/shared/presentation/patterns/`
- [ ] Empty states use `AppEmptyState` or `AppEmptyStateInline`
- [ ] Loading states use `AppLoadingState` or `AppLoadingInline`
- [ ] Error states use `AppErrorState`
- [ ] Section headers use `AppSectionHeader` or `AppSectionHeaderSimple`

### Tab Root Screens (Extra Scrutiny)
For changes to bottom-nav tab roots (Home, Learning, Community, Tests, Profile):

- [ ] Header style matches other tabs (gradient hero or simple app bar)
- [ ] Stats card overlay (if any) uses consistent positioning
- [ ] Section headers follow the same pattern across all tabs

---

## Automated Guardrails

### Lint Rules (analysis_options.yaml)

Add these custom lint rules to catch common violations:

```yaml
# In analysis_options.yaml
analyzer:
  errors:
    # Treat hardcoded colors as warnings during transition, errors later
    # (Requires custom lint package or manual review)
    
linter:
  rules:
    # Encourage const constructors for widget trees
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    
    # Avoid non-constant identifiers (helps catch magic numbers)
    avoid_field_initializers_in_const_classes: true
```

### Code Review Triggers

When reviewing, pay extra attention if the PR:

1. **Adds a new `.dart` file in `presentation/`** → Check for token compliance AND required imports
2. **Modifies a tab root screen** → Verify header/section/empty state patterns
3. **Adds a new color or gradient** → Must be justified and added to tokens first
4. **Uses `Color(0x...)` or `LinearGradient`** → Should use tokens instead
5. **Uses `AppColors.*`, `AppSpacing.*`, or other tokens** → Verify imports are present (compilation will fail if missing)

---

## Common Violations to Watch For

### ❌ Hardcoded Colors

```dart
// BAD
Container(color: Color(0xFF6366F1))
Text(style: TextStyle(color: Color(0xFF1F2937)))

// GOOD
Container(color: AppColors.primary)
Text(style: TextStyle(color: AppColors.textPrimary))
```

### ❌ Ad-hoc Gradients

```dart
// BAD
LinearGradient(colors: [Color(0xFF4F87FF), Color(0xFF9C4DFF)])

// GOOD
AppGradients.hero
```

### ❌ Magic Number Spacing

```dart
// BAD
Padding(padding: EdgeInsets.all(16))
SizedBox(height: 24)

// GOOD
Padding(padding: EdgeInsets.all(AppSpacing.md))
SizedBox(height: AppSpacing.xl)
```

### ❌ Custom Empty States

```dart
// BAD
Column(
  children: [
    Icon(Icons.inbox, size: 64),
    Text('No items'),
  ],
)

// GOOD
AppEmptyState(
  icon: Icons.inbox,
  title: 'No items',
)
```

### ❌ Inconsistent Headers

```dart
// BAD (different header styles per screen)
// Screen A: AppBar(...)
// Screen B: Container(gradient: ...)
// Screen C: SliverAppBar(...)

// GOOD (consistent pattern)
// All tab roots use the same hero header pattern or simple app bar
```

---

## Exceptions

Sometimes you need to deviate from the system. That's okay, but:

1. **Document the exception** in a code comment explaining why
2. **Get design/lead approval** for significant deviations
3. **Consider if the system needs updating** (maybe the exception is a new pattern)

Example of documented exception:

```dart
// EXCEPTION: Using custom color for third-party integration branding
// Approved in PR #123
Container(color: const Color(0xFF1DA1F2)) // Twitter blue
```

---

## Visual Regression Testing (Optional)

For critical screens, consider adding golden tests:

```dart
// test/golden/home_screen_test.dart
testWidgets('HomeScreen matches golden', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [...mockProviders],
      child: MaterialApp(home: HomeScreenV2()),
    ),
  );
  
  await expectLater(
    find.byType(HomeScreenV2),
    matchesGoldenFile('goldens/home_screen.png'),
  );
});
```

Run with: `flutter test --update-goldens` to generate baselines.

---

## Onboarding New Developers

When a new developer joins:

1. Point them to `docs/design/README.md` as the entry point
2. Have them read `02_foundations_tokens.md` before writing UI code
3. Show them the pattern widgets in `lib/src/shared/presentation/patterns/`
4. Walk through one tab root screen as an example

---

## Quarterly Audits

Every quarter, do a quick visual audit:

1. Take screenshots of all 5 tab roots side-by-side
2. Check for:
   - Consistent header heights and styles
   - Consistent section header patterns
   - Consistent empty/loading/error states
   - Consistent card styling
3. File issues for any drift discovered
4. Update this checklist if new patterns emerge

