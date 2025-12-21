VidyaRas Technical Debt - Issue List
Generated: December 22, 2025
Status: Post-Architecture Fix Cleanup

All critical architecture violations have been resolved. The following issues represent remaining technical debt items to improve code quality, security, and maintainability.

🟠 High Priority Issues
Issue #1: Replace Debug Print Statements with Proper Logging
Priority: High
Type: Code Quality / Performance
Effort: Medium (2-3 hours)

Description: The codebase contains 200+ print() statements in production code. These should be replaced with a proper logging framework that supports:

Log levels (debug, info, warning, error)
Production log filtering
Structured logging
Why This Matters:

Performance impact in production (print is synchronous)
Security risk (may leak sensitive data in logs)
Clutters production logs
No way to disable debug logs in release builds
Affected Files (sample):


courses/4_data/datasources/courses_remote_datasource.dart
 (~10 print statements)

tests/2_application/providers/quiz_providers.dart
 (~30 print statements)

tests/2_application/notifiers/test_notifier.dart
 (~15 print statements)

my_learning/4_data/datasources/my_learning_remote_datasource.dart
 (~20 print statements)
And 150+ more across the codebase
Recommended Solution:

Add logger package to pubspec.yaml
Create shared/utils/app_logger.dart with configured logger
Replace all print() calls with appropriate log levels
Configure to disable debug logs in production builds
Acceptance Criteria:

 Logger package added and configured
 All print statements replaced with logger calls
 Debug logs disabled in production builds
 Documentation added for logging conventions
Issue #2: Audit and Resolve TODO Comments
Priority: High
Type: Technical Debt
Effort: Small-Medium (1-2 hours)

Description: The codebase contains ~20 TODO comments that need to be reviewed and either:

Implemented immediately if critical
Converted to tracked issues
Removed if no longer relevant
Example TODOs Found:

home_repository_impl.dart:61 - "TODO: Fetch from user profile"
Various placeholder screens marked as TODO
Incomplete feature implementations
Recommended Actions:

Grep all TODO comments: grep -r "TODO" lib/src --include="*.dart"
For each TODO:
If critical: Implement immediately
If important: Create GitHub issue and reference in code
If obsolete: Remove
Acceptance Criteria:

 All TODOs reviewed and categorized
 Critical TODOs implemented or tracked as issues
 Obsolete TODOs removed
 Remaining TODOs have issue references
🟡 Medium Priority Issues
Issue #3: Fix .gitignore Security and Organization Issues ✅ RESOLVED
Priority: Medium
Type: Security / Repository Health
Effort: Small (30 minutes)
Status: Completed on December 22, 2025

Resolution:
- Updated .gitignore with patterns for *.jks, *.keystore, *.env, *.sql, firebase-debug.log
- Added exclusion for supabase/migrations/*.sql to preserve migrations
- Removed sensitive files from git tracking using git rm --cached:
  - vidyaras_app/vidyaras-upload-keystore.jks
  - vidyaras_app/supabase_setup.sql
  - vidyaras_app/supabase_chat_migration.sql
  - vidyaras_app/supabase_enable_realtime.sql
  - firebase-debug.log

Note: Store the keystore file securely outside the repository.

Issue #4: Review and Optimize StatefulWidget Usage ✅ RESOLVED
Priority: Medium
Type: Code Quality / Performance
Effort: Medium (2-3 hours)
Status: Completed on December 22, 2025

Resolution:
Reviewed all 7 StatefulWidget instances. No changes needed - all are appropriately using widget-scoped state:
- CourseFiltersBottomSheet - Local filter selections
- PasswordInputField - Visibility toggle state
- MainShell - PageController + tab index
- IntroScreen - PageController + page index
- QuestionNavigator - ScrollController for auto-scrolling
- _SectionCard - Expansion state
- SplashScreen - Simple loading screen

All other widgets using state management already use ConsumerStatefulWidget with Riverpod, which is the correct pattern for app state.
🟢 Low Priority Issues
Issue #5: Consolidate Documentation
Priority: Low
Type: Developer Experience
Effort: Medium (2-3 hours)

Description: The project has 27 markdown files across multiple directories with some redundancy and outdated content.

Current State:

Root level: CLAUDE.md (14.6KB), IMPLEMENTATION_SUMMARY.md (14.7KB)
docs/ folder: 25 markdown files
Some overlap and duplication
Recommended Structure:

docs/
  ├── README.md (main entry point)
  ├── architecture/
  │   ├── clean-architecture.md
  │   └── design-system.md
  ├── features/
  │   ├── enrollment.md
  │   └── quiz-system.md
  ├── guides/
  │   ├── component-usage.md
  │   └── launch-checklist.md
  └── archive/
      └── (outdated docs)
Acceptance Criteria:

 Documentation reorganized into logical structure
 Duplicate content consolidated
 Outdated docs archived or deleted
 Main README.md provides clear navigation
 Root-level docs moved to docs/ folder
Issue #6: Review Generated Code Strategy
Priority: Low
Type: Repository / CI/CD
Effort: Small (1 hour for decision + implementation)

Description: 55 .g.dart files (freezed, riverpod, json_serializable) are currently committed to the repository. Team should decide on strategy.

Options:

Option A: Keep committing (current)

✅ Developers can pull and run immediately
✅ No build step required for code review
❌ Larger repository size
❌ Merge conflicts on generated files
Option B: Add to .gitignore

✅ Smaller repository
✅ No merge conflicts on generated files
❌ Must run build_runner after every pull
❌ Must set up CI to generate files
Recommendation: If you have CI/CD pipeline: Choose Option B Otherwise: Keep Option A (current)

If choosing Option B:

Add *.g.dart to .gitignore
Update CI to run flutter pub run build_runner build
Add to README: "Run flutter pub run build_runner build after pulling"
Acceptance Criteria:

 Team decision made
 If B: .gitignore updated and CI configured
 Documentation updated with developer instructions
Summary
Priority	Issue	Effort	Status
🟠 High	#1 Replace debug prints	Medium	Pending
🟠 High	#2 Resolve TODOs	Small-Medium	Pending
🟡 Medium	#3 Fix .gitignore	Small	✅ Resolved
🟡 Medium	#4 Review StatefulWidgets	Medium	✅ Resolved
🟢 Low	#5 Consolidate docs	Medium	Pending
🟢 Low	#6 Generated code strategy	Small	Pending
Total Remaining Effort: ~6-8 hours of focused work

Recommended Priority Order:

Issue #2 (1-2 hours - code quality)
Issue #1 (2-3 hours - performance/security)
Issue #5 (2-3 hours - when time permits)
Issue #6 (1 hour - when convenient)
Next Steps
This Sprint: Address High priority issues (#1, #2)
Backlog: Low priority issues for future cleanup sprints
All critical architecture issues are resolved - your codebase is production-ready! These items represent continuous improvement opportunities.