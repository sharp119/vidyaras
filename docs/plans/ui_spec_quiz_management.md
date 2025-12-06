
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

**Quiz Builder (Two-Panel Layout):**
- `<Card />` - Settings panel & question editor
- `<Input />`,`<Textarea />` - Form fields
- `<Select />` - Dropdowns (difficulty, course association)
- `<Switch />` - Published/public toggles
- `<Tabs />` - Content type selector (Text/LaTeX/Image)
- `<RadioGroup />` - Correct answer selection
- `<Badge />` - Status badges, marks display
- `<Button />` - Add/edit/delete/save actions
- `<ScrollArea />` - Question list
- Drag-drop: `@dnd-kit/core` for question reordering

**Question Editor:**
- Rich text: `<Textarea />` or custom editor
- LaTeX: Custom input with live preview (KaTeX/MathJax)
- Image upload: Custom component
- `<Label />` - Field labels
- `<Button />` - Add/remove options

**Quiz List:**
- `<Card />` - Quiz cards
- `<Input />` - Search bar
- `<Select />` - Filter & sort
- `<DropdownMenu />` - Action menu
- `<Badge />` - Status/difficulty badges
- `<AlertDialog />` - Delete confirmation
- `<Skeleton />` - Loading states

**Quiz Preview:**
- `<Card />` - Question cards
- `<RadioGroup />` - Options display
- `<Badge />` - Correct answer indicator (teacher view)
- `<Collapsible />` - Explanation sections
- `<Button />` - Navigation

**Quiz Linking (in Lecture Editor):**
- `<Select />` with grouping - Quiz dropdown
  - Group 1: Course quizzes
  - Group 2: Standalone quizzes
  - Group 3: Other courses
- `<Badge />` - Selected quiz display
- `<Button />` - Create new quiz link

**Attempt Viewer:**
- `<Card />` - Attempt overview & questions
- `<Badge />` - Correct/wrong indicators
- `<Textarea />` - Teacher notes
- `<Button />` - Save notes, print
- `<Table />` (optional) - Attempts list

**Notifications:**
- `toast()` from sonner - Success/error messages

---

**Design Tokens:**
```css
Primary: hsl(262 83% 58%)        /* Purple */
Success: hsl(142 76% 36%)        /* Green for correct */
Destructive: hsl(0 84.2% 60.2%)  /* Red for wrong */
Warning: hsl(38 92% 50%)         /* Orange for pending */
```

---

**Purpose:** Complete UI specification for quiz creation, editing, viewing, and linking to courses

---
# Quiz Management - UI Specification

**Purpose:** Complete UI specification for quiz creation, editing, viewing, and linking to courses

---

## 1. QUIZ BUILDER (Main Quiz Creation/Edit)

### Current Functionality ✅
- None (needs to be built from scratch)

### Complete UI Elements Needed

#### **Quiz Builder Layout**
Two-panel layout:
- **Left Panel:** Quiz settings + Question list
- **Right Panel:** Question editor (when editing a question)

---

### **LEFT PANEL: Quiz Settings & Question List**

#### **Section 1: Quiz Metadata**
- [ ] Quiz Title (text input, required, max 200 chars)
- [ ] Description (textarea, optional, max 500 chars)
- [ ] **Course Association (Optional)**
  - [ ] Dropdown: "Link to Course"
  - [ ] Shows all courses
  - [ ] "Standalone Quiz" option (default)
  - [ ] Helper text: "Optional - quiz can be independent"

#### **Section 2: Quiz Configuration**
- [ ] **Time Limit** (number input, minutes, required)
  - [ ] Default: 30 minutes
  - [ ] Range: 5-180 minutes
- [ ] **Total Marks** (number input, required)
  - [ ] Default: 100
  - [ ] Auto-calculated from question marks (optional override)
- [ ] **Passing Marks** (number input, required)
  - [ ] Default: 50
  - [ ] Validation: Must be ≤ Total Marks
