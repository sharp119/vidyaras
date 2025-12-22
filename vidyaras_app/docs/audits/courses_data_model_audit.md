# Courses Data Model Audit

**Date**: 2025-12-22  
**Source of Truth**: [vidyaras.sql](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/vidyaras.sql)  
**Scope**: Comparison between SQL schema and Flutter app data models

---

## Executive Summary

The app's current courses data model has **significant discrepancies** from the SQL schema (source of truth). The main issues are:

1. **Shows archived courses** - No filtering by `status` field
2. **Incorrect `isFree` logic** - Uses only `is_premium` instead of proper price/status checks
3. **Missing critical database fields** in app models
4. **Inconsistent data mapping** across different datasources

---

## SQL Schema Definition (Source of Truth)

### `courses` Table Structure (Lines 433-463)

| Column | Type | Default | Description |
|--------|------|---------|-------------|
| `id` | uuid | gen_random_uuid() | Primary key |
| `title` | text | NOT NULL | Course title |
| `description` | text | - | Course description |
| `thumbnail_url` | text | - | Course thumbnail |
| `category` | text | - | Course category |
| `is_premium` | boolean | false | Requires paid subscription |
| `price` | numeric(10,2) | - | Price in INR (null if free) |
| `created_at` | timestamp | now() | Creation timestamp |
| `updated_at` | timestamp | now() | Last update timestamp |
| `instructor` | text | - | Instructor name |
| `rating` | numeric(2,1) | 0.0 | Course rating |
| `review_count` | integer | 0 | Number of reviews |
| `enrolled_count` | integer | 0 | Number of enrollments |
| `duration` | text | - | Course duration |
| `is_live` | boolean | false | Has live sessions |
| `is_recorded` | boolean | false | Has recorded lectures |
| `has_free_trial` | boolean | false | Has free trial |
| `language` | text | 'Bilingual (Hindi + English)' | Course language |
| `has_certificate` | boolean | true | Certificate available |
| `has_quizzes` | boolean | true | Has quizzes |
| `has_materials` | boolean | true | Has materials |
| `access_days` | integer | - | Days of access (null = lifetime) |
| **`status`** | text | 'draft' | **CRITICAL: 'draft', 'published', 'archived'** |
| `created_by` | uuid | - | Creator user ID |
| `what_you_learn` | text[] | {} | Learning outcomes array |
| `course_includes` | text[] | {} | Course inclusions array |
| `prerequisites` | text[] | {} | Prerequisites array |
| `original_price` | numeric | - | Original price (for discounts) |

---

## Critical Discrepancies

### 1. ❌ Missing `status` Filtering (HIGH SEVERITY)

> [!CAUTION]
> **The app shows ALL courses including `draft` and `archived` courses!**

**SQL Schema**: Has a `status` field with values: `'draft'`, `'published'`, `'archived'`

**App Implementation**: No filtering whatsoever.

#### Affected Files:
- [courses_remote_datasource.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/courses/4_data/datasources/courses_remote_datasource.dart) - `getAllCourses()`, `searchCourses()`, `getCoursesByCategory()`
- [home_remote_datasource.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/home/4_data/datasources/home_remote_datasource.dart) - `getFeaturedCourses()`, `getCourseDetail()`

#### Current Code (Line 16-19 in courses_remote_datasource.dart):
```dart
final response = await _supabase
    .from('courses')
    .select()
    .order('created_at', ascending: false);
```

#### Expected Code:
```dart
final response = await _supabase
    .from('courses')
    .select()
    .eq('status', 'published')  // ADD THIS FILTER
    .order('created_at', ascending: false);
```

---

### 2. ❌ Incorrect `isFree` Logic (HIGH SEVERITY)

> [!WARNING]
> **The `isFree` field is computed incorrectly and inconsistently.**

**SQL Schema Logic**: A course is free when:
- `is_premium` = false, AND
- `price` is NULL or 0

**App Implementation Variations**:

#### In `getAllCourses()` (Lines 42-46):
```dart
isFree:
    courseData['is_premium'] == false ||
    courseData['price'] == null ||
    courseData['price'] == '0' ||
    courseData['price'] == '0.00',
```
> ⚠️ Uses OR instead of proper logic

#### In `searchCourses()` (Line 94):
```dart
isFree: courseData['is_premium'] == false,
```
> ⚠️ Only checks `is_premium`, ignores price

#### In `getCoursesByCategory()` (Line 142):
```dart
isFree: courseData['is_premium'] == false,
```
> ⚠️ Same incomplete logic

#### Expected Logic:
```dart
// Course is free if NOT premium AND price is null/zero
isFree: courseData['is_premium'] == false && 
        (courseData['price'] == null || 
         courseData['price'] == 0 || 
         courseData['price'] == '0.00'),
```

---

### 3. ❌ Missing `status` Field in Course Model

