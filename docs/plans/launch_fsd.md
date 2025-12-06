# VidyaRas Public Launch - Feature Specification Document

**Version:** 1.0
**Date:** 2025-01-17
**Purpose:** Minimum viable features for public app launch

---

## 1. System Architecture

### Stack
- **Dashboard**: Next.js (Frontend + API routes)
- **App**: Flutter (Android)
- **Database**: Supabase (PostgreSQL)
- **Storage**: Supabase Storage (thumbnails, PDFs, quiz images)
- **Video Hosting**: Google Drive (recorded lectures)
- **Live Classes**: External links (Zoom/Google Meet/etc.)

### Data Flow
```
Flutter App ←→ Next.js API (/api/*) ←→ Supabase DB
                     ↓
              Supabase Storage
```

### Access Control Layers
1. **Public** - Browse published courses (unauthenticated)
2. **Student** - Enrolled courses, take quizzes, track progress
3. **Teacher** - Create/manage courses, quizzes, view reports
4. **Admin** - All teacher permissions + student management + payments

---

## 2. Data Models

### Hierarchy
```
Course
  └── Module (Intro, Beginner, Advanced, etc.)
       └── Lesson (Breathing Techniques, Asanas, etc.)
            ├── Lecture (Video - recorded OR live)
            ├── Materials (PDFs)
            └── Quiz (optional prerequisite)
```

### Core Entities

#### **Course**
```typescript
{
  id: string
  title: string
  instructor: string
  description: string
  thumbnailUrl: string              // Supabase Storage
  categories: string[]
  language: 'Hindi' | 'English' | 'Bilingual'

  // Type
  isLive: boolean
  isRecorded: boolean
  isFree: boolean

  // Pricing
  price: number
  emiMonthlyPrice?: number
  emiTenure?: number

  // Content
  whatYouLearn: string[]
  prerequisites: string[]
  courseIncludes: string[]

  // Live course specific
  liveBatchName?: string
  liveBatchSchedule?: string        // "Mon, Wed, Fri"
  liveBatchTime?: string             // "7:00 PM IST"
  liveBatchCapacity?: number

  // Visibility
  isPublished: boolean

  // Metadata
  createdAt: DateTime
  updatedAt: DateTime
}
```

#### **Module**
```typescript
{
  id: string
  courseId: string
  title: string                      // "Intro", "Intermediate", "Advanced"
  orderIndex: number                 // Display order
  createdAt: DateTime
}
```

#### **Lesson**
```typescript
{
  id: string
  moduleId: string
  title: string                      // "Breathing Techniques"
  description?: string
  orderIndex: number

  // Live course specific
  isCurrentLesson?: boolean          // For live courses only
  isLive?: boolean                   // Currently happening

  createdAt: DateTime
  updatedAt: DateTime
}
```

#### **Lecture** (Video Content)
```typescript
{
  id: string
  lessonId: string
  title: string
  description?: string
  type: 'recorded' | 'live'

  // Recorded lecture
  videoUrl?: string                  // Google Drive link
  durationMinutes?: number

  // Live lecture
  liveClassUrl?: string              // Zoom/Meet link
  scheduledAt?: DateTime

  // Recording of past live class
  recordingUrl?: string              // Added post-class

  // Gating
  requiredQuizId?: string            // Must pass this quiz to unlock

  orderIndex: number
  createdAt: DateTime
  updatedAt: DateTime
}
```

#### **Material** (PDFs, Documents)
```typescript
{
  id: string
  lessonId: string
  title: string
  fileUrl: string                    // Supabase Storage
  fileType: 'pdf' | 'doc' | 'image'
  fileSizeMb: number
  createdAt: DateTime
}
```

#### **Quiz**
```typescript
{
  id: string
  title: string
  description?: string
  courseId?: string                  // null = standalone

  fullMarks: number
  passingMarks: number
  timeAllottedMinutes: number

  isPublished: boolean
  isPublic: boolean                  // Free vs paid users
  difficultyLevel: 'beginner' | 'intermediate' | 'advanced'

  createdAt: DateTime
  updatedAt: DateTime
}
```

#### **QuizQuestion**
```typescript
{
  id: string
  quizId: string
  questionNumber: number

  questionData: ContentData          // Text/LaTeX/Image
  options: QuizOption[]              // 4 options
  correctOptionId: number            // 0-3
  explanation?: ContentData          // Optional explanation

  marks: number
  createdAt: DateTime
}
```

