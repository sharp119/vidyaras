
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

**Course Builder (5-Step Wizard):**
- `<Tabs />` - Step navigation
- `<Card />` - Step content container
- `<Input />`, `<Textarea />` - Text fields
- `<Select />` - Dropdowns (category, language, difficulty)
- `<RadioGroup />` - Course type selection
- `<Switch />` - Toggles (published, free, EMI)
- `<Badge />` - Status display (Draft/Published)
- `<Button />` - Actions (Save, Publish, Cancel)
- File upload: Custom component with drag-drop

**Course List:**
- `<Card />` - Course cards
- `<Input />` - Search bar
- `<Select />` - Filter & sort dropdowns
- `<DropdownMenu />` - 3-dot action menu
- `<Badge />` - Status badges
- `<AlertDialog />` - Delete confirmation
- `<Skeleton />` - Loading cards
- Empty state: Custom with illustration

**Module/Lesson/Lecture Manager:**
- `<Accordion />` - Collapsible modules
- `<Dialog />` - Add/edit modals
- `<Input />`, `<Textarea />` - Form fields
- `<Button />` - Add/edit/delete actions
- Drag-drop: `@dnd-kit/core` (external)
- `<Badge />` - Type indicators (Recorded/Live)
- `<Calendar />` - Schedule picker for live classes
- `<Select />` - Quiz linking dropdown

**Material Upload:**
- `<Dialog />` - Upload modal
- Custom file upload with `<Progress />` bar
- `<Button />` - Upload/cancel buttons

**Notifications:**
- `toast()` from sonner - Success/error messages

---

**Design Tokens:**
```css
Primary: hsl(262 83% 58%)        /* Purple buttons, links */
Success: hsl(142 76% 36%)        /* Green badges */
Destructive: hsl(0 84.2% 60.2%)  /* Red delete buttons */
Border Radius: 0.75rem
```

---

**Purpose:** Complete UI specification for course creation, editing, and content management

---
# Course Management - UI Specification

**Purpose:** Complete UI specification for course creation, editing, and content management

---

## 1. COURSE BUILDER (Main Course Creation/Edit)

### Current Functionality ✅
- Basic Info form (title, instructor, description)
- Step wizard interface (5 steps: Basic Info, Content, Curriculum, Pricing, Review)
- What You Learn (array of learning objectives)
- Course Includes (array of features)
- Prerequisites (array of requirements)
- Curriculum structure input (sections with lessons)
- Pricing configuration (free/paid, EMI options)
- Live batch information (name, schedule, time, capacity)
- JSON export (final output preview)
- AI-powered content generation (via floating chat)

### Missing Functionality ❌
- **Thumbnail upload** (image upload with preview)
- **Save to database button** (instead of just JSON export)
- **Edit mode** (load existing course data for editing)
- **Publish/Unpublish toggle** (draft vs published state)
- **Category selector** (multi-select dropdown)
- **Language selector** (Hindi/English/Bilingual)
- **Course visibility toggle** (visible/hidden from students)
- **Delete course button** (with confirmation)
- **Auto-save draft** (save progress automatically)

### Complete UI Elements Needed

#### **Step 1: Basic Information**
- [ ] Course Title (text input, required, max 200 chars)
- [ ] Instructor Name (text input, required)
- [ ] Description (rich text editor, required, min 100 chars)
- [ ] **Thumbnail Upload**
  - [ ] Image upload area (drag-drop or click)
  - [ ] Preview thumbnail (150x150px preview)
  - [ ] Remove/replace button
  - [ ] File requirements hint (JPG/PNG, max 2MB, 1200x600px recommended)
- [ ] **Category Tags**
  - [ ] Multi-select dropdown
  - [ ] Options: Music, Wellness, Yoga, Arts, Life Skills, Dance, Meditation, Cooking
  - [ ] Display selected tags as chips (removable)
- [ ] **Language Selector**
  - [ ] Radio buttons: Hindi / English / Bilingual
  - [ ] Default: Bilingual
- [ ] **Course Type**
  - [ ] Radio buttons: Live Course / Recorded Course / Free Course
  - [ ] Conditional fields based on selection

