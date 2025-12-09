# VidyaRas Production Readiness Assessment

**Date**: December 9, 2025
**Reviewed By**: Claude Code
**Status**: ⚠️ **NOT READY FOR PRODUCTION** (Critical blockers identified)

---

## 📋 Executive Summary

The VidyaRas application has a solid architectural foundation with proper authentication flow and user-specific data management. However, **critical blockers prevent production deployment**:

1. **Users cannot edit their profile/name** after initial sign-up
2. **No name verification step** during onboarding (users stuck with Google OAuth name)
3. **Profile editing marked as "Coming Soon!"** (incomplete feature)

**Good News**:
- ✅ No hardcoded user IDs in production code
- ✅ All user-specific data flows work correctly
- ✅ Authentication system is properly implemented
- ✅ Database architecture follows best practices

**Recommendation**: **1-2 weeks minimum** to fix critical blockers before production launch.

---

## 🔍 CRITICAL FINDINGS

### 1. **User Name Issue - THE PRIMARY PROBLEM** 🚨

**Problem**: User names are sourced exclusively from Google OAuth metadata via the `handle_new_user()` database trigger. The app has NO mechanism for users to:
- Edit their name after sign-up
- Provide/verify their name during onboarding
- Correct incorrect names from Google profiles

**Why "Aditya Paswan" appears for new users**:
- When testing with your Google account (Aditya Paswan), the trigger extracts YOUR name from OAuth metadata
- Each Google account gets its own profile with its own name from that account's metadata
- However, if users have incorrect/incomplete names in Google, they're stuck with them
- Profile editing shows "Coming Soon!" instead of functioning

**Impact**: **BLOCKER** 🔴
Users cannot control their identity in the app. This is unacceptable for production.

**Affected Files**:
- `vidyaras_app/lib/src/features/auth/3_domain/models/app_user.dart:19` (name field, read-only)
- `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:62` (edit disabled)
- `vidyaras_app/lib/src/features/auth/4_data/datasources/profile_datasource.dart:102-119` (`updateProfile()` exists but unused)

**Evidence**:
```dart
// app_user.dart:18-22
/// Full name from Google OAuth metadata
required String? fullName,

/// Display name (same as fullName)
required String? name,
```

```dart
// profile_screen.dart:62
onEditTap: () => _showComingSoonSnackbar(context, 'Edit Profile'),
```

---

### 2. **Missing Profile Edit Functionality** 🚨

**Current State**: Profile screen shows "Coming Soon!" when users tap edit button.

**Missing Features**:
- ❌ Edit name
- ❌ Edit email
- ❌ Change avatar/profile picture
- ❌ Update phone number
- ❌ Manage preferences
- ❌ Update bio/description

**Impact**: **BLOCKER** 🔴
Users are stuck with whatever data comes from Google OAuth, with no way to fix errors or update information.

**Affected Files**:
- `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:62`

**Note**: The backend `updateProfile()` method already exists at:
- `vidyaras_app/lib/src/features/auth/4_data/datasources/profile_datasource.dart:102-119`

Just needs a UI implementation.

---

### 3. **Incomplete Onboarding Flow** ⚠️

**Current Onboarding Steps** (Google OAuth Flow):
1. ✅ Google OAuth sign-in
2. ✅ Phone binding + OTP verification
3. ✅ Interests selection
4. ✅ Goals selection
5. ✅ Experience level selection
6. ✅ Language preference

**Missing Critical Step**:
- ❌ **Name verification/collection** - Users should see and confirm/edit the name pulled from Google
- ❌ Profile picture upload option
- ❌ Bio/description field

**Impact**: **HIGH** 🟡
Users may proceed with incorrect personal information and discover the issue too late (when profile editing is unavailable).

**Routing Gap**:
```
Current Flow:
/phone-binding → /onboarding/interests → ... → /home

Needed Flow:
/phone-binding → /onboarding/name-verify → /onboarding/interests → ... → /home
```

