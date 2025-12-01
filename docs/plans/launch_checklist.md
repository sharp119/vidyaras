# VidyaRas Public Launch - Implementation Checklist

**Goal:** Get dashboard and app production-ready for public launch
**Timeline:** 12 weeks
**Check off (✅) tasks as completed**

**Reference:** See `launch_fsd.md` for detailed feature specifications

---

## 📊 PROGRESS SUMMARY (Updated: 2024-11-23)

### Dashboard UI Status: ✅ 100% COMPLETE

All dashboard UI components are built and connected to local state management (React Context + localStorage).

| Module | UI Status | Context Integration |
|--------|-----------|---------------------|
| Course Management | ✅ Complete | ✅ CoursesContext |
| Module/Lesson Manager | ✅ Complete | ✅ CoursesContext |
| Lecture/Material Manager | ✅ Complete | ✅ CoursesContext |
| Quiz Builder & List | ✅ Complete | ✅ QuizzesContext |
| Quiz Preview | ✅ Complete | ✅ QuizzesContext |
| Student List & Detail | ✅ Complete | ✅ StudentsContext |
| Enrollment & Payment | ✅ Complete | ✅ StudentsContext |
| Live Sessions | ✅ Complete | ✅ LiveSessionsContext |
| Progress Reports | ✅ Complete | Basic UI |
| Revenue Reports | ✅ Complete | Basic UI |
| Settings | ✅ Complete | Basic UI |
| Theme (Light/Dark) | ✅ Complete | ThemeProvider |

### Remaining Work for Launch

| Phase | Status | What's Left |
|-------|--------|-------------|
| Phase 1: Database & API | ❌ 0% | Supabase setup, API endpoints, Auth |
| Phase 2-6: API Integration | ❌ 0% | Connect UI to real API endpoints |
| Phase 7: Reports API | ❌ 0% | Real data aggregation |
| Phase 8: App Integration | ❌ 0% | Flutter app API connection |
| Phase 9: Testing | ⚠️ 30% | E2E testing, security review |
| Phase 10-11: Deployment | ❌ 0% | Vercel, Supabase prod, Play Store |

### Next Steps (Priority Order)

1. **Set up Supabase database** - Create all tables from schema
2. **Build API layer** - Create endpoints for each module
3. **Connect UI to API** - Replace context localStorage with API calls
4. **Authentication** - Implement login/logout with Supabase Auth
5. **File uploads** - Thumbnails, materials to Supabase Storage

---

## PHASE 1: Database Schema & API Foundation (Week 1-2)

### Database Schema Setup
- [ ] Create `users` table in Supabase
- [ ] Create `courses` table with all fields
- [ ] Create `modules` table with course relationship
- [ ] Create `lessons` table with module relationship
- [ ] Create `lectures` table with lesson relationship
- [ ] Create `materials` table with lesson relationship
- [ ] Create `quizzes` table
- [ ] Create `quiz_questions` table with JSONB support
- [ ] Create `enrollments` table with constraints
- [ ] Create `lecture_completions` table
- [ ] Create `quiz_attempts` table
- [ ] Create `user_answers` table
- [ ] Add all indexes for performance
- [ ] Set up RLS policies (basic - refine later)

### Supabase Storage Buckets
- [ ] Create `course-thumbnails` bucket (public)
- [ ] Create `quiz-images` bucket (public)
- [ ] Create `materials` bucket (private/authenticated)
- [ ] Create `user-avatars` bucket (public)
- [ ] Configure bucket policies

### Next.js API Structure
- [ ] Set up `/api` directory structure
- [ ] Create Supabase client (server-side)
- [ ] Implement auth middleware for API routes
- [ ] Create role-based access control utils
- [ ] Set up error handling middleware
- [ ] Create response standardization utils

### Authentication
- [ ] Implement session validation
- [ ] Create `/api/auth/verify` endpoint
- [ ] Add role extraction from JWT
- [ ] Test admin/teacher/student access control