- [ ] **Difficulty Level** (dropdown)
  - [ ] Beginner
  - [ ] Intermediate
  - [ ] Advanced

#### **Section 3: Visibility Settings**
- [ ] **Published Toggle**
  - [ ] OFF: Draft (teachers only)
  - [ ] ON: Published (visible to students)
- [ ] **Access Control Toggle**
  - [ ] Public (free students can access)
  - [ ] Premium Only (paid students only)

#### **Section 4: Question Bank**
- [ ] **Question List Header**
  - [ ] "Questions (0)" counter
  - [ ] Add Question button (primary)
  - [ ] Bulk actions menu:
    - [ ] Delete Selected
    - [ ] Duplicate Selected
    - [ ] Import from Another Quiz

- [ ] **Question Cards (List View)**
  Each card shows:
  - [ ] Checkbox (for bulk selection)
  - [ ] Question number (auto)
  - [ ] Question preview (truncated, first 50 chars)
  - [ ] Content type badge (Text/LaTeX/Image)
  - [ ] Marks (small badge, e.g., "5 marks")
  - [ ] Edit button (opens right panel)
  - [ ] Duplicate button
  - [ ] Delete button
  - [ ] Drag handle (for reordering)

- [ ] **Empty State**
  - [ ] Illustration
  - [ ] "No questions yet"
  - [ ] Add First Question button

#### **Bottom Actions**
- [ ] Save as Draft button
- [ ] Preview Quiz button (opens preview in new tab)
- [ ] Publish Quiz button
- [ ] Cancel/Exit button

---

### **RIGHT PANEL: Question Editor**

#### **Question Content Section**

**Content Type Selector (Tabs)**
- [ ] Text Tab
- [ ] LaTeX Tab
- [ ] Image Tab

**For Text Content:**
- [ ] Rich text editor
  - [ ] Bold, Italic, Underline
  - [ ] Ordered/Unordered lists
  - [ ] Insert link
  - [ ] Clear formatting
- [ ] Character counter (max 1000 chars)

**For LaTeX Content:**
- [ ] LaTeX input field (monospace font)
  - [ ] Syntax highlighting (optional)
  - [ ] Common symbols toolbar:
    - [ ] Fractions, Square root, Subscript, Superscript
    - [ ] Greek letters, Integrals, Summation
- [ ] **Live Preview Panel**
  - [ ] Rendered LaTeX preview
  - [ ] Updates in real-time
  - [ ] "Preview not loading?" help link
- [ ] LaTeX cheat sheet link (opens modal)

**For Image Content:**
- [ ] Image upload area
  - [ ] Drag-drop zone
  - [ ] Or click to browse
  - [ ] Accepted: JPG, PNG
  - [ ] Max size: 5MB
  - [ ] Recommended: 800x600px
- [ ] Image preview (once uploaded)
- [ ] Replace image button
- [ ] Remove image button

---

#### **Answer Options Section**

**Options Header:**
- [ ] "Answer Options" label
- [ ] Add Option button (if < 6 options)
- [ ] Remove Option button (if > 2 options)
- [ ] "Min 2, Max 6 options" hint

**Option Cards (2-6 options)**
Each option shows:
- [ ] Option Label (A, B, C, D, E, F - auto)
- [ ] **Correct Answer Radio Button**
  - [ ] Only one can be selected
  - [ ] Required validation
- [ ] **Content Type Selector (per option)**
  - [ ] Tabs: Text / LaTeX / Image
  - [ ] Same UI as question content (simplified)
- [ ] Remove Option button (icon only)

**For Text Options:**
- [ ] Text input field (single line, max 200 chars)

**For LaTeX Options:**
- [ ] LaTeX input field
- [ ] Live preview below
- [ ] Symbols toolbar

**For Image Options:**
- [ ] Small image upload area
- [ ] Preview thumbnail (150x150px)
- [ ] Replace button

---

#### **Explanation Section (Optional)**

- [ ] "Add Explanation" toggle
  - [ ] If OFF: Section collapsed
  - [ ] If ON: Show explanation editor
