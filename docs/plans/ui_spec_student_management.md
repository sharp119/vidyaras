
> **📌 IMPORTANT MODULE NOTE:**  
> This is a **MODULE** of the VidyaRas Dashboard, NOT a standalone platform.  
> - Integrates into existing dashboard with sidebar navigation  
> - Uses shared design system and component library  
> - Should feel like part of the dashboard, not a separate app

**Part of:** VidyaRas Admin Dashboard  
**Design System Reference:** `ui_style_guidelines.md`  
**Component Library:** shadcn/ui + Tailwind CSS

---

## 🧩 shadcn Components to Use

**Student List:**
- `<Table />` - Student table (desktop)
- `<Card />` - Student cards (mobile/tablet)
- `<Input />` - Search bar
- `<Select />` - Filter & sort dropdowns
- `<Checkbox />` - Multi-select
- `<Badge />` - Enrollment/payment badges
- `<Avatar />` - Student profile pictures
- `<DropdownMenu />` - Action menu (3-dot)
- `<Skeleton />` - Loading table rows
- `<Pagination />` - Page navigation
- Empty state: Custom with illustration

**Student Detail (4 Tabs):**
- `<Tabs />` - Overview, Enrollments, Progress, Payments
- `<Card />` - Section containers
- `<Avatar />` - Large profile picture
- `<Badge />` - Status indicators
- `<Input />`, `<Textarea />` - Editable fields
- `<Button />` - Edit/save/enroll actions
- `<Progress />` - Course progress bars
- `<Select />` - Payment status dropdown
- `<Table />` (optional) - Payment records

**Enroll Student Modal (4-Step Wizard):**
- `<Dialog />` - Modal container
- Multi-step form within dialog
- `<RadioGroup />` - Course selection
- `<Input />` - Search courses
- `<Select />` - Enrollment type, payment status
- `<Calendar />` - Expiry date picker (if limited access)
- `<Switch />` - Lifetime/limited access toggle
- `<Button />` - Next/previous/enroll

**Bulk Enrollment:**
- `<Dialog />` - Bulk enroll modal
- `<Badge />` - Selected student count
- `<Select />` - Course dropdown
- `<Checkbox />` - "Same for all" toggle
- `<Progress />` - Enrollment progress bar

**Payment Tracking:**
- `<Badge />` - Payment status (Paid/Pending/NA)
- `<Select />` - Change status dropdown
- `<Dialog />` - Edit payment modal
- `<Input />` - Amount, date fields
- `<Calendar />` - Payment date picker

**Filters Panel:**
- `<Sheet />` - Filter drawer (mobile)
- `<Collapsible />` - Filter sections
- `<Checkbox />`, `<RadioGroup />` - Filter options
- `<Input />` - Range inputs (date, amount)
- `<Button />` - Apply/clear filters

**Notifications:**
- `toast()` from sonner - Success/error messages
- `<AlertDialog />` - Delete confirmation

---

**Design Tokens:**
```css
Primary: hsl(262 83% 58%)        /* Purple */
Success: hsl(142 76% 36%)        /* Green - Paid/Active */
Warning: hsl(38 92% 50%)         /* Orange - Pending */
Destructive: hsl(0 84.2% 60.2%)  /* Red - Expired */
Muted: hsl(240 5% 96%)           /* Gray backgrounds */
```

---

**Purpose:** Complete UI specification for viewing students, managing enrollments, and tracking payments

---
# Student Management - UI Specification

**Purpose:** Complete UI specification for viewing students, managing enrollments, and tracking payments

---

## 1. STUDENT LIST PAGE

### Current Functionality ✅
- None (needs to be built from scratch)

### Complete UI Elements Needed

#### **Header Section**
- [ ] Page title: "Students"
- [ ] **Total Student Count**
  - [ ] Display: "X Total Students"
  - [ ] Live counter updates
- [ ] **Quick Stats Cards** (optional)
  - [ ] Active Students (enrolled in ≥1 course)
  - [ ] Inactive Students (no enrollments)
  - [ ] Students with Pending Payments

#### **Search & Filter Bar**
- [ ] **Search Input**
  - [ ] Placeholder: "Search by name, email, or phone..."
  - [ ] Real-time search (debounced)
  - [ ] Clear search button (X icon)
- [ ] **Filter Dropdown**
  - [ ] All Students
  - [ ] Active (has enrollments)
  - [ ] Inactive (no enrollments)
  - [ ] With Pending Payments
  - [ ] By Enrollment Date Range