**Affected Files**:
- `vidyaras_app/lib/src/shared/presentation/routing/app_router.dart:52-105` (onboarding routes)
- `vidyaras_app/lib/src/features/splash/splash_screen.dart:140-145` (GATE 4 logic)

---

### 4. **Authentication Flow Analysis** ✅

**4-Gate Routing System** (Implemented in splash screen):

```
GATE 1: Check Supabase session
  ↳ null → Navigate to /intro
  ↳ exists → Proceed to GATE 2

GATE 2: Fetch profile from profiles table
  ↳ null → Sign out + Navigate to /login (shouldn't happen due to trigger)
  ↳ exists → Proceed to GATE 3

GATE 3: Check phone_number
  ↳ null → Navigate to /phone-binding
  ↳ exists → Proceed to GATE 4

GATE 4: Check is_onboarded
  ↳ false → Navigate to /onboarding/interests
  ↳ true → Navigate to /home
```

**Status**: ✅ **WORKING CORRECTLY**

**Verified**:
- ✅ Session management works properly
- ✅ Profile auto-creation via `handle_new_user()` trigger
- ✅ Phone verification is mandatory
- ✅ Onboarding completion tracking
- ⚠️ **No name verification gate** (should be between GATE 3 and GATE 4)

**Location**: `vidyaras_app/lib/src/features/splash/splash_screen.dart:94-158`

---

### 5. **Data Persistence & User-Specific Flows** ✅

**Comprehensive Review Results**: ✅ **ALL CORRECT**

**Verified Components**:
1. ✅ **My Learning**: Uses `user.id` from auth provider
   - `my_learning_providers.dart:36,54,75,143` - Fetches enrolled courses for authenticated user

2. ✅ **Course Enrollments**: Properly linked to authenticated user ID
   - User-specific course progress tracking works correctly

3. ✅ **Quiz System**: Uses authenticated user ID for attempts
   - `quiz_repository_impl.dart` - All queries filter by current user

4. ✅ **Chat Messages**: References `profiles.id` (migrated from legacy `users` table)
   - Foreign key: `chat_messages.user_id → profiles.id`

5. ✅ **Home Screen Data**: Correctly fetches user profile from auth
   - `home_repository_impl.dart:26-33` - Gets authenticated user via `_authRepository.getCurrentUser()`

**No Hardcoded User IDs Found**: Searched entire codebase - "Aditya Paswan" only appears in:
- Documentation files (contracts, guides)
- Test data log files
- NOT in any production code

**Conclusion**: All user-specific data flows are architecturally sound.

---

### 6. **Mock Data & Incomplete Features** ⚠️

**Home Repository Implementation**:
- Currently returns **hardcoded mock data** for courses
- User stats (enrolled, completed, certificates) are mocked
- TODOs in code indicate pending API integration

**Location**: `vidyaras_app/lib/src/features/home/4_data/repositories/home_repository_impl.dart:44-56`

```dart
// TODO: Fetch actual stats from API
enrolledCount: 2,        // Hardcoded
completedCount: 0,       // Hardcoded
certificatesCount: 1,    // Hardcoded
referralPoints: 150,     // Hardcoded
```

**Impact**: **MEDIUM** 🟡
App will show fake data until real API endpoints are implemented.

**Also Affected**:
- Course listings (lines 60-153)
- Recommended courses
- Free courses

---

### 7. **UI/UX Placeholders** ⚠️

**"Coming Soon!" Features**:
1. Edit Profile (profile_screen.dart:62)
2. View Certificates (profile_screen.dart:81)
3. Various settings options

**Impact**: **MEDIUM** 🟡
Users will encounter non-functional buttons. Either implement these features or hide the buttons before launch.

**Recommendation**: Hide unimplemented features rather than showing disabled placeholders.

---

## 📋 PRODUCTION READINESS CHECKLIST

### ❌ **BLOCKERS** (Must Fix Before Launch)