#### **Step 2: Content Details**
- [ ] What You'll Learn (list builder)
  - [ ] Add item button
  - [ ] Text input per item (max 200 chars)
  - [ ] Remove item button
  - [ ] Drag to reorder
  - [ ] AI generate button (auto-fill)
- [ ] Prerequisites (list builder, same as above)
- [ ] Course Includes (list builder, same as above)

#### **Step 3: Curriculum (Module Structure Only)**
*Note: Actual lessons/lectures added later via Module Manager*
- [ ] Add Module button
- [ ] Module cards showing:
  - [ ] Module title (editable inline)
  - [ ] Module order number
  - [ ] Remove module button
  - [ ] Drag handle for reordering
- [ ] Empty state: "Add modules to organize your course"
- [ ] Helper text: "You'll add lessons and lectures to modules later"

#### **Step 4: Pricing**
- [ ] **Free Course Toggle**
  - [ ] If ON: Disable all pricing inputs
- [ ] **Full Price** (number input, ₹ symbol prefix)
- [ ] **EMI Option Toggle**
  - [ ] If ON: Show EMI fields
  - [ ] Monthly Price (number input)
  - [ ] EMI Tenure (dropdown: 3/6/9/12 months)
- [ ] **Live Batch Configuration** (only if course type = live)
  - [ ] Batch Name (text input)
  - [ ] Schedule (text input, e.g., "Mon, Wed, Fri")
  - [ ] Time (time picker, e.g., "7:00 PM IST")
  - [ ] Capacity (number input)

#### **Step 5: Review & Publish**
- [ ] Full course preview (read-only)
- [ ] **Publish Options**
  - [ ] Save as Draft button
  - [ ] Publish Course button
  - [ ] Visibility toggle (Visible to Students / Hidden)
- [ ] JSON export button (for reference)
- [ ] Validation warnings (if any required fields missing)

#### **Top Bar Actions (All Steps)**
- [ ] Save Draft button (always visible)
- [ ] Discard Changes button
- [ ] Preview Course button (opens student view in new tab)
- [ ] Exit button (back to course list)

---

## 2. COURSE LIST PAGE

### UI Elements

#### **Header Section**
- [ ] Page title: "All Courses"
- [ ] Create New Course button (primary CTA)
- [ ] Search bar (search by title/instructor)
- [ ] Filter dropdown:
  - [ ] All Courses
  - [ ] Published Only
  - [ ] Drafts Only
  - [ ] Live Courses
  - [ ] Recorded Courses
  - [ ] Free Courses
- [ ] Sort dropdown:
  - [ ] Recently Updated
  - [ ] Recently Created
  - [ ] Alphabetical (A-Z)
  - [ ] Most Enrollments

#### **Course Cards (Grid or List View)**
Each card shows:
- [ ] Thumbnail image
- [ ] Course title
- [ ] Instructor name
- [ ] Status badge (Published/Draft/Hidden)
- [ ] Course type badge (Live/Recorded/Free)
- [ ] Enrollment count (icon + number)
- [ ] Last updated date
- [ ] **Quick Actions Menu (3-dot menu)**
  - [ ] Edit Course (opens Course Builder in edit mode)
  - [ ] Manage Modules (opens Module Manager)
  - [ ] View as Student (preview)
  - [ ] Duplicate Course
  - [ ] Publish/Unpublish toggle
  - [ ] Hide/Show toggle
  - [ ] Delete Course (with confirmation dialog)

#### **Empty State**
- [ ] Illustration
- [ ] Message: "No courses yet"
- [ ] Create First Course button

---

## 3. MODULE MANAGER (Per Course)

### Access
- From Course List → Click "Manage Modules" on course card
- Or from Course Builder Step 3 → "Manage Modules in Detail" button

### UI Layout

#### **Header**
- [ ] Course title display (with thumbnail)
- [ ] Back to Course List button
- [ ] Edit Course Info button (opens Course Builder)
- [ ] Course status badge

#### **Module List (Collapsible Accordion)**
Each module shows:
- [ ] **Module Header (Collapsed State)**
  - [ ] Drag handle (for reordering)
  - [ ] Module number (auto-generated)
  - [ ] Module title (editable inline)
  - [ ] Lesson count (e.g., "5 lessons")
  - [ ] Total duration (e.g., "2h 30m")
  - [ ] Expand/collapse icon
  - [ ] Delete module button
  - [ ] Edit module button (modal or inline)

