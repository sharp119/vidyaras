# VidyaRas Dashboard - Style Guidelines & Component Library

**Purpose:** Unified design system and component usage guidelines for all dashboard modules

---

## 🎨 Design System Overview

The VidyaRas dashboard uses **shadcn/ui** components built on **Tailwind CSS** with a custom design system defined in HSL color tokens.

### Core Principles
1. **Modular Architecture** - Each feature (Course, Quiz, Student) is a self-contained module
2. **Consistent Design Language** - All modules use the same component library and design tokens
3. **Responsive by Default** - Desktop-first, mobile-friendly
4. **Accessible** - WCAG 2.1 Level AA compliance

---

## 📐 Design Tokens

### Color Palette (HSL)

**Light Mode:**
```css
--background: 240 10% 98%        /* Main background */
--foreground: 240 10% 10%        /* Main text */
--card: 0 0% 100%                /* Card background */
--card-foreground: 240 10% 10%   /* Card text */

--primary: 262 83% 58%           /* Primary purple */
--primary-foreground: 0 0% 100%  /* White text on primary */
--primary-glow: 262 90% 70%      /* Lighter purple for gradients */

--secondary: 240 5% 96%          /* Secondary gray */
--secondary-foreground: 240 10% 10%

--muted: 240 5% 96%              /* Muted backgrounds */
--muted-foreground: 240 4% 46%   /* Muted text */

--accent: 262 83% 58%            /* Accent purple (same as primary) */
--accent-foreground: 0 0% 100%

--destructive: 0 84.2% 60.2%     /* Red for delete/error */
--destructive-foreground: 0 0% 100%

--success: 142 76% 36%           /* Green for success states */
--warning: 38 92% 50%            /* Orange for warnings */

--border: 240 6% 90%             /* Border color */
--input: 240 6% 90%              /* Input border */
--ring: 262 83% 58%              /* Focus ring */
```

**Dark Mode:**
- Automatically switches with `class="dark"`
- All colors defined in `src/index.css`

### Gradients
```css
--gradient-primary: linear-gradient(135deg, hsl(262 83% 58%), hsl(262 90% 70%))
--gradient-accent: linear-gradient(135deg, hsl(175 60% 50%), hsl(195 60% 50%))
```

### Shadows
```css
--shadow-elevated: 0 2px 8px rgba(0, 0, 0, 0.08)
--shadow-glow: 0 10px 40px -10px hsl(262 83% 58% / 0.4)
```

### Border Radius
```css
--radius: 0.75rem      /* Base radius */
lg: var(--radius)      /* 0.75rem */
md: calc(var(--radius) - 2px)  /* 0.625rem */
sm: calc(var(--radius) - 4px)  /* 0.5rem */
```

### Typography
```css
Font Family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif
```

---

## 🧩 Available shadcn/ui Components

### Form Components (48 total installed)

#### **Input & Selection**
- `<Input />` - Text inputs
- `<Textarea />` - Multi-line text
- `<Select />` - Dropdown selection
- `<Combobox />` (via Command) - Searchable select
- `<RadioGroup />` - Single selection from options
- `<Checkbox />` - Boolean toggle
- `<Switch />` - Toggle switch
- `<Slider />` - Numeric range selector
- `<Calendar />` - Date picker
- `<InputOTP />` - One-time password input

#### **Form Structure**
- `<Form />` - Form container with validation (react-hook-form)
- `<Label />` - Form field labels

#### **Layout & Navigation**
- `<Card />` - Content containers
- `<Tabs />` - Tab navigation
- `<Accordion />` - Collapsible sections
- `<Collapsible />` - Show/hide content
- `<Separator />` - Horizontal/vertical dividers
- `<ScrollArea />` - Custom scrollbars
- `<ResizablePanel />` - Resizable layouts
- `<Sidebar />` - Navigation sidebar (already implemented)
- `<Breadcrumb />` - Navigation path
- `<NavigationMenu />` - Top navigation

#### **Feedback & Overlays**
- `<Dialog />` - Modal dialogs
- `<AlertDialog />` - Confirmation dialogs
- `<Sheet />` - Slide-in panel (mobile drawer)
- `<Drawer />` - Bottom drawer (mobile)
- `<Popover />` - Floating content
- `<HoverCard />` - Hover previews
- `<Tooltip />` - Hover hints
- `<Toast />` + `<Sonner />` - Notifications
- `<Alert />` - Inline alerts
- `<Progress />` - Progress bars
- `<Skeleton />` - Loading placeholders

