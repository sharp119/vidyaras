# Phase 2: Flutter App Refactoring - Progress Report

**Date:** December 6, 2025
**Status:** 65% Complete

---

## ✅ Completed Tasks

### 1. Legacy Auth Feature Archived
- **Location:** `/lib/src/features/auth_legacy_backup/`
- **Status:** ✅ Backed up successfully
- **MSG91 Service:** ✅ Preserved and copied to new feature

### 2. New Auth Feature Structure Created
- **Location:** `/lib/src/features/auth/`
- **Architecture:** ✅ Feature-First Layered (4 layers)
- **Structure:**
  ```
  auth/
  ├── 1_presentation/
  │   └── screens/
  │       ├── google_login_screen.dart ✅
  │       └── phone_binding_screen.dart ✅
  ├── 2_application/
  │   └── providers/
  │       └── auth_providers.dart ✅
  ├── 3_domain/
  │   ├── models/
  │   │   └── app_user.dart ✅
  │   └── repositories/
  │       └── auth_repository.dart ✅
  └── 4_data/
      ├── datasources/
      │   └── profile_datasource.dart ✅
      ├── repositories/
      │   └── auth_repository_impl.dart ✅
      └── services/
          └── msg91_service.dart ✅ (copied from legacy)
  ```

### 3. Domain Layer ✅
- **AppUser Model:** Maps to profiles table
  - Uses Freezed for immutability
  - Includes all profile fields (phone, onboarding status, preferences)
  - JSON serialization ready

- **AuthRepository Interface:** Defines contracts
  - `signInWithGoogle()` - Google OAuth
  - `getCurrentUser()` - Fetch profile
  - `updatePhoneNumber()` - Update phone after OTP
  - `completeOnboarding()` - Save preferences
  - `signOut()` - Sign out
  - `phoneExists()` - Check duplicate

### 4. Data Layer ✅
- **ProfileDataSource:** CRUD operations on profiles table
  - `getCurrentProfile()` - Get current user's profile
  - `updatePhoneNumber()` - Update phone (handles unique constraint error)
  - `completeOnboarding()` - Save onboarding data
  - `phoneExists()` - Check phone existence
  - `updateProfile()` - Generic update

- **AuthRepositoryImpl:** Implements repository interface
  - Google OAuth via Supabase
  - Profile operations via ProfileDataSource
  - Error handling with Either<String, T>
  - Unique constraint violation detection (code 23505)

### 5. Application Layer ✅
- **Providers (Riverpod):**
  - `supabaseClientProvider` - Supabase client instance
  - `profileDataSourceProvider` - ProfileDataSource instance
  - `authRepositoryProvider` - AuthRepository instance
  - `msg91ServiceProvider` - MSG91 service instance
  - `authStateChangesProvider` - Auth state stream
  - `currentProfileProvider` - Current profile async provider

### 6. Presentation Layer ✅
- **GoogleLoginScreen:**
  - Uses `SocialLoginButton` component
  - Uses `BilingualText` component (Hindi + English)
  - Google OAuth sign-in flow
  - Loading states
  - Error handling

- **PhoneBindingScreen:**
  - Two-step flow: Send OTP → Verify OTP
  - Uses `TextInputField` component
  - Uses `PrimaryButton` component
  - MSG91 OTP verification
  - Duplicate phone error handling
  - Navigation to onboarding on success

---

## 🚧 Remaining Tasks