- [ ] **Explanation Content** (same UI as question content)
  - [ ] Content type selector: Text / LaTeX / Image
  - [ ] Editor based on type
  - [ ] Preview for LaTeX
  - [ ] Helper text: "Shown to students after submitting quiz"

---

#### **Question Settings**

- [ ] **Marks for This Question** (number input)
  - [ ] Default: 1
  - [ ] Range: 1-100
  - [ ] Auto-updates quiz total marks

---

#### **Question Editor Actions**

- [ ] Save Question button (primary)
- [ ] Cancel button (discards changes)
- [ ] Delete Question button (destructive, with confirmation)

---

## 2. QUIZ LIST PAGE

### UI Elements

#### **Header Section**
- [ ] Page title: "Quiz Bank"
- [ ] Create New Quiz button (primary CTA)
- [ ] Search bar (search by title/course)
- [ ] **Filter Dropdown**
  - [ ] All Quizzes
  - [ ] Published Only
  - [ ] Drafts Only
  - [ ] Standalone Quizzes
  - [ ] Course-Linked Quizzes
  - [ ] By Difficulty (Beginner/Intermediate/Advanced)
- [ ] **Sort Dropdown**
  - [ ] Recently Updated
  - [ ] Recently Created
  - [ ] Alphabetical (A-Z)
  - [ ] Most Attempts

#### **Quiz Cards (Grid or List View)**
Each card shows:
- [ ] Quiz title
- [ ] Description (truncated, first 100 chars)
- [ ] Status badge (Published/Draft)
- [ ] Access badge (Public/Premium Only)
- [ ] Difficulty badge (Beginner/Intermediate/Advanced)
- [ ] **Stats Row**
  - [ ] Question count (e.g., "20 questions")
  - [ ] Time limit (e.g., "30 mins")
  - [ ] Total marks (e.g., "100 marks")
  - [ ] Passing marks (e.g., "Pass: 50")
- [ ] **If Course-Linked:**
  - [ ] Course name badge (clickable)
- [ ] **Attempt Stats** (if published)
  - [ ] Total attempts (e.g., "45 attempts")
  - [ ] Average score (e.g., "Avg: 67%")
- [ ] Last updated date
- [ ] **Quick Actions Menu (3-dot menu)**
  - [ ] Edit Quiz (opens Quiz Builder)
  - [ ] Preview Quiz (opens preview)
  - [ ] Duplicate Quiz
  - [ ] View Attempts (if published)
  - [ ] Publish/Unpublish toggle
  - [ ] Delete Quiz (with confirmation)

#### **Empty State**
- [ ] Illustration
- [ ] Message: "No quizzes yet"
- [ ] Create First Quiz button

---

## 3. QUIZ PREVIEW (Student View)

### Access
- From Quiz List → Preview Quiz
- From Quiz Builder → Preview button

### UI Sections

#### **Quiz Header**
- [ ] Quiz title
- [ ] Description
- [ ] **Info Row**
  - [ ] Question count
  - [ ] Time limit
  - [ ] Total marks
  - [ ] Passing marks
  - [ ] Difficulty badge
- [ ] Start Quiz button (disabled in preview mode)
- [ ] Back button

#### **Question Display (Preview Mode)**
Shows all questions sequentially:
- [ ] Question number
- [ ] Question content (rendered based on type)
  - [ ] Text: Formatted HTML
  - [ ] LaTeX: Rendered equation
  - [ ] Image: Full image display
- [ ] Options (A, B, C, D...)
  - [ ] Each option rendered based on type
  - [ ] Radio buttons (non-functional in preview)
- [ ] **Correct Answer Indicator** (teacher view only)
  - [ ] Green checkmark on correct option
- [ ] **Explanation Section** (if exists)
  - [ ] Collapsed by default
  - [ ] Expand to view
  - [ ] Rendered based on content type
- [ ] Marks display (e.g., "5 marks")

#### **Preview Footer**
- [ ] Close Preview button
- [ ] Edit Quiz button (returns to Quiz Builder)

