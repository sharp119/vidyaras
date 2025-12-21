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
Issue #3: Fix .gitignore Security and Organization Issues
Priority: Medium
Type: Security / Repository Health
Effort: Small (30 minutes)

Description: The 

.gitignore
 file has gaps that allow sensitive files to be tracked in version control.

Currently Tracked Files That Shouldn't Be:


vidyaras-upload-keystore.jks
 ⚠️ SECURITY RISK

supabase_setup.sql

supabase_chat_migration.sql

supabase_enable_realtime.sql

firebase-debug.log
Required .gitignore Additions:

# Secrets & Keys
*.jks
*.keystore
*.env
*.env.*
!*.env.example
# SQL migrations (should be in supabase/migrations/)
*.sql
# Firebase
firebase-debug.log
.firebase/
Migration Steps:

Add entries to 

.gitignore
Move SQL files to proper location: supabase/migrations/
Remove tracked sensitive files from git history:
git rm --cached vidyaras-upload-keystore.jks
git rm --cached *.sql
git rm --cached firebase-debug.log
Store keystore securely (not in repository)
Acceptance Criteria:

 Updated .gitignore committed
 Sensitive files removed from git history
 SQL migrations moved to proper directory
 Keystore stored securely outside repository
 Documentation updated with keystore setup instructions
Issue #4: Review and Optimize StatefulWidget Usage
Priority: Medium
Type: Code Quality / Performance
Effort: Medium (2-3 hours)

Description: The codebase has 10 StatefulWidget instances. Some may be using widget state for data that should be managed by Riverpod, leading to unnecessary rebuilds and complexity.

Found StatefulWidgets:

CourseFiltersBottomSheet
PasswordInputField
MainShell
_SectionCard (in lessons tab)
IntroScreen
QuestionNavigator
SplashScreen
Review Criteria: For each StatefulWidget, determine if state is:

✅ Widget-scoped (TextEditingController, AnimationController) - Keep as StatefulWidget
❌ App/Feature state - Convert to ConsumerWidget with Riverpod
Acceptance Criteria:

 All StatefulWidgets reviewed
 App state moved to Riverpod where appropriate
 Only truly widget-scoped state uses StatefulWidget
 Documentation added explaining widget state conventions
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
Priority	Issue	Effort	Impact
🟠 High	#1 Replace debug prints	Medium	Performance & Security
🟠 High	#2 Resolve TODOs	Small-Medium	Code Quality
🟡 Medium	#3 Fix .gitignore	Small	Security
🟡 Medium	#4 Review StatefulWidgets	Medium	Performance
🟢 Low	#5 Consolidate docs	Medium	Developer Experience
🟢 Low	#6 Generated code strategy	Small	Repository Health
Total Estimated Effort: 1-2 days of focused work

Recommended Priority Order:

Issue #3 (30 min - security fix)
Issue #2 (1-2 hours - code quality)
Issue #1 (2-3 hours - performance/security)
Issue #4 (2-3 hours - optimization)
Issue #5 (2-3 hours - when time permits)
Issue #6 (1 hour - when convenient)
Next Steps
Immediate: Create GitHub issues from this list
This Sprint: Address High priority issues (#1, #2)
Next Sprint: Address Medium priority issues (#3, #4)
Backlog: Low priority issues for future cleanup sprints
All critical architecture issues are resolved - your codebase is production-ready! These items represent continuous improvement opportunities.