#### **ContentData** (Flexible Content)
```typescript
{
  type: 'text' | 'latex' | 'image_url'
  content: string                    // Text or URL
}
```

#### **QuizOption**
```typescript
{
  id: number                         // 0-3
  data: ContentData                  // Text/LaTeX/Image
}
```

#### **Enrollment**
```typescript
{
  id: string
  userId: string
  courseId: string

  enrollmentStatus: 'active' | 'completed' | 'expired'
  enrollmentType: 'free' | 'paid'

  // Payment
  paymentStatus: 'pending' | 'paid' | 'na'  // Manual tracking
  amountPaid?: number

  // Progress
  progress: number                   // 0.0-1.0
  lastAccessedAt?: DateTime

  enrolledAt: DateTime
  expiresAt?: DateTime
}
```

#### **LectureCompletion**
```typescript
{
  id: string
  userId: string
  lectureId: string

  watchedSeconds?: number            // For videos
  isCompleted: boolean

  completedAt: DateTime
}
```

#### **QuizAttempt**
```typescript
{
  id: string
  userId: string
  quizId: string

  score: number
  totalMarks: number
  percentage: number
  timeTakenSeconds: number

  isCompleted: boolean

  // Teacher feedback
  teacherNotes?: string

  startedAt: DateTime
  completedAt?: DateTime
}
```

#### **UserAnswer**
```typescript
{
  id: string
  attemptId: string
  questionId: string
  selectedOptionId: number
  isCorrect: boolean
  marksAwarded: number
  answeredAt: DateTime
}
```

#### **User**
```typescript
{
  id: string
  phoneNumber: string                // Primary auth
  name: string
  email?: string
  avatarUrl?: string

  role: 'student' | 'teacher' | 'admin'

  createdAt: DateTime
}
```

---

## 3. User Roles & Permissions

### Admin
- All teacher permissions
- **+ Student Management**: View, edit students
- **+ Enrollment Management**: Manually enroll students
- **+ Payment Tracking**: Mark paid/unpaid

### Teacher
- **Course Management**: Create, edit, publish courses
- **Content Management**: Add modules, lessons, lectures, materials
- **Quiz Management**: Create, edit, publish quizzes
- **Progress Reports**: View student progress & quiz results
- **Feedback**: Add notes on quiz attempts

### Student
- **Browse**: View published courses
- **Enroll**: Self-enroll (free) or admin-enrolled (paid)
- **Learn**: Watch lectures, download materials
- **Quizzes**: Attempt quizzes, view results
- **Progress**: Track own progress

### Public (Unauthenticated)
- Browse published free courses (limited info)
- View course details
- Cannot enroll or access content

---

## 4. Core Features

### 4.1 Course Management

#### Dashboard: Course Builder
**Current Status**: Partial - generates JSON, needs DB integration

**Features Needed**:
- ✅ Course metadata input (title, instructor, description)
- ✅ Add learning objectives, prerequisites, includes
- ✅ Pricing setup (free/paid, EMI options)
- ✅ Live batch configuration
- ❌ **Thumbnail upload** (Supabase Storage)
- ❌ **Save to database** (API integration)
- ❌ **Publish toggle** (isPublished)
- ❌ **Edit existing courses**

**Teacher Workflow**:
1. Fill basic info (title, instructor, description)
2. Upload thumbnail
3. Set categories & language
4. Add "What you'll learn"
5. Set prerequisites & course includes
6. Configure pricing
7. If live course: Set batch details
8. Save as draft or publish

**API Endpoints**:
```
POST   /api/courses              - Create course
PUT    /api/courses/:id          - Update course
GET    /api/courses              - List courses (with filters)
GET    /api/courses/:id          - Get course details
DELETE /api/courses/:id          - Delete course
POST   /api/upload/thumbnail     - Upload thumbnail
```

---

### 4.2 Module Management

#### Dashboard: Module Manager (within Course)

**Features**:
- Add module to course
- Edit module title
- Reorder modules (drag-drop)
- Delete module

**Teacher Workflow**:
1. Open course
2. Click "Add Module"
3. Enter title (e.g., "Introduction", "Advanced")
4. Save
5. Reorder as needed

