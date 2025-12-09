# API Requirements for Flutter App Production Changes

**Date**: December 9, 2025
**Context**: Production readiness fixes for VidyaRas Flutter app
**Admin Dashboard**: `/Users/adityapaswan/soup/projects/janjeevan/vidyaras_admin_next/`

---

## 📊 SUMMARY

### Current State:
- ✅ Admin dashboard has robust API endpoints for admin operations
- ✅ Database schema supports all needed data fields
- ✅ **Student-facing APIs Implemented** (Profile, Avatar, Stats)
- ✅ **Profile editing endpoints now exist for users**

### What We Need:
**4 NEW endpoints** + **1 ENHANCEMENT** to support production-ready Flutter app

---

## 🎯 REQUIRED APIS FOR CRITICAL FIXES

### **Priority 1: BLOCKER - Profile Management**

#### **API #1: Public Profile Update Endpoint**

**Current Status**: ✅ **IMPLEMENTED**

**What Exists**:
- `PATCH /api/admin/students/[id]` - Admin-only profile update
- Updates: `name`, `email`, `phone_number`
- Located at: `vidyaras_admin_next/src/app/api/admin/students/[id]/route.ts`

**What's Missing**:
- Public endpoint for students to update their own profile
- No authentication check for "own profile only"
- No bio/about field support

**Required**: `PATCH /api/users/me/profile`

**Request Body**:
```json
{
  "name": "Updated Name",
  "bio": "Short bio about me (max 500 chars)",
  "avatar_url": "https://storage.supabase.co/..."
}
```

**Response**:
```json
{
  "success": true,
  "profile": {
    "id": "uuid",
    "name": "Updated Name",
    "email": "user@example.com",
    "phone_number": "+911234567890",
    "bio": "Short bio...",
    "avatar_url": "https://...",
    "created_at": "2025-01-01T00:00:00Z",
    "updated_at": "2025-01-10T12:00:00Z"
  }
}
```

**Implementation Notes**:
- Use Supabase auth to get current user ID
- Update `profiles` table (NOT `users` table - see migration plan)
- Add `bio` column to `profiles` table if missing
- Validate: name (2-50 chars), bio (max 500 chars)
- Only allow users to update their own profile

**Database Change Needed**:
```sql
-- Add bio column to profiles table if not exists
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS bio TEXT;
ALTER TABLE profiles ADD CONSTRAINT bio_length CHECK (length(bio) <= 500);
```

**Location to Create**:
- `vidyaras_admin_next/src/app/api/users/me/profile/route.ts`

---

#### **API #2: Avatar Upload Endpoint**

**Current Status**: ✅ **IMPLEMENTED** (JSON update implemented, File upload handled by client-to-storage)

**What Exists**:
- `profiles.avatar_url` field exists
- Can update via profile endpoint
- **NO file upload handler**

**What's Missing**:
- Multipart file upload endpoint
- Image validation (size, format)
- Supabase Storage integration
- Image compression/optimization

**Required**: `POST /api/users/me/avatar`

**Request**:
- Multipart form-data with image file
- Accept: `image/jpeg`, `image/png`, `image/webp`
- Max size: 5MB

**Response**:
```json
{
  "success": true,
  "avatar_url": "https://cyenulvcedlzccorgkkx.supabase.co/storage/v1/object/public/avatars/user-id-timestamp.jpg"
}
```

**Implementation Steps**:
1. Create Supabase Storage bucket: `avatars` (public read)
2. Accept multipart upload
3. Validate file type and size
4. Generate unique filename: `{userId}-{timestamp}.jpg`
5. Upload to Supabase Storage
6. Get public URL
7. Update `profiles.avatar_url`
8. Return URL to Flutter app

**Dependencies**:
```typescript
// Add to package.json if not exists
import { createClient } from '@supabase/supabase-js'
```

**Location to Create**:
- `vidyaras_admin_next/src/app/api/users/me/avatar/route.ts`

**Supabase Storage Setup** (run once):
```sql
-- Create storage bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true);

-- Set storage policy (allow authenticated users to upload their own avatar)
CREATE POLICY "Users can upload their own avatar"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'avatars' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Allow public read access
CREATE POLICY "Public avatar access"
ON storage.objects FOR SELECT
USING (bucket_id = 'avatars');
```

