# VidyaRas Design System
> Complete visual guidelines for a warm, culturally authentic, and digitally clear learning experience.

---

## 1. Color Palette

### Primary Accent
| Color | Hex | Usage |
|-------|-----|-------|
| **Orange** | `#FF5722` | Primary CTAs, active navigation, progress indicators, key highlights |

> Signifies warmth, enthusiasm, and cultural vibrancy.

### Secondary Accent
| Color | Hex | Usage |
|-------|-----|-------|
| Teal/Blue | `#00BCD4` | Subtle secondary accents, attribute tags |
| Green | `#4CAF50` | "Completed" states, success indicators |

### Neutrals
| Color | Hex | Usage |
|-------|-----|-------|
| White | `#FFFFFF` | Primary background, content areas |
| Light Gray | `#F5F5F5` | Subtle backgrounds, inactive states |
| Medium Gray | `#E0E0E0` | Dividers, borders |
| Dark Gray | `#424242` | Secondary text, icons |
| Black | `#212121` | Primary text, strong headings |

### Semantic Colors
| Purpose | Hex | Usage |
|---------|-----|-------|
| Success | `#4CAF50` | Completed actions, success states |
| Warning | `#FF9800` | Moderate alerts, "Good" score |
| Error | `#F44336` | Errors, important warnings |
| Live/New | `#E53935` | 🔴 Live badge, "New" badge |

### Category Icon Colors
| Category | Icon Color | Background (10% opacity) |
|----------|------------|--------------------------|
| Music | `#2196F3` | `#2196F31A` |
| Wellness | `#4CAF50` | `#4CAF501A` |
| Yoga | `#FF5722` | `#FF57221A` |
| Arts | `#E91E63` | `#E91E631A` |

### Score Badge Colors
| Score Level | Background | Text |
|-------------|------------|------|
| Excellent | `#4CAF50` | White |
| Good | `#FF9800` | White |
| Needs Work | `#F44336` | White |

---

## 2. Typography

### Font Families
| Script | Recommendation |
|--------|----------------|
| **English & Hindi** | Clean sans-serif (Roboto, Noto Sans, Open Sans) with Devanagari support |

### Font Sizes (sp)
| Level | Size | Usage |
|-------|------|-------|
| **H1** | 24sp | Screen titles ("My Learning") |
| **H2** | 20sp | Major section titles ("Continue Learning", "My Courses") |
| **H3** | 16sp | Card titles, sub-section headers |
| **Body** | 14sp | Descriptions, chat messages |
| **Helper** | 12sp | Metadata, timestamps, instructor names, review counts |
| **Button** | 14-16sp | Depends on button prominence |

### Text Styles
| Type | Weight | Color |
|------|--------|-------|
| Headings | Bold / Semi-Bold | `#212121` |
| Body | Regular | `#424242` |
| Helper | Regular | `#757575` |
| CTA | Bold | `#FF5722` or white on orange |

---

## 3. Sizing Values

### Border Radius (dp)
| Size | Value | Usage |
|------|-------|-------|
| Small | 8dp | Buttons, tags, input fields |
| Medium | 12dp | Cards, modals |
| Large | 16dp | Prominent cards, hero elements |
| Pill | 24dp | Tab toggles, filter chips |

### Icon Sizes (dp)
| Size | Value | Usage |
|------|-------|-------|
| Standard | 24dp | Navigation, actionable icons |
| Small | 20dp | Inline icons |
| Large | 48dp+ | Illustrations, empty states |

### Circular Icon Containers
| Property | Value |
|----------|-------|
| Diameter | 48dp |
| Icon Size | 24dp (centered) |
| Background | 10% opacity of icon color |
| Border Radius | 50% (full circle) |

### Button Dimensions (dp)
| Property | Value |
|----------|-------|
| Standard Height | 48dp (minimum touch target) |
| Horizontal Padding | 16dp (left & right) |
| Vertical Padding | Centered within 48dp height |

### Card Elevation
| State | Elevation | Usage |
|-------|-----------|-------|
| Default | 1 | Course cards, standard cards |
| Pressed/Hover | 2 | Interactive feedback |
| Modal/Dialog | 8-12 | Overlays above content |

---

## 4. Spacing Scale

> Base unit: **4dp** for harmonious, predictable rhythm.

| Token | Value | Usage Example |
|-------|-------|---------------|
| `xs` | 4dp | Tight inline spacing |
| `sm` | 8dp | Horizontal card margins |
| `md-sm` | 12dp | Vertical card margins |
| `md` | 16dp | Button padding, content insets |
| `md-lg` | 24dp | Section spacing |
| `lg` | 32dp | Major block separation |
| `xl` | 48dp | Screen padding, hero spacing |
| `xxl` | 64dp | Large decorative spacing |

---

## 5. Dark Mode

