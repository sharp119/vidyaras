# VidyaRas Dashboard - Launch Checklist

**Goal:** Dashboard ready to manage app features for public launch

**Current App Features:** Auth, Courses, Lectures, Live Classes, Materials, Quizzes (with text/LaTeX/image), Enrollments, Progress Tracking

---

## Phase 1: API Layer (Unified for Dashboard & App)

### 1.1 Database Schema
- [ ] Create `admin_roles` table (id, user_id, role, is_active)
- [ ] Create `teacher_assignments` table (id, teacher_id, course_id, is_active)
- [ ] Add RLS policies for admin/teacher access
- [ ] Add indexes on user_id, course_id, role columns
- [ ] Generate TypeScript types from schema

### 1.2 API Architecture Setup
- [ ] Create Next.js API routes structure (`/api/v1/...`)
- [ ] Set up Supabase client for API routes (server-side)
- [ ] Create middleware for auth verification
- [ ] Create RBAC permission checker utility
- [ ] Set up error handling middleware

### 1.3 Courses API
- [ ] `GET /api/v1/courses` - List all courses (public: published only, admin: all)
- [ ] `GET /api/v1/courses/:id` - Get course details with lectures
- [ ] `POST /api/v1/courses` - Create course (admin only)
- [ ] `PUT /api/v1/courses/:id` - Update course (admin/assigned teacher)
- [ ] `DELETE /api/v1/courses/:id` - Delete course (admin only)
- [ ] `PATCH /api/v1/courses/:id/publish` - Publish/unpublish (admin only)

### 1.4 Lectures API
- [ ] `GET /api/v1/courses/:courseId/lectures` - List lectures by course
- [ ] `GET /api/v1/lectures/:id` - Get lecture details
- [ ] `POST /api/v1/lectures` - Create lecture (admin/teacher)
- [ ] `PUT /api/v1/lectures/:id` - Update lecture (admin/teacher)
- [ ] `DELETE /api/v1/lectures/:id` - Delete lecture (admin/teacher)
- [ ] `PATCH /api/v1/lectures/reorder` - Reorder lectures (admin/teacher)

### 1.5 Live Classes API
- [ ] `GET /api/v1/courses/:courseId/live-classes` - List live classes
- [ ] `GET /api/v1/live-classes/:id` - Get live class details
- [ ] `POST /api/v1/live-classes` - Create live class (admin/teacher)
- [ ] `PUT /api/v1/live-classes/:id` - Update live class (admin/teacher)
- [ ] `DELETE /api/v1/live-classes/:id` - Delete live class (admin/teacher)
- [ ] `PATCH /api/v1/live-classes/:id/complete` - Mark complete + add recording (admin/teacher)

### 1.6 Course Materials API
- [ ] `GET /api/v1/courses/:courseId/materials` - List materials
- [ ] `POST /api/v1/materials/upload` - Upload file to Supabase Storage (admin/teacher)
- [ ] `POST /api/v1/materials` - Create material record (admin/teacher)
- [ ] `PUT /api/v1/materials/:id` - Update material (admin/teacher)
- [ ] `DELETE /api/v1/materials/:id` - Delete material + file (admin/teacher)

### 1.7 Quizzes API
- [ ] `GET /api/v1/quizzes` - List quizzes (public: published, admin: all)
- [ ] `GET /api/v1/quizzes/:id` - Get quiz with questions
- [ ] `POST /api/v1/quizzes` - Create quiz (admin/teacher)
- [ ] `PUT /api/v1/quizzes/:id` - Update quiz (admin/teacher)
- [ ] `DELETE /api/v1/quizzes/:id` - Delete quiz (admin/teacher)
- [ ] `POST /api/v1/quizzes/:id/questions` - Add question (admin/teacher)
- [ ] `PUT /api/v1/questions/:id` - Update question (admin/teacher)
- [ ] `DELETE /api/v1/questions/:id` - Delete question (admin/teacher)
- [ ] `PATCH /api/v1/quizzes/:id/publish` - Publish/unpublish (admin/teacher)