**SQL Schema**: Has `status` field

**App Model** ([course.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/home/3_domain/models/course.dart)):
```dart
@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String title,
    required String instructor,
    String? thumbnailUrl,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int enrolledCount,
    String? price,
    String? duration,
    @Default(false) bool isFree,
    @Default(false) bool isLive,
    @Default(false) bool hasFreeTrial,
    @Default(false) bool isRecorded,
    double? progress,
    List<String>? categories,
    DateTime? createdAt,
  }) = _Course;
  // ...
}
```

**Missing Fields**:
- `status` (draft/published/archived)
- `description`
- `language`
- `hasCertificate`
- `hasQuizzes`
- `hasMaterials`
- `originalPrice`
- `createdBy`
- `updatedAt`

---

### 4. ⚠️ `category` vs `categories` Mismatch (MEDIUM SEVERITY)

**SQL Schema**: Single `category` field (text)

**App Model**: `List<String>? categories` (array)

**Current Mapping** (Lines 50-52 in courses_remote_datasource.dart):
```dart
categories: courseData['category'] != null
    ? [courseData['category'] as String]
    : [],
```

This is a workaround but creates confusion. The model should match the DB schema.

---

### 5. ⚠️ Price Handling Inconsistencies (MEDIUM SEVERITY)

**SQL Schema**: `price` is `numeric(10,2)` (a number)

**App Model**: `price` is `String?`

**Issues**:
1. Price is formatted with `₹` prefix in datasource, not in presentation layer
2. Comparison logic treats price as string: `courseData['price'] == '0'`
3. Original price field (`original_price`) is not used for discount display

---

### 6. ⚠️ Duplicate SectionInfo Models (MEDIUM SEVERITY)

Two different `SectionInfo` models exist:

#### Home Feature ([home/3_domain/models/section_info.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/home/3_domain/models/section_info.dart)):
```dart
class SectionInfo {
  required String id,
  required String title,
  required List<LessonItem> lessons,
  int? totalDurationMinutes,
}
```

#### MyLearning Feature ([my_learning/3_domain/models/section_info.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/my_learning/3_domain/models/section_info.dart)):
```dart
class SectionInfo {
  required String id,
  required String title,
  @Default(0) int totalDurationMinutes,
  @Default(0) int lectureCount,
  @Default(0) int completedCount,
}
```

These should be consolidated or clearly differentiated.

---

### 7. ⚠️ CourseMaterial `section_id` vs `module_id` (LOW SEVERITY)

**SQL Schema** ([course_materials table](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/vidyaras.sql#L409-L419)):
```sql
"section_id" "text",  -- Optional: which section this material belongs to
```

**App Model** ([course_material.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/my_learning/3_domain/models/course_material.dart)):
```dart
String? moduleId,  // Uses moduleId instead of sectionId
```

**Datasource Mapping** (Line 442 in my_learning_remote_datasource.dart):
```dart
moduleId: data['module_id'] as String?,  // Wrong field name
```

The SQL schema uses `section_id` but the app reads `module_id`.

---

## Summary Table

| Issue | Severity | Location | Impact |
|-------|----------|----------|--------|
| No `status` filtering | 🔴 HIGH | All datasources | Shows draft/archived courses |
| Incorrect `isFree` logic | 🔴 HIGH | courses_remote_datasource.dart | Wrong free course display |
| Missing `status` in model | 🟠 MEDIUM | course.dart | Can't filter/display status |
| `category` vs `categories` | 🟠 MEDIUM | course.dart | Model-DB mismatch |
| Price as string | 🟠 MEDIUM | course.dart | Formatting issues |
| Duplicate SectionInfo | 🟠 MEDIUM | home/, my_learning/ | Code duplication |
| section_id vs module_id | 🟡 LOW | course_material.dart | Wrong field mapping |

---

## Recommended Fixes

### Priority 1 (Critical)
1. Add `.eq('status', 'published')` filter to ALL course queries
2. Fix `isFree` logic to use proper AND conditions

### Priority 2 (Important)  
3. Add missing fields to `Course` model (`status`, `description`, etc.)
4. Fix `category` to be single string, not array
5. Change `price` to `double?` and format in UI layer

### Priority 3 (Cleanup)
6. Consolidate `SectionInfo` models
7. Fix `section_id` vs `module_id` field name

---

## Files To Modify

1. [course.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/home/3_domain/models/course.dart) - Add missing fields
2. [courses_remote_datasource.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/courses/4_data/datasources/courses_remote_datasource.dart) - Add status filter, fix isFree
3. [home_remote_datasource.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/home/4_data/datasources/home_remote_datasource.dart) - Add status filter
4. [my_learning_remote_datasource.dart](file:///Users/g2m7/projects/cross/vidyaras/vidyaras_app/lib/src/features/my_learning/4_data/datasources/my_learning_remote_datasource.dart) - Fix field mappings
