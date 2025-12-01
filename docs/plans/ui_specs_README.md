# Dashboard UI Specifications - Quick Reference

> **📌 IMPORTANT:** All UI modules are part of the unified VidyaRas Dashboard, not standalone applications.
> They integrate with the existing sidebar layout and share a common design system.

**Purpose:** Detailed UI/UX specifications for VidyaRas dashboard interface design

---

## 📋 Documents

### 0. **Style Guidelines & Component Library** ⭐ START HERE
**File:** `ui_style_guidelines.md`

**Covers:**
- Complete design system (colors, spacing, typography)
- All 48 available shadcn/ui components
- Component usage patterns & examples
- Responsive design guidelines
- Accessibility requirements
- Common UI patterns (forms, lists, modals, etc.)

**This is your master reference** - Read this first before designing any module!

---

### 1. **Course Management UI Spec**
**File:** `ui_spec_course_management.md`

> Includes component recommendations at the top

**Covers:**
- Course Builder (5-step wizard)
- Course List (with filters)
- Module Manager (nested structure)
- Lesson Manager (within modules)
- Lecture Manager (recorded + live)
- Material Manager (PDF uploads)

**UI Screens:** 7 main screens
**Components:** ~150 elements
**Development Time:** 3-4 weeks

**Key Features:**
- Thumbnail upload
- Publish/draft toggle
- Drag-drop reordering
- Quiz linking in lectures
- Live class management

---

### 2. **Quiz Management UI Spec**
**File:** `ui_spec_quiz_management.md`

> Includes component recommendations at the top

**Covers:**
- Quiz Builder (two-panel editor)
- Question Editor (text/LaTeX/image support)
- Quiz List (with analytics)
- Quiz Preview (student view)
- Quiz Linking (dropdown in lecture editor)
- Quiz Attempt Viewer (with teacher feedback)

**UI Screens:** 6 main screens
**Components:** ~100 elements
**Development Time:** 2-3 weeks

**Key Features:**
- Flexible content types (text/LaTeX/image)
- Live LaTeX preview
- Option to link quiz to lecture/lesson
- Teacher feedback on attempts
- Bulk question operations

---

### 3. **Student Management UI Spec**
**File:** `ui_spec_student_management.md`

> Includes component recommendations at the top

**Covers:**
- Student List (table/cards with search)
- Student Detail (4 tabs: Overview, Enrollments, Progress, Payments)
- Enroll Student (4-step wizard)
- Bulk Enrollment
- Payment Tracking

**UI Screens:** 5 main screens
**Components:** ~140 elements
**Development Time:** 2-3 weeks

**Key Features:**
- Manual enrollment with payment tracking
- Progress monitoring per course
- Payment status management
- Bulk operations
- Advanced filters

---

## 🎯 Quick Navigation

### By Development Priority:
1. **Course Builder** (complete first - foundation)
2. **Module/Lesson/Lecture Manager** (core content management)
3. **Quiz Builder** (essential for gated content)
4. **Student List & Detail** (admin needs visibility)
5. **Enrollment & Payment** (monetization critical)

### By User Role:
- **Admin**: All features
- **Teacher**: Course + Quiz management (no payment editing)
- **Student**: Not applicable (mobile app only)

---

## 🔗 Cross-Feature Integration Points

### Quiz Linking
- **Location:** Lecture Manager (Add/Edit Lecture modal)
- **UI Element:** "Link Quiz" dropdown
- **Shows:** All available quizzes (grouped by course)
- **Behavior:** Select quiz → Students must pass to unlock lecture
- **Spec:** See `ui_spec_quiz_management.md` Section 4

### Course Association
- **Location:** Quiz Builder (Quiz Settings section)
- **UI Element:** "Link to Course" dropdown
- **Shows:** All courses + "Standalone" option
- **Behavior:** Optional - quiz can be independent
- **Spec:** See `ui_spec_quiz_management.md` Section 1

### Enrollment from Student Detail
- **Location:** Student Detail page → Enrollments tab
- **UI Element:** "Enroll in Course" button
- **Opens:** Enroll Student Modal (4-step wizard)
- **Spec:** See `ui_spec_student_management.md` Section 3

---

## 📊 Component Breakdown