- [ ] **Sort Dropdown**
  - [ ] Recently Joined
  - [ ] Name (A-Z)
  - [ ] Name (Z-A)
  - [ ] Most Enrollments
- [ ] Export to CSV button (optional)

#### **Student Table/Cards**

**Table View (Desktop)**
Columns:
- [ ] Checkbox (for bulk selection)
- [ ] Avatar + Name
  - [ ] Profile picture (or initials if no picture)
  - [ ] Full name (clickable → opens detail page)
- [ ] Email
- [ ] Phone Number
- [ ] Enrollment Count
  - [ ] Display: "X courses"
  - [ ] Clickable (opens enrollments)
- [ ] Active Enrollments
  - [ ] Count of active (vs expired/completed)
- [ ] Pending Payments
  - [ ] Count or amount
  - [ ] Red badge if > 0
- [ ] Join Date
- [ ] **Actions Menu (3-dot menu)**
  - [ ] View Details (opens detail page)
  - [ ] Enroll in Course
  - [ ] View Progress
  - [ ] Send Message (optional)
  - [ ] Suspend Account (optional)
  - [ ] Delete Student (with confirmation)

**Card View (Mobile/Tablet)**
Each card shows:
- [ ] Avatar + Name
- [ ] Email + Phone
- [ ] Enrollment count badge
- [ ] Pending payment badge (if any)
- [ ] View Details button
- [ ] Quick action menu

#### **Empty State**
- [ ] Illustration
- [ ] Message: "No students found"
- [ ] "Students will appear here once they sign up"

#### **Pagination**
- [ ] Items per page: 25/50/100 dropdown
- [ ] Page numbers
- [ ] Previous/Next buttons
- [ ] "Showing X-Y of Z students" text

---

## 2. STUDENT DETAIL PAGE

### Access
- From Student List → Click student name or "View Details"

### UI Layout

#### **Header Section**
- [ ] Back to Student List button
- [ ] **Student Profile Header**
  - [ ] Large avatar (or initials)
  - [ ] Change picture button (admin only)
  - [ ] Full name (editable inline)
  - [ ] Email (editable inline)
  - [ ] Phone number (display only, verified)
  - [ ] Join date
  - [ ] Account status badge (Active/Suspended)

#### **Quick Actions Bar**
- [ ] Enroll in Course button (primary CTA)
- [ ] Send Message button (optional)
- [ ] Suspend/Activate toggle
- [ ] Delete Account button (destructive)

---

### **Tab Navigation**
Four tabs:
1. Overview
2. Enrollments
3. Progress & Activity
4. Payment History

---

### **TAB 1: Overview**

#### **Personal Information Card**
- [ ] Full Name (editable)
- [ ] Email (editable)
- [ ] Phone Number (display only)
- [ ] Date of Birth (editable, optional)
- [ ] Gender (dropdown, optional)
- [ ] Address (textarea, optional)
- [ ] Edit Info button
- [ ] Save Changes button

#### **Account Statistics**
- [ ] Total Enrollments (clickable → Enrollments tab)
- [ ] Active Courses
- [ ] Completed Courses
- [ ] Total Quiz Attempts
- [ ] Average Quiz Score
- [ ] Total Learning Hours (optional)
- [ ] Join Date
- [ ] Last Active Date

#### **Recent Activity Feed** (optional)
- [ ] Last 5 activities:
  - [ ] Enrolled in course X
  - [ ] Completed lecture Y
  - [ ] Passed quiz Z
  - [ ] Accessed course materials
- [ ] View All Activity button (→ Activity tab)

---

### **TAB 2: Enrollments**

#### **Header Actions**
- [ ] **Enroll in Course Button** (opens enrollment modal)
- [ ] Filter dropdown:
  - [ ] All Enrollments
  - [ ] Active Only
  - [ ] Completed Only
  - [ ] Expired Only
- [ ] Sort dropdown:
  - [ ] Recent First
  - [ ] Course Name (A-Z)
  - [ ] Progress (High to Low)

#### **Enrollment Cards**
Each card shows:
- [ ] **Course Header**
  - [ ] Course thumbnail
  - [ ] Course title (clickable → course detail)
  - [ ] Instructor name
- [ ] **Enrollment Info**
  - [ ] Enrollment status badge (Active/Completed/Expired)
  - [ ] Enrollment type badge (Free/Paid)
  - [ ] Enrolled date
  - [ ] Expires on (if applicable)