#### **Data Display**
- `<Table />` - Data tables
- `<Badge />` - Status badges
- `<Avatar />` - User avatars
- `<AspectRatio />` - Image containers
- `<Carousel />` - Image sliders
- `<Chart />` - Data visualization

#### **Actions**
- `<Button />` - All button variants
- `<DropdownMenu />` - Action menus
- `<ContextMenu />` - Right-click menus
- `<Menubar />` - Menu bar
- `<Toggle />` - Toggle buttons
- `<ToggleGroup />` - Grouped toggles

#### **Advanced**
- `<Command />` - Command palette (Cmd+K)
- `<Pagination />` - Page navigation

---

## 🎯 Component Usage Guidelines

### When to Use What

#### **Buttons**
```tsx
// Primary action (save, publish, create)
<Button>Save Course</Button>

// Secondary action (cancel, back)
<Button variant="outline">Cancel</Button>

// Destructive action (delete)
<Button variant="destructive">Delete</Button>

// Ghost button (less prominent)
<Button variant="ghost">Skip</Button>

// Link button
<Button variant="link">Learn More</Button>

// With icon
<Button><Plus className="mr-2 h-4 w-4" />Add Module</Button>
```

#### **Form Inputs**
```tsx
// Text input
<Input type="text" placeholder="Course title..." />

// Textarea
<Textarea placeholder="Course description..." rows={5} />

// Select dropdown
<Select>
  <SelectTrigger>
    <SelectValue placeholder="Select difficulty" />
  </SelectTrigger>
  <SelectContent>
    <SelectItem value="beginner">Beginner</SelectItem>
    <SelectItem value="intermediate">Intermediate</SelectItem>
  </SelectContent>
</Select>

// Checkbox
<Checkbox id="published" />
<Label htmlFor="published">Published</Label>

// Switch toggle
<Switch id="live" />
<Label htmlFor="live">Live Course</Label>
```

#### **Dialogs & Modals**
```tsx
// Modal dialog
<Dialog>
  <DialogTrigger asChild>
    <Button>Open</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Add Module</DialogTitle>
      <DialogDescription>Enter module details</DialogDescription>
    </DialogHeader>
    {/* Form content */}
    <DialogFooter>
      <Button variant="outline">Cancel</Button>
      <Button>Create</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>

// Confirmation dialog
<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="destructive">Delete</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogHeader>
      <AlertDialogTitle>Are you sure?</AlertDialogTitle>
      <AlertDialogDescription>This action cannot be undone.</AlertDialogDescription>
    </AlertDialogHeader>
    <AlertDialogFooter>
      <AlertDialogCancel>Cancel</AlertDialogCancel>
      <AlertDialogAction>Delete</AlertDialogAction>
    </AlertDialogFooter>
  </AlertDialogContent>
</AlertDialog>

// Mobile drawer (Sheet)
<Sheet>
  <SheetTrigger asChild>
    <Button>Filters</Button>
  </SheetTrigger>
  <SheetContent side="left">
    <SheetHeader>
      <SheetTitle>Filter Options</SheetTitle>
    </SheetHeader>
    {/* Filter form */}
  </SheetContent>
</Sheet>
```

#### **Data Display**
```tsx
// Card
<Card>
  <CardHeader>
    <CardTitle>Course Title</CardTitle>
    <CardDescription>Course description</CardDescription>
  </CardHeader>
  <CardContent>
    {/* Card content */}
  </CardContent>
  <CardFooter>
    <Button>View Details</Button>
  </CardFooter>
</Card>

// Badge
<Badge>Published</Badge>
<Badge variant="secondary">Draft</Badge>
<Badge variant="destructive">Expired</Badge>
<Badge variant="outline">Free</Badge>

// Table
<Table>
  <TableHeader>
    <TableRow>
      <TableHead>Name</TableHead>
      <TableHead>Status</TableHead>
    </TableRow>
  </TableHeader>
  <TableBody>
    <TableRow>
      <TableCell>Course 1</TableCell>
      <TableCell><Badge>Published</Badge></TableCell>
    </TableRow>
  </TableBody>
</Table>

// Progress bar
<Progress value={75} className="w-full" />
```

