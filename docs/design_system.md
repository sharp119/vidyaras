# Vidyaras Admin Design System

This document outlines the design system for the Vidyaras Admin dashboard, based on Tailwind CSS v4 and Shadcn UI.

## Core Principles
- **Consistency**: Use shared components and tokens. Do not hardcode hex values or arbitrary spacing.
- **Simplicity**: Stick to the defined color palette and typography.
- **Accessibility**: Ensure sufficient contrast and keyboard navigation support.

## Colors
All colors are defined as CSS variables in `index.css` and mapped in `tailwind.config.ts`.

### Primary
- `bg-primary`: Main brand color (Purple/Violet)
- `text-primary-foreground`: Text on primary background

### Secondary
- `bg-secondary`: Secondary actions/backgrounds
- `text-secondary-foreground`: Text on secondary background

### Backgrounds
- `bg-background`: Page background
- `bg-card`: Card background (white/dark gray)
- `bg-muted`: Muted background for inactive items

### Text
- `text-foreground`: Primary text color
- `text-muted-foreground`: Secondary/helper text color

## Typography
Font family: `Inter` (sans-serif).

- **Headings**: `font-bold`, `tracking-tight`
  - H1: `text-3xl` or `text-2xl`
  - H2: `text-xl`
- **Body**: `text-sm` or `text-base`
- **Small**: `text-xs`, `text-muted-foreground`

## Spacing
Use Tailwind's default spacing scale.
- Layout padding: `p-4` or `p-6`
- Component gap: `gap-4` or `gap-2`
- Section spacing: `space-y-6`

## Components
Use Shadcn UI components from `@/components/ui`.

### Buttons
- Primary: `<Button>Action</Button>`
- Secondary: `<Button variant="secondary">Cancel</Button>`
- Ghost: `<Button variant="ghost">Icon</Button>`
- Destructive: `<Button variant="destructive">Delete</Button>`

### Cards
Use `Card`, `CardHeader`, `CardTitle`, `CardContent`.
```tsx
<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
  </CardHeader>
  <CardContent>
    Content
  </CardContent>
</Card>
```

### Inputs
Use `Input`, `Label`, `Textarea`.
Always wrap inputs with a `Label`.

## Layout
The dashboard uses a Sidebar layout.
- **Page Wrapper**: Pages are rendered inside `SidebarInset`.
- **Header**: Use the standard dashboard header structure if possible, or a consistent page header.
- **Content**: Wrap content in a container (e.g., `max-w-4xl mx-auto` or `container`).

## Course Builder Specifics
The Course Builder should align with the dashboard layout:
- Remove custom full-screen headers that conflict with the sidebar.
- Use the standard breadcrumb navigation.
- Use `StepWizard` for multi-step processes, but ensure it fits within the content area.