- [ ] **Progress Bar**
  - [ ] Percentage completed (e.g., "45%")
  - [ ] Visual progress bar
  - [ ] Completed lectures / Total lectures
- [ ] **Payment Status** (if paid course)
  - [ ] Status badge: PAID (green) / PENDING (orange) / NA (gray)
  - [ ] Amount paid (e.g., "₹5,000")
  - [ ] Payment date
  - [ ] **Change Payment Status** dropdown:
    - [ ] Mark as Paid
    - [ ] Mark as Pending
    - [ ] Mark as N/A
  - [ ] Edit Payment button (opens modal)
- [ ] **Quick Actions**
  - [ ] View Progress (→ Progress tab)
  - [ ] Extend Enrollment (add more days)
  - [ ] Unenroll (with confirmation)

#### **Empty State**
- [ ] "Not enrolled in any courses yet"
- [ ] Enroll in Course button

---

### **TAB 3: Progress & Activity**

#### **Course Progress Section**
For each enrolled course:
- [ ] **Course Name Header** (expandable)
- [ ] Overall Progress (percentage + bar)
- [ ] **Module-wise Breakdown** (expanded)
  - [ ] Module name
  - [ ] Lectures completed / Total lectures
  - [ ] Progress percentage
  - [ ] Last accessed date
  - [ ] View Details (→ detailed lecture list)

#### **Lecture Completion Details** (nested)
- [ ] Lecture title
- [ ] Status: Completed (✓) / In Progress / Not Started
- [ ] Completion date (if completed)
- [ ] Watch time (for videos)

#### **Quiz Attempts Section**
- [ ] **Quiz Attempts List**
  - [ ] Quiz title (clickable → attempt viewer)
  - [ ] Attempt date
  - [ ] Score (e.g., "75/100")
  - [ ] Percentage (e.g., "75%")
  - [ ] Result badge (PASSED/FAILED)
  - [ ] View Details button
- [ ] Filter by course dropdown

#### **Activity Timeline** (optional)
- [ ] Chronological activity feed
  - [ ] Date/time
  - [ ] Activity type icon
  - [ ] Activity description
  - [ ] Course name (if applicable)
- [ ] Load More button

---

### **TAB 4: Payment History**

#### **Payment Summary Cards**
- [ ] Total Amount Paid (all courses)
- [ ] Total Amount Pending
- [ ] Last Payment Date
- [ ] Next Payment Due (if EMI)

#### **Payment Records Table**
Columns:
- [ ] Course Name
- [ ] Enrollment Date
- [ ] Amount
- [ ] Payment Status (PAID/PENDING/NA badge)
- [ ] Payment Date
- [ ] Payment Method (Manual/Online) (optional)
- [ ] Receipt (download link) (optional)
- [ ] **Actions**
  - [ ] Edit Payment Status
  - [ ] Add Payment Record (if pending)
  - [ ] View Details

#### **Add/Edit Payment Modal**
- [ ] Course dropdown (auto-filled if from enrollment)
- [ ] Amount (number input, ₹ prefix)
- [ ] Payment Status dropdown (Paid/Pending/NA)
- [ ] Payment Date (date picker)
- [ ] Payment Method dropdown (Manual/Online/Cash/UPI) (optional)
- [ ] Notes textarea (optional)
- [ ] Save button
- [ ] Cancel button

#### **Empty State**
- [ ] "No payment records yet"
- [ ] Add Payment Record button (if enrollments exist)

---

## 3. ENROLL STUDENT MODAL

### Access
- From Student Detail → Enroll in Course button
- From Student List → Actions → Enroll in Course

### UI Elements

#### **Step 1: Select Course**
- [ ] **Course Search/Filter**
  - [ ] Search input
  - [ ] Filter by category
  - [ ] Filter by type (Live/Recorded/Free)
- [ ] **Course List** (radio selection)
  - [ ] Course thumbnail
  - [ ] Course title
  - [ ] Instructor
  - [ ] Type badge (Live/Recorded/Free)
  - [ ] Price
  - [ ] Radio button (single selection)
- [ ] Next button (disabled until course selected)

#### **Step 2: Enrollment Details**
- [ ] **Selected Course Display**
  - [ ] Course thumbnail + title
  - [ ] Change Course button