#### **BLOCKER #1: Implement Profile Editing**
**Priority**: 🔴 **CRITICAL**
**Estimated Effort**: 3-5 days

**Requirements**:
- [ ] Create edit profile screen with form
- [ ] Allow name editing with validation (2-50 chars)
- [ ] Allow avatar upload (optional)
- [ ] Allow bio/description editing (optional, max 500 chars)
- [ ] Implement save functionality
- [ ] Add loading states and error handling
- [ ] Update profile_screen.dart to navigate to edit screen

**Implementation Notes**:
- Backend method already exists: `ProfileDataSource.updateProfile()`
- Need to create UI layer only
- Consider using existing form components from shared widgets

---

#### **BLOCKER #2: Add Name Verification to Onboarding**
**Priority**: 🔴 **CRITICAL**
**Estimated Effort**: 2-3 days

**Requirements**:
- [ ] Create new onboarding step after phone binding
- [ ] Pre-fill name from Google OAuth metadata
- [ ] Allow users to edit/confirm name
- [ ] Add validation (required, 2-50 chars)
- [ ] Save to `profiles.full_name` and `profiles.name`
- [ ] Update routing to include new step
- [ ] Update GATE 4 logic if needed

**User Flow**:
```
/phone-binding
  → OTP verified
  → /onboarding/name-verify (NEW)
  → Name confirmed
  → /onboarding/interests
  → ... rest of onboarding
```

---

#### **BLOCKER #3: Database Trigger Validation**
**Priority**: 🔴 **CRITICAL**
**Estimated Effort**: 1 day

**Requirements**:
- [ ] Verify `handle_new_user()` trigger extracts name correctly from OAuth
- [ ] Add fallback logic if OAuth metadata missing name
- [ ] Set default name as "User" if no name found
- [ ] Add logging for trigger execution (debugging)
- [ ] Test with various Google account configurations

**SQL Location**: Need to check Supabase dashboard for trigger definition.

**Expected Trigger Logic**:
```sql
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, name, avatar_url, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'User'),  -- Fallback
    COALESCE(NEW.raw_user_meta_data->>'name', 'User'),       -- Fallback
    NEW.raw_user_meta_data->>'avatar_url',
    'student'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

---

### ⚠️ **HIGH PRIORITY** (Strongly Recommended Before Launch)

#### **HIGH #1: Profile Picture Upload**
**Priority**: 🟡 **HIGH**
**Estimated Effort**: 2-3 days

**Requirements**:
- [ ] Set up Supabase Storage bucket for avatars
- [ ] Integrate image picker (use `image_picker` package)
- [ ] Implement image compression (use `flutter_image_compress`)
- [ ] Upload to Supabase Storage
- [ ] Update `profiles.avatar_url` with public URL
- [ ] Handle upload errors gracefully
- [ ] Show loading indicator during upload

---

#### **HIGH #2: Real API Integration for Home Data**
**Priority**: 🟡 **HIGH**
**Estimated Effort**: 3-5 days

**Requirements**:
- [ ] Create Supabase tables for courses, enrollments, certificates
- [ ] Implement real API calls in HomeRepositoryImpl
- [ ] Fetch actual enrolled courses count
- [ ] Fetch actual completed courses count
- [ ] Fetch actual certificates count
- [ ] Replace mock course data with real data
- [ ] Add proper error handling
- [ ] Implement caching strategy

---

#### **HIGH #3: Complete User Management Features**
**Priority**: 🟡 **HIGH**
**Estimated Effort**: 2-3 days

**Requirements**:
- [ ] Email change with verification
- [ ] Phone number change with OTP re-verification
- [ ] Delete account functionality (with confirmation)
- [ ] Export user data (GDPR compliance)
- [ ] Privacy settings

---

### 💡 **MEDIUM PRIORITY** (Nice to Have)

#### **MED #1: Enhanced Onboarding**
**Estimated Effort**: 2-3 days

- [ ] Add profile picture upload step
- [ ] Add "About Me" / bio section
- [ ] Show progress indicator during onboarding
- [ ] Allow users to skip optional steps
- [ ] Add "Back" navigation between steps

---

#### **MED #2: Settings Improvements**
**Estimated Effort**: 2-3 days

- [ ] Notification preferences (push, email, SMS)
- [ ] Privacy settings (profile visibility)
- [ ] Language preference toggle (Hindi/English)
- [ ] Theme preference (light/dark mode)
- [ ] Account security settings

---

#### **MED #3: Profile Enhancements**
**Estimated Effort**: 1-2 days

- [ ] Add social media links
- [ ] Add location/city field
- [ ] Add learning streak counter
- [ ] Add badges/achievements display
- [ ] Add "Member since" date

---

### ✅ **LOW PRIORITY** (Post-Launch)

- [ ] Advanced privacy controls
- [ ] Multiple profile themes
- [ ] Profile badges system
- [ ] Achievement milestones
- [ ] Referral tracking dashboard

---

## 🛠️ IMPLEMENTATION PLAN

### **Phase 1: Critical Fixes (Week 1)** - MUST COMPLETE

**Goal**: Fix all blockers to make app production-ready.

#### **Day 1-2: Task 1.1 - Name Verification Step**

**Objective**: Add mandatory name verification/editing step during onboarding.

**Files to Create**:
```
vidyaras_app/lib/src/features/onboarding/
  └── 1_presentation/
      └── screens/
          └── onboarding_name_screen.dart (NEW)