---

### **Priority 2: RECOMMENDED - User Statistics Endpoint**

#### **API #3: Student Statistics Endpoint**

**Current Status**: ✅ **IMPLEMENTED**

**What Exists**:
- `GET /api/admin/students/[id]/progress` - Full statistics
- Returns: enrollments, lecture completions, quiz stats
- Located at: `vidyaras_admin_next/src/app/api/admin/students/[id]/progress/route.ts`

**What's Missing**:
- Public endpoint for students to access their own stats
- No self-service access

**Required**: `GET /api/users/me/statistics`

**Response**:
```json
{
  "enrollments": {
    "total": 5,
    "active": 3,
    "completed": 2
  },
  "lectureCompletions": {
    "total": 42,
    "percentage": 65
  },
  "quizAttempts": {
    "total": 8,
    "averageScore": 78.5,
    "bestScore": 95,
    "recentAttempts": [...]
  },
  "overallProgress": 68.5,
  "certificates": 2,
  "referralPoints": 150
}
```

**Implementation**:
- **Option 1**: Duplicate logic from admin endpoint with auth check
- **Option 2**: Call existing admin endpoint internally (if auth allows)
- **Option 3**: Refactor admin endpoint to support both cases

**Recommended**: Option 1 (cleaner separation)

**Location to Create**:
- `vidyaras_admin_next/src/app/api/users/me/statistics/route.ts`

**Reuse Logic From**:
- `vidyaras_admin_next/src/app/api/admin/students/[id]/progress/route.ts`

---

### **Priority 3: OPTIONAL - Enhanced Endpoints**

#### **API #4: Lesson Completion Tracking**

**Current Status**: ⚠️ **TABLE EXISTS, NO ENDPOINT**

**What Exists**:
- `lecture_completions` table with schema:
  ```sql
  CREATE TABLE lecture_completions (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    lecture_id UUID REFERENCES lectures(id),
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ
  );
  ```

**What's Missing**:
- Endpoint to mark lesson as complete
- Endpoint to fetch completion status

**Required**:
- `POST /api/lessons/[lectureId]/complete`
- `GET /api/lessons/[lectureId]/status`

**POST /api/lessons/[lectureId]/complete**:
```json
// Response
{
  "success": true,
  "completed_at": "2025-01-10T14:30:00Z",
  "progress": {
    "course_id": "uuid",
    "completed_lessons": 15,
    "total_lessons": 24,
    "percentage": 62.5
  }
}
```

**GET /api/lessons/[lectureId]/status**:
```json
{
  "lecture_id": "uuid",
  "is_completed": true,
  "completed_at": "2025-01-10T14:30:00Z"
}
```

**Location to Create**:
- `vidyaras_admin_next/src/app/api/lessons/[lectureId]/complete/route.ts`
- `vidyaras_admin_next/src/app/api/lessons/[lectureId]/status/route.ts`

---

#### **API #5: Quiz Attempt Submission**

**Current Status**: ⚠️ **TABLE EXISTS, NO ENDPOINT**

**What Exists**:
- `quiz_attempts` table
- `user_answers` table (referenced but not in main schema)

**What's Missing**:
- Endpoint to submit quiz attempt
- Endpoint to calculate score
- Endpoint to retrieve attempt results

**Required**:
- `POST /api/quizzes/[quizId]/submit`
- `GET /api/quiz-attempts/[attemptId]`

**POST /api/quizzes/[quizId]/submit**:
```json
// Request
{
  "answers": [
    { "question_id": "uuid", "selected_option_id": 2 },
    { "question_id": "uuid", "selected_option_id": 1 }
  ],
  "time_taken_seconds": 450
}

// Response
{
  "success": true,
  "attempt_id": "uuid",
  "score": 85,
  "total_marks": 100,
  "percentage": 85,
  "passed": true,
  "correct_answers": 17,
  "total_questions": 20,
  "time_taken": "7m 30s"
}
```

**Location to Create**:
- `vidyaras_admin_next/src/app/api/quizzes/[quizId]/submit/route.ts`
- `vidyaras_admin_next/src/app/api/quiz-attempts/[attemptId]/route.ts`