**API Endpoints**:
```
POST   /api/courses/:courseId/modules              - Create module
PUT    /api/modules/:id                            - Update module
DELETE /api/modules/:id                            - Delete module
PUT    /api/modules/reorder                        - Reorder modules
```

---

### 4.3 Lesson Management

#### Dashboard: Lesson Manager (within Module)

**Features**:
- Add lesson to module
- Edit lesson details
- Mark as "Current Lesson" (live courses only)
- Toggle "Is Live" status (live courses only)
- Reorder lessons
- Delete lesson

**Teacher Workflow**:
1. Open module
2. Click "Add Lesson"
3. Enter title & description
4. If live course: Can mark as "Current" or "Live"
5. Save
6. Reorder as needed

**API Endpoints**:
```
POST   /api/modules/:moduleId/lessons              - Create lesson
PUT    /api/lessons/:id                            - Update lesson
DELETE /api/lessons/:id                            - Delete lesson
PUT    /api/lessons/:id/set-current                - Mark as current (live)
PUT    /api/lessons/:id/set-live                   - Toggle live status
PUT    /api/lessons/reorder                        - Reorder lessons
```

---

### 4.4 Lecture Management

#### Dashboard: Lecture Manager (within Lesson)

**Features**:
- Add recorded lecture (Google Drive URL)
- Add live lecture (manual link entry)
- Add recording to past live lecture
- Link prerequisite quiz
- Edit lecture details
- Reorder lectures
- Delete lecture

**Teacher Workflow - Recorded Lecture**:
1. Open lesson
2. Click "Add Recorded Lecture"
3. Enter title, description
4. Paste Google Drive video URL
5. Enter duration
6. Optional: Link quiz prerequisite
7. Save

**Teacher Workflow - Live Lecture**:
1. Open lesson
2. Click "Add Live Lecture"
3. Enter title, description
4. Paste live class URL (Zoom/Meet)
5. Set scheduled time
6. Save
7. **After class**: Edit → Add recording URL

**API Endpoints**:
```
POST   /api/lessons/:lessonId/lectures             - Create lecture
PUT    /api/lectures/:id                           - Update lecture
DELETE /api/lectures/:id                           - Delete lecture
PUT    /api/lectures/reorder                       - Reorder lectures
```

---

### 4.5 Material Management

#### Dashboard: Material Manager (within Lesson)

**Features**:
- Upload PDF/document to Supabase Storage
- Attach to lesson
- Delete material

**Teacher Workflow**:
1. Open lesson
2. Click "Add Material"
3. Upload PDF file
4. Enter title
5. Save (automatically uploads to Supabase Storage)

**API Endpoints**:
```
POST   /api/lessons/:lessonId/materials            - Upload & attach material
DELETE /api/materials/:id                          - Delete material
POST   /api/upload/material                        - Upload to Supabase Storage
```

---

### 4.6 Quiz Management

#### Dashboard: Quiz Builder (Standalone)

**Features**:
- Create quiz (standalone or course-specific)
- Add questions with flexible content (text/LaTeX/image)
- Add 4 options per question (text/LaTeX/image)
- Mark correct answer
- Add explanation (optional)
- Set marks per question
- Configure quiz settings (time, passing marks)
- Publish toggle
- Edit existing quizzes

**Teacher Workflow**:
1. Navigate to "Quiz Builder"
2. Click "Create New Quiz"
3. Enter title, description
4. Set time limit, full marks, passing marks
5. Set difficulty & visibility
6. Add questions:
   - Select content type (text/LaTeX/image)
   - Enter question
   - Add 4 options (with content type)
   - Mark correct answer
   - Add explanation (optional)
   - Set marks
7. Save as draft or publish

**Question Content Types**:
- **Text**: Plain text
- **LaTeX**: Mathematical equations
- **Image**: Upload to Supabase Storage, show image

**API Endpoints**:
```
POST   /api/quizzes                                - Create quiz
PUT    /api/quizzes/:id                            - Update quiz
GET    /api/quizzes                                - List quizzes
GET    /api/quizzes/:id                            - Get quiz details
DELETE /api/quizzes/:id                            - Delete quiz
POST   /api/quizzes/:id/questions                  - Add question
PUT    /api/questions/:id                          - Update question
DELETE /api/questions/:id                          - Delete question
POST   /api/upload/quiz-image                      - Upload quiz image
```

---

### 4.7 Student Management

#### Dashboard: Student List & Details