```

**Files to Modify**:
1. `vidyaras_app/lib/src/shared/presentation/routing/app_router.dart`
   - Add new route: `/onboarding/name-verify`
   - Insert between phone-binding and interests

2. `vidyaras_app/lib/src/features/auth/1_presentation/screens/phone_binding_screen.dart`
   - Update navigation after OTP success: `context.go('/onboarding/name-verify')`

3. `vidyaras_app/lib/src/features/onboarding/2_application/notifiers/onboarding_notifier.dart`
   - Add method to save name: `saveName(String name)`

**Implementation Steps**:
```dart
// 1. Create OnboardingNameScreen with:
//    - Text input pre-filled with Google OAuth name
//    - Edit capability with validation
//    - "Continue" button calls onboardingNotifier.saveName()
//    - Uses ProfileDataSource.updateProfile() to save

// 2. Add validation:
//    - Required field
//    - Min 2 characters, max 50 characters
//    - No special characters except spaces, hyphens, apostrophes

// 3. Update routing:
GoRoute(
  path: '/onboarding/name-verify',
  name: 'onboarding-name-verify',
  builder: (context, state) => const OnboardingNameScreen(),
),
```

**Testing**:
- Sign in with Google account that has a name
- Verify name is pre-filled
- Edit name and save
- Check profile shows updated name

---

#### **Day 3-5: Task 1.2 - Profile Edit Screen**

**Objective**: Implement full profile editing functionality.

**Files to Create**:
```
vidyaras_app/lib/src/features/profile/
  ├── 1_presentation/
  │   └── screens/
  │       └── edit_profile_screen.dart (NEW)
  └── 2_application/
      └── notifiers/
          └── profile_edit_notifier.dart (NEW)
```

**Files to Modify**:
1. `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart:62`
   - Replace: `_showComingSoonSnackbar(context, 'Edit Profile')`
   - With: `context.push('/profile/edit')`

2. `vidyaras_app/lib/src/shared/presentation/routing/app_router.dart`
   - Add route: `/profile/edit`

**Implementation Steps**:
```dart
// 1. Create EditProfileScreen with form fields:
//    - Name (required)
//    - Email (read-only for now, or add change email flow)
//    - Bio/About Me (optional, max 500 chars)
//    - Avatar upload button

