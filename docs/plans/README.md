# VidyaRas Public Launch Documentation

Complete documentation for bringing VidyaRas to market with dashboard and app.

---

## 📋 Documents

### 1. **Feature Specification Document (FSD)**
**File:** `launch_fsd.md`

Comprehensive feature specification covering:
- System architecture (Next.js + Flutter + Supabase)
- Complete data models (Course → Module → Lesson → Lecture hierarchy)
- User roles & permissions (Admin, Teacher, Student, Public)
- All features with workflows
- API endpoints with access control
- Database schema
- File storage strategy
- Out of scope items (post-launch)

**Read this first** to understand what we're building.

---

### 2. **Implementation Checklist**
**File:** `launch_checklist.md`

12-week actionable checklist broken into phases:
- ✅ Phase 1: Database & API Foundation (Week 1-2)
- ✅ Phase 2: Course Management (Week 3-4)
- ✅ Phase 3: Module & Lesson Management (Week 4-5)
- ✅ Phase 4: Lecture & Material Management (Week 5-6)
- ✅ Phase 5: Quiz System (Week 6-7)
- ✅ Phase 6: Student & Enrollment Management (Week 8)
- ✅ Phase 7: Progress Reports & Teacher Tools (Week 9)
- ✅ Phase 8: App API Integration (Week 10-11)
- ✅ Phase 9: Dashboard Polish & Testing (Week 11)
- ✅ Phase 10: Pre-Launch Prep (Week 12)
- 🚀 Phase 11: Launch Day

Check off items as you complete them.

---

## 🎯 Quick Start

1. **Understand the Vision**: Read `launch_fsd.md` sections 1-4
2. **Review Data Models**: Read `launch_fsd.md` section 2
3. **Start Building**: Follow `launch_checklist.md` Phase 1
4. **Reference Architecture**: Use `launch_fsd.md` as reference during development

---

## 🏗️ System Overview

**Architecture:**
```
Flutter App ←→ Next.js API ←→ Supabase
             (Dashboard)
```

**Content Hierarchy:**
```
Course → Module → Lesson → Lecture
                        ├── Materials (PDFs)
                        └── Quiz (optional prerequisite)
```

**Tech Stack:**
- Dashboard: Next.js 14+ (Frontend + API)
- App: Flutter (Android-first)
- Database: Supabase (PostgreSQL)
- Storage: Supabase Storage + Google Drive (videos)
- Live Classes: External links (Zoom/Meet)

---

## 📊 Current Status

**App:** UI ready with demo data, needs API integration
**Dashboard:** Course Builder partial, needs completion + all other features
**API:** Not built yet
**Database:** Schema defined in FSD, needs implementation

---

## 🚀 Critical Path to Launch

1. ✅ Complete Course Builder (DB integration + uploads)
2. ✅ Build Module/Lesson/Lecture Management
3. ✅ Build Quiz Builder
4. ✅ Build Student & Enrollment Management
5. ✅ Integrate App with API
6. ✅ Test Everything
7. 🚀 Deploy & Launch

**Timeline:** 12 weeks

---

## 📝 Notes

- This is v1 - ship fast, iterate later
- Focus on critical path items
- Test continuously
- Get user feedback early
- Done > Perfect

**Questions?** Refer to `launch_fsd.md` for detailed specs.