**Features** (Admin only):
- View all students
- Search students
- View student details
- Edit student info
- Set payment status manually
- View enrolled courses
- View quiz attempts

**Admin Workflow**:
1. Navigate to "Students"
2. Browse/search students
3. Click student to view details
4. View enrollments & progress
5. Mark payment status (paid/unpaid)

**API Endpoints**:
```
GET    /api/students                               - List students
GET    /api/students/:id                           - Student details
PUT    /api/students/:id                           - Update student
GET    /api/students/:id/enrollments               - Student enrollments
```

---

### 4.8 Enrollment Management

#### Dashboard: Manual Enrollment

**Features** (Admin only):
- Manually enroll student in course
- Set enrollment type (free/paid)
- Set payment status
- Remove enrollment

**Admin Workflow**:
1. Open student profile
2. Click "Enroll in Course"
3. Select course
4. Set enrollment type
5. If paid: Mark payment status
6. Save

**API Endpoints**:
```
POST   /api/enrollments                            - Create enrollment
DELETE /api/enrollments/:id                        - Remove enrollment
PUT    /api/enrollments/:id/payment                - Update payment status
```

---

### 4.9 Progress Reports

#### Dashboard: Student Progress View

**Features** (Teacher/Admin):
- View course-wise progress
- View lecture completion rates
- View quiz attempts & scores
- Add feedback notes on quiz attempts

**Teacher Workflow**:
1. Navigate to "Reports"
2. Select course
3. View enrolled students & progress
4. Click student → View detailed progress
5. View quiz attempts → Add notes

**API Endpoints**:
```
GET    /api/reports/course/:courseId               - Course progress report
GET    /api/reports/student/:studentId             - Student progress report
GET    /api/quiz-attempts/:attemptId               - Quiz attempt details
PUT    /api/quiz-attempts/:attemptId/notes         - Add teacher notes
```

---

### 4.10 App Features (Student-Facing)

#### Current Status
App has UI ready with demo data, needs API integration

#### Features:
- **Authentication**: Phone number (MSG91 OTP) ✅ (already working)
- **Browse Courses**: View published courses
- **Course Details**: View curriculum, reviews, pricing
- **Enrollment**: Self-enroll (free) or request enrollment (paid)
- **My Learning**: View enrolled courses
- **Watch Lectures**: Stream from Google Drive
- **Join Live Class**: Direct link to Zoom/Meet
- **Download Materials**: Download PDFs
- **Take Quiz**: Attempt quizzes, view results
- **Track Progress**: See completion percentage

#### Student Workflows:

**Browse & Enroll**:
1. Open app
2. Browse courses
3. Click course → View details
4. If free: Click "Enroll" → Instant enrollment
5. If paid: Click "Request Enrollment" → Admin enrolls manually

**Learn (Recorded Course)**:
1. Go to "My Learning"
2. Click enrolled course
3. View modules → lessons → lectures
4. Click lecture → Watch video (Google Drive)
5. Download materials
6. Take quiz (if required)
7. Progress auto-tracked

**Learn (Live Course)**:
1. Go to "My Learning"
2. Click enrolled course
3. See "Current Lesson" highlighted
4. See "Join Class" button on course card
5. Click → Open live class link
6. After class: Teacher adds recording
7. Watch recording from lecture list

**Take Quiz**:
1. Open course/lesson
2. Click quiz
3. Start attempt → Timer starts
4. Answer questions (text/LaTeX/images rendered)
5. Submit
6. View score & explanations
7. Teacher can add notes

**API Endpoints** (Student):
```
GET    /api/courses                                - Browse courses
GET    /api/courses/:id                            - Course details
POST   /api/enrollments/self-enroll                - Self-enroll (free)
POST   /api/enrollments/request                    - Request enrollment (paid)
GET    /api/my-learning                            - Enrolled courses
GET    /api/courses/:id/content                    - Full course content
POST   /api/lectures/:id/complete                  - Mark lecture complete
GET    /api/quizzes/:id                            - Get quiz
POST   /api/quiz-attempts                          - Start attempt
POST   /api/quiz-attempts/:id/submit               - Submit attempt
GET    /api/quiz-attempts/:id/results              - View results
```

---

## 5. API Access Control Matrix