- [ ] **Module Content (Expanded State)**
  - [ ] Lesson list (nested inside module)
  - [ ] Add Lesson button
  - [ ] Empty state if no lessons: "No lessons in this module yet"

#### **Add Module Button**
- [ ] Fixed at bottom or top
- [ ] Opens modal:
  - [ ] Module Title input
  - [ ] Create button
  - [ ] Cancel button

---

## 4. LESSON MANAGER (Within Module)

### UI Elements (Nested in Module)

#### **Lesson Cards (Inside Expanded Module)**
Each lesson card shows:
- [ ] Drag handle (reorder within module)
- [ ] Lesson number (auto within module)
- [ ] Lesson title (editable inline)
- [ ] Lecture count (e.g., "3 lectures")
- [ ] Material count (e.g., "2 materials")
- [ ] **Live Course Only:**
  - [ ] "Mark as Current" button (highlights lesson)
  - [ ] "Current Lesson" badge (if marked)
  - [ ] "Set Live" toggle (green when live)
  - [ ] "Live Now" badge (if toggle ON)
- [ ] Expand to show lectures/materials
- [ ] Edit lesson button
- [ ] Delete lesson button

#### **Add Lesson Button**
- [ ] Inside each module
- [ ] Opens modal/drawer:
  - [ ] Lesson Title (text input, required)
  - [ ] Description (textarea, optional)
  - [ ] Create Lesson button
  - [ ] Cancel button

#### **Lesson Detail View (Expanded)**
Shows:
- [ ] **Lectures Section**
  - [ ] Lecture list (see Lecture Manager below)
  - [ ] Add Lecture button
- [ ] **Materials Section**
  - [ ] Material list (see Material Manager below)
  - [ ] Upload Material button

---

## 5. LECTURE MANAGER (Within Lesson)

### UI Elements (Nested in Lesson)

#### **Add Lecture Options**
Two buttons:
- [ ] + Add Recorded Lecture
- [ ] + Add Live Lecture

#### **Add Recorded Lecture Modal**
- [ ] Lecture Title (text input, required)
- [ ] Description (textarea, optional)
- [ ] **Google Drive Video URL** (text input, required)
  - [ ] Validation hint: "Enter shareable Google Drive link"
  - [ ] Test link button (optional)
- [ ] Duration (number input, minutes)
- [ ] **Link Quiz (Optional)**
  - [ ] Dropdown: "Select quiz to unlock this lecture"
  - [ ] Shows all available quizzes
  - [ ] "None" option (default)
  - [ ] Helper text: "Students must pass this quiz before accessing lecture"
- [ ] Save Lecture button
- [ ] Cancel button

#### **Add Live Lecture Modal**
- [ ] Lecture Title (text input, required)
- [ ] Description (textarea, optional)
- [ ] **Live Class URL** (text input, required)
  - [ ] Placeholder: "Enter Zoom, Google Meet, or any meeting link"
- [ ] Scheduled Date & Time (datetime picker)
- [ ] Duration (number input, minutes)
- [ ] **Link Quiz (Optional)** (same as recorded)
- [ ] Save Lecture button
- [ ] Cancel button

#### **Lecture Cards (List View)**
Each lecture shows:
- [ ] Drag handle (reorder)
- [ ] Lecture number
- [ ] Lecture title (editable inline)
- [ ] Type badge (Recorded/Live)
- [ ] Duration
- [ ] **If Recorded:**
  - [ ] Video link preview (truncated)
  - [ ] Open video button
- [ ] **If Live:**
  - [ ] Scheduled date/time
  - [ ] Join link preview (truncated)
  - [ ] Open link button
  - [ ] **Add Recording button** (for past live lectures)
    - [ ] Opens modal to add Google Drive recording URL
    - [ ] Converts to "hybrid" lecture (both live link + recording)
- [ ] **If Quiz Linked:**
  - [ ] Quiz badge (shows quiz title)
  - [ ] Remove quiz link button
- [ ] Edit lecture button (opens same modal as add)
- [ ] Delete lecture button

---

## 6. MATERIAL MANAGER (Within Lesson)