| Element | Light Mode | Dark Mode |
|---------|------------|-----------|
| Primary Background | `#FFFFFF` | `#121212` |
| Surface/Card | `#FFFFFF` | `#1E1E1E` |
| Primary Text | `#212121` | `#FFFFFF` |
| Secondary Text | `#424242` | `#B0B0B0` |
| Disabled Text | `#9E9E9E` | `#616161` |
| Accent Orange | `#FF5722` | `#FF8A65` or `#FFB300` |
| Divider/Border | `#E0E0E0` | `#363636` |
| Icons (Inactive) | `#757575` | `#B0B0B0` |
| Icons (Active) | `#FF5722` | `#FF8A65` |

---

## 6. Motion & Animation

### Transition Durations
| Speed | Duration | Usage |
|-------|----------|-------|
| Fast | 150ms | Micro-interactions, highlights |
| Standard | 300ms | Screen transitions, component changes |
| Slow | 500ms | Complex transitions, intros |

### Easing Curves
| Curve | Usage |
|-------|-------|
| `ease-in-out` | Default (smooth start and end) |
| `ease-out` | Alerts, feedback (quick start, gentle end) |
| Spring | Playful elements (physics-based bounce) |

### Loading States
| Type | Implementation |
|------|----------------|
| **Skeleton** | Shimmering gray rectangles as placeholders |
| **Spinner** | Circular progress indicator in primary orange |

---

## 7. Component States

| State | Visual Treatment |
|-------|------------------|
| **Default** | Standard appearance |
| **Hover** | Slight elevation increase, subtle gray overlay |
| **Pressed** | Reduced elevation, darker overlay, border change |
| **Disabled** | 50% opacity, `#9E9E9E` text, non-interactive |
| **Focused** | 2dp orange ring border (keyboard nav, inputs) |

### Empty States Design
| Element | Guidelines |
|---------|------------|
| Illustration | Friendly, relevant visual |
| Headline | Clear explanation ("No Courses Enrolled Yet") |
| CTA Button | Primary action ("Explore Courses", "Start Quiz") |
| Supporting Text | Optional context paragraph |

---

## 8. UI Components

### Headers

#### Orange Gradient Header (Primary)
| Property | Value |
|----------|-------|
| Background | Linear gradient `#FF5722` → `#FF8A65` |
| Text | White |
| Usage | Home, My Learning, Community, Tests screens |

#### White Header (Secondary)
| Property | Value |
|----------|-------|
| Background | White with subtle shadow |
| Text | `#212121` |
| Usage | Course Detail, inner screens |

### Bottom Navigation
| Property | Value |
|----------|-------|
| Tabs | Home, Learning, Community, Tests, Profile |
| Active | Icon + label in `#FF5722` |
| Inactive | `#757575` |
| Background | White or `#F5F5F5` |

### Buttons

#### Primary
| Property | Value |
|----------|-------|
| Background | `#FF5722` |
| Text | `#FFFFFF`, 14-16sp |
| Border Radius | 8dp |
| Height | 48dp |

#### Secondary
| Property | Value |
|----------|-------|
| Background | `#FFFFFF` |
| Border | 1px `#FF5722` |
| Text | `#FF5722` |

#### Text Button
| Property | Value |
|----------|-------|
| Background | None |
| Text | `#FF5722` or `#424242` |

### Tab Toggle
| Property | Value |
|----------|-------|
| Active Tab | `#FF5722` border, white/orange fill |
| Inactive Tab | `#E0E0E0` border, transparent |
| Border Radius | 24dp (pill shape) |
| Height | 40dp |

### Cards

| Type | Key Features |
|------|--------------|
| **Course Card** | Thumbnail, title, instructor, rating, progress/price |
| **Live Class Card** | 🔴 Live badge, scheduled time |
| **Category Card** | Large icon/image, orange accent |
| **Stat Card** | Number + label ("Active Courses") |

### Badges & Tags

| Badge Type | Background | Text | Usage |
|------------|------------|------|-------|
| New | `#E53935` | White | New courses |
| Free | `#4CAF50` | White | Free courses |
| Free Trial | `#FF5722` | White | Trial available |
| Workshop | `#FF9800` | White | Workshop type |
| Live | `#E53935` | White | Live indicator |
| Due Today | `#E53935` | — | Assessment urgency |
| Upcoming | `#757575` | — | Future items |

### Attribute Tags (Course Detail)
| Tag | Icon Color | Background |
|-----|------------|------------|
| Language | `#00BCD4` | `#00BCD41A` |
| Certificate | `#4CAF50` | `#4CAF501A` |
| Duration | `#757575` | `#7575751A` |

### Input Fields

#### Search Bar
| Property | Value |
|----------|-------|
| Shape | Rounded rectangle (8dp) |
| Background | `#F5F5F5` or white |
| Border | `#E0E0E0` |
| Icon | Search (left), orange on gradient headers |