### File Upload Infrastructure
- [ ] Create `/api/upload/thumbnail` endpoint
- [ ] Create `/api/upload/quiz-image` endpoint
- [ ] Create `/api/upload/material` endpoint
- [ ] Add file validation (type, size)
- [ ] Test upload to Supabase Storage

---

## PHASE 2: Course Management (Week 3-4)

### Course API Endpoints
- [ ] `POST /api/courses` - Create course
- [ ] `PUT /api/courses/:id` - Update course
- [ ] `GET /api/courses` - List courses (with filters)
- [ ] `GET /api/courses/:id` - Get course details
- [ ] `DELETE /api/courses/:id` - Delete course (soft delete)
- [ ] Add validation for all endpoints
- [ ] Test with Postman/Thunder Client

### Dashboard: Complete Course Builder
- [ ] Integrate thumbnail upload with Supabase Storage
- [ ] Connect form to `POST /api/courses` endpoint
- [x] Add loading states during API calls
- [x] Add error handling & toast notifications
- [x] Add "Save as Draft" vs "Publish" buttons
- [ ] Implement edit mode (load existing course data)
- [ ] Test create flow end-to-end
- [ ] Test edit flow end-to-end
- [x] **UI COMPLETE:** Course Builder with step wizard (Basic Info, Content, Pricing, Curriculum, Review)
- [x] **UI COMPLETE:** Connected to CoursesContext for local state management

### Dashboard: Course List Page
- [x] Create course list page (`/courses`)
- [x] Display all courses with thumbnails
- [x] Add search/filter functionality
- [x] Add "Edit" button → Opens Course Builder
- [x] Add "Delete" button with confirmation
- [x] Add "Publish/Unpublish" toggle
- [x] Show course statistics (enrollments, etc.)
- [x] **UI COMPLETE:** Connected to CoursesContext for local state management

---

## PHASE 3: Module & Lesson Management (Week 4-5)

### Module API Endpoints
- [ ] `POST /api/courses/:courseId/modules` - Create module
- [ ] `PUT /api/modules/:id` - Update module
- [ ] `DELETE /api/modules/:id` - Delete module
- [ ] `PUT /api/modules/reorder` - Reorder modules
- [ ] Add validation
- [ ] Test endpoints

### Dashboard: Module Manager
- [x] Create Module Manager page (`/courses/:id/modules`)
- [x] Display modules in order
- [x] Add "Add Module" form
- [x] Implement edit module (inline or modal)
- [x] Implement delete module (with confirmation)
- [ ] Implement drag-drop reordering
- [ ] Save reordering to API
- [ ] Test all CRUD operations
- [x] **UI COMPLETE:** Connected to CoursesContext for local state management

### Lesson API Endpoints
- [ ] `POST /api/modules/:moduleId/lessons` - Create lesson
- [ ] `PUT /api/lessons/:id` - Update lesson
- [ ] `DELETE /api/lessons/:id` - Delete lesson
- [ ] `PUT /api/lessons/:id/set-current` - Mark as current (live)
- [ ] `PUT /api/lessons/:id/set-live` - Toggle live status
- [ ] `PUT /api/lessons/reorder` - Reorder lessons
- [ ] Add validation
- [ ] Test endpoints

### Dashboard: Lesson Manager
- [x] Create Lesson Manager (within Module Manager)
- [x] Display lessons under each module
- [x] Add "Add Lesson" form
- [x] Implement edit lesson
- [x] Implement delete lesson
- [ ] Add "Mark as Current" button (live courses only)
- [ ] Add "Set Live/Not Live" toggle (live courses only)
- [ ] Implement drag-drop reordering
- [ ] Test all operations
- [x] **UI COMPLETE:** Connected to CoursesContext for local state management

---

## PHASE 4: Lecture & Material Management (Week 5-6)

### Lecture API Endpoints
- [ ] `POST /api/lessons/:lessonId/lectures` - Create lecture
- [ ] `PUT /api/lectures/:id` - Update lecture
- [ ] `DELETE /api/lectures/:id` - Delete lecture
- [ ] `PUT /api/lectures/reorder` - Reorder lectures
- [ ] Add validation (URL format, required fields)
- [ ] Test endpoints

