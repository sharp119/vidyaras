# UI Inconsistency Report

## Executive Summary
- Core UI surfaces rely on per-screen app bars and manual status bar overrides, leaving system styling inconsistent across tabs.
- Typography, spacing, and color usage live in inline styles, so visual hierarchy drifts screen-to-screen and is costly to align.
- Hardcoded copy and pseudo-data block localization and dynamic feeds, and force duplicate logic in presentation code.

## Key Findings

### App Shell, App Bar, and Status Bar
- Screens still declare bespoke `AppBar`s with manual styling (`vidyaras_app/lib/src/shared/presentation/screens/courses_screen.dart:88`, `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:24`, `vidyaras_app/lib/src/features/my_courses/1_presentation/screens/learn_screen.dart:33`, `vidyaras_app/lib/src/shared/presentation/screens/tests_screen.dart:12`), so global tweaks require touching every screen.
- Status bar colors are frozen to a light palette and ignore device theme (`vidyaras_app/lib/main.dart:21`, `vidyaras_app/lib/src/shared/presentation/theme/app_theme.dart:31`), creating clashes when screens use dark imagery.
- The main shell wraps content in its own `SafeArea` (`vidyaras_app/lib/src/shared/presentation/screens/main_shell.dart:63`), while child screens manage safe areas too, leading to double padding and uneven baselines.

### Typography & Copy
- Headings and body copy redefine `TextStyle` inline (`vidyaras_app/lib/src/features/my_courses/1_presentation/screens/course_progress_detail_screen.dart:99`, `vidyaras_app/lib/src/features/home/1_presentation/widgets/home_header.dart:24`, `vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:155`), bypassing `Theme.of(context).textTheme`.
- The curated text scale in `AppTheme` (`vidyaras_app/lib/src/shared/presentation/theme/app_theme.dart:27`) is effectively unused, so typographic rhythm drifts per widget.
- Share and status copy embed raw emoji placeholders (`vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:149`), which renders inconsistently and blocks localization.

### Spacing & Layout Rhythm
- Screens lean on literal spacing constants like `EdgeInsets.all(20)` and `SizedBox(height:20)` (`vidyaras_app/lib/src/shared/presentation/screens/courses_screen.dart:233`, `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:49`, `vidyaras_app/lib/src/features/home/1_presentation/screens/home_screen_v2.dart:114`, `vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:146`), rather than shared spacing tokens.
- Calculated offsets such as `screenHeight * 0.13` (`vidyaras_app/lib/src/features/home/1_presentation/screens/home_screen_v2.dart:49`, `vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:47`) create device-dependent gaps that break the vertical rhythm on short phones.

### Color & Visual Hierarchy
- Widgets embed raw hex colors and vanilla `Colors.*` (`vidyaras_app/lib/src/features/home/1_presentation/screens/home_screen_v2.dart:116`, `vidyaras_app/lib/src/shared/presentation/screens/courses_screen.dart:255`, `vidyaras_app/lib/src/features/my_courses/1_presentation/screens/course_progress_detail_screen.dart:468`, `vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:136`), bypassing the palette in `AppColors`.
- CTAs mix theme colors with hardcoded whites and blacks (`vidyaras_app/lib/src/features/my_courses/1_presentation/screens/course_progress_detail_screen.dart:465`, `vidyaras_app/lib/src/features/home/1_presentation/widgets/home_header.dart:55`, `vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:50`), producing inconsistent contrast and accessibility risk.

### Hardcoded Data & Strings
- Category tabs and filter pills are duplicated as static lists (`vidyaras_app/lib/src/features/home/1_presentation/screens/home_screen_v2.dart:116`, `vidyaras_app/lib/src/shared/presentation/screens/courses_screen.dart:255`), so changes require edits in multiple widgets.
- Stats labels, empty-state copy, and button text live inline (`vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:237`, `vidyaras_app/lib/src/features/home/1_presentation/screens/home_screen_v2.dart:158`, `vidyaras_app/lib/src/shared/presentation/screens/courses_screen.dart:237`), preventing localization or dynamic messaging.
- Progress and sharing copy include business logic in presentation (`vidyaras_app/lib/src/features/my_courses/1_presentation/screens/course_progress_detail_screen.dart:334`, `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:149`), locking presentation to particular data formats.

### Component Behaviour & Reuse Gaps
- `PrimaryButton` inspects its label text to decide whether to show the arrow icon (`vidyaras_app/lib/src/shared/presentation/components/buttons/primary_button.dart:58`), which is brittle and impossible to localize.
- Multiple screens replicate card/list markup (`vidyaras_app/lib/src/features/my_courses/1_presentation/screens/course_progress_detail_screen.dart:188`, `vidyaras_app/lib/src/features/tests/1_presentation/screens/test_series_screen.dart:247`, `vidyaras_app/lib/src/features/home/1_presentation/screens/home_screen_v2.dart:185`), instead of leaning on reusable layout primitives.
- A reusable `AppHeader` exists but is not adopted (`vidyaras_app/lib/src/shared/presentation/components/navigation/app_header.dart:15`), so we instead customise raw `AppBar`s in each screen.

## Additional Observations
- Only a light theme is provided; there is no dark-mode surface mapping or adaptive status bar logic (`vidyaras_app/lib/src/shared/presentation/theme/app_theme.dart:9`).
- Interaction patterns such as pull-to-refresh, filter dialogs, and snackbars instantiate theme colors directly, which will need auditing once the design system is centralised.
