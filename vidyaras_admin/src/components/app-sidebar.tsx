import * as React from "react"
import {
  BookOpen,
  GraduationCap,
  LayoutDashboard,
  Settings2,
  Sparkles,
  Users,
  Video,
  FileText,
  DollarSign,
} from "lucide-react"

import { NavMain } from "@/components/nav-main"
import { NavProjects } from "@/components/nav-projects"
import { NavUser } from "@/components/nav-user"
import { TeamSwitcher } from "@/components/team-switcher"
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarRail,
} from "@/components/ui/sidebar"

// VidyaRas Admin data
const data = {
  user: {
    name: "Admin User",
    email: "admin@vidyaras.com",
    avatar: "/avatars/admin.jpg",
  },
  teams: [
    {
      name: "VidyaRas",
      logo: GraduationCap,
      plan: "Admin",
    },
  ],
  navMain: [
    {
      title: "Dashboard",
      url: "/",
      icon: LayoutDashboard,
      isActive: true,
      items: [
        {
          title: "Overview",
          url: "/",
        },
        {
          title: "Analytics",
          url: "#",
        },
      ],
    },
    {
      title: "Courses",
      url: "#",
      icon: BookOpen,
      items: [
        {
          title: "All Courses",
          url: "#",
        },
        {
          title: "Course Builder",
          url: "/courses/builder",
        },
        {
          title: "Categories",
          url: "#",
        },
      ],
    },
    {
      title: "Students",
      url: "#",
      icon: Users,
      items: [
        {
          title: "All Students",
          url: "#",
        },
        {
          title: "Enrollments",
          url: "#",
        },
        {
          title: "Progress Reports",
          url: "#",
        },
      ],
    },
    {
      title: "Live Sessions",
      url: "#",
      icon: Video,
      items: [
        {
          title: "Scheduled",
          url: "#",
        },
        {
          title: "Past Sessions",
          url: "#",
        },
        {
          title: "Recordings",
          url: "#",
        },
      ],
    },
    {
      title: "Settings",
      url: "#",
      icon: Settings2,
      items: [
        {
          title: "General",
          url: "#",
        },
        {
          title: "Instructors",
          url: "#",
        },
        {
          title: "Payments",
          url: "#",
        },
      ],
    },
  ],
  projects: [
    {
      name: "Content Library",
      url: "#",
      icon: FileText,
    },
    {
      name: "Revenue Reports",
      url: "#",
      icon: DollarSign,
    },
    {
      name: "AI Assistant",
      url: "#",
      icon: Sparkles,
    },
  ],
}

export function AppSidebar({ ...props }: React.ComponentProps<typeof Sidebar>) {
  return (
    <Sidebar collapsible="icon" {...props}>
      <SidebarHeader>
        <TeamSwitcher teams={data.teams} />
      </SidebarHeader>
      <SidebarContent>
        <NavMain items={data.navMain} />
        <NavProjects projects={data.projects} />
      </SidebarContent>
      <SidebarFooter>
        <NavUser user={data.user} />
      </SidebarFooter>
      <SidebarRail />
    </Sidebar>
  )
}