### Dashboard: Lecture Manager
- [x] Create Lecture Manager (within Lesson)
- [x] Display lectures under each lesson
- [x] Add "Add Recorded Lecture" form
  - [x] Title & description inputs
  - [x] Google Drive URL input with validation
  - [x] Duration input
  - [x] Quiz prerequisite selector
- [x] Add "Add Live Lecture" form
  - [x] Title & description inputs
  - [x] Live class URL input
  - [x] Scheduled time picker
  - [x] Quiz prerequisite selector
- [x] Implement edit lecture (all fields)
- [ ] Add "Add Recording" option (for past live lectures)
- [x] Implement delete lecture
- [ ] Implement drag-drop reordering
- [ ] Test all operations
- [x] **UI COMPLETE:** Connected to CoursesContext for local state management

### Material API Endpoints
- [ ] `POST /api/lessons/:lessonId/materials` - Upload material
- [ ] `DELETE /api/materials/:id` - Delete material
- [ ] Add file validation (PDF, size limits)
- [ ] Test endpoints

### Dashboard: Material Manager
- [x] Create Material Manager (within Lesson)
- [x] Display materials under each lesson
- [x] Add "Upload Material" form
  - [x] File upload input
  - [x] Title input
  - [ ] Upload progress indicator
- [x] Show material preview (filename, size)
- [x] Implement delete material
- [ ] Test upload flow end-to-end
- [x] **UI COMPLETE:** Connected to CoursesContext for local state management

---

## PHASE 5: Quiz System (Week 6-7)

### Quiz API Endpoints
- [ ] `POST /api/quizzes` - Create quiz
- [ ] `PUT /api/quizzes/:id` - Update quiz
- [ ] `GET /api/quizzes` - List quizzes (with filters)
- [ ] `GET /api/quizzes/:id` - Get quiz with questions
- [ ] `DELETE /api/quizzes/:id` - Delete quiz
- [ ] `POST /api/quizzes/:id/questions` - Add question
- [ ] `PUT /api/questions/:id` - Update question
- [ ] `DELETE /api/questions/:id` - Delete question
- [ ] Add validation for ContentData structure
- [ ] Test all endpoints

### Dashboard: Quiz Builder
- [x] Create Quiz Builder page (`/quizzes/create`)
- [x] Quiz metadata form (title, description, settings)
- [x] Add difficulty selector
- [x] Add time limit input
- [x] Add passing marks input
- [x] Add "Is Published" toggle
- [x] Add "Is Public" toggle
- [x] Implement question editor:
  - [x] Content type selector (text/LaTeX/image)
  - [x] Text input for text content
  - [ ] LaTeX preview for LaTeX content
  - [ ] Image upload for image content
  - [x] 4 option inputs (each with content type)
  - [x] Correct answer selector (radio buttons)
  - [x] Explanation input (optional, with content type)
  - [x] Marks input per question
- [x] Add question list (reorderable)
- [x] Implement edit question (inline or modal)
- [x] Implement delete question
- [ ] Save quiz to API
- [ ] Test create flow end-to-end
- [x] **UI COMPLETE:** Connected to QuizzesContext for local state management

### Dashboard: Quiz List Page
- [x] Create quiz list page (`/quizzes`)
- [x] Display all quizzes
- [x] Add search/filter functionality
- [x] Add "Edit" button → Opens Quiz Builder
- [x] Add "Delete" button with confirmation
- [x] Add "Publish/Unpublish" toggle
- [x] Show quiz statistics (attempts, avg score)
- [x] **UI COMPLETE:** Connected to QuizzesContext for local state management

### Dashboard: Quiz Preview
- [x] Create quiz preview page
- [x] Render questions with content types
- [x] Show correct answers (teacher view)
- [x] Show explanations
- [x] **UI COMPLETE:** Connected to QuizzesContext for local state management

---

## PHASE 6: Student & Enrollment Management (Week 8)