### 1.8 Students API
- [ ] `GET /api/v1/students` - List all students (admin only)
- [ ] `GET /api/v1/students/:id` - Get student details (admin only)
- [ ] `POST /api/v1/students` - Create student (admin only)
- [ ] `PUT /api/v1/students/:id` - Update student (admin only)
- [ ] `DELETE /api/v1/students/:id` - Delete student (admin only)

### 1.9 Enrollments API
- [ ] `GET /api/v1/enrollments` - List all enrollments (admin only)
- [ ] `GET /api/v1/students/:id/enrollments` - Student enrollments (admin/student self)
- [ ] `POST /api/v1/enrollments` - Create enrollment (admin only)
- [ ] `PUT /api/v1/enrollments/:id` - Update enrollment (admin only)
- [ ] `DELETE /api/v1/enrollments/:id` - Remove enrollment (admin only)
- [ ] `POST /api/v1/enrollments/bulk` - Bulk enroll students (admin only)

### 1.10 Progress Tracking API (Read-Only for Dashboard)
- [ ] `GET /api/v1/students/:id/progress` - Overall progress (admin only)
- [ ] `GET /api/v1/students/:id/courses/:courseId/progress` - Course progress (admin only)
- [ ] `GET /api/v1/lecture-completions` - All completions (admin only)

### 1.11 Teachers/Admin API
- [ ] `GET /api/v1/teachers` - List teachers (admin only)
- [ ] `POST /api/v1/teachers` - Add teacher role to user (admin only)
- [ ] `DELETE /api/v1/teachers/:id` - Remove teacher role (admin only)
- [ ] `POST /api/v1/teachers/:id/assign-course` - Assign course (admin only)
- [ ] `DELETE /api/v1/teachers/:id/unassign-course` - Unassign course (admin only)

---

## Phase 2: Dashboard Frontend

### 2.1 Project Setup
- [ ] Initialize Next.js 14+ project with TypeScript
- [ ] Install dependencies (shadcn/ui, Supabase, React Query, Zod, Tailwind)
- [ ] Configure Supabase client
- [ ] Set up environment variables
- [ ] Configure Tailwind with theme colors

### 2.2 Authentication
- [ ] Create login page
- [ ] Implement Supabase Auth login
- [ ] Check user role from `admin_roles` table
- [ ] Redirect if no admin/teacher role
- [ ] Create auth middleware for route protection
- [ ] Create logout functionality

### 2.3 Dashboard Layout
- [ ] Create dashboard layout (topbar + sidebar)
- [ ] Build topbar (logo, user menu, logout)
- [ ] Build sidebar navigation (role-based menu items)
- [ ] Create dashboard home page (redirect to courses for now)
- [ ] Make responsive (mobile menu)

### 2.4 Course Management
- [ ] Create courses list page (table with search, filters)
- [ ] Create course create/edit form
  - [ ] Basic info (title, description, instructor, thumbnail upload)
  - [ ] Pricing (price, is_premium, has_free_trial)
  - [ ] Settings (language, category, status)
  - [ ] Publish/unpublish toggle
- [ ] Implement course CRUD (call API endpoints)
- [ ] Add thumbnail upload to Supabase Storage
- [ ] Create course detail view
- [ ] Add delete confirmation dialog

### 2.5 Lecture Management
- [ ] Create lectures page (grouped by section)
- [ ] Create lecture create/edit form
  - [ ] Title, description
  - [ ] Section assignment (dropdown or new section)
  - [ ] Type selection (video/live/reading/practice)
  - [ ] Duration input
  - [ ] Video upload/URL input
  - [ ] Quiz assignment (dropdown)
