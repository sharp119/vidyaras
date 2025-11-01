# VidyaRas Supabase Database Schema

**Generated:** 2025-01-02
**Project:** VidyaRas Learning Platform
**Database:** PostgreSQL (Supabase)

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Database Extensions](#database-extensions)
3. [Migration History](#migration-history)
4. [Schema Diagram](#schema-diagram)
5. [Table Definitions](#table-definitions)
   - [User Management](#user-management)
   - [Course Management](#course-management)
   - [Learning Progress](#learning-progress)
   - [Quiz System](#quiz-system)
6. [Relationships & Constraints](#relationships--constraints)
7. [Row Level Security (RLS)](#row-level-security-rls)
8. [Indexes & Performance](#indexes--performance)

---

## Overview

The VidyaRas database schema is designed to support a comprehensive learning management system with the following core features:

- **User Authentication & Profiles** - Phone-based OTP login
- **Course Management** - Live and recorded courses with multiple sections
- **Learning Progress Tracking** - Lecture completions, enrollments
- **Quiz System** - Flexible quiz engine with analytics
- **Live Classes** - Zoom integration for live sessions
- **Course Materials** - Downloadable resources

**Total Tables:** 11 (public schema)
**RLS Enabled:** Yes (on critical tables)

---

## Database Extensions

### Installed Extensions

| Extension | Version | Schema | Purpose |
|-----------|---------|--------|---------|
| `pg_graphql` | 1.5.11 | graphql | GraphQL support for API |
| `supabase_vault` | 0.3.1 | vault | Secure secrets storage |
| `pgcrypto` | 1.3 | extensions | Cryptographic functions |
| `pg_stat_statements` | 1.11 | extensions | Query performance tracking |
| `uuid-ossp` | 1.1 | extensions | UUID generation |

### Available (Not Installed)

- `postgis` - Geospatial data (future: location-based features)
- `pg_cron` - Scheduled jobs (future: automated tasks)
- `vector` - Vector embeddings (future: AI recommendations)

---

## Migration History

| Version | Name | Purpose |
|---------|------|---------|
| 20251020001902 | create_courses_table | Initial course structure |
| 20251020001920 | create_quizzes_table | Quiz system foundation |
| 20251020001942 | create_questions_table | Quiz questions with JSONB |
| 20251020002008 | create_quiz_attempts_and_user_answers_tables | Quiz attempt tracking |
| 20251020092852 | update_quiz_rls_policies_for_public_access | Public quiz access |
| 20251020094027 | add_comprehensive_quiz_analytics | Analytics & insights |
| 20251022105750 | create_guest_user_and_fix_fk | Guest user support |
| 20251027153614 | create_lectures_table | Lecture/lesson structure |
| 20251027153629 | create_live_classes_table | Live class scheduling |
| 20251027153638 | create_enrollments_table | Course enrollment tracking |
| 20251027153649 | create_lecture_completions_table | Progress tracking |
| 20251027153700 | create_course_materials_table | Downloadable materials |
| 20251027153710 | update_quizzes_add_lecture_fields | Quiz-lecture linking |
| 20251027153735 | update_courses_add_fields | Enhanced course metadata |

---

## Schema Diagram

```
┌─────────────┐
│    users    │
└──────┬──────┘
       │
       ├──────────────────────────────────────┐
       │                                      │
       ▼                                      ▼
┌─────────────┐                      ┌─────────────────┐
│ enrollments │◄─────────────────────│    courses      │
└──────┬──────┘                      └────────┬────────┘
       │                                      │
       │                              ┌───────┴────────┐
       │                              │                │
       │                              ▼                ▼
       │                      ┌──────────────┐  ┌─────────────┐
       │                      │   lectures   │  │live_classes │
       │                      └──────┬───────┘  └─────────────┘
       │                             │
       │                             │
       │                      ┌──────┴───────┐
       │                      │              │
       │                      ▼              ▼
       │              ┌──────────────┐ ┌────────────────┐
       │              │   quizzes    │ │course_materials│
       │              └──────┬───────┘ └────────────────┘
       │                     │
       │              ┌──────┴────────┐
       │              │               │
       │              ▼               ▼
       │      ┌─────────────┐  ┌──────────────┐
       │      │  questions  │  │quiz_attempts │
       │      └─────────────┘  └──────┬───────┘
       │                              │
       │                       ┌──────┴────────┐
       │                       │               │
       │                       ▼               ▼
       │               ┌──────────────┐ ┌───────────────────┐
       │               │user_answers  │ │question_analytics │
       │               └──────────────┘ └───────────────────┘
       │
       ▼
┌─────────────────────┐
│lecture_completions  │
└─────────────────────┘
```

---

## Table Definitions

### User Management

#### 1. `users` (public.users)

**Purpose:** Core user table for the application (separate from auth.users)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | User identifier |
| phone_number | text | UNIQUE, NOT NULL | User's phone number for OTP login |
| name | text | NULLABLE | User's full name |
| email | text | NULLABLE | Optional email address |
| created_at | timestamptz | DEFAULT now() | Account creation timestamp |
| updated_at | timestamptz | DEFAULT now() | Last update timestamp |

**Rows:** 10
**RLS:** Disabled

**Related Tables:**
- `enrollments` (user_id)
- `quiz_attempts` (user_id)
- `lecture_completions` (user_id)

---

#### 2. `profiles` (public.profiles)

**Purpose:** Additional user profile data (linked to auth.users)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY, FK → auth.users.id | Links to auth user |
| phone_number | text | UNIQUE, CHECK (regex) | Validated phone format |
| name | text | NOT NULL | User's display name |
| email | text | NULLABLE | Email address |
| created_at | timestamptz | DEFAULT now() | Profile creation |
| updated_at | timestamptz | DEFAULT now() | Last modification |

**Rows:** 0
**RLS:** Enabled
**Phone Validation:** Must match `^\\+[1-9]\\d{1,14}$` (E.164 format)

---

### Course Management

#### 3. `courses` (public.courses)

**Purpose:** Stores all course information for the learning platform

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Course identifier |
| title | text | NOT NULL | Course title |
| description | text | NULLABLE | Detailed description |
| thumbnail_url | text | NULLABLE | Course thumbnail image |
| category | text | NULLABLE | Course category (Music, Wellness, etc.) |
| is_premium | boolean | DEFAULT false | Requires payment |
| price | numeric | NULLABLE | Course price in INR (null = free) |
| instructor | text | NULLABLE | Instructor name |
| rating | numeric | DEFAULT 0.0 | Average rating (0-5) |
| review_count | integer | DEFAULT 0 | Number of reviews |
| enrolled_count | integer | DEFAULT 0 | Total enrollments |
| duration | text | NULLABLE | Course duration (e.g., "8 weeks") |
| is_live | boolean | DEFAULT false | Has live sessions |
| is_recorded | boolean | DEFAULT false | Has recorded lectures |
| has_free_trial | boolean | DEFAULT false | Offers free trial |
| language | text | DEFAULT 'Bilingual (Hindi + English)' | Course language |
| has_certificate | boolean | DEFAULT true | Issues certificate |
| has_quizzes | boolean | DEFAULT true | Includes quizzes |
| has_materials | boolean | DEFAULT true | Has downloadable materials |
| access_days | integer | NULLABLE | Days of access (null = lifetime) |
| created_at | timestamptz | DEFAULT now() | Course creation |
| updated_at | timestamptz | DEFAULT now() | Last update |

**Rows:** 6
**RLS:** Enabled

**Related Tables:**
- `lectures` (course_id)
- `live_classes` (course_id)
- `enrollments` (course_id)
- `course_materials` (course_id)
- `quizzes` (course_id)

---

#### 4. `lectures` (public.lectures)

**Purpose:** Individual lectures/lessons within courses

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Lecture identifier |
| course_id | uuid | FK → courses.id | Parent course |
| section_id | text | NOT NULL | Section identifier (s1, s2, s3) |
| section_title | text | NOT NULL | Section name |
| title | text | NOT NULL | Lecture title |
| description | text | NULLABLE | Lecture description |
| order_index | integer | NOT NULL | Order in curriculum |
| type | text | DEFAULT 'video', CHECK | video/live/reading/practice |
| duration_minutes | integer | NULLABLE | Lecture duration |
| video_url | text | NULLABLE | Video content URL |
| required_quiz_id | uuid | FK → quizzes.id | Required quiz to unlock next |
| created_at | timestamptz | DEFAULT now() | Creation timestamp |
| updated_at | timestamptz | DEFAULT now() | Last update |

**Rows:** 64
**RLS:** Disabled
**Type Values:** `video`, `live`, `reading`, `practice`

---

#### 5. `live_classes` (public.live_classes)

**Purpose:** Scheduled live class sessions with Zoom integration

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Live class identifier |
| course_id | uuid | FK → courses.id | Parent course |
| lecture_id | uuid | FK → lectures.id | Related lecture (optional) |
| title | text | NOT NULL | Class title |
| description | text | NULLABLE | Class description |
| scheduled_at | timestamptz | NOT NULL | Start time |
| duration_minutes | integer | DEFAULT 120 | Duration (default 2 hours) |
| zoom_link | text | NOT NULL | Zoom meeting URL |
| meeting_id | text | NULLABLE | Zoom meeting ID |
| passcode | text | NULLABLE | Zoom passcode |
| recording_url | text | NULLABLE | Recording after completion |
| status | text | DEFAULT 'upcoming', CHECK | completed/upcoming/live |
| created_at | timestamptz | DEFAULT now() | Creation timestamp |

**Rows:** 12
**RLS:** Disabled
**Status Values:** `completed`, `upcoming`, `live`

---

#### 6. `course_materials` (public.course_materials)

**Purpose:** Downloadable course resources (PDFs, videos, documents)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Material identifier |
| course_id | uuid | FK → courses.id | Parent course |
| title | text | NOT NULL | Material title |
| type | text | DEFAULT 'pdf', CHECK | File type |
| file_url | text | NOT NULL | Download URL |
| file_size_mb | numeric | NULLABLE | File size in MB |
| section_id | text | NULLABLE | Section assignment (s1, s2) |
| created_at | timestamptz | DEFAULT now() | Upload timestamp |

**Rows:** 16
**RLS:** Disabled
**Type Values:** `pdf`, `video`, `doc`, `image`, `other`

---

### Learning Progress

#### 7. `enrollments` (public.enrollments)

**Purpose:** Tracks which users are enrolled in which courses

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Enrollment identifier |
| user_id | uuid | FK → users.id | Enrolled user |
| course_id | uuid | FK → courses.id | Enrolled course |
| enrolled_at | timestamptz | DEFAULT now() | Enrollment date |
| status | text | DEFAULT 'active', CHECK | Enrollment status |
| last_accessed_at | timestamptz | NULLABLE | Last course access |
| created_at | timestamptz | DEFAULT now() | Record creation |

**Rows:** 16
**RLS:** Disabled
**Status Values:** `active`, `completed`, `expired`

---

#### 8. `lecture_completions` (public.lecture_completions)

**Purpose:** Tracks completed lectures for progress tracking

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Completion identifier |
| user_id | uuid | FK → users.id | User who completed |
| lecture_id | uuid | FK → lectures.id | Completed lecture |
| completed_at | timestamptz | DEFAULT now() | Completion time |
| watched_seconds | integer | NULLABLE | Total watch time (for resume) |
| created_at | timestamptz | DEFAULT now() | Record creation |

**Rows:** 59
**RLS:** Disabled

**Use Cases:**
- Track learning progress
- Calculate completion percentage
- Resume video playback
- Unlock next lecture

---

### Quiz System

#### 9. `quizzes` (public.quizzes)

**Purpose:** Quiz metadata and configuration

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Quiz identifier |
| title | text | NOT NULL | Quiz title |
| description | text | NULLABLE | Quiz description |
| course_id | uuid | FK → courses.id | Parent course (nullable for standalone) |
| full_marks | integer | DEFAULT 100 | Total marks |
| time_allotted_minutes | integer | DEFAULT 30 | Time limit |
| is_published | boolean | DEFAULT false | Visibility toggle |
| is_public | boolean | DEFAULT true | Public access |
| difficulty_level | text | CHECK | beginner/intermediate/advanced |
| related_lecture_id | uuid | FK → lectures.id | Associated lecture |
| is_required | boolean | DEFAULT false | Blocks next lecture |
| passing_score | integer | DEFAULT 70 | Minimum % to pass (0-100) |
| created_at | timestamptz | DEFAULT now() | Creation time |
| updated_at | timestamptz | DEFAULT now() | Last update |

**Rows:** 7
**RLS:** Enabled
**Difficulty Levels:** `beginner`, `intermediate`, `advanced`

---

#### 10. `questions` (public.questions)

**Purpose:** Quiz questions with flexible JSONB content (text, LaTeX, images)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Question identifier |
| quiz_id | uuid | FK → quizzes.id | Parent quiz |
| question_number | integer | NOT NULL | Question order |
| question_data | jsonb | NOT NULL, CHECK | Question content |
| options | jsonb | NOT NULL, CHECK (array) | Answer options |
| correct_option_id | integer | NOT NULL | Correct answer index (0-based) |
| explanation | jsonb | NULLABLE | Answer explanation |
| marks | integer | DEFAULT 1 | Points awarded |
| created_at | timestamptz | DEFAULT now() | Creation time |
| updated_at | timestamptz | DEFAULT now() | Last update |

**Rows:** 65
**RLS:** Enabled

**JSONB Structure:**

```json
// question_data format
{
  "type": "text|latex|image_url",
  "content": "Question text or URL..."
}

// options format
[
  {
    "id": 0,
    "data": {
      "type": "text",
      "content": "Option A"
    }
  },
  {
    "id": 1,
    "data": {
      "type": "text",
      "content": "Option B"
    }
  }
]

// explanation format (same as question_data)
{
  "type": "text",
  "content": "Explanation..."
}
```

---

#### 11. `quiz_attempts` (public.quiz_attempts)

**Purpose:** Tracks every quiz attempt by users with analytics

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Attempt identifier |
| user_id | uuid | FK → users.id | User taking quiz |
| quiz_id | uuid | FK → quizzes.id | Quiz being attempted |
| score | integer | DEFAULT 0 | Marks obtained |
| total_marks | integer | NOT NULL | Maximum possible marks |
| percentage | numeric | GENERATED | Auto-calculated % |
| time_taken_seconds | integer | NULLABLE | Time spent |
| started_at | timestamptz | DEFAULT now() | Start time |
| completed_at | timestamptz | NULLABLE | Completion time |
| is_completed | boolean | DEFAULT false | Completion status |
| attempt_number | integer | DEFAULT 1 | Attempt count |
| rank | integer | NULLABLE | Rank among all users |
| percentile | numeric | NULLABLE | Percentile score |
| accuracy | numeric | NULLABLE | Accuracy percentage |
| created_at | timestamptz | DEFAULT now() | Record creation |

**Rows:** 43
**RLS:** Enabled

**Auto-Calculated Fields:**
- `percentage` = (score / total_marks) × 100

---

#### 12. `user_answers` (public.user_answers)

**Purpose:** Individual answers for each question in quiz attempts

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | bigint | PRIMARY KEY | Answer identifier |
| attempt_id | uuid | FK → quiz_attempts.id | Parent attempt |
| question_id | uuid | FK → questions.id | Question answered |
| selected_option_id | integer | NOT NULL | User's choice (0-based) |
| is_correct | boolean | NOT NULL | Correctness |
| marks_awarded | integer | DEFAULT 0 | Marks given |
| answered_at | timestamptz | DEFAULT now() | Answer timestamp |

**Rows:** 211
**RLS:** Enabled

---

#### 13. `question_analytics` (public.question_analytics)

**Purpose:** Detailed analytics per question in attempts

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Analytics identifier |
| attempt_id | uuid | FK → quiz_attempts.id | Parent attempt |
| question_id | uuid | FK → questions.id | Question analyzed |
| time_spent_seconds | integer | DEFAULT 0 | Time on question |
| is_bookmarked | boolean | DEFAULT false | User bookmarked |
| visit_count | integer | DEFAULT 1 | Times visited |
| created_at | timestamptz | DEFAULT now() | First visit |
| updated_at | timestamptz | DEFAULT now() | Last visit |

**Rows:** 20
**RLS:** Enabled

**Use Cases:**
- Identify difficult questions
- Track time per question
- Resume quiz functionality
- Question review features

---

## Relationships & Constraints

### Foreign Key Map

```
users
├── enrollments.user_id
├── quiz_attempts.user_id
└── lecture_completions.user_id

courses
├── lectures.course_id
├── live_classes.course_id
├── enrollments.course_id
├── course_materials.course_id
└── quizzes.course_id

lectures
├── live_classes.lecture_id
├── lecture_completions.lecture_id
├── lectures.required_quiz_id
└── quizzes.related_lecture_id

quizzes
├── questions.quiz_id
├── quiz_attempts.quiz_id
└── lectures.required_quiz_id

questions
├── user_answers.question_id
└── question_analytics.question_id

quiz_attempts
├── user_answers.attempt_id
└── question_analytics.attempt_id
```

### Constraint Checks

| Table | Column | Check Constraint |
|-------|--------|------------------|
| courses | is_premium | boolean |
| lectures | type | IN ('video', 'live', 'reading', 'practice') |
| live_classes | status | IN ('completed', 'upcoming', 'live') |
| course_materials | type | IN ('pdf', 'video', 'doc', 'image', 'other') |
| enrollments | status | IN ('active', 'completed', 'expired') |
| quizzes | difficulty_level | IN ('beginner', 'intermediate', 'advanced') |
| questions | question_data | Must contain 'type' key |
| questions | options | Must be JSON array |
| profiles | phone_number | Regex: `^\\+[1-9]\\d{1,14}$` |

---

## Row Level Security (RLS)

### Tables with RLS Enabled

| Table | Status | Description |
|-------|--------|-------------|
| profiles | ✅ Enabled | User profile data protection |
| courses | ✅ Enabled | Course visibility control |
| quizzes | ✅ Enabled | Public quiz access policies |
| questions | ✅ Enabled | Question content protection |
| quiz_attempts | ✅ Enabled | User attempt privacy |
| user_answers | ✅ Enabled | Answer data protection |
| question_analytics | ✅ Enabled | Analytics privacy |

### Tables with RLS Disabled

| Table | Reason |
|-------|--------|
| users | Internal user management |
| lectures | Public course content |
| live_classes | Public class schedule |
| enrollments | Backend-managed |
| lecture_completions | Backend-managed |
| course_materials | Public resources |

**Note:** RLS policies need to be reviewed and documented separately for each enabled table.

---

## Indexes & Performance

### Recommended Indexes

```sql
-- User lookups
CREATE INDEX idx_users_phone ON users(phone_number);
CREATE INDEX idx_users_email ON users(email);

-- Course queries
CREATE INDEX idx_courses_category ON courses(category);
CREATE INDEX idx_courses_is_premium ON courses(is_premium);
CREATE INDEX idx_courses_rating ON courses(rating DESC);

-- Enrollment lookups
CREATE INDEX idx_enrollments_user ON enrollments(user_id);
CREATE INDEX idx_enrollments_course ON enrollments(course_id);
CREATE INDEX idx_enrollments_status ON enrollments(status);

-- Lecture ordering
CREATE INDEX idx_lectures_course_order ON lectures(course_id, order_index);
CREATE INDEX idx_lectures_section ON lectures(section_id);

-- Quiz attempts
CREATE INDEX idx_quiz_attempts_user ON quiz_attempts(user_id);
CREATE INDEX idx_quiz_attempts_quiz ON quiz_attempts(quiz_id);
CREATE INDEX idx_quiz_attempts_completed ON quiz_attempts(is_completed);

-- Question lookups
CREATE INDEX idx_questions_quiz ON questions(quiz_id, question_number);

-- Live class scheduling
CREATE INDEX idx_live_classes_scheduled ON live_classes(scheduled_at);
CREATE INDEX idx_live_classes_status ON live_classes(status);
```

### Query Optimization Notes

1. **Course Listing** - Use `rating DESC` index for featured courses
2. **User Progress** - Join `enrollments` with `lecture_completions` using user_id
3. **Quiz Leaderboard** - Sort `quiz_attempts` by score DESC with percentile
4. **Content Filtering** - Use category + is_premium for course discovery

---

## Data Statistics

| Table | Rows | RLS | Notes |
|-------|------|-----|-------|
| users | 10 | ❌ | Active user accounts |
| profiles | 0 | ✅ | Auth-linked profiles (empty) |
| courses | 6 | ✅ | Live courses available |
| lectures | 64 | ❌ | Total lecture content |
| live_classes | 12 | ❌ | Scheduled sessions |
| enrollments | 16 | ❌ | Active enrollments |
| lecture_completions | 59 | ❌ | Progress records |
| course_materials | 16 | ❌ | Downloadable resources |
| quizzes | 7 | ✅ | Active quizzes |
| questions | 65 | ✅ | Quiz questions |
| quiz_attempts | 43 | ✅ | User attempts |
| user_answers | 211 | ✅ | Individual answers |
| question_analytics | 20 | ✅ | Analytics records |

**Total Active Users:** 10
**Total Course Content:** 6 courses × 64 lectures = 384 potential lesson combinations
**Quiz Participation:** 43 attempts across 7 quizzes

---

## API Considerations

### GraphQL Schema

Supabase auto-generates GraphQL schema from tables. Key queries:

```graphql
# Get all courses with lectures
query GetCourses {
  coursesCollection {
    edges {
      node {
        id
        title
        lectures(orderBy: { order_index: ASC }) {
          id
          title
          type
        }
      }
    }
  }
}

# Get user enrollments with progress
query GetUserEnrollments($userId: UUID!) {
  enrollmentsCollection(filter: { user_id: { eq: $userId } }) {
    edges {
      node {
        course {
          title
        }
        status
        last_accessed_at
      }
    }
  }
}
```

### REST API Endpoints

Supabase PostgREST automatically generates REST endpoints:

```
GET    /rest/v1/courses
GET    /rest/v1/courses?select=*,lectures(*)
GET    /rest/v1/enrollments?user_id=eq.{uuid}
POST   /rest/v1/quiz_attempts
PATCH  /rest/v1/lecture_completions?id=eq.{uuid}
```

---

## Future Enhancements

### Planned Tables

1. **`certificates`** - Generated certificates for completed courses
2. **`payments`** - Transaction history and billing
3. **`reviews`** - Course reviews and ratings
4. **`notifications`** - Push notifications and announcements
5. **`chat_messages`** - Community chat (batch-specific + global)
6. **`referrals`** - Referral tracking and rewards

### Schema Improvements

1. Add composite indexes for common query patterns
2. Implement database functions for complex calculations
3. Add triggers for automatic timestamp updates
4. Create views for common joined queries
5. Implement audit logging for sensitive operations

---

## Maintenance & Backup

### Recommended Practices

1. **Regular Backups** - Daily automated backups via Supabase
2. **Migration Versioning** - All schema changes via migrations
3. **Index Monitoring** - Check pg_stat_user_indexes weekly
4. **Query Performance** - Monitor pg_stat_statements
5. **RLS Policy Audits** - Monthly security review

### Performance Monitoring

```sql
-- Check table sizes
SELECT
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check slow queries
SELECT
  query,
  calls,
  total_exec_time,
  mean_exec_time,
  max_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;
```

---

## Contact & Support

**Database Administrator:** VidyaRas Dev Team
**Email:** support@vidyaras.com
**Documentation:** https://vidyaras.com/docs

---

**Document Version:** 1.0
**Last Updated:** 2025-01-02
**Next Review:** 2025-02-01