### Student API Endpoints
- [ ] `GET /api/students` - List students (admin only)
- [ ] `GET /api/students/:id` - Student details (admin only)
- [ ] `PUT /api/students/:id` - Update student (admin only)
- [ ] `GET /api/students/:id/enrollments` - Student enrollments
- [ ] Add admin-only middleware
- [ ] Test endpoints

### Dashboard: Student List Page (Admin)
- [x] Create student list page (`/students`)
- [x] Display all students with avatar, name, phone
- [x] Add search functionality
- [x] Show enrollment count per student
- [x] Click student → View details
- [x] **UI COMPLETE:** Connected to StudentsContext for local state management

### Dashboard: Student Detail Page (Admin)
- [x] Create student detail page (`/students/:id`)
- [x] Display student info (editable)
- [x] Show enrolled courses list
- [x] Show payment status per course
- [x] Add "Enroll in Course" button
- [x] **UI COMPLETE:** Connected to StudentsContext for local state management

### Enrollment API Endpoints
- [ ] `POST /api/enrollments` - Manual enrollment (admin)
- [ ] `POST /api/enrollments/self-enroll` - Self-enroll (student, free only)
- [ ] `DELETE /api/enrollments/:id` - Remove enrollment (admin)
- [ ] `PUT /api/enrollments/:id/payment` - Update payment status (admin)
- [ ] Add validation & access control
- [ ] Test endpoints

### Dashboard: Enrollment Manager
- [x] Create enrollment form (within student detail)
- [x] Course selector
- [x] Enrollment type selector (free/paid)
- [x] Payment status selector (if paid)
- [x] Amount paid input
- [ ] Save enrollment to API
- [ ] Test enrollment flow
- [x] **UI COMPLETE:** EnrollStudentModal connected to StudentsContext & CoursesContext

### Dashboard: Payment Tracking
- [x] Add payment status column to enrollments list
- [x] Add "Mark as Paid" button
- [x] Add "Mark as Pending" button
- [ ] Update payment status via API
- [ ] Show payment history (if tracking over time)
- [x] **UI COMPLETE:** RecordPaymentModal connected to StudentsContext

### Dashboard: Live Sessions Management (BONUS - Not in original spec)
- [x] Create Live Sessions page (`/sessions`)
- [x] Display upcoming and past sessions
- [x] Add "Schedule Session" modal
- [x] Course linking in session
- [x] Delete session functionality
- [x] **UI COMPLETE:** Connected to LiveSessionsContext for local state management

---

## PHASE 7: Progress Reports & Teacher Tools (Week 9)

### Report API Endpoints
- [ ] `GET /api/reports/course/:courseId` - Course progress report
- [ ] `GET /api/reports/student/:studentId` - Student progress report
- [ ] `GET /api/reports/quiz/:quizId` - Quiz report (all attempts)
- [ ] Add aggregation logic (completion rates, averages)
- [ ] Test endpoints

### Dashboard: Course Progress Report
- [ ] Create course report page (`/reports/course/:id`)
- [ ] Show enrolled students list
- [ ] Show progress percentage per student
- [ ] Show completed lectures count
- [ ] Show quiz scores per student
- [ ] Add export to CSV button (optional)

### Dashboard: Student Progress Report
- [ ] Create student report page (`/reports/student/:id`)
- [ ] Show all enrolled courses
- [ ] Show progress per course
- [ ] Show lecture completion timeline
- [ ] Show quiz attempts & scores

### Quiz Attempt API Endpoints
- [ ] `GET /api/quiz-attempts/:attemptId` - Get attempt details
- [ ] `PUT /api/quiz-attempts/:attemptId/notes` - Add teacher notes
- [ ] Test endpoints

### Dashboard: Quiz Attempt Viewer
- [ ] Create quiz attempt viewer page (`/quiz-attempts/:id`)
- [ ] Show student info
- [ ] Show quiz title & score
- [ ] Show all questions with student answers
- [ ] Highlight correct/incorrect answers
- [ ] Show explanations
- [ ] Add teacher notes textarea
- [ ] Save teacher notes via API
- [ ] Test feedback flow