- [ ] Implement lecture CRUD (call API endpoints)
- [ ] Add drag-and-drop reordering (sections and lectures)
- [ ] Add video upload to Supabase Storage
- [ ] Show lectures organized by section in course detail view

### 2.6 Live Class Management
- [ ] Create live classes list page (table with filters)
- [ ] Create live class create/edit form
  - [ ] Course selection
  - [ ] Lecture association (optional)
  - [ ] Title, description
  - [ ] Date/time picker
  - [ ] Duration input
  - [ ] Zoom link input (manual for now)
  - [ ] Status dropdown (upcoming/live/completed)
- [ ] Implement live class CRUD (call API endpoints)
- [ ] Add recording URL field (for completed classes)
- [ ] Create calendar view (optional, can be Phase 3)

### 2.7 Course Materials Management
- [ ] Create materials list page (by course)
- [ ] Create material upload form
  - [ ] File upload (drag-drop)
  - [ ] Title input
  - [ ] Type selection (pdf/video/doc/image/other)
  - [ ] Section assignment (optional)
- [ ] Implement material CRUD (call API endpoints)
- [ ] Add file upload to Supabase Storage
- [ ] Show file size and preview link
- [ ] Add delete confirmation with file cleanup

### 2.8 Quiz Management
- [ ] Create quizzes list page (table with search, filters)
- [ ] Create quiz editor
  - [ ] Basic settings (title, description, course, time limit, full marks)
  - [ ] Difficulty level, passing score
  - [ ] Publish/unpublish toggle
  - [ ] Public/premium toggle
- [ ] Create question bank interface
  - [ ] List questions in quiz
  - [ ] Add/edit/delete question buttons
  - [ ] Show question number, type, marks
- [ ] Create question editor
  - [ ] Question content input with type selector (text/latex/image)
  - [ ] Rich text editor for text type
  - [ ] LaTeX input field with preview
  - [ ] Image upload for image type
  - [ ] Options array (min 2, max 6)
  - [ ] Each option supports text/latex/image
  - [ ] Correct answer selection (radio)
  - [ ] Marks input
  - [ ] Optional explanation field (same content types)
- [ ] Implement quiz CRUD (call API endpoints)
- [ ] Implement question CRUD (call API endpoints)
- [ ] Add quiz preview mode
- [ ] Show linked lectures in quiz editor

### 2.9 Student Management
- [ ] Create students list page (table with search, filters)
- [ ] Create student detail page
  - [ ] Profile info (name, email, phone)
  - [ ] Enrolled courses list
  - [ ] Progress overview
  - [ ] Quiz attempts summary
- [ ] Create student create/edit form
- [ ] Implement student CRUD (call API endpoints)
- [ ] Add suspend/activate toggle

### 2.10 Enrollment Management
- [ ] Create enrollments list page (table with filters by course/student)
- [ ] Add "Enroll Student" button in student detail page
  - [ ] Course selection dropdown
  - [ ] Status selection (active/trial)
  - [ ] Access duration input (optional)
- [ ] Implement enrollment CRUD (call API endpoints)
- [ ] Add bulk enroll functionality (select multiple students, pick course)
- [ ] Add extend/revoke access buttons
- [ ] Show enrollment status and progress

### 2.11 Teacher Management (RBAC)
- [ ] Create teachers list page (table)
- [ ] Create "Add Teacher" form
  - [ ] Select existing user OR create new user
  - [ ] Assign 'teacher' role in admin_roles
- [ ] Implement add teacher (call API endpoint)
- [ ] Implement remove teacher (call API endpoint)
- [ ] Create teacher detail page
  - [ ] Profile info
  - [ ] Assigned courses list
- [ ] Add course assignment interface
  - [ ] Multi-select courses
  - [ ] Assign/unassign buttons