### Reusable Components Needed:
- [ ] File Upload Widget (thumbnails, PDFs, images)
- [ ] Rich Text Editor (course descriptions, quiz questions)
- [ ] LaTeX Editor with Preview
- [ ] Drag-Drop List (reordering modules/lessons/lectures)
- [ ] Multi-Step Wizard (Course Builder, Enrollment)
- [ ] Data Table with Filters (Student List, Quiz Attempts)
- [ ] Status Badge (Published/Draft, Paid/Pending, Passed/Failed)
- [ ] Progress Bar (course progress, quiz score)
- [ ] Modal/Drawer (forms, confirmations)
- [ ] Toast Notifications (success/error messages)

---

## 🎨 Design System Requirements

### Colors
- **Primary:** Course Builder CTA, Publish buttons
- **Success:** Passed, Paid, Active
- **Warning:** Pending, Draft
- **Error:** Failed, Unpaid, Expired
- **Neutral:** Disabled, Inactive

### Typography
- **Headings:** Bold, large (page titles, section headers)
- **Body:** Regular, readable (forms, descriptions)
- **Monospace:** LaTeX editor, code inputs
- **Small:** Helper text, timestamps, badges

### Spacing
- **Tight:** Form fields (8px)
- **Medium:** Cards, sections (16px)
- **Loose:** Page layout (24-32px)

### Icons
- **Navigation:** ChevronLeft, ChevronRight, Menu
- **Actions:** Edit, Delete, Add, Upload, Download
- **Status:** Check, X, Clock, Lock, Eye
- **Content:** Video, Document, Quiz, Image

---

## ✅ Validation Rules Summary

### Course Builder
- Title: Required, max 200 chars
- Thumbnail: Required, JPG/PNG, max 2MB
- Description: Required, min 100 chars
- At least 1 module before publishing

### Quiz Builder
- Title: Required, max 200 chars
- At least 1 question before publishing
- Passing marks ≤ Total marks
- Each question: 2-6 options, 1 correct answer
- LaTeX syntax validation
- Image: max 5MB, JPG/PNG only

### Student Enrollment
- Course: Required (single selection)
- Duplicate enrollment check
- Payment amount > 0 if status = Paid
- Access duration > 0 if limited

---

## 🚀 Implementation Order

### Phase 1: Foundation (Week 1-2)
1. Design system setup (colors, typography, components)
2. Reusable components library
3. Dashboard layout (sidebar, header, routing)

### Phase 2: Course Management (Week 3-5)
1. Course Builder (5 steps)
2. Course List
3. Module Manager
4. Lesson Manager
5. Lecture Manager
6. Material Manager

### Phase 3: Quiz System (Week 6-7)
1. Quiz Builder (with LaTeX support)
2. Question Editor
3. Quiz List
4. Quiz Preview
5. Quiz Linking integration

### Phase 4: Student Management (Week 8-9)
1. Student List
2. Student Detail (4 tabs)
3. Enrollment Modal
4. Payment Tracking
5. Bulk Operations

---

## 📝 Notes for Designers

### Priority 1: Desktop Design
- Primary target: Desktop/laptop (1920x1080, 1440x900)
- Teachers/admins use desktop primarily

### Priority 2: Tablet Support
- Responsive layout for iPad (landscape)
- Touch-friendly controls
- Drawers instead of modals

### Priority 3: Mobile (Basic)
- Stack layout
- Simplified forms
- Bottom sheets for actions

### Accessibility
- Keyboard navigation throughout
- Screen reader support
- WCAG 2.1 Level AA compliance
- Focus indicators on all interactive elements

---

## 🔍 What's NOT in These Specs

- Backend API design (see `launch_fsd.md`)
- Database schema (see `launch_fsd.md`)
- Authentication flow
- App (Flutter) design
- Advanced analytics dashboards
- Email/notification templates
- Video streaming implementation
- Payment gateway integration

These specs focus purely on **dashboard UI/UX** for teachers and admins.

---

## 📂 Files Location

```
/docs/plans/
├── ui_style_guidelines.md         # ⭐ MASTER REFERENCE - Read first!
├── ui_spec_course_management.md   # Course, Module, Lesson, Lecture, Material
├── ui_spec_quiz_management.md     # Quiz Builder, Linking, Attempts
├── ui_spec_student_management.md  # Students, Enrollment, Payments
└── ui_specs_README.md             # This file (quick reference)
```

---

**Ready to design!** 🎨

Use these specs to create mockups, prototypes, or directly implement the UI. Each spec includes exact field requirements, validations, states, and behaviors.