---

## PHASE 8: App API Integration (Week 10-11)

### App: Replace Supabase Direct Calls

#### Authentication Module
- [ ] Update auth to use `/api/auth/verify`
- [ ] Store JWT token in secure storage
- [ ] Add token to all API requests

#### Home/Browse Courses
- [ ] Replace course fetching with `GET /api/courses`
- [ ] Test course list display
- [ ] Replace course detail fetching with `GET /api/courses/:id`
- [ ] Test course detail display

#### Enrollment Flow
- [ ] Replace self-enrollment with `POST /api/enrollments/self-enroll`
- [ ] Test free course enrollment
- [ ] Show "Request Enrollment" for paid courses
- [ ] Test paid course enrollment request

#### My Learning Module
- [ ] Replace enrolled courses fetching with `GET /api/my-learning`
- [ ] Test my learning screen
- [ ] Replace course content fetching with `GET /api/courses/:id/content`
- [ ] Test course content display (modules, lessons, lectures)

#### Lecture Completion
- [ ] Replace completion tracking with `POST /api/lectures/:id/complete`
- [ ] Test lecture completion
- [ ] Verify progress updates

#### Quiz System
- [ ] Replace quiz fetching with `GET /api/quizzes/:id`
- [ ] Test quiz display (text, LaTeX, images)
- [ ] Replace quiz attempt with `POST /api/quiz-attempts`
- [ ] Test quiz attempt creation
- [ ] Replace answer submission with `POST /api/quiz-attempts/:id/submit`
- [ ] Test quiz submission
- [ ] Replace result fetching with `GET /api/quiz-attempts/:id/results`
- [ ] Test result display

#### Material Download
- [ ] Replace material fetching with authenticated Supabase Storage URLs
- [ ] Test material download

#### Live Class Join
- [ ] Test live class link opening
- [ ] Verify "Join Class" button functionality

### App: Testing & Bug Fixes
- [ ] Test all student workflows end-to-end
- [ ] Test on multiple Android devices
- [ ] Fix UI/UX issues
- [ ] Fix API integration bugs
- [ ] Test offline behavior (graceful errors)
- [ ] Test loading states
- [ ] Test error states

---

## PHASE 9: Dashboard Polish & Testing (Week 11)

### Dashboard UI/UX Polish
- [x] Consistent styling across all pages
- [x] Responsive layout (desktop focus, mobile basic)
- [x] Loading states for all API calls
- [x] Error handling & user feedback
- [x] Success messages & toasts
- [x] Confirmation dialogs for delete operations
- [x] Form validation & error messages
- [ ] Accessibility basics (keyboard navigation, labels)
- [x] **COMPLETE:** Light/Dark theme toggle
- [x] **COMPLETE:** Centralized styling in index.css
- [x] **COMPLETE:** shadcn/ui component library integration

### Dashboard Testing
- [ ] Test all teacher workflows end-to-end
- [ ] Test all admin workflows end-to-end
- [ ] Test edge cases (empty states, long text, special characters)
- [ ] Test file uploads (various sizes, formats)
- [ ] Test concurrent operations (multiple tabs)
- [ ] Cross-browser testing (Chrome, Firefox, Safari)
- [ ] Performance testing (large datasets)

### Security Review
- [ ] Verify all API endpoints have auth middleware
- [ ] Verify role-based access control works
- [ ] Test for SQL injection vulnerabilities
- [ ] Test for XSS vulnerabilities
- [ ] Verify file upload restrictions
- [ ] Check for sensitive data exposure in API responses
- [ ] Review Supabase RLS policies

---

## PHASE 10: Pre-Launch Prep (Week 12)

### Content Preparation
- [ ] Teachers create 5-10 test courses
- [ ] Add modules, lessons, lectures to test courses
- [ ] Upload test materials
- [ ] Create 20+ test quizzes
- [ ] Publish courses

### User Acceptance Testing
- [ ] Recruit 3-5 teachers for testing
- [ ] Recruit 10-20 students for testing
- [ ] Collect feedback
- [ ] Fix critical bugs
- [ ] Iterate on UX issues