#### **Navigation**
```tsx
// Tabs
<Tabs defaultValue="overview">
  <TabsList>
    <TabsTrigger value="overview">Overview</TabsTrigger>
    <TabsTrigger value="enrollments">Enrollments</TabsTrigger>
  </TabsList>
  <TabsContent value="overview">Overview content</TabsContent>
  <TabsContent value="enrollments">Enrollments content</TabsContent>
</Tabs>

// Accordion
<Accordion type="single" collapsible>
  <AccordionItem value="item-1">
    <AccordionTrigger>Module 1</AccordionTrigger>
    <AccordionContent>
      {/* Lesson list */}
    </AccordionContent>
  </AccordionItem>
</Accordion>
```

#### **Feedback**
```tsx
// Toast notification
import { toast } from "sonner"

toast.success("Course created successfully")
toast.error("Failed to save course")
toast.info("Processing...")
toast.warning("Unsaved changes")

// Inline alert
<Alert>
  <AlertCircle className="h-4 w-4" />
  <AlertTitle>Warning</AlertTitle>
  <AlertDescription>Please fill all required fields</AlertDescription>
</Alert>

// Tooltip
<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="ghost" size="icon">
        <Info className="h-4 w-4" />
      </Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Additional information</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>
```

---

## 📏 Spacing & Layout Standards

### Container Widths
```tsx
max-w-7xl  // Full-width pages (Course List)
max-w-4xl  // Content pages (Course Builder)
max-w-2xl  // Forms & modals
max-w-xl   // Narrow content
```

### Padding/Margin Scale
```tsx
p-0   // 0px
p-1   // 4px
p-2   // 8px
p-4   // 16px (most common)
p-6   // 24px
p-8   // 32px
p-12  // 48px
```

### Gap Scale (Flex/Grid)
```tsx
gap-2  // 8px (tight)
gap-4  // 16px (normal)
gap-6  // 24px (loose)
gap-8  // 32px (very loose)
```

---

## 🎨 Component Patterns

### Form Layout Pattern
```tsx
<Card>
  <CardHeader>
    <CardTitle>Basic Information</CardTitle>
    <CardDescription>Enter course details</CardDescription>
  </CardHeader>
  <CardContent className="space-y-4">
    <div className="space-y-2">
      <Label htmlFor="title">Course Title</Label>
      <Input id="title" placeholder="Enter title..." />
    </div>
    <div className="space-y-2">
      <Label htmlFor="description">Description</Label>
      <Textarea id="description" rows={5} />
    </div>
  </CardContent>
  <CardFooter className="flex justify-between">
    <Button variant="outline">Cancel</Button>
    <Button>Save</Button>
  </CardFooter>
</Card>
```

### List Item Pattern (with actions)
```tsx
<div className="flex items-center justify-between p-4 border rounded-lg">
  <div className="flex items-center gap-4">
    <DragHandle /> {/* Optional drag icon */}
    <div>
      <p className="font-medium">Item Title</p>
      <p className="text-sm text-muted-foreground">Item description</p>
    </div>
  </div>
  <div className="flex items-center gap-2">
    <Badge>Status</Badge>
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" size="icon">
          <MoreVertical className="h-4 w-4" />
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        <DropdownMenuItem>Edit</DropdownMenuItem>
        <DropdownMenuItem>Duplicate</DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuItem className="text-destructive">Delete</DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  </div>
</div>
```

### Empty State Pattern
```tsx
<div className="flex flex-col items-center justify-center p-12 text-center">
  <div className="rounded-full bg-muted p-6 mb-4">
    <Icon className="h-12 w-12 text-muted-foreground" />
  </div>
  <h3 className="text-lg font-semibold mb-2">No items yet</h3>
  <p className="text-sm text-muted-foreground mb-6">
    Get started by creating your first item
  </p>
  <Button>
    <Plus className="mr-2 h-4 w-4" />
    Create Item
  </Button>
</div>
```

### Loading State Pattern
```tsx
// Skeleton loaders
<Card>
  <CardHeader>
    <Skeleton className="h-4 w-1/2" />
    <Skeleton className="h-3 w-3/4" />
  </CardHeader>
  <CardContent className="space-y-2">
    <Skeleton className="h-4 w-full" />
    <Skeleton className="h-4 w-5/6" />
  </CardContent>
</Card>

// Spinner
<Button disabled>
  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
  Loading...
</Button>
```

---

## 🎯 Icon Library

Using **lucide-react** (included with shadcn/ui)