// 2. Create ProfileEditNotifier:
@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  @override
  ProfileEditState build() {
    return const ProfileEditState.initial();
  }

  Future<void> updateProfile({
    required String name,
    String? bio,
  }) async {
    state = const ProfileEditState.loading();

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.updateProfile({
      'full_name': name,
      'name': name,
      'bio': bio,
    });

    result.fold(
      (failure) => state = ProfileEditState.error(failure.message),
      (_) => state = const ProfileEditState.success(),
    );
  }
}

// 3. Use existing ProfileDataSource.updateProfile() method
```

**UI Components to Use**:
- `TextInputField` for name
- `TextInputField` for bio (multiline)
- `PrimaryButton` for save
- `AppBackButton` for cancel

**Validation**:
- Name: required, 2-50 chars
- Bio: optional, max 500 chars

**Testing**:
- Edit name and save
- Edit bio and save
- Test validation errors
- Verify profile screen shows updated data

---

#### **Day 5: Task 1.3 - Database Trigger Validation**

**Objective**: Ensure `handle_new_user()` trigger has proper fallback logic.

**Steps**:
1. Access Supabase Dashboard → SQL Editor
2. Check current trigger definition
3. Update with fallback logic (see SQL above)
4. Test with new Google sign-ins
5. Add logging for debugging

**Verification**:
```sql
-- Check trigger exists
SELECT * FROM pg_trigger WHERE tgname = 'on_auth_user_created';

-- Check function definition
SELECT prosrc FROM pg_proc WHERE proname = 'handle_new_user';

-- Test with sample data
INSERT INTO auth.users (id, email, raw_user_meta_data)
VALUES (gen_random_uuid(), 'test@example.com', '{}');

-- Verify profile created with fallback name
SELECT * FROM profiles WHERE email = 'test@example.com';
```

---

### **Phase 2: High Priority Features (Week 2)** - RECOMMENDED

#### **Day 6-8: Task 2.1 - Profile Picture Upload**

**Objective**: Allow users to upload and change profile pictures.

**Steps**:
1. Create Supabase Storage bucket: `avatars`
   - Public bucket with read access
   - 5MB file size limit
   - Accept: jpg, jpeg, png, webp

2. Add dependencies to `pubspec.yaml`:
   ```yaml
   dependencies:
     image_picker: ^1.0.7
     flutter_image_compress: ^2.1.0
   ```

3. Create avatar upload widget:
   ```
   vidyaras_app/lib/src/shared/presentation/components/inputs/
     └── avatar_upload_widget.dart (NEW)
   ```

4. Integrate into EditProfileScreen

**Implementation**:
```dart
Future<String?> uploadAvatar(File imageFile) async {
  // 1. Compress image
  final compressed = await FlutterImageCompress.compressWithFile(
    imageFile.path,
    quality: 85,
    minWidth: 512,
    minHeight: 512,
  );

  // 2. Generate unique filename
  final userId = supabase.auth.currentUser!.id;
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final filename = '$userId-$timestamp.jpg';

  // 3. Upload to Supabase Storage
  await supabase.storage.from('avatars').uploadBinary(
    filename,
    compressed,
    fileOptions: const FileOptions(upsert: true),
  );

  // 4. Get public URL
  final publicUrl = supabase.storage.from('avatars').getPublicUrl(filename);

  // 5. Update profile
  await supabase.from('profiles').update({
    'avatar_url': publicUrl,
  }).eq('id', userId);

  return publicUrl;
}
```

---

#### **Day 9-10: Task 2.2 - Real API Integration**

**Objective**: Replace mock data with real Supabase queries.

**Database Schema Needed**:
```sql
-- Assuming these tables exist (check schema first)

-- 1. Get enrolled courses count
SELECT COUNT(*) FROM enrollments WHERE user_id = '...';

-- 2. Get completed courses count
SELECT COUNT(*) FROM enrollments
WHERE user_id = '...' AND completion_status = 'completed';

-- 3. Get certificates count
SELECT COUNT(*) FROM certificates WHERE user_id = '...';