- [ ] **Enrollment Type**
  - [ ] Radio: Free Enrollment
  - [ ] Radio: Paid Enrollment
  - [ ] Auto-selected based on course type
- [ ] **Enrollment Status** (dropdown)
  - [ ] Active (default)
  - [ ] Trial (optional)
- [ ] **Access Duration**
  - [ ] Radio: Lifetime Access
  - [ ] Radio: Limited Access
  - [ ] If Limited: Days input (number)
  - [ ] Expiry date preview (auto-calculated)

#### **Step 3: Payment Details** (if Paid Enrollment)
- [ ] **Payment Status** (dropdown)
  - [ ] Paid
  - [ ] Pending
  - [ ] N/A
- [ ] **Amount** (number input, ₹ prefix)
  - [ ] Pre-filled with course price
  - [ ] Editable
- [ ] **Payment Date** (date picker)
  - [ ] Default: Today
- [ ] **Payment Method** (dropdown, optional)
  - [ ] Manual
  - [ ] Online
  - [ ] Cash
  - [ ] UPI
  - [ ] Bank Transfer
- [ ] **Notes** (textarea, optional)
  - [ ] Placeholder: "Add payment notes..."

#### **Step 4: Review & Confirm**
- [ ] **Summary Card**
  - [ ] Student: [Name]
  - [ ] Course: [Title]
  - [ ] Enrollment Type: Free/Paid
  - [ ] Status: Active/Trial
  - [ ] Access: Lifetime / Expires on [Date]
  - [ ] **If Paid:**
    - [ ] Amount: ₹X
    - [ ] Payment Status: Paid/Pending/NA
    - [ ] Payment Date: [Date]
- [ ] Edit buttons for each section (go back to step)
- [ ] **Enroll Student Button** (primary CTA)
- [ ] Cancel button

#### **Success State**
- [ ] Success icon
- [ ] "Student enrolled successfully!"
- [ ] View Enrollment button (→ Student Detail, Enrollments tab)
- [ ] Enroll Another Student button
- [ ] Close button

---

## 4. BULK ENROLLMENT MODAL

### Access
- From Student List → Select multiple students → Bulk Enroll

### UI Elements

#### **Selected Students Display**
- [ ] "Enrolling X students" header
- [ ] List of selected students (name + email)
- [ ] Remove individual student button
- [ ] Clear all button

#### **Course Selection**
- [ ] Course dropdown/search (same as single enrollment)
- [ ] Selected course preview

#### **Enrollment Settings** (same as single)
- [ ] Enrollment type
- [ ] Access duration
- [ ] Payment settings (if paid)
  - [ ] Same for all toggle
  - [ ] Individual payment settings (advanced)

#### **Confirm & Enroll**
- [ ] Summary preview
- [ ] Enroll All button
- [ ] Progress indicator (during enrollment)
- [ ] Success/failure count

---

## 5. BULK OPERATIONS (Student List)

### Multi-Select Mode
- [ ] Checkbox column in table
- [ ] Select All checkbox (header)
- [ ] **Bulk Actions Toolbar** (appears when items selected)
  - [ ] Selected count display (e.g., "5 students selected")
  - [ ] Enroll in Course button
  - [ ] Send Message button (optional)
  - [ ] Export Selected button
  - [ ] Delete Selected button (with confirmation)
  - [ ] Clear Selection button

---

## 6. VALIDATION & ERROR STATES

### Form Validation
- [ ] Required field indicators (red asterisk)
- [ ] **Enrollment Validation**
  - [ ] Check for duplicate enrollment (student already enrolled)
  - [ ] Warning: "Already enrolled in this course"
  - [ ] Option: Re-enroll or Extend existing
- [ ] **Payment Validation**
  - [ ] Amount must be > 0 if status = Paid
  - [ ] Payment date cannot be future
- [ ] **Access Duration Validation**
  - [ ] Days must be > 0 if limited access

### Loading States
- [ ] Skeleton loaders for student cards
- [ ] Spinner during enrollment
- [ ] Progress bar for bulk operations
- [ ] "Loading student details..." overlay

### Success States
- [ ] Toast: "Student enrolled successfully"
- [ ] Toast: "Payment status updated"
- [ ] Toast: "Student information saved"
- [ ] Toast: "X students enrolled"

### Error States
- [ ] Toast: "Enrollment failed"
- [ ] Toast: "Duplicate enrollment detected"
- [ ] Inline error: "Invalid payment amount"
- [ ] Alert: "Cannot delete student with active enrollments"