- [ ] Implement course assignment (call API endpoints)
- [ ] Create teacher dashboard view (shows only assigned courses)
- [ ] Test permission restrictions (teacher can't delete courses, etc.)

---

## Phase 3: Integration & Testing

### 3.1 Dashboard Testing
- [ ] Test all CRUD operations (courses, lectures, quizzes, etc.)
- [ ] Test file uploads (thumbnails, videos, materials, images)
- [ ] Test RBAC (admin vs teacher permissions)
- [ ] Test quiz creation with all content types (text/latex/image)
- [ ] Test enrollment workflows
- [ ] Test search and filters on all list pages
- [ ] Test responsive design (mobile/tablet)

### 3.2 API Testing
- [ ] Test all API endpoints with Postman/Thunder Client
- [ ] Verify permission checks work (public, admin, teacher)
- [ ] Test error handling (invalid data, unauthorized access)
- [ ] Test pagination on list endpoints
- [ ] Test file upload endpoints
- [ ] Load test critical endpoints

### 3.3 Database Verification
- [ ] Verify all data created via dashboard appears in Supabase
- [ ] Check RLS policies work correctly
- [ ] Verify foreign key constraints
- [ ] Check data integrity (no orphaned records)

### 3.4 App Sync Verification (Current Direct Supabase Access)
- [ ] Verify Flutter app shows published courses from dashboard
- [ ] Verify lectures appear in course content
- [ ] Verify quizzes appear and work with all content types
- [ ] Verify live classes appear in schedule
- [ ] Verify materials are downloadable
- [ ] Verify enrollment data syncs
- [ ] Verify progress tracking works

---

## Phase 4: Deployment

### 4.1 Environment Setup
- [ ] Set up production Supabase project (or use existing)
- [ ] Run all database migrations on production
- [ ] Configure production environment variables
- [ ] Set up custom domain (if needed)
- [ ] Configure SSL certificate

### 4.2 Deploy Dashboard
- [ ] Deploy to Vercel
- [ ] Configure environment variables on Vercel
- [ ] Test production deployment
- [ ] Set up error monitoring (Sentry)
- [ ] Configure Vercel Analytics

### 4.3 Create Initial Data
- [ ] Create super_admin user in admin_roles table
- [ ] Test login with super_admin account
- [ ] Create first course via dashboard
- [ ] Create first quiz via dashboard
- [ ] Verify app shows the data

### 4.4 Launch Readiness
- [ ] Document API endpoints (create API docs)
- [ ] Create admin user guide (how to use dashboard)
- [ ] Create teacher user guide
- [ ] Train initial admins/teachers
- [ ] Set up monitoring and alerts
- [ ] Create backup strategy

---

## Launch Criteria

**All must be checked before public app launch:**

- [ ] Dashboard deployed and accessible
- [ ] All API endpoints working
- [ ] RBAC implemented and tested
- [ ] Courses can be created, published, managed
- [ ] Lectures can be created, organized by section
- [ ] Live classes can be scheduled
- [ ] Course materials can be uploaded
- [ ] Quizzes can be created with text/LaTeX/image questions
- [ ] Students can be managed and enrolled
- [ ] Teachers can be assigned to courses
- [ ] Flutter app displays all dashboard-created content correctly
- [ ] No critical bugs
- [ ] Performance acceptable (API response < 500ms)
- [ ] At least 2 admins trained
- [ ] Backup system in place

---

## Progress Tracking

**Phase 1 (API):** 0/11 modules
**Phase 2 (Dashboard):** 0/11 modules
**Phase 3 (Testing):** 0/4 modules
**Phase 4 (Deployment):** 0/4 modules

**Total:** 0/30 modules complete (0%)

---

**Priority Order:**
1. API Layer (Phase 1) - CRITICAL
2. Dashboard Core (2.1-2.4, 2.5, 2.8, 2.9, 2.10) - CRITICAL
3. Dashboard Secondary (2.6, 2.7, 2.11) - HIGH
4. Testing (Phase 3) - CRITICAL
5. Deployment (Phase 4) - CRITICAL
