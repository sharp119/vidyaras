# VidyaRas Admin Panel - Technical Specification Document

**Project:** VidyaRas Learning Platform
**Component:** Admin & Teacher Web Dashboard
**Version:** 1.0
**Created:** 2025-11-17
**Status:** Planning Phase

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Current State Analysis](#2-current-state-analysis)
3. [Admin Panel Overview](#3-admin-panel-overview)
4. [User Roles & Permissions](#4-user-roles--permissions)
5. [Core Features & Modules](#5-core-features--modules)
6. [Technology Stack](#6-technology-stack)
7. [Architecture & Design Principles](#7-architecture--design-principles)
8. [Database Integration](#8-database-integration)
9. [UI/UX Guidelines](#9-uiux-guidelines)
10. [Security & Authentication](#10-security--authentication)
11. [API Requirements](#11-api-requirements)
12. [Analytics & Reporting](#12-analytics--reporting)
13. [Implementation Roadmap](#13-implementation-roadmap)
14. [Testing Strategy](#14-testing-strategy)
15. [Deployment & DevOps](#15-deployment--devops)

---

## 1. Executive Summary

### 1.1 Purpose

The VidyaRas Admin Panel is a web-based dashboard system designed to provide comprehensive management capabilities for the VidyaRas learning platform. It serves two primary user groups:

1. **Administrators** - Full system management and oversight
2. **Teachers/Instructors** - Course content management and student engagement tools

### 1.2 Key Objectives

- **Centralized Management:** Single interface for all platform operations
- **Role-Based Access:** Granular permissions for admins and teachers
- **Data-Driven Decisions:** Rich analytics and reporting capabilities
- **Content Management:** Intuitive tools for course creation and updates
- **Student Engagement:** Monitor progress, communicate, and provide support
- **Revenue Tracking:** Payment monitoring and financial analytics

### 1.3 Success Metrics

- **Performance:** Dashboard loads in < 2 seconds
- **Usability:** 90%+ task completion rate without training
- **Reliability:** 99.9% uptime
- **Security:** Zero data breaches, complete RBAC implementation
- **Scalability:** Support 500+ concurrent users in Year 1

---

## 2. Current State Analysis

### 2.1 Existing Infrastructure

#### Student Application (Flutter)
- **Status:** Implemented
- **Features:**
  - Authentication (phone-based OTP)
  - Onboarding flow
  - Home screen with course listing
  - My Learning (enrolled courses)
  - Quiz/Test system (complete workflow)
  - Course viewing and progress tracking
- **Total Dart Files:** 204
- **Architecture:** Feature-First Layered (4 layers)

#### Backend (Supabase)
- **Status:** Fully configured
- **Database:** PostgreSQL
- **Tables:** 13 tables with comprehensive relationships
- **Key Data:**
  - 10 users
  - 6 courses
  - 64 lectures
  - 12 live classes
  - 7 quizzes (65 questions)
  - 16 enrollments
  - 59 lecture completions
  - 43 quiz attempts
- **RLS Policies:** Enabled on critical tables
- **Extensions:** GraphQL, vault, crypto, UUID support

#### Reusable Components
- **28 Pre-built UI Components** extracted from mockups
- Categories: Buttons (6), Inputs (3), Typography (3), Layout (4), Cards (5), Navigation (3), Progress (4)
- Theme system with predefined colors and gradients
- Bilingual support (Hindi + English)

### 2.2 What's Missing

**NO ADMIN PANEL EXISTS YET**

Required components:
- Web-based dashboard interface
- Admin and teacher role management
- Course creation and editing tools
- User management interface
- Analytics and reporting dashboards
- Content moderation tools
- Payment and revenue tracking
- Communication tools (announcements, notifications)

---

## 3. Admin Panel Overview

### 3.1 Platform Type

**Web Application** (not mobile app)

**Rationale:**
- Large data tables and complex forms better suited for desktop
- Teachers and admins work primarily from computers
- Easier to maintain than separate native apps
- Cross-platform compatibility
- Responsive design for tablet access

### 3.2 Core Components

```
VidyaRas Admin Panel
│
├── Authentication & Authorization
│   ├── Login (email/password or Google SSO)
│   ├── Role-based access control (RBAC)
│   └── Session management
│
├── Admin Dashboard
│   ├── Overview metrics
│   ├── User management
│   ├── Course management
│   ├── Revenue analytics
│   ├── System settings
│   └── Content moderation
│
└── Teacher Dashboard
    ├── My courses
    ├── Student management
    ├── Content creation
    ├── Live class scheduling
    ├── Quiz management
    └── Performance analytics
```

### 3.3 User Journey Overview

#### Admin Journey
1. Login with credentials
2. View dashboard with system metrics
3. Navigate to specific management module
4. Perform CRUD operations on entities
5. View analytics and reports
6. Make announcements or moderate content

#### Teacher Journey
1. Login with credentials
2. View assigned courses and students
3. Create/edit course content (lectures, quizzes)
4. Schedule live classes
5. Monitor student progress
6. Provide feedback and support

---

## 4. User Roles & Permissions

### 4.1 Role Hierarchy

```
┌─────────────────────────────────────┐
│         Super Admin                 │ (Full access)
└────────────────┬────────────────────┘
                 │
      ┌──────────┴──────────┐
      │                     │
┌─────┴─────────┐    ┌─────┴─────────┐
│     Admin     │    │    Teacher    │
└───────────────┘    └───────────────┘
```

### 4.2 Permission Matrix

| Feature | Super Admin | Admin | Teacher |
|---------|-------------|-------|---------|
| **User Management** | | | |
| View all users | ✅ | ✅ | ❌ |
| Create/edit users | ✅ | ✅ | ❌ |
| Delete users | ✅ | ⚠️ (restricted) | ❌ |
| Assign roles | ✅ | ❌ | ❌ |
| View enrolled students | ✅ | ✅ | ✅ (own courses) |
| **Course Management** | | | |
| View all courses | ✅ | ✅ | ✅ |
| Create courses | ✅ | ✅ | ✅ |
| Edit any course | ✅ | ✅ | ✅ (assigned only) |
| Delete courses | ✅ | ✅ | ❌ |
| Assign instructors | ✅ | ✅ | ❌ |
| Publish/unpublish | ✅ | ✅ | ✅ (own courses) |
| **Content Management** | | | |
| Create lectures | ✅ | ✅ | ✅ (assigned) |
| Upload materials | ✅ | ✅ | ✅ (assigned) |
| Create quizzes | ✅ | ✅ | ✅ (assigned) |
| Moderate content | ✅ | ✅ | ❌ |
| **Live Classes** | | | |
| Schedule classes | ✅ | ✅ | ✅ (assigned) |
| Generate Zoom links | ✅ | ✅ | ✅ (assigned) |
| View attendance | ✅ | ✅ | ✅ (own classes) |
| **Analytics** | | | |
| System-wide analytics | ✅ | ✅ | ❌ |
| Course analytics | ✅ | ✅ | ✅ (assigned) |
| Revenue reports | ✅ | ✅ | ❌ |
| Student progress | ✅ | ✅ | ✅ (assigned) |
| **Payments** | | | |
| View transactions | ✅ | ✅ | ❌ |
| Issue refunds | ✅ | ⚠️ (approval) | ❌ |
| Manage pricing | ✅ | ✅ | ❌ |
| **Communication** | | | |
| Send announcements | ✅ | ✅ | ✅ (own students) |
| Moderate chat | ✅ | ✅ | ✅ (own batches) |
| Send notifications | ✅ | ✅ | ✅ (limited) |
| **System Settings** | | | |
| Configure platform | ✅ | ❌ | ❌ |
| Manage integrations | ✅ | ❌ | ❌ |
| View logs | ✅ | ⚠️ (limited) | ❌ |

**Legend:**
- ✅ Full access
- ⚠️ Restricted/conditional access
- ❌ No access

### 4.3 Role Database Schema

**Add to Supabase:**

```sql
-- Create roles table
CREATE TABLE IF NOT EXISTS public.admin_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('super_admin', 'admin', 'teacher')),
  assigned_at TIMESTAMPTZ DEFAULT now(),
  assigned_by UUID REFERENCES auth.users(id),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, role)
);

-- Create teacher-course assignments
CREATE TABLE IF NOT EXISTS public.teacher_assignments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  course_id UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  assigned_at TIMESTAMPTZ DEFAULT now(),
  assigned_by UUID REFERENCES auth.users(id),
  is_active BOOLEAN DEFAULT true,
  UNIQUE(teacher_id, course_id)
);

-- Create permissions table (optional for fine-grained control)
CREATE TABLE IF NOT EXISTS public.role_permissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  role TEXT NOT NULL,
  resource TEXT NOT NULL, -- e.g., 'users', 'courses', 'payments'
  action TEXT NOT NULL,   -- e.g., 'create', 'read', 'update', 'delete'
  UNIQUE(role, resource, action)
);

-- Add indexes
CREATE INDEX idx_admin_roles_user_id ON public.admin_roles(user_id);
CREATE INDEX idx_admin_roles_role ON public.admin_roles(role);
CREATE INDEX idx_teacher_assignments_teacher ON public.teacher_assignments(teacher_id);
CREATE INDEX idx_teacher_assignments_course ON public.teacher_assignments(course_id);
```

---

## 5. Core Features & Modules

### 5.1 Dashboard (Home)

#### Admin Dashboard

**Metrics Overview (Top Cards):**
- Total Students (active/inactive)
- Total Courses (published/draft)
- Total Revenue (current month/all time)
- Active Live Classes (today/this week)
- Quiz Attempts (today/this week)
- New Enrollments (this week/month)

**Charts & Visualizations:**
- Revenue trend (line chart - 6 months)
- Enrollment trend (area chart - 6 months)
- Course category distribution (pie chart)
- Top performing courses (bar chart - top 10)
- Student activity heatmap (calendar view)
- Quiz performance distribution (histogram)

**Recent Activity Feed:**
- New enrollments
- Course completions
- Payment transactions
- User registrations
- Live class completions

**Quick Actions:**
- Create new course
- Schedule live class
- Create announcement
- View pending approvals

#### Teacher Dashboard

**Metrics Overview:**
- My Courses (active/total)
- Total Students (across all courses)
- Upcoming Live Classes
- Pending Quiz Reviews
- Course Completion Rate

**Charts:**
- Student progress in my courses
- Quiz performance trends
- Attendance trends for live classes

**My Courses List:**
- Course title
- Enrolled students count
- Progress percentage
- Next live class
- Quick actions (edit, view students, analytics)

---

### 5.2 User Management

#### Features:
- **User List View**
  - Searchable table (by name, email, phone)
  - Filters: role, status, enrollment date range
  - Sortable columns
  - Pagination
  - Bulk actions

- **User Details**
  - Profile information (name, email, phone, photo)
  - Role and permissions
  - Enrollment history
  - Course progress
  - Payment history
  - Quiz attempts
  - Activity log

- **User Actions**
  - Create new user (admin only)
  - Edit user details
  - Assign/remove roles
  - Suspend/activate account
  - Reset password
  - View as student (impersonation)

- **Bulk Operations**
  - Import users from CSV
  - Export user list
  - Send bulk emails
  - Enroll in courses

#### UI Components:
- Data table with advanced filtering
- User detail modal/page
- Role assignment dropdown
- Status badge (active/inactive/suspended)
- Action buttons (edit, delete, view)

---

### 5.3 Course Management

#### Course List View

**Table Columns:**
- Thumbnail
- Course title
- Category
- Instructor
- Price (INR)
- Enrolled count
- Status (published/draft)
- Created date
- Actions

**Filters:**
- Category
- Price range
- Status (published/draft)
- Language
- Has live classes
- Date range

**Actions:**
- Create new course
- Edit course
- Duplicate course
- Delete course
- View analytics
- Preview as student

#### Course Editor

**Tabs:**

1. **Basic Information**
   - Title (bilingual)
   - Description (rich text, bilingual)
   - Category dropdown
   - Thumbnail upload
   - Instructor assignment
   - Language selection
   - Tags

2. **Pricing & Access**
   - Price (INR)
   - Is premium toggle
   - Has free trial toggle
   - Access duration (days)
   - Discount/coupon support
   - EMI options

3. **Curriculum**
   - Section-based structure
   - Add/edit/delete sections
   - Add lectures to sections
   - Reorder sections and lectures (drag-drop)
   - Set lecture type (video/live/reading/practice)
   - Attach quizzes to lectures
   - Required quiz toggle

4. **Live Classes**
   - Schedule live sessions
   - Zoom integration
   - Generate meeting links
   - Set recurring classes
   - Send calendar invites

5. **Materials**
   - Upload PDFs, videos, documents
   - Organize by section
   - File size and format validation
   - Download statistics

6. **Settings**
   - Publish/unpublish toggle
   - Certificate generation settings
   - Enrollment limit
   - Prerequisite courses
   - Completion criteria

**Validation:**
- Required fields
- Image format/size limits
- Price validation
- Duplicate title check

---

### 5.4 Lecture Management

#### Lecture Editor

**Fields:**
- Lecture title (bilingual)
- Description (rich text)
- Section assignment
- Order/sequence
- Type (video/live/reading/practice)
- Duration (minutes)
- Video upload/URL
- Transcript/notes
- Required quiz assignment

**Video Upload:**
- Direct upload to Supabase Storage
- Or external URL (YouTube, Vimeo, Zoom recording)
- Video processing status
- Thumbnail auto-generation
- Quality selection (SD/HD)

**Requirements:**
- Set prerequisite lectures
- Attach quiz (required to proceed)
- Minimum watch time
- Downloadable toggle

---

### 5.5 Quiz Management

#### Quiz List View

**Table:**
- Quiz title
- Course association
- Questions count
- Full marks
- Time limit (minutes)
- Difficulty level
- Published status
- Attempts count
- Actions

**Filters:**
- Course
- Difficulty
- Published status
- Date created

#### Quiz Editor

**Basic Settings:**
- Title (bilingual)
- Description (rich text)
- Course association (optional)
- Full marks
- Time allotted (minutes)
- Passing score (percentage)
- Published toggle
- Public/premium toggle
- Difficulty level
- Related lecture

**Question Bank:**
- Add new question
- Edit existing question
- Delete question
- Reorder questions (drag-drop)
- Import from CSV
- Duplicate question

**Question Editor:**
- Question number (auto)
- Question content:
  - Type: text/latex/image_url/video_url
  - Content input (WYSIWYG for text, LaTeX editor, file upload)
- Options (minimum 2, maximum 6):
  - Option ID
  - Option content (same types as question)
  - Correct answer selection (radio button)
- Marks for this question
- Explanation (optional, same content types)

**Preview:**
- Live preview of quiz
- Test as student
- Review mode

**Analytics:**
- Total attempts
- Average score
- Pass rate
- Question-wise difficulty (% correct)
- Time spent per question
- Student rankings

---

### 5.6 Live Class Management

#### Schedule View

**Calendar View:**
- Month/week/day views
- Upcoming classes highlighted
- Past classes (with recordings)
- Color-coded by course
- Click to view/edit details

**List View:**
- Course name
- Title
- Scheduled date/time
- Duration
- Zoom link
- Status (upcoming/live/completed)
- Attendance count
- Recording URL

#### Create/Edit Live Class

**Fields:**
- Course assignment
- Lecture association (optional)
- Title (bilingual)
- Description
- Date and time (with timezone)
- Duration (minutes)
- Zoom integration:
  - Auto-generate meeting
  - Or manual link entry
  - Meeting ID
  - Passcode
- Recurring class settings
- Send notifications toggle

**Zoom Integration:**
- OAuth connection with Zoom
- Auto-create meetings with API
- Fetch meeting details
- Auto-add recording URL post-class

**Post-Class:**
- Mark as completed
- Upload recording URL
- View attendance list
- Send summary email

---

### 5.7 Enrollment Management

#### Enrollment List

**Table:**
- Student name
- Course title
- Enrolled date
- Status (active/completed/expired)
- Progress (percentage)
- Last accessed
- Actions

**Filters:**
- Course
- Student
- Status
- Date range
- Progress range

**Actions:**
- Manual enrollment (admin)
- Extend access
- Revoke access
- View student progress
- Export enrollment list

#### Enrollment Analytics
- Enrollment trend over time
- Drop-off analysis
- Completion rate by course
- Average time to complete
- Most popular courses

---

### 5.8 Payment & Revenue

#### Transaction List

**Table:**
- Transaction ID
- Student name
- Course title
- Amount (INR)
- Payment method
- Status (success/pending/failed/refunded)
- Date
- Actions

**Filters:**
- Date range
- Status
- Course
- Payment method
- Amount range

**Actions:**
- View receipt
- Issue refund
- Download invoice
- Export transactions

#### Revenue Dashboard

**Metrics:**
- Total revenue (all time)
- This month's revenue
- Revenue growth (% vs last month)
- Average order value
- Refund rate

**Charts:**
- Revenue by course (bar chart)
- Revenue trend (line chart)
- Payment method distribution (pie chart)
- Revenue by category (stacked area)

**Coupon Management:**
- Create/edit coupons
- Usage statistics
- Expiry management

---

### 5.9 Analytics & Reporting

#### System Analytics (Admin Only)

**User Metrics:**
- Total registered users
- Active users (7/30 days)
- User growth rate
- Retention rate
- Churn rate

**Course Metrics:**
- Total courses
- Published vs draft
- Average completion rate
- Course engagement score
- Drop-off points

**Revenue Metrics:**
- Total revenue
- MRR/ARR (Monthly/Annual Recurring Revenue)
- ARPU (Average Revenue Per User)
- Conversion rate (free → paid)

**Engagement Metrics:**
- Daily/Weekly Active Users (DAU/WAU)
- Session duration
- Pages per session
- Quiz participation rate
- Live class attendance rate

**Charts:**
- User acquisition funnel
- Revenue waterfall
- Cohort analysis
- Geographic distribution (if available)

#### Course Analytics

**Overview:**
- Total enrollments
- Active students
- Completion rate
- Average rating
- Revenue generated

**Student Progress:**
- Lecture-wise completion
- Drop-off points
- Average time per lecture
- Quiz performance

**Engagement:**
- Video watch time
- Quiz attempt rate
- Material download count
- Live class attendance

**Feedback:**
- Ratings and reviews
- Net Promoter Score (NPS)
- Common feedback themes

#### Reports Export

**Available Reports:**
- User list (CSV/Excel)
- Enrollment report (CSV/Excel)
- Revenue report (CSV/Excel)
- Quiz performance (CSV/Excel)
- Course completion (CSV/Excel)
- Custom date range

**Scheduled Reports:**
- Weekly summary email
- Monthly revenue report
- Quarterly analytics

---

### 5.10 Communication Tools

#### Announcements

**Features:**
- Create announcement
- Target audience:
  - All users
  - Specific course students
  - Specific batch
  - Custom filter
- Bilingual content (Hindi + English)
- Scheduling (send now or later)
- Delivery channels:
  - In-app notification
  - Email
  - SMS (optional)
- Urgency level (info/warning/critical)
- Expiry date

**Announcement List:**
- Title
- Target audience
- Sent date
- Status (draft/scheduled/sent)
- Delivery stats (sent/opened)
- Actions (edit, duplicate, delete)

#### Notifications

**Push Notifications:**
- Triggered by events:
  - New course enrollment
  - Live class reminder (1 hour before)
  - Quiz published
  - Certificate ready
  - Payment success
- Manual notifications (admin)
- Template management

**Email Notifications:**
- Welcome email
- Course enrollment confirmation
- Payment receipt
- Certificate delivery
- Live class invite
- Custom campaigns

**In-App Messages:**
- Banner messages
- Pop-up modals
- Sidebar alerts

---

### 5.11 Content Moderation

#### Community Chat Moderation

**Features:**
- View all chat messages (batch + global)
- Flag inappropriate content
- Delete messages
- Warn/ban users
- Keyword filtering
- Report management

#### Review Moderation

**Course Reviews:**
- Approve/reject reviews
- Flag spam
- Respond to reviews
- Hide/unhide reviews

#### User-Generated Content

**Uploaded Materials:**
- Review uploaded assignments
- Flag inappropriate files
- Moderate discussion posts

---

### 5.12 Settings & Configuration

#### System Settings (Super Admin)

**General:**
- Platform name
- Logo upload
- Favicon
- Default language
- Timezone
- Date/time format

**Payment Settings:**
- Payment gateway configuration
- Currency
- Tax rates
- Refund policy

**Email Settings:**
- SMTP configuration
- Email templates
- Sender name/email
- Email signature

**Integration Settings:**
- Zoom API credentials
- Google Analytics
- Facebook Pixel
- Third-party plugins

**Security Settings:**
- Password policy
- Session timeout
- Two-factor authentication
- IP whitelisting

#### User Preferences

**Profile Settings:**
- Name
- Email
- Phone
- Profile photo
- Password change

**Notification Preferences:**
- Email notifications toggle
- SMS notifications toggle
- Push notifications toggle
- Notification frequency

---

## 6. Technology Stack

### 6.1 Frontend

**Framework:** Next.js 14+ (App Router)

**Rationale:**
- Modern React framework with SSR/SSG support
- Built-in routing
- API routes for serverless functions
- Excellent performance
- SEO-friendly (if public pages needed)
- TypeScript support

**UI Library:** shadcn/ui + Radix UI

**Rationale:**
- Matches student app's shadcn_ui usage (consistent design)
- Accessible components (WCAG compliant)
- Highly customizable
- No runtime overhead
- Copy-paste components

**Styling:** Tailwind CSS

**Rationale:**
- Rapid development
- Consistent design tokens
- Small bundle size
- Responsive utilities
- Dark mode support

**State Management:**
- **React Query (TanStack Query)** - Server state
- **Zustand** - Client state (lightweight alternative to Redux)

**Forms:** React Hook Form + Zod

**Rationale:**
- Type-safe form validation
- Excellent performance
- Minimal re-renders
- Easy schema definition

**Charts:** Recharts or Chart.js

**Rationale:**
- Simple API
- Responsive
- Good documentation
- Active maintenance

**Rich Text Editor:** Tiptap or Lexical

**Rationale:**
- Modern
- Extensible
- Good mobile support
- Collaborative editing support (future)

**File Upload:** react-dropzone + Supabase Storage

**Date/Time:** date-fns or Day.js

**Icons:** Lucide React (matches shadcn/ui)

**Table:** TanStack Table

**Rationale:**
- Headless (full control)
- Sorting, filtering, pagination
- Virtual scrolling for large datasets
- TypeScript support

### 6.2 Backend

**Primary:** Supabase (existing)

**Services Used:**
- **Database:** PostgreSQL
- **Auth:** Supabase Auth (email/password + social login)
- **Storage:** Supabase Storage (videos, PDFs, images)
- **Realtime:** Supabase Realtime (live updates)
- **Edge Functions:** Serverless functions (optional)

**Additional Backend (if needed):**
- Next.js API routes for custom logic
- Supabase Edge Functions for scheduled tasks

**External Integrations:**
- **Zoom API:** Live class management
- **Payment Gateway:** Razorpay or Stripe (for Indian market, Razorpay preferred)
- **Email Service:** Supabase + Resend or SendGrid
- **SMS Service:** Twilio or MSG91

### 6.3 Authentication & Authorization

**Auth Provider:** Supabase Auth

**Login Methods:**
- Email + Password
- Google OAuth (SSO)
- Magic Link (optional)

**Session Management:**
- JWT tokens
- Refresh tokens
- Role-based claims in token

**Authorization:**
- Row Level Security (RLS) policies in Supabase
- Client-side role checks
- Middleware for route protection

### 6.4 Deployment & Hosting

**Hosting:** Vercel

**Rationale:**
- Optimized for Next.js
- Automatic deployments
- Edge network (global CDN)
- Serverless functions
- Preview deployments
- Free tier generous

**Database:** Supabase Cloud (already set up)

**Storage:** Supabase Storage

**CDN:** Vercel Edge Network + Supabase CDN

**Domain:** Custom domain with SSL

### 6.5 DevOps & Monitoring

**Version Control:** Git + GitHub

**CI/CD:** GitHub Actions + Vercel

**Monitoring:**
- Vercel Analytics (performance)
- Sentry (error tracking)
- Supabase Dashboard (database metrics)

**Logging:**
- Console logs in development
- Structured logging in production
- Log aggregation (optional: Logtail, Datadog)

---

## 7. Architecture & Design Principles

### 7.1 Project Structure

```
vidyaras-admin/
├── .github/
│   └── workflows/          # CI/CD pipelines
├── public/                 # Static assets
│   ├── images/
│   ├── icons/
│   └── fonts/
├── src/
│   ├── app/                # Next.js App Router
│   │   ├── (auth)/        # Auth routes (login, etc.)
│   │   ├── (dashboard)/   # Protected dashboard routes
│   │   │   ├── admin/     # Admin-only routes
│   │   │   ├── teacher/   # Teacher routes
│   │   │   └── shared/    # Shared dashboard routes
│   │   ├── api/           # API routes
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/        # Reusable UI components
│   │   ├── ui/            # shadcn/ui components
│   │   ├── forms/         # Form components
│   │   ├── tables/        # Table components
│   │   ├── charts/        # Chart components
│   │   └── layout/        # Layout components
│   ├── lib/               # Utilities and config
│   │   ├── supabase/      # Supabase client & helpers
│   │   ├── utils/         # Utility functions
│   │   ├── constants/     # Constants
│   │   ├── validations/   # Zod schemas
│   │   └── hooks/         # Custom React hooks
│   ├── types/             # TypeScript types & interfaces
│   ├── styles/            # Global styles
│   └── middleware.ts      # Next.js middleware (auth)
├── .env.local             # Environment variables
├── next.config.js
├── tailwind.config.js
├── tsconfig.json
└── package.json
```

### 7.2 Design Patterns

#### Component Structure

**Atomic Design Principles:**
- **Atoms:** Basic UI elements (Button, Input, Badge)
- **Molecules:** Simple combinations (InputWithLabel, CardHeader)
- **Organisms:** Complex components (DataTable, CourseEditor)
- **Templates:** Page layouts
- **Pages:** Complete screens

#### State Management Strategy

**Server State (React Query):**
- All data from Supabase
- Automatic caching
- Background refetching
- Optimistic updates

**Client State (Zustand):**
- UI state (sidebar open/closed)
- User preferences
- Temporary form data

#### Error Handling

**Boundary Pattern:**
- Error boundaries for React errors
- Try-catch for async operations
- Graceful degradation
- User-friendly error messages

**Validation:**
- Client-side: Zod schemas with React Hook Form
- Server-side: Database constraints + Supabase RLS

### 7.3 Code Quality Standards

**TypeScript:**
- Strict mode enabled
- No `any` types (use `unknown` when necessary)
- Interface-first approach
- Proper type exports

**Naming Conventions:**
- Components: PascalCase (`UserTable.tsx`)
- Functions: camelCase (`getUserById`)
- Constants: UPPER_SNAKE_CASE (`API_BASE_URL`)
- Files: kebab-case or PascalCase

**Code Organization:**
- One component per file
- Co-locate related files (component + styles + tests)
- Index files for clean imports
- Max 250 lines per file (guideline)

**Documentation:**
- JSDoc for public functions
- README for each major module
- Inline comments for complex logic

---

## 8. Database Integration

### 8.1 Existing Tables Usage

#### Users & Roles

**Tables:**
- `public.users` - Core user data
- `public.profiles` - Extended profile (linked to auth.users)
- `public.admin_roles` - Admin/teacher roles (NEW)
- `public.teacher_assignments` - Course assignments (NEW)

**Queries:**
```typescript
// Get all users with roles
const { data, error } = await supabase
  .from('users')
  .select(`
    *,
    admin_roles (
      role,
      is_active
    )
  `)
  .order('created_at', { ascending: false });

// Get teacher's assigned courses
const { data } = await supabase
  .from('teacher_assignments')
  .select(`
    *,
    courses (
      id,
      title,
      thumbnail_url,
      enrolled_count
    )
  `)
  .eq('teacher_id', userId)
  .eq('is_active', true);
```

#### Courses & Content

**Tables:**
- `public.courses` - Course metadata
- `public.lectures` - Individual lectures
- `public.live_classes` - Live sessions
- `public.course_materials` - Downloadable files

**Queries:**
```typescript
// Get course with full curriculum
const { data } = await supabase
  .from('courses')
  .select(`
    *,
    lectures (
      id,
      title,
      section_id,
      section_title,
      order_index,
      type,
      duration_minutes
    ),
    live_classes (
      id,
      title,
      scheduled_at,
      zoom_link,
      status
    ),
    course_materials (
      id,
      title,
      type,
      file_url
    )
  `)
  .eq('id', courseId)
  .single();
```

#### Quiz System

**Tables:**
- `public.quizzes` - Quiz metadata
- `public.questions` - Questions with JSONB content
- `public.quiz_attempts` - Student attempts
- `public.user_answers` - Individual answers
- `public.question_analytics` - Performance data

**Queries:**
```typescript
// Get quiz with questions and analytics
const { data } = await supabase
  .from('quizzes')
  .select(`
    *,
    questions (
      id,
      question_number,
      question_data,
      options,
      correct_option_id,
      marks
    ),
    quiz_attempts (
      count
    )
  `)
  .eq('id', quizId)
  .single();

// Get quiz performance analytics
const { data } = await supabase
  .from('quiz_attempts')
  .select(`
    score,
    total_marks,
    percentage,
    time_taken_seconds,
    user_id,
    users (name)
  `)
  .eq('quiz_id', quizId)
  .eq('is_completed', true)
  .order('score', { ascending: false });
```

#### Enrollments & Progress

**Tables:**
- `public.enrollments` - Course enrollments
- `public.lecture_completions` - Progress tracking

**Queries:**
```typescript
// Get course enrollment with progress
const { data } = await supabase
  .from('enrollments')
  .select(`
    *,
    users (
      name,
      email,
      phone_number
    ),
    courses (
      title,
      lectures (count)
    ),
    lecture_completions (count)
  `)
  .eq('course_id', courseId);

// Calculate progress percentage (done in app or with Postgres function)
const progress = (completions / totalLectures) * 100;
```

### 8.2 New Tables Required

See [Section 4.3](#43-role-database-schema) for role tables.

**Additional Tables:**

```sql
-- Announcements
CREATE TABLE IF NOT EXISTS public.announcements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  author_id UUID REFERENCES auth.users(id),
  target_audience TEXT NOT NULL, -- 'all', 'course', 'batch', 'custom'
  target_id UUID, -- course_id or batch_id if applicable
  scheduled_at TIMESTAMPTZ,
  sent_at TIMESTAMPTZ,
  status TEXT CHECK (status IN ('draft', 'scheduled', 'sent')),
  delivery_channels JSONB DEFAULT '["in_app"]', -- ['in_app', 'email', 'sms']
  priority TEXT CHECK (priority IN ('info', 'warning', 'critical')),
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Payments (if not using external service exclusively)
CREATE TABLE IF NOT EXISTS public.payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id),
  course_id UUID REFERENCES public.courses(id),
  amount NUMERIC NOT NULL,
  currency TEXT DEFAULT 'INR',
  payment_method TEXT, -- 'card', 'upi', 'netbanking', 'wallet'
  payment_gateway TEXT, -- 'razorpay', 'stripe'
  gateway_transaction_id TEXT,
  status TEXT CHECK (status IN ('pending', 'success', 'failed', 'refunded')),
  paid_at TIMESTAMPTZ,
  refunded_at TIMESTAMPTZ,
  refund_reason TEXT,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Certificates
CREATE TABLE IF NOT EXISTS public.certificates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id),
  course_id UUID NOT NULL REFERENCES public.courses(id),
  certificate_number TEXT UNIQUE NOT NULL,
  issued_at TIMESTAMPTZ DEFAULT now(),
  certificate_url TEXT, -- PDF URL in Supabase Storage
  metadata JSONB,
  UNIQUE(user_id, course_id)
);

-- Coupons
CREATE TABLE IF NOT EXISTS public.coupons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT UNIQUE NOT NULL,
  description TEXT,
  discount_type TEXT CHECK (discount_type IN ('percentage', 'fixed')),
  discount_value NUMERIC NOT NULL,
  max_uses INTEGER,
  uses_count INTEGER DEFAULT 0,
  valid_from TIMESTAMPTZ DEFAULT now(),
  valid_until TIMESTAMPTZ,
  applicable_courses UUID[], -- Array of course IDs
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Activity Logs (audit trail)
CREATE TABLE IF NOT EXISTS public.activity_logs (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  action TEXT NOT NULL, -- 'create', 'update', 'delete', 'login', etc.
  resource TEXT NOT NULL, -- 'course', 'user', 'quiz', etc.
  resource_id UUID,
  metadata JSONB,
  ip_address TEXT,
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Create indexes
CREATE INDEX idx_announcements_status ON public.announcements(status);
CREATE INDEX idx_announcements_scheduled ON public.announcements(scheduled_at);
CREATE INDEX idx_payments_user ON public.payments(user_id);
CREATE INDEX idx_payments_status ON public.payments(status);
CREATE INDEX idx_certificates_user ON public.certificates(user_id);
CREATE INDEX idx_coupons_code ON public.coupons(code);
CREATE INDEX idx_activity_logs_user ON public.activity_logs(user_id);
CREATE INDEX idx_activity_logs_created ON public.activity_logs(created_at DESC);
```

### 8.3 Row Level Security (RLS) Policies

**Admin Roles Table:**

```sql
-- Enable RLS
ALTER TABLE public.admin_roles ENABLE ROW LEVEL SECURITY;

-- Super admins can see all roles
CREATE POLICY "Super admins can view all roles"
ON public.admin_roles FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.admin_roles
    WHERE user_id = auth.uid() AND role = 'super_admin' AND is_active = true
  )
);

-- Users can view their own role
CREATE POLICY "Users can view their own role"
ON public.admin_roles FOR SELECT
TO authenticated
USING (user_id = auth.uid());

-- Only super admins can insert/update roles
CREATE POLICY "Super admins can manage roles"
ON public.admin_roles FOR ALL
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.admin_roles
    WHERE user_id = auth.uid() AND role = 'super_admin' AND is_active = true
  )
);
```

**Teacher Assignments:**

```sql
ALTER TABLE public.teacher_assignments ENABLE ROW LEVEL SECURITY;

-- Teachers can view their own assignments
CREATE POLICY "Teachers can view their assignments"
ON public.teacher_assignments FOR SELECT
TO authenticated
USING (
  teacher_id = auth.uid() OR
  EXISTS (
    SELECT 1 FROM public.admin_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'super_admin') AND is_active = true
  )
);

-- Admins can manage assignments
CREATE POLICY "Admins can manage teacher assignments"
ON public.teacher_assignments FOR ALL
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.admin_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'super_admin') AND is_active = true
  )
);
```

**Payments Table:**

```sql
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

-- Users can view their own payments
CREATE POLICY "Users can view their own payments"
ON public.payments FOR SELECT
TO authenticated
USING (user_id = auth.uid());

-- Admins can view all payments
CREATE POLICY "Admins can view all payments"
ON public.payments FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.admin_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'super_admin') AND is_active = true
  )
);
```

### 8.4 Supabase Client Setup

**TypeScript Client:**

```typescript
// lib/supabase/client.ts
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { Database } from '@/types/supabase';

export const supabase = createClientComponentClient<Database>();
```

**Server-Side Client (for API routes):**

```typescript
// lib/supabase/server.ts
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { Database } from '@/types/supabase';

export const createServerSupabaseClient = () => {
  const cookieStore = cookies();
  return createServerComponentClient<Database>({ cookies: () => cookieStore });
};
```

**Type Generation:**

```bash
# Generate TypeScript types from Supabase schema
npx supabase gen types typescript --project-id <project-id> > src/types/supabase.ts
```

---

## 9. UI/UX Guidelines

### 9.1 Design Principles

**Consistency:**
- Match student app's design language (shadcn_ui)
- Consistent spacing (use Tailwind spacing scale)
- Consistent typography (use theme font scale)
- Consistent colors (use theme colors)

**Clarity:**
- Clear hierarchy (headings, subheadings, body text)
- Ample whitespace
- Obvious interactive elements
- Descriptive labels and placeholders

**Efficiency:**
- Quick access to common actions
- Keyboard shortcuts for power users
- Bulk operations for repetitive tasks
- Smart defaults in forms

**Feedback:**
- Loading states for all async operations
- Success/error toast notifications
- Confirmation dialogs for destructive actions
- Progress indicators for multi-step processes

**Accessibility:**
- WCAG 2.1 Level AA compliance
- Keyboard navigation
- Screen reader support
- Sufficient color contrast

### 9.2 Component Library

**Base Components (shadcn/ui):**
- Button (primary, secondary, outline, ghost, destructive)
- Input (text, email, password, number, date)
- Select (dropdown)
- Checkbox
- Radio Group
- Switch (toggle)
- Textarea
- Badge
- Card
- Dialog (modal)
- Dropdown Menu
- Popover
- Tabs
- Toast (notifications)
- Alert
- Skeleton (loading state)
- Table
- Pagination
- Avatar
- Progress
- Separator
- Sheet (slide-in panel)

**Custom Components:**
- DataTable (with sorting, filtering, pagination)
- RichTextEditor (Tiptap-based)
- FileUploader (drag-drop)
- ImageUploader (with preview)
- DateRangePicker
- MultiSelect
- CourseSelector
- UserSelector
- QuestionEditor (with content type support)
- ChartCard (wrapper for chart components)
- StatCard (dashboard metrics)
- EmptyState (no data placeholder)
- LoadingSpinner
- ConfirmDialog

### 9.3 Layout Structure

**Dashboard Layout:**

```
┌─────────────────────────────────────────────┐
│  Topbar (Logo | Breadcrumbs | User Menu)   │
├────────┬────────────────────────────────────┤
│        │                                    │
│        │                                    │
│ Sidebar│  Main Content Area                │
│  Nav   │                                    │
│        │                                    │
│        │                                    │
│        │                                    │
└────────┴────────────────────────────────────┘
```

**Topbar:**
- Logo (left)
- Breadcrumb navigation (center)
- Search bar (optional)
- Notifications icon
- User profile dropdown (right)

**Sidebar:**
- Collapsible (hamburger menu)
- Role-based navigation menu
- Active route highlight
- Icons + labels
- Sticky position

**Main Content:**
- Page title + actions (top)
- Filters/tabs (if applicable)
- Content area
- Pagination/load more (bottom)

### 9.4 Responsive Design

**Breakpoints:**
- Mobile: < 640px (sm)
- Tablet: 640px - 1024px (md to lg)
- Desktop: > 1024px (xl)

**Mobile Behavior:**
- Sidebar collapses to hamburger menu
- Tables switch to card view
- Charts adjust size
- Forms use full width
- Reduce padding/margins

### 9.5 Color Scheme

**Base Colors (align with student app):**
- Primary: Blue (#3B82F6) → Purple (#8B5CF6) gradient
- Secondary: Orange (#F97316)
- Success: Green (#10B981)
- Warning: Yellow (#F59E0B)
- Error: Red (#EF4444)
- Neutral: Gray scale (#F9FAFB to #111827)

**Semantic Colors:**
- Background: White (#FFFFFF) / Dark (#1F2937)
- Text Primary: Gray-900 (#111827) / White
- Text Secondary: Gray-600 (#4B5563)
- Border: Gray-200 (#E5E7EB)
- Hover: Gray-100 (#F3F4F6)

**Dark Mode:**
- Support toggle in user preferences
- Use Tailwind's dark mode utilities

### 9.6 Typography

**Font Family:**
- Primary: Inter or System Font Stack
- Monospace: JetBrains Mono (for code/IDs)

**Scale:**
- Heading 1: 36px / 2.25rem (font-extrabold)
- Heading 2: 30px / 1.875rem (font-bold)
- Heading 3: 24px / 1.5rem (font-semibold)
- Heading 4: 20px / 1.25rem (font-semibold)
- Body: 16px / 1rem (font-normal)
- Small: 14px / 0.875rem (font-normal)
- Tiny: 12px / 0.75rem (font-normal)

---

## 10. Security & Authentication

### 10.1 Authentication Flow

**Login Process:**
1. User enters email + password
2. Supabase Auth validates credentials
3. If valid, returns JWT access token + refresh token
4. Check if user has admin/teacher role in `admin_roles` table
5. If no role, deny access with error message
6. If role exists, store session and redirect to dashboard

**Session Management:**
- Access token stored in HTTP-only cookie (secure)
- Refresh token rotation
- Session timeout: 24 hours
- Auto logout on token expiration

**Logout:**
- Clear session
- Invalidate tokens
- Redirect to login page

### 10.2 Authorization

**Middleware Protection:**

```typescript
// middleware.ts
import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  const supabase = createMiddlewareClient({ req, res });

  const {
    data: { session },
  } = await supabase.auth.getSession();

  // Redirect to login if not authenticated
  if (!session) {
    return NextResponse.redirect(new URL('/login', req.url));
  }

  // Check role
  const { data: role } = await supabase
    .from('admin_roles')
    .select('role, is_active')
    .eq('user_id', session.user.id)
    .single();

  if (!role || !role.is_active) {
    return NextResponse.redirect(new URL('/unauthorized', req.url));
  }

  // Route-based role checks
  if (req.nextUrl.pathname.startsWith('/admin') && role.role !== 'admin' && role.role !== 'super_admin') {
    return NextResponse.redirect(new URL('/unauthorized', req.url));
  }

  return res;
}

export const config = {
  matcher: ['/admin/:path*', '/teacher/:path*', '/dashboard/:path*'],
};
```

**Client-Side Checks:**

```typescript
// hooks/useAuth.ts
import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase/client';

export function useAuth() {
  const [user, setUser] = useState(null);
  const [role, setRole] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const getUser = async () => {
      const { data: { session } } = await supabase.auth.getSession();

      if (session?.user) {
        setUser(session.user);

        // Fetch role
        const { data: roleData } = await supabase
          .from('admin_roles')
          .select('role, is_active')
          .eq('user_id', session.user.id)
          .eq('is_active', true)
          .single();

        setRole(roleData?.role || null);
      }

      setLoading(false);
    };

    getUser();

    // Listen for auth changes
    const { data: authListener } = supabase.auth.onAuthStateChange(
      (event, session) => {
        if (event === 'SIGNED_IN') {
          setUser(session?.user || null);
        } else if (event === 'SIGNED_OUT') {
          setUser(null);
          setRole(null);
        }
      }
    );

    return () => {
      authListener.subscription.unsubscribe();
    };
  }, []);

  return { user, role, loading };
}
```

**Permission Checks:**

```typescript
// lib/permissions.ts
export const PERMISSIONS = {
  USERS_VIEW: ['super_admin', 'admin'],
  USERS_CREATE: ['super_admin', 'admin'],
  USERS_DELETE: ['super_admin'],
  COURSES_VIEW: ['super_admin', 'admin', 'teacher'],
  COURSES_CREATE: ['super_admin', 'admin', 'teacher'],
  COURSES_DELETE: ['super_admin', 'admin'],
  REVENUE_VIEW: ['super_admin', 'admin'],
  // ... more permissions
};

export function hasPermission(userRole: string, permission: keyof typeof PERMISSIONS): boolean {
  return PERMISSIONS[permission]?.includes(userRole) ?? false;
}
```

### 10.3 Data Security

**Input Validation:**
- All user inputs validated with Zod schemas
- SQL injection prevention (Supabase handles)
- XSS prevention (React escapes by default)
- CSRF protection (Supabase Auth cookies)

**File Upload Security:**
- File type validation (whitelist)
- File size limits
- Virus scanning (optional: ClamAV)
- Unique filenames (UUID-based)
- Secure URLs (signed URLs for sensitive files)

**Sensitive Data:**
- Passwords hashed (Supabase Auth handles)
- PII encrypted at rest (Supabase default)
- Audit logs for data access
- GDPR compliance (data export/deletion)

### 10.4 Rate Limiting

**API Rate Limits:**
- Supabase: Built-in rate limiting
- Custom API routes: Use `next-rate-limit` package
- Limits:
  - Login: 5 attempts per 15 minutes
  - API calls: 100 requests per minute
  - File uploads: 10 per hour

### 10.5 Audit Logging

**What to Log:**
- User login/logout
- Role changes
- Course create/edit/delete
- Quiz create/edit/delete
- User create/edit/delete
- Payment transactions
- Settings changes

**Log Storage:**
- `activity_logs` table (see Section 8.2)
- Retention: 90 days
- Admin access only

---

## 11. API Requirements

### 11.1 Supabase API Usage

**REST API (PostgREST):**
- Auto-generated from database schema
- Full CRUD on all tables
- Filtering, sorting, pagination
- Row Level Security enforced

**Example Queries:**

```typescript
// Fetch courses with filters
const { data: courses } = await supabase
  .from('courses')
  .select('*')
  .eq('is_premium', false)
  .order('created_at', { ascending: false })
  .range(0, 9);

// Create new lecture
const { data, error } = await supabase
  .from('lectures')
  .insert({
    course_id: courseId,
    title: 'Lecture Title',
    section_id: 's1',
    order_index: 1,
  })
  .select()
  .single();

// Update quiz
await supabase
  .from('quizzes')
  .update({ is_published: true })
  .eq('id', quizId);

// Delete user (soft delete or actual)
await supabase
  .from('users')
  .delete()
  .eq('id', userId);
```

### 11.2 Custom API Routes (Next.js)

**When to Use:**
- Complex business logic not suitable for direct DB queries
- Third-party integrations (Zoom, payment gateway)
- Scheduled tasks
- Webhooks

**Example Routes:**

```
/api/
├── auth/
│   ├── login              POST
│   ├── logout             POST
│   └── me                 GET
├── courses/
│   ├── [id]              GET, PUT, DELETE
│   ├── duplicate         POST
│   └── analytics         GET
├── users/
│   ├── [id]              GET, PUT, DELETE
│   ├── import            POST (CSV upload)
│   └── bulk-enroll       POST
├── quizzes/
│   ├── [id]/analytics    GET
│   └── export            POST
├── payments/
│   ├── webhook           POST (Razorpay/Stripe)
│   └── refund            POST
├── integrations/
│   ├── zoom/create       POST
│   └── zoom/webhook      POST
├── analytics/
│   ├── dashboard         GET
│   └── reports/export    POST
└── notifications/
    ├── send              POST
    └── schedule          POST
```

**API Structure:**

```typescript
// app/api/courses/[id]/analytics/route.ts
import { createServerSupabaseClient } from '@/lib/supabase/server';
import { NextRequest, NextResponse } from 'next/server';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createServerSupabaseClient();

    // Check auth
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Check permissions
    const { data: role } = await supabase
      .from('admin_roles')
      .select('role')
      .eq('user_id', session.user.id)
      .single();

    if (!role || !['admin', 'super_admin', 'teacher'].includes(role.role)) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
    }

    // Fetch analytics data
    const courseId = params.id;

    // ... complex queries, aggregations, etc.

    return NextResponse.json({ data: analytics });
  } catch (error) {
    console.error('Error fetching course analytics:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

### 11.3 External API Integrations

#### Zoom API

**Purpose:** Create and manage live class meetings

**Endpoints Used:**
- `POST /users/{userId}/meetings` - Create meeting
- `GET /meetings/{meetingId}` - Get meeting details
- `DELETE /meetings/{meetingId}` - Delete meeting
- `GET /meetings/{meetingId}/recordings` - Get recordings

**Implementation:**

```typescript
// lib/integrations/zoom.ts
import axios from 'axios';

const ZOOM_API_BASE = 'https://api.zoom.us/v2';

export async function createZoomMeeting(data: {
  topic: string;
  start_time: string;
  duration: number;
}) {
  const response = await axios.post(
    `${ZOOM_API_BASE}/users/me/meetings`,
    {
      topic: data.topic,
      type: 2, // Scheduled meeting
      start_time: data.start_time,
      duration: data.duration,
      settings: {
        host_video: true,
        participant_video: true,
        join_before_host: false,
        mute_upon_entry: true,
        auto_recording: 'cloud',
      },
    },
    {
      headers: {
        Authorization: `Bearer ${process.env.ZOOM_ACCESS_TOKEN}`,
      },
    }
  );

  return response.data;
}
```

#### Payment Gateway (Razorpay)

**Purpose:** Process payments and handle webhooks

**Endpoints Used:**
- `POST /orders` - Create order
- `POST /payments/{paymentId}/capture` - Capture payment
- `POST /refunds` - Process refund

**Webhook Handler:**

```typescript
// app/api/payments/webhook/route.ts
import { NextRequest, NextResponse } from 'next/server';
import crypto from 'crypto';
import { supabase } from '@/lib/supabase/server';

export async function POST(req: NextRequest) {
  const body = await req.text();
  const signature = req.headers.get('x-razorpay-signature');

  // Verify signature
  const expectedSignature = crypto
    .createHmac('sha256', process.env.RAZORPAY_WEBHOOK_SECRET!)
    .update(body)
    .digest('hex');

  if (signature !== expectedSignature) {
    return NextResponse.json({ error: 'Invalid signature' }, { status: 400 });
  }

  const event = JSON.parse(body);

  // Handle events
  if (event.event === 'payment.captured') {
    // Update payment record
    await supabase
      .from('payments')
      .update({
        status: 'success',
        paid_at: new Date().toISOString(),
      })
      .eq('gateway_transaction_id', event.payload.payment.entity.id);

    // Enroll user in course (if applicable)
    // ... enrollment logic
  }

  return NextResponse.json({ received: true });
}
```

---

## 12. Analytics & Reporting

### 12.1 Dashboard Metrics

**Admin Dashboard:**

```typescript
// Metrics to display
interface DashboardMetrics {
  totalUsers: number;
  activeUsers: number; // logged in last 7 days
  totalCourses: number;
  publishedCourses: number;
  totalRevenue: number;
  monthlyRevenue: number;
  enrollmentsThisMonth: number;
  liveClassesToday: number;
  quizAttemptsThisWeek: number;
  averageCourseRating: number;
}

// SQL queries for each metric
const metrics = {
  totalUsers: await supabase.from('users').select('id', { count: 'exact', head: true }),
  // ... more queries
};
```

**Revenue Analytics:**

- Total revenue (all time)
- Monthly revenue trend (line chart)
- Revenue by course (bar chart)
- Payment method distribution (pie chart)
- Refund rate
- Average transaction value

**User Analytics:**

- User growth over time (line chart)
- Active users (DAU/MAU)
- User retention cohort analysis
- Geographic distribution (if available)
- Device/platform breakdown

**Course Analytics:**

- Most popular courses (by enrollment)
- Completion rate by course
- Average rating by course
- Drop-off points (lecture-level)
- Time to complete

**Engagement Analytics:**

- Daily/Weekly Active Users
- Average session duration
- Pages per session
- Quiz participation rate
- Live class attendance rate
- Material download stats

### 12.2 Reports

**Exportable Reports:**

1. **User Report**
   - Fields: Name, Email, Phone, Enrolled Courses, Status, Join Date
   - Filters: Date range, status, course
   - Format: CSV, Excel

2. **Enrollment Report**
   - Fields: Student, Course, Enrolled Date, Progress %, Status, Last Accessed
   - Filters: Course, date range, status
   - Format: CSV, Excel

3. **Revenue Report**
   - Fields: Date, User, Course, Amount, Payment Method, Status
   - Filters: Date range, course, status
   - Format: CSV, Excel, PDF

4. **Quiz Performance Report**
   - Fields: Quiz, Student, Score, Percentage, Time Taken, Date
   - Filters: Quiz, date range, score range
   - Format: CSV, Excel

5. **Course Completion Report**
   - Fields: Course, Students Enrolled, Completed, Completion Rate, Avg Time to Complete
   - Filters: Date range, category
   - Format: CSV, Excel, PDF

**Implementation:**

```typescript
// lib/reports.ts
import { Parser } from 'json2csv';

export async function generateUserReport(filters: any) {
  // Fetch data from Supabase
  const { data: users } = await supabase
    .from('users')
    .select(`
      name,
      email,
      phone_number,
      created_at,
      enrollments (count)
    `)
    .gte('created_at', filters.startDate)
    .lte('created_at', filters.endDate);

  // Convert to CSV
  const parser = new Parser({
    fields: ['name', 'email', 'phone_number', 'enrollments', 'created_at'],
  });
  const csv = parser.parse(users);

  return csv;
}
```

### 12.3 Real-Time Analytics

**Use Supabase Realtime:**

```typescript
// Subscribe to real-time enrollment changes
const subscription = supabase
  .channel('enrollments')
  .on(
    'postgres_changes',
    {
      event: 'INSERT',
      schema: 'public',
      table: 'enrollments',
    },
    (payload) => {
      console.log('New enrollment:', payload.new);
      // Update dashboard metrics in real-time
    }
  )
  .subscribe();
```

---

## 13. Implementation Roadmap

### 13.1 Phase 1: Foundation (Weeks 1-2)

**Goals:**
- Set up project structure
- Implement authentication
- Create base layout and navigation

**Tasks:**
1. **Project Setup**
   - Initialize Next.js project
   - Install dependencies (shadcn/ui, Supabase, React Query, etc.)
   - Configure Tailwind CSS
   - Set up TypeScript strict mode
   - Configure ESLint and Prettier

2. **Database Setup**
   - Create new tables (admin_roles, teacher_assignments, etc.)
   - Set up RLS policies
   - Generate TypeScript types from schema

3. **Authentication**
   - Implement login page
   - Supabase Auth integration
   - Middleware for route protection
   - Role-based access logic
   - Logout functionality

4. **Base Layout**
   - Create dashboard layout (topbar + sidebar)
   - Implement navigation menu
   - Role-based menu items
   - Responsive design (mobile hamburger)

5. **User Management (Basic)**
   - List all users (table view)
   - Search and filters
   - View user details (modal)

**Deliverables:**
- Working login system
- Protected dashboard routes
- Basic user list view

---

### 13.2 Phase 2: Core Features (Weeks 3-5)

**Goals:**
- Complete user and course management
- Implement quiz management
- Build analytics dashboard

**Tasks:**
1. **User Management (Complete)**
   - Create/edit users
   - Assign roles
   - Suspend/activate accounts
   - Bulk operations
   - Export users

2. **Course Management**
   - Course list view (table + filters)
   - Course editor (all tabs)
   - Curriculum builder (sections + lectures)
   - Video upload to Supabase Storage
   - Course materials upload
   - Publish/unpublish toggle
   - Course analytics page

3. **Lecture Management**
   - Lecture editor
   - Video upload/URL
   - Section organization
   - Required quiz assignment

4. **Quiz Management**
   - Quiz list view
   - Quiz editor (basic settings)
   - Question bank
   - Question editor (all content types)
   - Preview mode
   - Quiz analytics

5. **Admin Dashboard**
   - Metrics overview cards
   - Revenue trend chart
   - Enrollment trend chart
   - Recent activity feed
   - Quick actions

**Deliverables:**
- Full course CRUD functionality
- Quiz creation and editing
- Analytics dashboard with charts

---

### 13.3 Phase 3: Advanced Features (Weeks 6-7)

**Goals:**
- Live class management
- Payment and revenue tracking
- Communication tools

**Tasks:**
1. **Live Class Management**
   - Schedule view (calendar + list)
   - Create/edit live class
   - Zoom integration (API)
   - Auto-generate Zoom links
   - View attendance
   - Recording upload

2. **Enrollment Management**
   - Enrollment list view
   - Manual enrollment
   - Extend/revoke access
   - Enrollment analytics

3. **Payment & Revenue**
   - Transaction list
   - Filters and search
   - Razorpay integration
   - Webhook handler
   - Issue refunds
   - Revenue dashboard
   - Coupon management

4. **Communication Tools**
   - Announcement system
   - Create announcement
   - Target audience selection
   - Schedule announcements
   - Delivery tracking
   - Email notifications setup

5. **Activity Logs**
   - Log all admin actions
   - Activity log viewer
   - Filters (user, action, date)

**Deliverables:**
- Working live class scheduling
- Payment processing and tracking
- Announcement system

---

### 13.4 Phase 4: Polish & Launch (Week 8)

**Goals:**
- Complete testing
- Performance optimization
- Deploy to production

**Tasks:**
1. **Testing**
   - Unit tests for utilities
   - Integration tests for API routes
   - E2E tests for critical flows (Playwright)
   - Accessibility testing
   - Cross-browser testing
   - Mobile responsiveness testing

2. **Performance Optimization**
   - Code splitting
   - Image optimization
   - Lazy loading
   - Caching strategies
   - Database query optimization (indexes)

3. **Security Audit**
   - Review all RLS policies
   - Check for SQL injection vulnerabilities
   - Test authentication flows
   - Verify file upload security
   - Rate limiting implementation

4. **Documentation**
   - User manual (PDF)
   - Admin guide
   - Teacher guide
   - API documentation
   - Deployment guide

5. **Deployment**
   - Set up Vercel project
   - Configure environment variables
   - Set up custom domain
   - Configure SSL
   - Set up monitoring (Sentry)

6. **Launch**
   - Soft launch (internal testing)
   - Create initial admin accounts
   - Train admins and teachers
   - Production deployment
   - Monitor for issues

**Deliverables:**
- Fully tested admin panel
- Deployed to production
- Documentation completed
- User training completed

---

### 13.5 Post-Launch (Ongoing)

**Tasks:**
1. **Monitoring & Maintenance**
   - Monitor error logs (Sentry)
   - Monitor performance (Vercel Analytics)
   - Regular database backups
   - Security patches

2. **Feature Enhancements**
   - User feedback collection
   - Prioritize feature requests
   - Iterative improvements

3. **Optimizations**
   - Query performance tuning
   - UI/UX refinements
   - Mobile app (optional future)

---

## 14. Testing Strategy

### 14.1 Testing Levels

**Unit Tests:**
- Utility functions
- Validation schemas (Zod)
- Permission checks
- Date formatting
- Math calculations

**Integration Tests:**
- API routes
- Database queries
- Supabase integration
- External API integrations (Zoom, payment gateway)

**Component Tests:**
- UI components (shadcn/ui customizations)
- Forms (validation, submission)
- Tables (sorting, filtering)

**End-to-End Tests:**
- Login flow
- Course creation flow
- Quiz creation flow
- Payment flow
- User management flow

### 14.2 Testing Tools

**Framework:** Vitest (unit and integration tests)

**Component Testing:** React Testing Library

**E2E Testing:** Playwright

**Coverage:** Aim for 80%+ code coverage

**CI/CD Integration:** Run tests on every pull request (GitHub Actions)

### 14.3 Test Examples

**Unit Test (Permission Check):**

```typescript
// lib/permissions.test.ts
import { describe, it, expect } from 'vitest';
import { hasPermission, PERMISSIONS } from './permissions';

describe('hasPermission', () => {
  it('should allow super_admin to delete users', () => {
    expect(hasPermission('super_admin', 'USERS_DELETE')).toBe(true);
  });

  it('should deny teacher from deleting users', () => {
    expect(hasPermission('teacher', 'USERS_DELETE')).toBe(false);
  });

  it('should allow teacher to view courses', () => {
    expect(hasPermission('teacher', 'COURSES_VIEW')).toBe(true);
  });
});
```

**Component Test (Button):**

```typescript
// components/ui/Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { describe, it, expect, vi } from 'vitest';
import { Button } from './Button';

describe('Button', () => {
  it('should render with text', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('should call onClick when clicked', () => {
    const handleClick = vi.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('should be disabled when disabled prop is true', () => {
    render(<Button disabled>Click me</Button>);
    expect(screen.getByText('Click me')).toBeDisabled();
  });
});
```

**E2E Test (Login):**

```typescript
// e2e/login.spec.ts
import { test, expect } from '@playwright/test';

test('admin can login', async ({ page }) => {
  await page.goto('/login');

  // Fill in credentials
  await page.fill('input[name="email"]', 'admin@vidyaras.com');
  await page.fill('input[name="password"]', 'password123');

  // Click login button
  await page.click('button[type="submit"]');

  // Should redirect to dashboard
  await expect(page).toHaveURL('/admin/dashboard');

  // Should see dashboard heading
  await expect(page.locator('h1')).toContainText('Dashboard');
});
```

---

## 15. Deployment & DevOps

### 15.1 Environment Variables

**Required Environment Variables:**

```bash
# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJxxx...
SUPABASE_SERVICE_ROLE_KEY=eyJxxx... # Server-side only

# Zoom
ZOOM_CLIENT_ID=xxx
ZOOM_CLIENT_SECRET=xxx
ZOOM_ACCOUNT_ID=xxx
ZOOM_ACCESS_TOKEN=xxx

# Razorpay
RAZORPAY_KEY_ID=rzp_xxx
RAZORPAY_KEY_SECRET=xxx
RAZORPAY_WEBHOOK_SECRET=xxx

# Email (Resend or SendGrid)
EMAIL_API_KEY=xxx
EMAIL_FROM_ADDRESS=noreply@vidyaras.com

# Monitoring
NEXT_PUBLIC_SENTRY_DSN=https://xxx@xxx.ingest.sentry.io/xxx

# App
NEXT_PUBLIC_APP_URL=https://admin.vidyaras.com
```

### 15.2 Deployment Steps

**1. Vercel Setup:**

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Link project
vercel link

# Set environment variables
vercel env add NEXT_PUBLIC_SUPABASE_URL
# ... repeat for all env vars

# Deploy to production
vercel --prod
```

**2. Custom Domain:**

- Add domain in Vercel dashboard
- Update DNS records (CNAME or A record)
- SSL auto-configured by Vercel

**3. CI/CD Pipeline (GitHub Actions):**

```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

### 15.3 Monitoring

**Vercel Analytics:**
- Page load times
- Web Vitals (LCP, FID, CLS)
- Traffic sources

**Sentry (Error Tracking):**
- Runtime errors
- API errors
- User feedback

**Supabase Dashboard:**
- Database performance
- Query slowness
- Connection pooling

**Custom Logging:**
- Application logs (activity_logs table)
- Admin action audit trail

### 15.4 Backup Strategy

**Database Backups:**
- Supabase: Daily automated backups (built-in)
- Retention: 7 days (free tier) or 30 days (paid)
- Manual backups before major updates

**File Backups:**
- Supabase Storage: Redundant storage (auto)
- Manual backup of critical files to external storage

**Code Backups:**
- Git repository (GitHub)
- Multiple branches for different environments

---

## 16. Appendices

### Appendix A: Glossary

- **RLS:** Row Level Security - Database-level access control
- **RBAC:** Role-Based Access Control - Permission system based on user roles
- **SSR:** Server-Side Rendering - Rendering pages on the server
- **SSG:** Static Site Generation - Pre-rendering pages at build time
- **CSR:** Client-Side Rendering - Rendering pages in the browser
- **CRUD:** Create, Read, Update, Delete - Basic database operations
- **JWT:** JSON Web Token - Token-based authentication
- **WCAG:** Web Content Accessibility Guidelines - Accessibility standards
- **DAU/MAU:** Daily/Monthly Active Users - Engagement metrics
- **MRR/ARR:** Monthly/Annual Recurring Revenue - Revenue metrics

### Appendix B: References

- Next.js Documentation: https://nextjs.org/docs
- Supabase Documentation: https://supabase.com/docs
- shadcn/ui: https://ui.shadcn.com
- Tailwind CSS: https://tailwindcss.com/docs
- React Query: https://tanstack.com/query
- Zod: https://zod.dev
- Vercel: https://vercel.com/docs

### Appendix C: Contact Information

- **Project Lead:** [Name]
- **Tech Lead:** [Name]
- **Design Lead:** [Name]
- **Supabase Admin:** [Name]
- **Support Email:** support@vidyaras.com

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-17 | Claude | Initial specification document created |

---

**END OF SPECIFICATION DOCUMENT**