### UI Elements (Nested in Lesson)

#### **Upload Material Button**
Opens modal/drawer:
- [ ] File Upload Area
  - [ ] Drag-drop zone
  - [ ] Or click to browse
  - [ ] Accepted: PDF, DOC, DOCX, PPT, PPTX, images
  - [ ] Max size: 50MB
  - [ ] Upload progress bar (when uploading)
- [ ] Material Title (text input, auto-filled from filename)
- [ ] Upload button
- [ ] Cancel button

#### **Material Cards (List View)**
Each material shows:
- [ ] File icon (based on type: PDF, DOC, image, etc.)
- [ ] Material title
- [ ] File type (PDF, DOC, etc.)
- [ ] File size (e.g., "2.5 MB")
- [ ] Upload date
- [ ] Preview button (opens in new tab)
- [ ] Download button
- [ ] Delete button (with confirmation)

#### **Empty State**
- [ ] Icon
- [ ] "No materials uploaded yet"
- [ ] Upload Material button

---

## 7. COURSE DETAIL PAGE (Read-Only View)

### Access
- From Course List → View as Student

### UI Sections
- [ ] Course header (thumbnail, title, instructor, rating)
- [ ] Enrollment info (enrolled count, price)
- [ ] Course description
- [ ] What You'll Learn section
- [ ] Prerequisites section
- [ ] Course Includes section
- [ ] **Full Curriculum Display**
  - [ ] Modules (expandable)
  - [ ] Lessons (expandable)
  - [ ] Lectures (with type badges, duration)
  - [ ] Materials (download links)
  - [ ] Locked lectures (if quiz prerequisite exists)
- [ ] Reviews section (if any)
- [ ] Live batch info (if live course)

---

## 8. BULK OPERATIONS

### Multi-Select Mode
- [ ] Select multiple courses checkbox (on course list)
- [ ] Bulk actions toolbar (when items selected):
  - [ ] Publish Selected
  - [ ] Unpublish Selected
  - [ ] Hide Selected
  - [ ] Delete Selected (with confirmation)

---

## 9. VALIDATION & ERROR STATES

### Form Validation
- [ ] Required field indicators (red asterisk)
- [ ] Inline error messages (below field)
- [ ] Error summary at top (if form submission fails)
- [ ] Prevent duplicate course titles (warning)
- [ ] URL validation for Google Drive/live class links
- [ ] Image upload validation (size, format)

### Loading States
- [ ] Skeleton loaders for course cards
- [ ] Spinner during save/publish
- [ ] Upload progress bars for images/materials
- [ ] Disabled buttons during API calls

### Success States
- [ ] Toast notification: "Course created successfully"
- [ ] Toast notification: "Module added"
- [ ] Toast notification: "Lecture saved"
- [ ] Toast notification: "Material uploaded"
- [ ] Confirmation before destructive actions (delete)

---

## 10. RESPONSIVE BEHAVIOR

### Desktop (Primary)
- [ ] Full layout with sidebar
- [ ] Drag-drop enabled
- [ ] Modals for forms

### Tablet
- [ ] Collapsible sidebar
- [ ] Touch-friendly drag handles
- [ ] Drawer instead of modals

### Mobile (Basic Support)
- [ ] List view only (no grid)
- [ ] Bottom sheet for forms
- [ ] No drag-drop (manual reorder with buttons)

---

## 11. ACCESSIBILITY

- [ ] Keyboard navigation (Tab, Enter, Escape)
- [ ] Screen reader labels
- [ ] Focus indicators
- [ ] Aria labels for icons
- [ ] Color contrast compliance

---

## Summary of UI Screens

1. **Course Builder** (5-step wizard) - CREATE/EDIT
2. **Course List** (grid/list view with filters) - BROWSE
3. **Module Manager** (accordion layout per course) - MANAGE STRUCTURE
4. **Lesson Manager** (nested in modules) - MANAGE CONTENT
5. **Lecture Manager** (nested in lessons) - MANAGE VIDEOS
6. **Material Manager** (nested in lessons) - MANAGE FILES
7. **Course Detail** (read-only student view) - PREVIEW

---

**Total UI Components:** ~150 individual elements
**Estimated Development Time:** 3-4 weeks for complete course management UI