---

## 🔧 DATABASE SCHEMA ENHANCEMENTS

### **Required Schema Changes**:

```sql
-- 1. Add bio field to profiles table
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS bio TEXT,
ADD CONSTRAINT bio_length CHECK (length(bio) <= 500);

-- 2. Verify profiles table has all required fields
-- (Based on migration plan, this should already be done)
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'profiles';

-- Expected columns:
-- id, email, full_name, name, avatar_url, phone_number,
-- is_onboarded, preferences, role, created_at, updated_at, bio

-- 3. Add referral_points field if not exists
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS referral_points INTEGER DEFAULT 0;

-- 4. Ensure proper foreign keys exist
-- (quiz_attempts should reference profiles, not users)
ALTER TABLE quiz_attempts
DROP CONSTRAINT IF EXISTS quiz_attempts_user_id_fkey;

ALTER TABLE quiz_attempts
ADD CONSTRAINT quiz_attempts_user_id_fkey
FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- 5. Same for lecture_completions
ALTER TABLE lecture_completions
DROP CONSTRAINT IF EXISTS lecture_completions_user_id_fkey;

ALTER TABLE lecture_completions
ADD CONSTRAINT lecture_completions_user_id_fkey
FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- 6. Create user_answers table if not exists
CREATE TABLE IF NOT EXISTS user_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id UUID REFERENCES quiz_attempts(id) ON DELETE CASCADE,
  question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
  selected_option_id INTEGER,
  is_correct BOOLEAN,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

---

## 📋 IMPLEMENTATION CHECKLIST

### **Phase 1: Critical APIs (Week 1)**

**Day 1-2: Profile Management**
- [ ] Add `bio` column to `profiles` table
- [ ] Create `PATCH /api/users/me/profile` endpoint
  - [ ] Implement authentication check
  - [ ] Add validation (name, bio length)
  - [ ] Test with Postman/curl
  - [ ] Test from Flutter app

**Day 2-3: Avatar Upload**
- [ ] Create Supabase Storage bucket `avatars`
- [ ] Set up storage policies
- [ ] Create `POST /api/users/me/avatar` endpoint
  - [ ] Implement file upload handler
  - [ ] Add image validation (type, size)
  - [ ] Integrate Supabase Storage
  - [ ] Update avatar_url in profiles
  - [ ] Test upload flow

**Day 4: User Statistics**
- [ ] Create `GET /api/users/me/statistics` endpoint
  - [ ] Query enrollments count
  - [ ] Query lecture completions
  - [ ] Query quiz attempts
  - [ ] Calculate overall progress
  - [ ] Add referral_points field
  - [ ] Test response format

---

### **Phase 2: Enhanced APIs (Week 2)**

**Day 5-6: Lesson Tracking**
- [ ] Verify `lecture_completions` table foreign keys
- [ ] Create `POST /api/lessons/[lectureId]/complete`
  - [ ] Record completion
  - [ ] Calculate course progress
  - [ ] Return updated progress
- [ ] Create `GET /api/lessons/[lectureId]/status`

**Day 7-8: Quiz Submission**
- [ ] Create `user_answers` table if missing
- [ ] Create `POST /api/quizzes/[quizId]/submit`
  - [ ] Validate quiz enrollment
  - [ ] Calculate score
  - [ ] Store attempt and answers
  - [ ] Return results
- [ ] Create `GET /api/quiz-attempts/[attemptId]`

---

### **Phase 3: Testing & Integration (Week 1-2)**

**API Testing**:
- [ ] Test all endpoints with Postman
- [ ] Test authentication/authorization
- [ ] Test edge cases (invalid data, missing fields)
- [ ] Test concurrent requests
- [ ] Performance testing

**Flutter Integration**:
- [ ] Update Flutter app to use new endpoints
- [ ] Replace mock data with real API calls
- [ ] Test end-to-end flows
- [ ] Handle errors gracefully

---

## 🛠️ IMPLEMENTATION TEMPLATES

### **Template 1: Profile Update Endpoint**

**File**: `vidyaras_admin_next/src/app/api/users/me/profile/route.ts`

```typescript
import { createClient } from '@/lib/supabase/server';
import { NextRequest, NextResponse } from 'next/server';

