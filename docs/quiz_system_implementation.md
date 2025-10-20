# Quiz System Implementation Guide

## Overview

This document describes the complete quiz system implementation for VidyaRas, supporting flexible content types (text, LaTeX, images) in both Hindi and English.

---

## 🗄️ Database Schema

### Tables Created

#### 1. **`courses`** Table
Stores course information for linking quizzes.

| Column | Type | Description |
|--------|------|-------------|
| `id` | UUID | Primary key |
| `title` | TEXT | Course title |
| `description` | TEXT | Course description |
| `thumbnail_url` | TEXT | Course thumbnail image |
| `category` | TEXT | Course category |
| `is_premium` | BOOLEAN | Premium/paid course flag |
| `price` | DECIMAL | Course price in INR |
| `created_at` | TIMESTAMPTZ | Creation timestamp |
| `updated_at` | TIMESTAMPTZ | Last update timestamp |

**RLS Policies:**
- ✅ Anyone can view courses
- ✅ Authenticated users can create/update courses

---

#### 2. **`quizzes`** Table
Stores quiz metadata with toggle options.

| Column | Type | Default | Description |
|--------|------|---------|-------------|
| `id` | UUID | gen_random_uuid() | Primary key |
| `title` | TEXT | - | Quiz title |
| `description` | TEXT | NULL | Quiz description |
| `course_id` | UUID | NULL | Links to course (NULL = standalone/public) |
| `full_marks` | INT | 100 | Total marks for quiz |
| `time_allotted_minutes` | INT | 30 | Time limit in minutes |
| `is_published` | BOOLEAN | **false** | **Toggle to show/hide quiz** |
| `is_public` | BOOLEAN | **true** | **true = free for all, false = paid users only** |
| `difficulty_level` | TEXT | NULL | 'beginner', 'intermediate', 'advanced' |
| `created_at` | TIMESTAMPTZ | now() | Creation timestamp |
| `updated_at` | TIMESTAMPTZ | now() | Last update timestamp |

**RLS Policies:**
- ✅ Anyone can view published quizzes (`is_published = true`)
- ✅ Authenticated users can view all quizzes (including unpublished)
- ✅ Authenticated users can create/update/delete quizzes

**Indexes:**
- `idx_quizzes_course_id` - For filtering by course
- `idx_quizzes_is_published` - For filtering published quizzes
- `idx_quizzes_is_public` - For filtering public/premium quizzes

---

#### 3. **`questions`** Table
Stores questions with flexible JSONB content.

| Column | Type | Description |
|--------|------|-------------|
| `id` | UUID | Primary key |
| `quiz_id` | UUID | Foreign key to quizzes (CASCADE delete) |
| `question_number` | INT | Question order (unique per quiz) |
| `question_data` | **JSONB** | **Flexible question content** |
| `options` | **JSONB** | **Array of option objects** |
| `correct_option_id` | INT | Index of correct option (0-based) |
| `explanation` | JSONB | Optional explanation |
| `marks` | INT | Marks for this question |
| `created_at` | TIMESTAMPTZ | Creation timestamp |
| `updated_at` | TIMESTAMPTZ | Last update timestamp |

**JSONB Structure:**

**question_data format:**
```json
{
  "type": "text|latex|image_url|video_url",
  "content": "actual content here"
}
```

**options format:**
```json
[
  {
    "id": 0,
    "data": {"type": "text", "content": "Option A"}
  },
  {
    "id": 1,
    "data": {"type": "latex", "content": "$x^2$"}
  },
  {
    "id": 2,
    "data": {"type": "image_url", "content": "https://..."}
  }
]
```

**Constraints:**
- ✅ `question_data` must have `type` and `content` fields
- ✅ `options` must be a JSON array
- ✅ `question_number` is unique within a quiz

**RLS Policies:**
- ✅ Users can view questions of published quizzes
- ✅ Authenticated users can view/create/update/delete all questions

---

#### 4. **`quiz_attempts`** Table
Tracks user quiz attempts.

| Column | Type | Description |
|--------|------|-------------|
| `id` | UUID | Primary key |
| `user_id` | UUID | Foreign key to auth.users |
| `quiz_id` | UUID | Foreign key to quizzes |
| `score` | INT | Final score achieved |
| `total_marks` | INT | Total possible marks |
| `percentage` | DECIMAL | **Auto-calculated** percentage |
| `time_taken_seconds` | INT | Time taken in seconds |
| `started_at` | TIMESTAMPTZ | When quiz started |
| `completed_at` | TIMESTAMPTZ | When quiz completed |
| `is_completed` | BOOLEAN | Completion status |
| `created_at` | TIMESTAMPTZ | Record creation time |

**Auto-calculated Fields:**
- `percentage` = (score / total_marks) * 100 (generated column)