### Documentation
- [ ] Write teacher onboarding guide
- [ ] Write admin user manual
- [ ] Create video tutorials (optional)
- [ ] Document API for future development

### Deployment Setup

#### Dashboard Deployment
- [ ] Set up hosting (Vercel recommended for Next.js)
- [ ] Configure environment variables
- [ ] Set up custom domain (optional)
- [ ] Configure HTTPS
- [ ] Test deployed dashboard
- [ ] Set up error monitoring (Sentry, etc.)

#### Supabase Production
- [ ] Create production Supabase project
- [ ] Run database migrations
- [ ] Set up storage buckets
- [ ] Configure RLS policies
- [ ] Set up backups

#### App Deployment
- [ ] Update API base URL in app config
- [ ] Build production APK
- [ ] Test APK on multiple devices
- [ ] Create Play Store listing
  - [ ] App screenshots
  - [ ] App description
  - [ ] Privacy policy
  - [ ] Terms of service
- [ ] Submit to Play Store
- [ ] Wait for approval

### Launch Monitoring
- [ ] Set up analytics (Google Analytics, Mixpanel, etc.)
- [ ] Set up error tracking for app (Crashlytics)
- [ ] Set up uptime monitoring for dashboard
- [ ] Create admin dashboard for key metrics
- [ ] Set up alerts for critical errors

---

## PHASE 11: Launch Day 🚀

### Pre-Launch Checklist (Day Before)
- [ ] Final smoke test of all features
- [ ] Verify all environment variables
- [ ] Check database connections
- [ ] Verify file uploads working
- [ ] Test app downloads from Play Store
- [ ] Notify teachers & early users

### Launch Day Tasks
- [ ] Monitor error logs closely
- [ ] Monitor user signups
- [ ] Monitor course enrollments
- [ ] Be ready for immediate bug fixes
- [ ] Collect user feedback
- [ ] Post on social media (if applicable)

### Week 1 Post-Launch
- [ ] Daily error log review
- [ ] Daily user feedback review
- [ ] Quick bug fixes for critical issues
- [ ] Monitor performance metrics
- [ ] Support teachers with onboarding
- [ ] Gather feature requests for v2

---

## Success Criteria

### Minimum Launch Requirements (Must Have):
- ✅ 5+ published courses
- ✅ All course management features working
- ✅ All quiz features working
- ✅ Student enrollment working (free & paid)
- ✅ Progress tracking working
- ✅ App connected to API successfully
- ✅ No critical bugs

### Nice to Have (Can Defer):
- 📊 Advanced analytics
- 📧 Email notifications
- 🔔 Push notifications
- 💳 Automated payment gateway

---

## Critical Path Items (Cannot Launch Without)

1. **Course Builder** - Teachers must be able to create courses
2. **Lesson/Lecture Manager** - Teachers must add content
3. **Quiz Builder** - Teachers must create quizzes
4. **Student Enrollment** - Students must be able to enroll
5. **App API Integration** - App must work with new API
6. **Play Store Approval** - App must be downloadable

---

## Risk Mitigation

### High Risk Items:
1. **Play Store Approval Delay**
   - Mitigation: Submit 1 week before launch date
   - Backup: Distribute APK directly if needed

2. **API Performance Issues**
   - Mitigation: Load test before launch
   - Backup: Implement caching, optimize queries

3. **Teacher Onboarding Friction**
   - Mitigation: Create detailed guides + video tutorials
   - Backup: Offer 1-on-1 onboarding sessions

4. **Student App Bugs**
   - Mitigation: Thorough testing with real users
   - Backup: Have hotfix process ready

---

## Notes

- Check off items as you complete them
- Update timeline if needed (realistic estimates)
- Focus on critical path items first
- Don't get blocked on nice-to-haves
- Test continuously, don't wait until the end
- Get user feedback early and often

**Remember:** Done is better than perfect for v1. Ship it, learn, iterate! 🚀
