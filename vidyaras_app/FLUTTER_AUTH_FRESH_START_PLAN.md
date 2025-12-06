# Flutter App Authentication & Authorization Plan (Fresh Start)

## 1. Overview
We are implementing a clean, secure, and unified authentication system for the VidyaRas Flutter application. This plan aligns perfectly with the Admin Dashboard's architecture, ensuring a "Single Source of Truth" for user identity.

**Key Decision:** We are **NOT** migrating legacy phone-auth users. We are starting fresh.

## 2. Architecture

### A. Authentication (Identity)
*   **Method:** **Google Sign-In Only**.
*   **Provider:** Supabase Auth (via Google OAuth).
*   **Why:** Guarantees a valid, secure identity token for every user, enabling Row Level Security (RLS) and simplifying account management.

### B. Authorization (Access Control)
*   **Source of Truth:** `public.profiles` table.
*   **Role:** All app users are `'student'` by default.
*   **Access Gate:** The app checks the profile status before granting access to the Home Screen.

### C. The User Flow

1.  **Login Screen:**
    *   **Action:** User clicks "Continue with Google".
    *   **System:** Supabase creates a session + `auth.users` row.
    *   **Trigger:** Database automatically creates a `public.profiles` row.

2.  **Phone Verification (Mandatory):**
    *   **Check:** App checks if `profile.phone_number` is set.
    *   **Action:** If missing, user *must* verify their phone number via OTP.
    *   **System:** Updates the *existing* profile with the verified number.

3.  **Onboarding (Mandatory):**
    *   **Check:** App checks if `profile.is_onboarded` is true.
    *   **Action:** If false, user completes the onboarding steps (Interests, Goals, etc.).
    *   **System:** Updates `profile.preferences` and sets `is_onboarded = true`.

4.  **Home Screen:**
    *   **Access:** Granted only when Auth + Phone + Onboarding are complete.

## 3. Implementation Steps

### Phase 1: Database Setup (Already Done)
*   ✅ `public.profiles` has `phone_number`, `is_onboarded`, `preferences`.
*   ✅ `handle_new_user` trigger creates profiles for new Google sign-ins.

### Phase 2: Flutter App - UI & Logic

#### Step 1: Login Screen (`LoginScreen`)
*   **UI:** Clean, branded screen.
*   **Element:** Single "Continue with Google" button.
*   **Logic:** Triggers `supabase.auth.signInWithOAuth()`.

#### Step 2: Phone Binding Screen (`PhoneBindingScreen`)
*   **UI:** Phone Input + OTP Input.
*   **Logic:**
    *   Sends OTP to the entered number.
    *   Verifies OTP.
    *   **Update:** Calls `supabase.from('profiles').update({ phone_number: ... })`.

#### Step 3: Onboarding Flow (`OnboardingScreen`)
*   **UI:** Multi-step form (Interests, Goals, etc.).
*   **Logic:** Collects data and updates `profiles` with `preferences` and `is_onboarded: true`.

#### Step 4: Routing Logic (`SplashScreen`)
*   **Logic:**
    ```dart
    if (!session) -> LoginScreen
    else if (!profile.phone_number) -> PhoneBindingScreen
    else if (!profile.is_onboarded) -> OnboardingScreen
    else -> HomeScreen
    ```

## 4. Security & Data Integrity
*   **RLS Policies:** Since users are now authenticated via Supabase, we can enforce strict RLS:
    *   `auth.uid() = id` (Users can only read/update their own profile).
*   **Data Consistency:** No "ghost" users. Every user in the app has a valid Google identity and a verified phone number.

This plan provides a robust, scalable, and secure foundation for the application.