#### Text Input
| Property | Value |
|----------|-------|
| Background | White |
| Border | `#E0E0E0` (2dp orange on focus) |
| Text | `#212121` |

### Progress Indicators
| Type | Track | Fill |
|------|-------|------|
| Linear | `#E0E0E0` | `#FF5722` |
| Circular | `#E0E0E0` | `#FF5722` |
| Percentage Label | Right-aligned, `#FF5722` |

### Icons
| State | Color |
|-------|-------|
| Inactive | `#757575` |
| Active | `#FF5722` |

---

## 9. Screen-Specific Components

### Modals/Dialogs
| Property | Value |
|----------|-------|
| Background | White (rounded corners, 12dp) |
| Overlay | 60% black semi-transparent |
| Buttons | "Cancel" (secondary) + "Confirm" (primary) |
| Position | Centered |

### Snackbars/Toasts
| Property | Value |
|----------|-------|
| Background | `#333333` |
| Text | `#FFFFFF` |
| Duration | 3-5 seconds (auto-dismiss) |
| Position | Bottom of screen |

### Dropdown Menus
| Property | Value |
|----------|-------|
| Background | White |
| Item hover | `#F5F5F5` |
| Dividers | `#E0E0E0` between groups |

### Announcement Cards
| Property | Value |
|----------|-------|
| Background | White |
| Left Accent | 4dp orange bar |
| Icon | Relevant illustration |

### Challenge Cards
| Property | Value |
|----------|-------|
| Background | Dark overlay on image |
| Text | White |
| Badge | "Active" in green |
| CTA | Orange outline button |

### Forum Category Cards
| Property | Value |
|----------|-------|
| Shape | Square, white background |
| Border | 1dp `#E0E0E0` |
| Icon | Circular, colored background |
| Text | Center-aligned label |

### Date/Time Pickers
- Prefer native platform pickers (iOS/Android)
- Custom: Align with VidyaRas aesthetic, clear selection states

### Lists
| Property | Value |
|----------|-------|
| Scrolling | Native behavior |
| Dividers | Subtle `#E0E0E0` lines |
| Pull-to-refresh | Standard platform spinner |

---

## 10. Accessibility

### Touch Targets
| Requirement | Value |
|-------------|-------|
| Minimum size | **48dp × 48dp** for all interactive elements |

### Color Contrast (WCAG AA)
| Content Type | Minimum Ratio |
|--------------|---------------|
| Regular text | 4.5:1 |
| Large text (18pt bold / 24pt) | 3:1 |
| UI components & graphics | 3:1 |

### Font Scaling
- Respect system font size preferences
- Layouts must handle larger text gracefully
- Text wrapping with responsive adjustments

### Semantic Labeling
- Use `contentDescription` (Android) / `accessibilityLabel` (iOS)
- Clear, concise labels for all interactive elements
- Proper semantic HTML elements where applicable

---

## Quick Reference

```
═══════════════════════════════════════════
COLORS
═══════════════════════════════════════════
Primary Orange:     #FF5722
Orange Gradient:    #FF5722 → #FF8A65
Dark Mode Orange:   #FF8A65
Success Green:      #4CAF50
Warning Orange:     #FF9800
Live/New Red:       #E53935
Error Red:          #F44336
Teal Accent:        #00BCD4

Category Colors:
  Music:            #2196F3
  Wellness:         #4CAF50
  Yoga:             #FF5722
  Arts:             #E91E63

White:              #FFFFFF
Light Gray:         #F5F5F5
Medium Gray:        #E0E0E0
Dark Gray:          #424242
Black:              #212121
Helper Text:        #757575

Dark Mode BG:       #121212
Dark Mode Surface:  #1E1E1E
Dark Mode Text:     #FFFFFF
Dark Mode Secondary:#B0B0B0

═══════════════════════════════════════════
TYPOGRAPHY (sp)
═══════════════════════════════════════════
H1: 24sp    H2: 20sp    H3: 16sp
Body: 14sp  Helper: 12sp

═══════════════════════════════════════════
SPACING (dp)
═══════════════════════════════════════════
xs: 4    sm: 8     md-sm: 12   md: 16
md-lg: 24   lg: 32   xl: 48     xxl: 64

═══════════════════════════════════════════
BORDER RADIUS (dp)
═══════════════════════════════════════════
Small: 8dp   Medium: 12dp   Large: 16dp   Pill: 24dp

═══════════════════════════════════════════
CIRCULAR ICONS (dp)
═══════════════════════════════════════════
Container: 48dp   Icon: 24dp   BG Opacity: 10%

═══════════════════════════════════════════
MOTION (ms)
═══════════════════════════════════════════
Fast: 150ms   Standard: 300ms   Slow: 500ms
```
