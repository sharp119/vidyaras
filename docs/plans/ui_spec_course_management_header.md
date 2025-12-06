# Course Management - UI Specification

> **📌 IMPORTANT:** This is a **MODULE** of the VidyaRas Dashboard, not a standalone platform.  
> It integrates into the existing dashboard layout (with sidebar navigation) and shares the unified design system.

**Part of:** VidyaRas Admin Dashboard  
**Design System:** See `ui_style_guidelines.md` for complete design system reference  
**Component Library:** shadcn/ui (48 components available)

---

## 🎨 Quick Design Reference

### Use These shadcn Components

**Forms & Inputs:**
- `<Input />` - Text fields
- `<Textarea />` - Multi-line text
- `<Select />` - Dropdowns
- `<Checkbox />` + `<Label />` - Checkboxes
- `<Switch />` - Toggle switches
- `<RadioGroup />` - Radio buttons
- `<Calendar />` - Date picker
- `<Form />` - Form wrapper with validation

**Layout:**
- `<Card />` - Section containers
- `<Tabs />` - Step navigation
- `<Accordion />` - Collapsible modules
- `<Separator />` - Visual dividers
- `<ScrollArea />` - Scrollable content

**Actions & Feedback:**
- `<Button />` - All button types (variants: default, outline, destructive, ghost)
- `<Dialog />` - Modals for add/edit
- `<AlertDialog />` - Delete confirmations
- `<DropdownMenu />` - Action menus (3-dot)
- `<Badge />` - Status indicators
- `<Progress />` - Progress bars
- `<Skeleton />` - Loading states
- `toast()` from sonner - Notifications

**Data Display:**
- `<Table />` - Course list
- `<Avatar />` - User images
- Drag-drop: `@dnd-kit/core` (external library)

### Design Tokens (From Dashboard)
```css
Primary Color: hsl(262 83% 58%)  /* Purple */
Success: hsl(142 76% 36%)        /* Green */
Warning: hsl(38 92% 50%)         /* Orange */
Destructive: hsl(0 84.2% 60.2%)  /* Red */
Border Radius: 0.75rem
Font: 'Inter', sans-serif
```

---

## 📋 Component Recommendations by Section

Below, each UI section includes **specific shadcn component recommendations** marked with 🧩.

---