### 7. Update Splash Screen Routing ⏳ CRITICAL
**Location:** `/lib/src/features/splash/splash_screen.dart` (or check if it's in auth_legacy_backup)

**Requirements:**
```dart
// Implement 4-gate flow:
// GATE 1: Check Supabase session → If null, go to /login
// GATE 2: Fetch profile → If null, sign out + retry
// GATE 3: Check phone_number → If null, go to /phone-binding
// GATE 4: Check is_onboarded → If false, go to /onboarding/interests
// All gates passed → Go to /home
```

**Implementation File:** Create `/lib/src/features/splash/splash_screen.dart`

---

### 8. Update Onboarding Datasource ⏳ CRITICAL
**Location:** `/lib/src/features/onboarding/4_data/datasources/onboarding_datasource.dart`

**Changes Required:**
- Replace Hive storage with Supabase profiles table
- Update `saveOnboardingData()` to use profiles.preferences JSONB column
- Update `isOnboarded()` to check profiles.is_onboarded
- Update `getOnboardingData()` to read from profiles.preferences

**Affected Files:**
- `/lib/src/features/onboarding/2_application/notifiers/onboarding_notifier.dart`
  - Update to call new datasource methods
  - Remove Hive dependencies

---

### 9. Update App Router ⏳ CRITICAL
**Location:** `/lib/src/shared/presentation/routing/app_router.dart` (or similar)

**Routes to Add:**
```dart
GoRoute(path: '/login', builder: (context, state) => const GoogleLoginScreen()),
GoRoute(path: '/phone-binding', builder: (context, state) => const PhoneBindingScreen()),
// Keep existing onboarding routes
// Keep existing home route
```

---

### 10. Configure Deep Linking ⏳ REQUIRED
**File:** `/android/app/src/main/AndroidManifest.xml`

**Add This:**
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="io.supabase.vidyaras"
        android:host="login-callback" />
</intent-filter>
```

---

### 11. Update main.dart ⏳ REQUIRED
**File:** `/lib/main.dart`

**Changes:**
```dart
await Supabase.initialize(
  url: 'https://cyenulvcedlzccorgkkx.supabase.co',
  anonKey: 'YOUR_ANON_KEY_HERE', // Get from Supabase dashboard
  authOptions: const FlutterAuthClientOptions(
    authFlowType: AuthFlowType.pkce, // CRITICAL for mobile OAuth
  ),
);

// Optional: Add auth state listener for debugging
Supabase.instance.client.auth.onAuthStateChange.listen((data) {
  print('🔐 Auth Event: ${data.event}');
});
```

---

### 12. Code Generation ⏳ REQUIRED
**Commands to Run:**
```bash
cd vidyaras_application/vidyaras_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**This will generate:**
- `app_user.freezed.dart`
- `app_user.g.dart`
- `auth_providers.g.dart`

---

### 13. Fix Import Errors ⏳
After code generation, check for:
- Missing `@JsonKey` annotations if field names don't match JSON keys
- Import statements for all components
- Route names in GoRouter configuration

---

## 📋 Testing Checklist (After Implementation)

### Pre-Deployment:
- [ ] Run `flutter analyze` (no errors)
- [ ] Run code generation
- [ ] App compiles successfully
- [ ] No runtime errors on launch

### Post-Deployment:
- [ ] Google sign-in works
- [ ] Profile auto-created after Google sign-in
- [ ] Phone binding required after Google sign-in
- [ ] OTP sent via MSG91
- [ ] OTP verification works
- [ ] Duplicate phone shows error message
- [ ] Onboarding flow works
- [ ] Session persists across restarts
- [ ] Routing gates work correctly

---

## 🔥 Critical Issues to Address

### Issue 1: Supabase Anon Key
**Where:** `main.dart`
**Action:** Get the publishable anon key from Supabase dashboard
**Path:** Project Settings → API → Project API keys → anon/public key

### Issue 2: Google OAuth Credentials
**Where:** Supabase Dashboard
**Action:** Verify Google OAuth is configured
**Path:** Authentication → Providers → Google

### Issue 3: Missing Assets
**Where:** `google_login_screen.dart` line 85
**Issue:** `assets/svgs/google_logo.svg` may not exist
**Fix:** Either add the SVG asset or replace with Icon widget temporarily

---

## 📁 Files Created in This Phase

1. `/lib/src/features/auth/3_domain/models/app_user.dart`
2. `/lib/src/features/auth/3_domain/repositories/auth_repository.dart`
3. `/lib/src/features/auth/4_data/datasources/profile_datasource.dart`
4. `/lib/src/features/auth/4_data/repositories/auth_repository_impl.dart`
5. `/lib/src/features/auth/4_data/services/msg91_service.dart` (copied)
6. `/lib/src/features/auth/2_application/providers/auth_providers.dart`
7. `/lib/src/features/auth/1_presentation/screens/google_login_screen.dart`
8. `/lib/src/features/auth/1_presentation/screens/phone_binding_screen.dart`

---

## 🚀 Next Steps

**To complete Phase 2, you need to:**

1. **Update Splash Screen** with 4-gate routing logic
2. **Update Onboarding Datasource** to use profiles table
3. **Update App Router** with new auth routes
4. **Configure Deep Linking** in AndroidManifest.xml
5. **Update main.dart** with Supabase initialization
6. **Run Code Generation** (`build_runner`)
7. **Test the Complete Flow** end-to-end

**Estimated Time Remaining:** 2-3 hours

**Would you like me to continue with the remaining tasks?**