---

## 4. QUIZ LINKING (Dropdown in Lecture/Lesson Editor)

### Location
- In Lecture Manager → Add/Edit Lecture modal
- In Lesson Manager → Add/Edit Lesson modal (future)

### UI Element: "Link Quiz" Section

#### **Quiz Selector Dropdown**
- [ ] Label: "Prerequisite Quiz (Optional)"
- [ ] Dropdown showing:
  - [ ] **None** (default, no prerequisite)
  - [ ] **All Available Quizzes** (grouped)
    - [ ] Group 1: "Quizzes from this Course"
      - [ ] Shows course-linked quizzes
    - [ ] Group 2: "Standalone Quizzes"
      - [ ] Shows all standalone quizzes
    - [ ] Group 3: "Quizzes from Other Courses"
      - [ ] Shows quizzes from other courses
  - [ ] Each quiz item shows:
    - [ ] Quiz title
    - [ ] Question count
    - [ ] Passing marks
    - [ ] Difficulty badge

#### **Selected Quiz Display**
When quiz selected:
- [ ] Quiz badge (with title)
- [ ] "Change Quiz" button
- [ ] "Remove Quiz" button (X icon)
- [ ] Helper text: "Students must score ≥50% to unlock this lecture"

#### **Create New Quiz Link**
- [ ] "+ Create New Quiz" option at bottom of dropdown
  - [ ] Opens Quiz Builder in new tab/modal
  - [ ] Auto-links to course (if creating from course context)
  - [ ] Returns to lecture editor after saving

---

## 5. QUIZ ATTEMPT VIEWER (Teacher View)

### Access
- From Quiz List → View Attempts
- From Student Detail → Click quiz attempt

### UI Sections

#### **Attempt Overview**
- [ ] Quiz title
- [ ] Student name (with avatar)
- [ ] Attempt date/time
- [ ] **Score Summary Card**
  - [ ] Score: "75/100"
  - [ ] Percentage: "75%"
  - [ ] Result badge: PASSED (green) / FAILED (red)
  - [ ] Time taken: "18 minutes"
  - [ ] Correct answers: "15/20"

#### **Question-by-Question Review**
Each question shows:
- [ ] Question number
- [ ] Question content (rendered)
- [ ] Options with:
  - [ ] Student's selected answer (highlighted in blue)
  - [ ] Correct answer (highlighted in green)
  - [ ] If wrong: Both visible, student answer in red
- [ ] **Status Badge**
  - [ ] ✓ Correct (green)
  - [ ] ✗ Wrong (red)
- [ ] Marks awarded (e.g., "5/5" or "0/5")
- [ ] **Explanation** (if exists, expanded)

#### **Teacher Feedback Section**
- [ ] "Teacher Notes" textarea
  - [ ] Placeholder: "Add feedback for student..."
  - [ ] Character limit: 500 chars
- [ ] Save Notes button
- [ ] **Existing Notes Display** (if saved)
  - [ ] Teacher name
  - [ ] Feedback text
  - [ ] Date added
  - [ ] Edit button

#### **Actions**
- [ ] Print Attempt button (PDF export)
- [ ] Email to Student button (optional)
- [ ] Back to Attempts List button

---

## 6. QUIZ ATTEMPTS LIST (Per Quiz)

### Access
- From Quiz List → View Attempts

### UI Elements

#### **Header**
- [ ] Quiz title
- [ ] Back to Quiz List button
- [ ] Edit Quiz button

#### **Summary Stats**
- [ ] Total Attempts (card)
- [ ] Average Score (card)
- [ ] Pass Rate (card)
- [ ] Completion Rate (card)

#### **Attempts Table**
Columns:
- [ ] Student Name (with avatar)
- [ ] Attempt Date
- [ ] Score (e.g., "75/100")
- [ ] Percentage (e.g., "75%")
- [ ] Result (PASSED/FAILED badge)
- [ ] Time Taken
- [ ] Actions:
  - [ ] View Details (opens Attempt Viewer)
  - [ ] Delete Attempt (with confirmation)