-- 4. Get referral points (if referral system exists)
SELECT referral_points FROM profiles WHERE id = '...';
```

**Files to Modify**:
- `vidyaras_app/lib/src/features/home/4_data/repositories/home_repository_impl.dart:44-56`

**Replace Mock Data With**:
```dart
// Fetch real stats from Supabase
final enrolledCount = await _supabase
  .from('enrollments')
  .select('id', const FetchOptions(count: CountOption.exact))
  .eq('user_id', user.id)
  .count();

final completedCount = await _supabase
  .from('enrollments')
  .select('id', const FetchOptions(count: CountOption.exact))
  .eq('user_id', user.id)
  .eq('completion_status', 'completed')
  .count();

// etc...
```

---

### **Phase 3: Testing & Polish (Week 3)** - QUALITY ASSURANCE

#### **Day 11-13: Comprehensive Testing**

**Test Scenarios**:

1. **New User Flow**:
   - [ ] Sign in with Google (new account)
   - [ ] Verify phone with OTP
   - [ ] See name verification screen with Google name
   - [ ] Edit name and proceed
   - [ ] Complete onboarding
   - [ ] Verify name appears correctly in profile

2. **Existing User Flow**:
   - [ ] Sign in with existing account
   - [ ] Navigate directly to home
   - [ ] Access profile
   - [ ] Edit profile (name, bio)
   - [ ] Upload profile picture
   - [ ] Verify changes persist

3. **Edge Cases**:
   - [ ] Google account with no name (fallback to "User")
   - [ ] Google account with very long name
   - [ ] Google account with special characters in name
   - [ ] Network errors during profile save
   - [ ] Network errors during image upload
   - [ ] Invalid image file formats
   - [ ] Image upload failures (timeout, size limit)

4. **Data Integrity**:
   - [ ] User A cannot edit User B's profile
   - [ ] Enrollment data is user-specific
   - [ ] Quiz attempts are user-specific
   - [ ] Chat messages show correct user names

5. **Performance**:
   - [ ] Profile screen loads quickly
   - [ ] Image upload shows progress
   - [ ] Form validation is instant
   - [ ] No memory leaks in image picker

---

#### **Day 14-15: Bug Fixes & Polish**

- [ ] Fix any bugs discovered during testing
- [ ] Improve error messages (user-friendly)
- [ ] Add loading indicators where missing
- [ ] Optimize images and assets
- [ ] Run performance profiler
- [ ] Check for memory leaks
- [ ] Review console logs (remove debug prints)

---

### **Phase 4: Pre-Launch Checklist (Final 2 Days)**

#### **Security Audit**:
- [ ] Verify RLS policies on profiles table
- [ ] Ensure users can only update their own profiles
- [ ] Check for SQL injection vulnerabilities
- [ ] Validate all user inputs on backend
- [ ] Test with malicious inputs

#### **Privacy & Compliance**:
- [ ] Add privacy policy
- [ ] Add terms of service
- [ ] Implement data export (GDPR)
- [ ] Implement account deletion (GDPR)
- [ ] Add consent checkboxes where needed

#### **Documentation**:
- [ ] Update architecture docs
- [ ] Document new onboarding flow
- [ ] Add API documentation
- [ ] Create user guide
- [ ] Document known issues/limitations

#### **Deployment Preparation**:
- [ ] Set up production Supabase project
- [ ] Configure environment variables
- [ ] Test production build
- [ ] Set up crash reporting (Sentry/Firebase Crashlytics)
- [ ] Set up analytics (Firebase/Mixpanel)
- [ ] Configure app signing keys
- [ ] Prepare Play Store listing
- [ ] Create screenshots and promotional materials

---

## 📊 TIMELINE SUMMARY

| Phase | Duration | Status | Deliverables |
|-------|----------|--------|--------------|
| **Phase 1: Critical Fixes** | 5 days | ⚠️ Required | Name verification, Profile editing, Trigger validation |
| **Phase 2: High Priority** | 5 days | 🟡 Recommended | Avatar upload, Real API integration |
| **Phase 3: Testing** | 5 days | ✅ Essential | QA testing, Bug fixes |
| **Phase 4: Pre-Launch** | 2 days | ✅ Essential | Security audit, Documentation |
| **TOTAL** | **~3 weeks** | | **Production Ready** |

**Minimum Viable Launch**: Phase 1 only (1 week)
**Recommended Launch**: Phase 1 + Phase 2 (2 weeks)
**Professional Launch**: All phases (3 weeks)

---

## 🎯 SUCCESS CRITERIA

Before declaring production-ready, verify:

- [ ] ✅ Users can edit their name after sign-up
- [ ] ✅ Users verify/edit name during onboarding
- [ ] ✅ Profile editing works without errors
- [ ] ✅ All user data is properly isolated (no data leakage)
- [ ] ✅ No "Coming Soon" placeholders for core features
- [ ] ✅ Real API data replaces mock data
- [ ] ✅ Tested with 5+ real Google accounts
- [ ] ✅ No critical bugs in core flows
- [ ] ✅ Security audit passed
- [ ] ✅ Privacy policy implemented

---

## 📞 NEXT STEPS

**Immediate Actions**:
1. Review this assessment with the team
2. Prioritize which phase to target
3. Assign tasks to developers
4. Set up testing environment with multiple Google accounts
5. Begin Phase 1 implementation

**Questions to Resolve**:
1. Do we have access to production Supabase instance?
2. Is the `handle_new_user()` trigger already deployed?
3. What's the target launch date?
4. Are there existing API endpoints for course data?
5. Do we need approval for Supabase Storage setup?

---

## 🔗 RELATED DOCUMENTS

- Architecture: `docs/architecture.md`
- Coding Rules: `docs/rules.md`
- Component Guide: `docs/component_usage_guide.md`
- Migration Plan: `vidyaras_app/GOOGLE_OAUTH_MIGRATION_MASTER_PLAN.md`

---

**Assessment Date**: December 9, 2025
**Next Review Date**: After Phase 1 completion
**Contact**: Development Team

---

## Appendix A: File References

### Critical Files for Phase 1 Implementation

**Authentication & Profile**:
- `vidyaras_app/lib/src/features/auth/3_domain/models/app_user.dart`
- `vidyaras_app/lib/src/features/auth/4_data/datasources/profile_datasource.dart`
- `vidyaras_app/lib/src/features/auth/2_application/providers/auth_providers.dart`

**Onboarding**:
- `vidyaras_app/lib/src/features/onboarding/1_presentation/screens/` (all screens)
- `vidyaras_app/lib/src/features/onboarding/2_application/notifiers/onboarding_notifier.dart`

**Profile Screen**:
- `vidyaras_app/lib/src/shared/presentation/screens/profile_screen.dart`
- `vidyaras_app/lib/src/shared/presentation/widgets/profile/` (all profile widgets)

**Routing**:
- `vidyaras_app/lib/src/shared/presentation/routing/app_router.dart`
- `vidyaras_app/lib/src/features/splash/splash_screen.dart`

**Home Repository** (for Phase 2):
- `vidyaras_app/lib/src/features/home/4_data/repositories/home_repository_impl.dart`

---

## Appendix B: Database Schema Reference

### Profiles Table (Current Schema)
```sql
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT,
  full_name TEXT,
  name TEXT,
  avatar_url TEXT,
  phone_number TEXT UNIQUE,
  is_onboarded BOOLEAN DEFAULT FALSE,
  preferences JSONB DEFAULT '{}'::jsonb,
  role TEXT DEFAULT 'student',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### Needed for Phase 2 (verify existence):
- `enrollments` table
- `certificates` table
- `quiz_attempts` table
- `lecture_completions` table

---

**END OF ASSESSMENT**