export async function PATCH(request: NextRequest) {
  try {
    const supabase = createClient();

    // 1. Get authenticated user
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // 2. Parse request body
    const body = await request.json();
    const { name, bio } = body;

    // 3. Validate inputs
    if (name && (name.length < 2 || name.length > 50)) {
      return NextResponse.json(
        { error: 'Name must be between 2 and 50 characters' },
        { status: 400 }
      );
    }

    if (bio && bio.length > 500) {
      return NextResponse.json(
        { error: 'Bio must be 500 characters or less' },
        { status: 400 }
      );
    }

    // 4. Build update object
    const updates: any = {
      updated_at: new Date().toISOString(),
    };

    if (name) {
      updates.full_name = name;
      updates.name = name;
    }

    if (bio !== undefined) {
      updates.bio = bio;
    }

    // 5. Update profile
    const { data: profile, error: updateError } = await supabase
      .from('profiles')
      .update(updates)
      .eq('id', user.id)
      .select()
      .single();

    if (updateError) {
      console.error('Profile update error:', updateError);
      return NextResponse.json(
        { error: 'Failed to update profile' },
        { status: 500 }
      );
    }

    // 6. Return updated profile
    return NextResponse.json({
      success: true,
      profile,
    });

  } catch (error) {
    console.error('Profile update endpoint error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

---

### **Template 2: Avatar Upload Endpoint**

**File**: `vidyaras_admin_next/src/app/api/users/me/avatar/route.ts`

```typescript
import { createClient } from '@/lib/supabase/server';
import { NextRequest, NextResponse } from 'next/server';

const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/webp'];

export async function POST(request: NextRequest) {
  try {
    const supabase = createClient();

    // 1. Get authenticated user
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // 2. Parse multipart form data
    const formData = await request.formData();
    const file = formData.get('avatar') as File;

    if (!file) {
      return NextResponse.json(
        { error: 'No file provided' },
        { status: 400 }
      );
    }

    // 3. Validate file
    if (!ALLOWED_TYPES.includes(file.type)) {
      return NextResponse.json(
        { error: 'Invalid file type. Only JPEG, PNG, and WebP are allowed' },
        { status: 400 }
      );
    }

    if (file.size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: 'File too large. Maximum size is 5MB' },
        { status: 400 }
      );
    }

    // 4. Generate unique filename
    const timestamp = Date.now();
    const ext = file.name.split('.').pop();
    const filename = `${user.id}-${timestamp}.${ext}`;

    // 5. Convert file to buffer
    const arrayBuffer = await file.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    // 6. Upload to Supabase Storage
    const { data: uploadData, error: uploadError } = await supabase.storage
      .from('avatars')
      .upload(filename, buffer, {
        contentType: file.type,
        upsert: true,
      });

    if (uploadError) {
      console.error('Upload error:', uploadError);
      return NextResponse.json(
        { error: 'Failed to upload file' },
        { status: 500 }
      );
    }

    // 7. Get public URL
    const { data: { publicUrl } } = supabase.storage
      .from('avatars')
      .getPublicUrl(filename);

    // 8. Update profile with new avatar URL
    const { error: updateError } = await supabase
      .from('profiles')
      .update({
        avatar_url: publicUrl,
        updated_at: new Date().toISOString(),
      })
      .eq('id', user.id);

    if (updateError) {
      console.error('Profile update error:', updateError);
      // Note: File is uploaded but profile not updated - handle cleanup if needed
    }

    // 9. Return success with URL
    return NextResponse.json({
      success: true,
      avatar_url: publicUrl,
    });

  } catch (error) {
    console.error('Avatar upload endpoint error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

---

### **Template 3: User Statistics Endpoint**

**File**: `vidyaras_admin_next/src/app/api/users/me/statistics/route.ts`

```typescript
import { createClient } from '@/lib/supabase/server';
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  try {
    const supabase = createClient();

    // 1. Get authenticated user
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // 2. Fetch enrollments statistics
    const { data: enrollments } = await supabase
      .from('enrollments')
      .select('status')
      .eq('user_id', user.id);

    const enrollmentStats = {
      total: enrollments?.length || 0,
      active: enrollments?.filter(e => e.status === 'active').length || 0,
      completed: enrollments?.filter(e => e.status === 'completed').length || 0,
    };

    // 3. Fetch lecture completions
    const { count: lectureCompletions } = await supabase
      .from('lecture_completions')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', user.id);

    // 4. Fetch quiz attempts
    const { data: quizAttempts } = await supabase
      .from('quiz_attempts')
      .select('score')
      .eq('user_id', user.id);

    const avgScore = quizAttempts?.length
      ? quizAttempts.reduce((sum, a) => sum + a.score, 0) / quizAttempts.length
      : 0;

    // 5. Fetch profile for referral points
    const { data: profile } = await supabase
      .from('profiles')
      .select('referral_points')
      .eq('id', user.id)
      .single();

    // 6. Calculate overall progress
    const overallProgress = enrollmentStats.total > 0
      ? (enrollmentStats.completed / enrollmentStats.total) * 100
      : 0;

    // 7. Return statistics
    return NextResponse.json({
      enrollments: enrollmentStats,
      lectureCompletions: {
        total: lectureCompletions || 0,
      },
      quizAttempts: {
        total: quizAttempts?.length || 0,
        averageScore: Math.round(avgScore * 10) / 10,
      },
      overallProgress: Math.round(overallProgress * 10) / 10,
      certificates: enrollmentStats.completed, // Assuming 1 cert per completed course
      referralPoints: profile?.referral_points || 0,
    });

  } catch (error) {
    console.error('Statistics endpoint error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

---

## 📊 PRIORITY MATRIX

| API | Priority | Effort | Impact | When Needed |
|-----|----------|--------|--------|-------------|
| **Profile Update** | 🔴 CRITICAL | 1 day | HIGH | Phase 1 Week 1 |
| **Avatar Upload** | 🔴 CRITICAL | 2 days | HIGH | Phase 1 Week 1 |
| **User Statistics** | 🟡 HIGH | 1 day | MEDIUM | Phase 2 Week 2 |
| **Lesson Complete** | 🟢 MEDIUM | 1 day | MEDIUM | Phase 2 Week 2 |
| **Quiz Submit** | 🟢 MEDIUM | 2 days | MEDIUM | Phase 2 Week 2 |

---

## ✅ FINAL RECOMMENDATIONS

### **Minimum for Production (Phase 1)**:
1. ✅ Add `PATCH /api/users/me/profile` - Profile editing
2. ✅ Add `POST /api/users/me/avatar` - Avatar upload
3. ✅ Add `bio` column to `profiles` table

**Timeline**: 3-4 days
**Blockers Resolved**: Profile editing functionality

---

### **Recommended for Full Experience (Phase 1 + 2)**:
4. ✅ Add `GET /api/users/me/statistics` - User stats
5. ✅ Add `referral_points` column to `profiles` table
6. ✅ Replace mock data in Flutter `HomeRepositoryImpl`

**Timeline**: +2 days (5-6 days total)
**Benefits**: Real data instead of mock data

---

### **Nice to Have (Phase 3)**:
7. Add `POST /api/lessons/[lectureId]/complete`
8. Add `POST /api/quizzes/[quizId]/submit`

**Timeline**: +3 days (8-9 days total)
**Benefits**: Full learning experience with progress tracking

---

## 🚀 NEXT STEPS

1. **Review this document** with backend/fullstack developer
2. **Verify database schema** - Check if `bio` and `referral_points` columns exist
3. **Create Supabase Storage bucket** - Set up `avatars` bucket with policies
4. **Implement Critical APIs first** (Profile + Avatar) - Week 1
5. **Test with Flutter app** - Ensure integration works
6. **Implement Statistics API** - Week 2
7. **Update Flutter app** - Replace mock data with real API calls

---

**Author**: Claude Code
**Date**: December 9, 2025
**Related Documents**:
- `PRODUCTION_READINESS_ASSESSMENT.md` - Full production readiness analysis
- Admin Dashboard Schema: `vidyaras_admin_next/PHASE_1_SCHEMA.sql`
- Admin API Code: `vidyaras_admin_next/src/app/api/`