#### **Filters**
- [ ] Search by student name
- [ ] Filter by result (All/Passed/Failed)
- [ ] Filter by date range

---

## 7. BULK OPERATIONS

### Multi-Select Mode (Quiz List)
- [ ] Select multiple quizzes (checkbox)
- [ ] **Bulk Actions Toolbar**
  - [ ] Publish Selected
  - [ ] Unpublish Selected
  - [ ] Delete Selected (with confirmation)
  - [ ] Duplicate Selected

---

## 8. VALIDATION & ERROR STATES

### Form Validation
- [ ] Required field indicators (red asterisk)
- [ ] **Quiz Settings Validation**
  - [ ] Passing marks ≤ Total marks
  - [ ] Time limit > 0
  - [ ] At least 1 question before publishing
- [ ] **Question Validation**
  - [ ] Question content not empty
  - [ ] At least 2 options
  - [ ] One correct answer selected
  - [ ] All option contents filled
- [ ] **LaTeX Validation**
  - [ ] Syntax error highlighting
  - [ ] Preview failure warning
- [ ] **Image Validation**
  - [ ] File size < 5MB
  - [ ] Format: JPG/PNG only
  - [ ] Minimum dimensions: 200x200px

### Loading States
- [ ] Skeleton loaders for quiz cards
- [ ] Spinner during save/publish
- [ ] Image upload progress bars
- [ ] LaTeX preview loading indicator

### Success States
- [ ] Toast: "Quiz created successfully"
- [ ] Toast: "Question saved"
- [ ] Toast: "Quiz published"
- [ ] Toast: "Feedback saved"

---

## 9. RESPONSIVE BEHAVIOR

### Desktop (Primary)
- [ ] Two-panel layout (quiz settings + question editor)
- [ ] Full rich text editors
- [ ] Modal for confirmations

### Tablet
- [ ] Single column layout
- [ ] Collapsible sections
- [ ] Drawer for question editor

### Mobile (Basic Support)
- [ ] Stack layout
- [ ] Simplified text editor
- [ ] Bottom sheet for forms
- [ ] No drag-drop (manual reorder)

---

## 10. ACCESSIBILITY

- [ ] Keyboard navigation
  - [ ] Tab through questions
  - [ ] Arrow keys for option selection
  - [ ] Escape to close modals
- [ ] Screen reader labels
  - [ ] "Question X of Y"
  - [ ] "Option A: [content]"
  - [ ] "Correct answer: Option B"
- [ ] Focus indicators
- [ ] Aria labels for LaTeX preview
- [ ] Color contrast compliance

---

## 11. ADVANCED FEATURES (Optional/Future)

### Question Bank Import/Export
- [ ] Import questions from CSV/JSON
- [ ] Export questions to CSV/JSON
- [ ] Import from other quiz builders

### Question Templates
- [ ] Save question as template
- [ ] Load from template library
- [ ] Share templates with other teachers

### Randomization Options
- [ ] Shuffle questions toggle
- [ ] Shuffle options toggle
- [ ] Random question pool (select X from Y questions)

---

## Summary of UI Screens

1. **Quiz Builder** (two-panel editor) - CREATE/EDIT
2. **Quiz List** (grid/list with filters) - BROWSE
3. **Quiz Preview** (student view, read-only) - PREVIEW
4. **Quiz Linking Dropdown** (in lecture/lesson editor) - LINK
5. **Quiz Attempt Viewer** (per-student analysis) - REVIEW
6. **Quiz Attempts List** (all attempts per quiz) - ANALYTICS

---

## UI Components Summary

**Quiz Settings:** 15 inputs
**Question Editor:** 25+ fields (varies by content type)
**Quiz List:** 20 elements
**Attempt Viewer:** 15 elements
**Quiz Linking:** 8 elements

**Total UI Components:** ~80-100 individual elements
**Estimated Development Time:** 2-3 weeks for complete quiz management UI
