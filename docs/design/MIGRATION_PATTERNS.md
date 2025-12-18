# Design System Migration Patterns

This document captures common patterns and fixes discovered during the design system migration to prevent repeating the same mistakes.

## Import Requirements Pattern

### Problem
When migrating code to use design system tokens, it's easy to forget to add the required imports, causing compilation errors.

### Solution
**Always add imports immediately when using tokens:**

```dart
// Step 1: Replace hardcoded value
// Before: color: Color(0xFF6366F1)
// After:  color: AppColors.primary

// Step 2: IMMEDIATELY add the import (don't wait!)
import '../theme/app_colors.dart';
```

### Common Errors and Fixes

#### Error 1: Missing AppColors Import
```
Error: The getter 'AppColors' isn't defined for the type 'MyWidget'.
```

**Fix:**
```dart
// Add this import at the top of the file
import '../theme/app_colors.dart';
```

#### Error 2: Missing AppSpacing Import
```
Error: The getter 'AppSpacing' isn't defined for the type 'MyWidget'.
```

**Fix:**
```dart
// Add this import at the top of the file
import '../theme/app_spacing.dart';
```

#### Error 3: Missing AppGradients Import
```
Error: The getter 'AppGradients' isn't defined for the type 'MyWidget'.
```

**Fix:**
```dart
// Add this import at the top of the file
import '../theme/app_gradients.dart';
```

### Import Path Reference

From different file locations, adjust the relative path:

**From `lib/src/shared/presentation/components/`:**
```dart
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
```

**From `lib/src/shared/presentation/widgets/`:**
```dart
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
```

**From `lib/src/shared/presentation/screens/`:**
```dart
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
```

**From `lib/src/features/*/1_presentation/`:**
```dart
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
```

### Migration Workflow

When migrating a file:

1. **Identify tokens to use** (e.g., `AppColors.primary`, `AppSpacing.md`)
2. **Add imports FIRST** before making changes
3. **Replace hardcoded values** with tokens
4. **Verify compilation** - run `flutter analyze` or build
5. **Test visually** - ensure appearance is unchanged

### Example: Complete Migration

```dart
// BEFORE
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6366F1),
      padding: EdgeInsets.all(16),
    );
  }
}

// AFTER (with imports added)
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';  // ← Added
import '../theme/app_spacing.dart';  // ← Added

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,      // ← Migrated
      padding: EdgeInsets.all(AppSpacing.md),  // ← Migrated
    );
  }
}
```

## Token Mapping Reference

### Colors
- `Color(0xFF6366F1)` → `AppColors.primary`
- `Color(0xFF1F2937)` → `AppColors.textPrimary`
- `Color(0xFF4B5563)` → `AppColors.textSecondary`
- `Color(0xFF10B981)` → `AppColors.categoryWellness` or `AppColors.success`
- `Color(0xFFEF4444)` → `AppColors.error`
- `Color(0xFFFBBF24)` → `AppColors.warning` (for star ratings)

### Spacing
- `EdgeInsets.all(4)` → `EdgeInsets.all(AppSpacing.xxs)`
- `EdgeInsets.all(8)` → `EdgeInsets.all(AppSpacing.xs)`
- `EdgeInsets.all(12)` → `EdgeInsets.all(AppSpacing.sm)`
- `EdgeInsets.all(16)` → `EdgeInsets.all(AppSpacing.md)`
- `EdgeInsets.all(20)` → `AppSpacing.screenAll` (for screen padding)
- `EdgeInsets.all(24)` → `EdgeInsets.all(AppSpacing.xl)`
- `EdgeInsets.all(40)` → `EdgeInsets.all(AppSpacing.xxxl)`

### Error States
- Custom error Column → `AppErrorState(message: ..., onRetry: ...)`
- Custom loading Center → `AppLoadingState()`

## Prevention Checklist

Before submitting a PR with design system changes:

- [ ] All `AppColors.*` usages have `import '../theme/app_colors.dart'`
- [ ] All `AppSpacing.*` usages have `import '../theme/app_spacing.dart'`
- [ ] All `AppGradients.*` usages have `import '../theme/app_gradients.dart'`
- [ ] File compiles without errors (`flutter analyze`)
- [ ] Visual appearance matches original (no regressions)

## Quick Reference Card

Keep this handy when migrating files:

```
Token Usage          →  Required Import
─────────────────────────────────────────
AppColors.*          →  import '../theme/app_colors.dart'
AppSpacing.*         →  import '../theme/app_spacing.dart'
AppRadius.*          →  import '../theme/app_spacing.dart' (same file)
AppGradients.*       →  import '../theme/app_gradients.dart'
AppErrorState        →  import '../patterns/app_loading_state.dart'
AppLoadingState      →  import '../patterns/app_loading_state.dart'
AppEmptyState        →  import '../patterns/app_empty_state.dart'
```