**RLS Policies:**
- ✅ Users can only view/insert/update their own attempts

---

#### 5. **`user_answers`** Table
Stores individual answers for review.

| Column | Type | Description |
|--------|------|-------------|
| `id` | BIGSERIAL | Primary key |
| `attempt_id` | UUID | Foreign key to quiz_attempts |
| `question_id` | UUID | Foreign key to questions |
| `selected_option_id` | INT | Index of selected option |
| `is_correct` | BOOLEAN | Whether answer is correct |
| `marks_awarded` | INT | Marks awarded |
| `answered_at` | TIMESTAMPTZ | When answered |

**Constraints:**
- ✅ One answer per question per attempt (unique constraint)

**RLS Policies:**
- ✅ Users can only view/insert/update their own answers

---

## 📱 Flutter Implementation

### Domain Models (3_domain/models/)

#### 1. **ContentData**
```dart
@freezed
class ContentData with _$ContentData {
  const factory ContentData({
    required String type,     // 'text', 'latex', 'image_url', etc.
    required String content,  // The actual content
  }) = _ContentData;

  factory ContentData.text(String text) => ...;
  factory ContentData.latex(String latexString) => ...;
  factory ContentData.imageUrl(String url) => ...;
}
```

#### 2. **QuizOption**
```dart
@freezed
class QuizOption with _$QuizOption {
  const factory QuizOption({
    required int id,
    required ContentData data,
  }) = _QuizOption;
}
```

#### 3. **QuizQuestion**
```dart
@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String id,
    required String quizId,
    required int questionNumber,
    required ContentData questionData,
    required List<QuizOption> options,
    required int correctOptionId,
    ContentData? explanation,
    @Default(1) int marks,
  }) = _QuizQuestion;
}
```

#### 4. **Quiz**
```dart
@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String title,
    String? description,
    String? courseId,
    @Default(100) int fullMarks,
    @Default(30) int timeAllottedMinutes,
    @Default(false) bool isPublished,
    @Default(true) bool isPublic,
    String? difficultyLevel,
  }) = _Quiz;
}
```

#### 5. **QuizAttemptRecord**
```dart
@freezed
class QuizAttemptRecord with _$QuizAttemptRecord {
  const factory QuizAttemptRecord({
    required String id,
    required String userId,
    required String quizId,
    @Default(0) int score,
    required int totalMarks,
    double? percentage,
    int? timeTakenSeconds,
    required DateTime startedAt,
    DateTime? completedAt,
    @Default(false) bool isCompleted,
  }) = _QuizAttemptRecord;
}
```

#### 6. **UserAnswer**
```dart
@freezed
class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    required int id,
    required String attemptId,
    required String questionId,
    required int selectedOptionId,
    required bool isCorrect,
    @Default(0) int marksAwarded,
    required DateTime answeredAt,
  }) = _UserAnswer;
}
```

---

### Repository Interface (3_domain/repositories/)

**`quiz_repository.dart`**
```dart
abstract class QuizRepository {
  Future<Either<Failure, List<Quiz>>> getPublishedQuizzes({String? courseId});
  Future<Either<Failure, Quiz>> getQuizById(String quizId);
  Future<Either<Failure, List<QuizQuestion>>> getQuizQuestions(String quizId);
  Future<Either<Failure, QuizAttemptRecord>> createQuizAttempt({...});
  Future<Either<Failure, UserAnswer>> submitAnswer({...});
  Future<Either<Failure, QuizAttemptRecord>> completeQuizAttempt({...});
  Future<Either<Failure, List<QuizAttemptRecord>>> getUserQuizAttempts({...});
  Future<Either<Failure, List<UserAnswer>>> getUserAnswers(String attemptId);
}
```

---

### Repository Implementation (4_data/repositories/)

**`quiz_repository_impl.dart`**
- ✅ Uses Supabase client for all database operations
- ✅ Parses JSONB fields into domain models
- ✅ Handles errors with `Either<Failure, Success>` pattern
- ✅ Respects RLS policies

---

### UI Component (shared/presentation/components/)

**`ContentWidget`**
Renders any content type:

```dart
ContentWidget(
  contentData: question.questionData,
  textStyle: TextStyle(fontSize: 18),
)
```

**Supported Types:**
- ✅ `text` - Plain text (supports Hindi, English, any Unicode)
- ✅ `latex` - LaTeX math (displays with special formatting)
- ✅ `image_url` - Network images (cached)
- ⏳ `video_url` - Video placeholder (to be implemented)

---

## 🎯 Quiz Workflow

### 1. **Display Available Quizzes**
```dart
final quizzes = await quizRepository.getPublishedQuizzes();
// Only shows quizzes where is_published = true
```

### 2. **Start Quiz**
```dart
// Fetch questions
final questions = await quizRepository.getQuizQuestions(quizId);

// Create attempt record
final attempt = await quizRepository.createQuizAttempt(
  quizId: quizId,
  totalMarks: quiz.fullMarks,
);
```