| Endpoint | Public | Student | Teacher | Admin |
|----------|--------|---------|---------|-------|
| GET /api/courses (published) | ✅ | ✅ | ✅ | ✅ |
| GET /api/courses/:id | ✅ | ✅ | ✅ | ✅ |
| POST /api/courses | ❌ | ❌ | ✅ | ✅ |
| PUT /api/courses/:id | ❌ | ❌ | ✅ | ✅ |
| POST /api/enrollments/self-enroll | ❌ | ✅ | ✅ | ✅ |
| POST /api/enrollments (manual) | ❌ | ❌ | ❌ | ✅ |
| GET /api/my-learning | ❌ | ✅ | ✅ | ✅ |
| POST /api/quiz-attempts | ❌ | ✅ | ✅ | ✅ |
| PUT /api/quiz-attempts/:id/notes | ❌ | ❌ | ✅ | ✅ |
| GET /api/students | ❌ | ❌ | ❌ | ✅ |
| POST /api/quizzes | ❌ | ❌ | ✅ | ✅ |

---

## 6. File Storage Strategy

### Supabase Storage Buckets:
```
course-thumbnails/        - Course thumbnail images
quiz-images/              - Quiz question & option images
materials/                - PDFs, documents
user-avatars/             - User profile pictures
```

### External Storage:
- **Recorded Lectures**: Google Drive (shareable links)
- **Live Classes**: External platforms (Zoom, Google Meet, etc.)

### File Upload Flow:
1. User uploads file via dashboard
2. Next.js API validates file
3. Upload to Supabase Storage
4. Get public URL
5. Save URL in database

---

## 7. Database Schema (Supabase)

### Tables:

```sql
-- Users
users (
  id UUID PRIMARY KEY,
  phone_number TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  email TEXT,
  avatar_url TEXT,
  role TEXT DEFAULT 'student',
  created_at TIMESTAMP DEFAULT NOW()
)

-- Courses
courses (
  id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  instructor TEXT NOT NULL,
  description TEXT,
  thumbnail_url TEXT,
  categories TEXT[],
  language TEXT,
  is_live BOOLEAN DEFAULT false,
  is_recorded BOOLEAN DEFAULT false,
  is_free BOOLEAN DEFAULT false,
  price DECIMAL,
  emi_monthly_price DECIMAL,
  emi_tenure INTEGER,
  what_you_learn TEXT[],
  prerequisites TEXT[],
  course_includes TEXT[],
  live_batch_name TEXT,
  live_batch_schedule TEXT,
  live_batch_time TEXT,
  live_batch_capacity INTEGER,
  is_published BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
)

-- Modules
modules (
  id UUID PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  order_index INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
)

-- Lessons
lessons (
  id UUID PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  order_index INTEGER NOT NULL,
  is_current_lesson BOOLEAN DEFAULT false,
  is_live BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
)

-- Lectures
lectures (
  id UUID PRIMARY KEY,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL, -- 'recorded' | 'live'
  video_url TEXT,
  live_class_url TEXT,
  recording_url TEXT,
  duration_minutes INTEGER,
  scheduled_at TIMESTAMP,
  required_quiz_id UUID REFERENCES quizzes(id),
  order_index INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
)

-- Materials
materials (
  id UUID PRIMARY KEY,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_type TEXT NOT NULL,
  file_size_mb DECIMAL,
  created_at TIMESTAMP DEFAULT NOW()
)

-- Quizzes
quizzes (
  id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  course_id UUID REFERENCES courses(id),
  full_marks INTEGER NOT NULL,
  passing_marks INTEGER NOT NULL,
  time_allotted_minutes INTEGER NOT NULL,
  is_published BOOLEAN DEFAULT false,
  is_public BOOLEAN DEFAULT true,
  difficulty_level TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
)

-- Quiz Questions
quiz_questions (
  id UUID PRIMARY KEY,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE,
  question_number INTEGER NOT NULL,
  question_data JSONB NOT NULL, -- {type: 'text'|'latex'|'image_url', content: string}
  options JSONB NOT NULL, -- [{id: 0, data: ContentData}, ...]
  correct_option_id INTEGER NOT NULL,
  explanation JSONB,
  marks INTEGER DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW()
)

-- Enrollments
enrollments (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  enrollment_status TEXT DEFAULT 'active',
  enrollment_type TEXT NOT NULL, -- 'free' | 'paid'
  payment_status TEXT DEFAULT 'na', -- 'pending' | 'paid' | 'na'
  amount_paid DECIMAL,
  progress DECIMAL DEFAULT 0,
  last_accessed_at TIMESTAMP,
  enrolled_at TIMESTAMP DEFAULT NOW(),
  expires_at TIMESTAMP,
  UNIQUE(user_id, course_id)
)

-- Lecture Completions
lecture_completions (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  lecture_id UUID REFERENCES lectures(id) ON DELETE CASCADE,
  watched_seconds INTEGER,
  is_completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, lecture_id)
)

-- Quiz Attempts
quiz_attempts (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE,
  score INTEGER NOT NULL,
  total_marks INTEGER NOT NULL,
  percentage DECIMAL,
  time_taken_seconds INTEGER,
  is_completed BOOLEAN DEFAULT false,
  teacher_notes TEXT,
  started_at TIMESTAMP DEFAULT NOW(),
  completed_at TIMESTAMP
)

-- User Answers
user_answers (
  id UUID PRIMARY KEY,
  attempt_id UUID REFERENCES quiz_attempts(id) ON DELETE CASCADE,
  question_id UUID REFERENCES quiz_questions(id),
  selected_option_id INTEGER NOT NULL,
  is_correct BOOLEAN NOT NULL,
  marks_awarded INTEGER DEFAULT 0,
  answered_at TIMESTAMP DEFAULT NOW()
)
```