---

## 7. FILTERS & SEARCH

### Advanced Filters (Collapsible Panel)
- [ ] **Enrollment Filters**
  - [ ] Has enrollments (yes/no)
  - [ ] Enrolled in course (dropdown)
  - [ ] Enrollment count range (min-max)
- [ ] **Payment Filters**
  - [ ] Has pending payments (yes/no)
  - [ ] Payment status (Paid/Pending/NA)
  - [ ] Amount range (min-max)
- [ ] **Activity Filters**
  - [ ] Last active date range
  - [ ] Join date range
- [ ] Apply Filters button
- [ ] Clear Filters button

### Search Behavior
- [ ] Search in: Name, Email, Phone
- [ ] Minimum 2 characters to trigger
- [ ] Real-time results (300ms debounce)
- [ ] Show "Searching..." indicator
- [ ] Show result count
- [ ] Clear search button

---

## 8. RESPONSIVE BEHAVIOR

### Desktop (Primary)
- [ ] Full table layout
- [ ] Sidebar filters
- [ ] Modal for enrollment
- [ ] Multi-column layout for detail page

### Tablet
- [ ] Card grid (2 columns)
- [ ] Drawer for filters
- [ ] Drawer for enrollment
- [ ] Tabs for detail page

### Mobile (Basic Support)
- [ ] Single column card list
- [ ] Bottom sheet for filters
- [ ] Full-screen enrollment form
- [ ] Accordion sections for detail page

---

## 9. ACCESSIBILITY

- [ ] Keyboard navigation
  - [ ] Tab through student list
  - [ ] Arrow keys for table navigation
  - [ ] Enter to open details
- [ ] Screen reader labels
  - [ ] "Student X of Y"
  - [ ] "Enrollment status: Active"
  - [ ] "Payment pending: Amount ₹X"
- [ ] Focus indicators
- [ ] Aria labels for status badges
- [ ] Color contrast compliance
- [ ] Form labels properly associated

---

## 10. EXPORT & REPORTING (Optional)

### Export Options
- [ ] Export Student List to CSV
  - [ ] All students or selected
  - [ ] Include enrollments checkbox
  - [ ] Include payment info checkbox
- [ ] Export Enrollment Report (per student)
  - [ ] PDF format
  - [ ] Includes course progress
  - [ ] Payment history
- [ ] Export Payment Report
  - [ ] Date range selector
  - [ ] CSV or PDF

### Print Views
- [ ] Print Student Profile (detail page)
- [ ] Print Enrollment Certificate (optional)
- [ ] Print Payment Receipt (optional)

---

## 11. ADVANCED FEATURES (Optional/Future)

### Communication
- [ ] Send Email to Student(s)
- [ ] Send SMS notification
- [ ] In-app messaging

### Automation
- [ ] Auto-enroll on payment
- [ ] Auto-expire based on date
- [ ] Auto-send reminders for pending payments

### Analytics
- [ ] Student Engagement Score
- [ ] Completion Rate per Student
- [ ] Revenue per Student

---

## Summary of UI Screens

1. **Student List** (table/cards with search & filters) - BROWSE
2. **Student Detail** (4 tabs: Overview, Enrollments, Progress, Payments) - VIEW
3. **Enroll Student Modal** (4-step wizard) - ENROLL
4. **Bulk Enrollment Modal** (multi-student enrollment) - BULK ENROLL
5. **Edit Payment Modal** (payment status & details) - PAYMENT

---

## UI Components Summary

**Student List:** 25 elements
**Student Detail:** 60+ elements (across 4 tabs)
**Enrollment Modal:** 30 elements
**Payment Modal:** 15 elements
**Bulk Operations:** 10 elements

**Total UI Components:** ~140 individual elements
**Estimated Development Time:** 2-3 weeks for complete student management UI

---

## Data Privacy & Security Notes

### Display Rules
- [ ] Mask phone numbers (show last 4 digits only)
- [ ] Mask email addresses (optional, for privacy)
- [ ] Hide sensitive payment info from teachers (admin only)

### Permission Checks
- [ ] Admin: Full access (all features)
- [ ] Teacher: View only (no payment editing)
- [ ] Student: Cannot access other students' data

### Audit Trail (Optional)
- [ ] Log enrollment changes
- [ ] Log payment status changes
- [ ] Log student info edits
- [ ] Display "Last modified by X on Date" info