### 3. **Answer Questions**
```dart
// For each answer
await quizRepository.submitAnswer(
  attemptId: attempt.id,
  questionId: question.id,
  selectedOptionId: selectedOption,
  isCorrect: selectedOption == question.correctOptionId,
  marksAwarded: isCorrect ? question.marks : 0,
);
```

### 4. **Complete Quiz**
```dart
final finalAttempt = await quizRepository.completeQuizAttempt(
  attemptId: attempt.id,
  score: totalScore,
  timeTakenSeconds: timeTaken,
);
// percentage is auto-calculated by database
```

### 5. **Review Answers**
```dart
final userAnswers = await quizRepository.getUserAnswers(attemptId);
final questions = await quizRepository.getQuizQuestions(quizId);
// Display side-by-side comparison
```

---

## 📊 Sample Data

### Sample Quiz Created:
**Title:** संगीत सिद्धांत - मूल बातें (Music Theory Basics)
- ✅ 5 questions with mixed content
- ✅ Hindi text questions
- ✅ LaTeX math questions
- ✅ Bilingual content
- ✅ Published and public

**Questions Include:**
1. Hindi music theory (text)
2. Math with fractions (LaTeX)
3. Music notation symbols (text)
4. Indian classical music (Hindi text)
5. Western music time signatures (English text)

---

## 🔐 Security Features

### Row Level Security (RLS)
- ✅ Users can only view their own quiz attempts
- ✅ Users can only view their own answers
- ✅ Published quizzes are public
- ✅ Unpublished quizzes only visible to authenticated users

### Data Validation
- ✅ JSONB structure validated at database level
- ✅ Question numbers unique per quiz
- ✅ One answer per question per attempt
- ✅ Foreign key constraints ensure data integrity

---

## 🚀 Next Steps

### To Run Code Generation:
```bash
cd vidyaras_app
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `*.freezed.dart` files for all new models
- `*.g.dart` files for JSON serialization

### To Add LaTeX Support:
Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_math_fork: ^0.7.1
```

Then update `ContentWidget` to use `Math.tex()` for LaTeX rendering.

### To Test:
1. Run the app
2. Navigate to Tests/Quiz section
3. Published quiz should appear
4. Click to start quiz
5. Answer questions with mixed content types
6. Submit and view results
7. Review answers with explanations

---

## 📝 Admin Operations

### Create a New Quiz:
```sql
INSERT INTO quizzes (title, description, full_marks, time_allotted_minutes, is_published, is_public)
VALUES ('Quiz Title', 'Description', 50, 30, true, true);
```

### Add Questions:
```sql
INSERT INTO questions (quiz_id, question_number, question_data, options, correct_option_id, marks)
VALUES (
  'quiz-id-here',
  1,
  '{"type": "text", "content": "Your question?"}',
  '[
    {"id": 0, "data": {"type": "text", "content": "Option A"}},
    {"id": 1, "data": {"type": "text", "content": "Option B"}}
  ]',
  0,
  1
);
```

### Toggle Quiz Visibility:
```sql
-- Hide quiz
UPDATE quizzes SET is_published = false WHERE id = 'quiz-id';

-- Show quiz
UPDATE quizzes SET is_published = true WHERE id = 'quiz-id';
```

### Make Quiz Premium:
```sql
UPDATE quizzes SET is_public = false WHERE id = 'quiz-id';
```

---

## 🎨 Content Type Examples

### Text (Hindi):
```json
{
  "type": "text",
  "content": "सेमी ब्रीव का एक-चौथाई होगा -"
}
```

### LaTeX (Math):
```json
{
  "type": "latex",
  "content": "$2\\frac{5}{9}$"
}
```

### Image:
```json
{
  "type": "image_url",
  "content": "https://your-supabase-url/storage/v1/object/public/quiz-images/diagram.png"
}
```

### Video (Future):
```json
{
  "type": "video_url",
  "content": "https://your-cdn.com/video.mp4"
}
```

---

## ✅ Summary

**Database:**
- ✅ 5 tables created with proper relationships
- ✅ RLS policies for security
- ✅ Flexible JSONB for mixed content
- ✅ Toggle options (is_published, is_public)
- ✅ Course linking support
- ✅ Sample data inserted

**Flutter:**
- ✅ 6 domain models with Freezed
- ✅ Repository interface defined
- ✅ Repository implementation with Supabase
- ✅ ContentWidget for rendering any content type
- ✅ Full workflow support (start → answer → complete → review)

**Ready for:**
- 🎯 Integration with existing quiz screens
- 🎯 Code generation with build_runner
- 🎯 LaTeX rendering integration
- 🎯 Admin dashboard development
- 🎯 Testing and deployment