### Indexes:
```sql
CREATE INDEX idx_modules_course ON modules(course_id);
CREATE INDEX idx_lessons_module ON lessons(module_id);
CREATE INDEX idx_lectures_lesson ON lectures(lesson_id);
CREATE INDEX idx_materials_lesson ON materials(lesson_id);
CREATE INDEX idx_questions_quiz ON quiz_questions(quiz_id);
CREATE INDEX idx_enrollments_user ON enrollments(user_id);
CREATE INDEX idx_enrollments_course ON enrollments(course_id);
CREATE INDEX idx_completions_user ON lecture_completions(user_id);
CREATE INDEX idx_attempts_user ON quiz_attempts(user_id);
CREATE INDEX idx_attempts_quiz ON quiz_attempts(quiz_id);
CREATE INDEX idx_answers_attempt ON user_answers(attempt_id);
```

---

## 8. Launch Priority Order

### Phase 1: Database & API Foundation (Week 1-2)
1. Create Supabase schema
2. Set up Next.js API routes structure
3. Implement authentication middleware
4. Implement file upload endpoints

### Phase 2: Core Dashboard Features (Week 3-5)
1. Complete Course Builder (DB integration + thumbnail upload)
2. Module Management UI
3. Lesson Management UI
4. Lecture Management UI
5. Material Management UI

### Phase 3: Quiz System (Week 6-7)
1. Quiz Builder UI
2. Question editor with content types
3. Quiz publish/visibility controls

### Phase 4: Admin Features (Week 8)
1. Student Management UI
2. Enrollment Management UI
3. Payment Status Tracking

### Phase 5: Reports (Week 9)
1. Progress Reports UI
2. Quiz Attempt Viewer
3. Teacher Notes Feature

### Phase 6: App Integration (Week 10-11)
1. Replace Supabase direct calls with API calls
2. Test all student workflows
3. Bug fixes

### Phase 7: Testing & Launch (Week 12)
1. End-to-end testing
2. User acceptance testing
3. Deploy dashboard
4. Deploy app to Play Store

---

## 9. Success Metrics

### Launch Targets:
- **Courses**: 5-10 published courses
- **Students**: 100 active users
- **Quizzes**: 20+ quizzes available
- **Teachers**: 3-5 active teachers

### Key Metrics to Track:
- Course enrollment rate
- Quiz completion rate
- Student progress (avg % completion)
- Daily active users
- Teacher activity (content creation rate)

---

## 10. Out of Scope (Post-Launch)

Features NOT included in initial launch:
- Automated payment gateway integration
- Student self-payment
- Automated email notifications
- Push notifications
- Social features (comments, discussion forums)
- Advanced analytics dashboard
- Certificate generation
- Student leaderboards
- Referral program automation
- Video conferencing integration (Zoom API)
- Automated quiz grading (subjective questions)
- Course recommendations AI
- Mobile responsive dashboard (desktop only for now)

---

**Document Version:** 1.0
**Last Updated:** 2025-01-17