### Common Icons
```tsx
// Actions
<Plus />        // Add/Create
<Edit />        // Edit
<Trash2 />      // Delete
<Save />        // Save
<X />           // Close/Cancel
<Check />       // Confirm/Success
<MoreVertical />// Menu (3 dots)

// Navigation
<ChevronLeft /> <ChevronRight />
<ChevronUp /> <ChevronDown />
<ArrowLeft /> <ArrowRight />

// Content
<BookOpen />    // Course
<FileText />    // Lecture/Material
<Video />       // Video lecture
<Users />       // Students
<Trophy />      // Quiz/Achievement
<Calendar />    // Live class schedule

// Status
<AlertCircle /> // Warning/Info
<CheckCircle /> // Success
<XCircle />     // Error
<Clock />       // Pending
<Lock />        // Locked content
<Eye />         // View/Preview

// File operations
<Upload />
<Download />
<File />
<Folder />
<Image />
```

---

## 📱 Responsive Patterns

### Responsive Grid
```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  {/* Cards */}
</div>
```

### Responsive Visibility
```tsx
<div className="hidden md:block">Desktop only</div>
<div className="block md:hidden">Mobile only</div>
```

### Responsive Spacing
```tsx
<div className="p-4 md:p-6 lg:p-8">Content</div>
```

---

## ✅ Validation & Error States

### Form Validation
```tsx
<div className="space-y-2">
  <Label htmlFor="email">Email</Label>
  <Input
    id="email"
    type="email"
    className={errors.email ? "border-destructive" : ""}
  />
  {errors.email && (
    <p className="text-sm text-destructive">{errors.email.message}</p>
  )}
</div>
```

### Error States
```tsx
// Input error
<Input className="border-destructive" />

// Alert
<Alert variant="destructive">
  <AlertCircle className="h-4 w-4" />
  <AlertTitle>Error</AlertTitle>
  <AlertDescription>Failed to save changes</AlertDescription>
</Alert>

// Toast
toast.error("Something went wrong", {
  description: "Please try again later"
})
```

---

## 🎨 Custom Utility Classes

### Gradients
```tsx
className="bg-gradient-to-r from-primary to-primary-glow"
```

### Shadows
```tsx
className="shadow-elevated"  // Use for cards
className="shadow-glow"      // Use for primary CTAs
```

### Animations
```tsx
className="animate-accordion-down"  // Accordion open
className="animate-accordion-up"    // Accordion close
className="transition-all duration-200"  // Smooth transitions
```

---

## 📋 Checklist for New Modules

When creating a new module (e.g., Course Builder, Quiz Builder):

- [ ] Use `<Card />` for main sections
- [ ] Use `<Form />` from react-hook-form for forms
- [ ] Use `<Button variant="outline" />` for secondary actions
- [ ] Use `<Button variant="destructive" />` for delete actions
- [ ] Use `<Badge />` for status indicators
- [ ] Use `<Dialog />` for create/edit modals
- [ ] Use `<AlertDialog />` for confirmations
- [ ] Use `<Skeleton />` for loading states
- [ ] Use `toast()` from sonner for notifications
- [ ] Use design tokens (--primary, --radius, etc.)
- [ ] Follow spacing scale (gap-4, p-4, etc.)
- [ ] Include empty states with illustrations
- [ ] Add responsive classes (md:, lg:)
- [ ] Include keyboard navigation
- [ ] Add ARIA labels for accessibility

---

## 🔧 Development Setup

### Import shadcn components
```tsx
import { Button } from "@/components/ui/button"
import { Card, CardHeader, CardContent } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
// ... etc
```

### Use design tokens
```tsx
// Instead of hardcoded colors
className="bg-purple-600"  // ❌

// Use design tokens
className="bg-primary"     // ✅
```

### Custom variants
```tsx
// Extend button variants in tailwind.config.ts if needed
// Or use className for one-offs
<Button className="bg-gradient-to-r from-primary to-primary-glow">
  Gradient Button
</Button>
```

---

## 📚 Resources

- **shadcn/ui Docs:** https://ui.shadcn.com/
- **Tailwind CSS Docs:** https://tailwindcss.com/docs
- **Lucide Icons:** https://lucide.dev/icons/
- **Radix UI (underlying):** https://www.radix-ui.com/

---

**Remember:** All modules should feel like part of the same dashboard, not separate applications. Consistency is key!
