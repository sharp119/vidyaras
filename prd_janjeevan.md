VidyaRas Product Requirements Document (PRD)
1. Goals and Background Context
1.1. Goals
Enroll 500 paid, active students across all offerings within 12 months.

Establish a full learning ecosystem featuring live classes, on-demand content, quizzes, and community chat spaces.

Launch pilot content tracks in music and wellness, with plans to expand into yoga, arts, and life skills.

Build engagement through community-driven workshops and periodic feedback collection to refine offerings.

1.2. Background Context
There is a growing need for accessible, culturally grounded, and holistic education in extracurricular domains such as music, wellness, and creative skills. VidyaRas aims to fill this gap by creating an integrated, values-based learning environment that blends personal development with tradition and offers bilingual, structured instruction.

The target audience includes students preparing for music examinations, learners pursuing extracurricular credentials, and culturally-conscious individuals who value tradition and community in their learning. The platform's unique value proposition is its high-quality bilingual (Hindi & English) instruction, a hybrid learning model of live and on-demand content, and a socially conscious brand focused on preserving Indian performing arts.




2. Requirements
2.1. Functional
FR1: Users must be able to register, log in, and manage their profiles.

FR2: The platform must present a mandatory onboarding questionnaire after registration to capture user interests and learning goals.

FR3: The user's home screen must be a dynamic dashboard with content algorithmically recommended based on their onboarding answers.

FR4: The platform must support two course types: real-time Live Courses and self-paced Recorded Courses.

FR5: A free content strategy shall be implemented, offering limited trials of paid courses and standalone mini-courses.

FR6: For Live Courses, students must be assigned to batches, receive resources after each class, and if joining mid-batch, get access to previous recordings.

FR7: For Recorded Courses, progress must be gated; users must pass a quiz after a video to unlock the next one.

FR8: Students in Recorded Courses must be paired with a live batch to access its specific community chat.

FR9: The platform must support multiple payment models: upfront payment for all courses and monthly installments (EMI) for Live Courses only.

FR10: A discount system must be available, including discounts for upfront payments, bundled courses, and personalized coupon codes.

FR11: A student referral program must be implemented, allowing registered users to earn redeemable points.

FR12: A two-tiered chat system must exist: private, batch-specific chats and a general, platform-wide community forum.

FR13: A dedicated Test Series module must be available for students to take practice tests and track performance.

FR14: The media player must support picture-in-picture (PiP) playback and a background audio-only mode for practice tracks ("Harmonica Feature").

FR15: A web-based admin dashboard with role-based access for Teachers and Admins must be available to manage courses, users, and financials.

FR16: The platform must integrate with Zoom for scheduling and conducting all live classes.

FR17: The system will automatically generate a digital certificate upon successful course completion.

FR18: Students will have the ability to provide ratings and written reviews for courses they have completed.

FR19: The system will send push notifications to users for key events (e.g., upcoming live classes, new chat messages).

FR20: Teachers will have a tool on their dashboard to post announcements to their specific batches.

FR21: The Admin dashboard will include financial reporting to track revenue, EMIs, and refunds.

FR22: Free users will have specific access to: the "Harmonica" background audio feature, the platform-wide community chat, standalone mini-courses, and trial videos for paid courses.

FR23: The community chat will include moderation tools, such as the ability for users to report content.

2.2. Non Functional
NFR1: The platform must be architected to support 500 paid, active students within the first year.

NFR2: The user interface must be clean, intuitive, and personalized to adapt to each user's stated goals and interests.

NFR3: All financial transactions and user data must be handled securely, and the admin dashboard must enforce strict role-based access controls.

NFR4: The media delivery system must be performant, allowing for smooth video streaming and reliable background audio playback without draining device resources.

NFR5: The MVP, including all "Must-Have" features, must be developed and ready for launch within a 2-month timeline.

3. User Interface Design Goals

3.2. Key Interaction Paradigms
Personalized Onboarding: The user journey begins with a mandatory questionnaire that directly shapes their subsequent experience on the platform.

Algorithmic Curation: The home screen will be a dynamic dashboard, not a static catalog, with content recommendations driven by the user's profile.

Gated Progression: Self-paced learning in recorded courses will follow a "Video -> Quiz -> Unlock" model to ensure comprehension and engagement.

Hybrid Content Delivery: The UI must seamlessly accommodate both scheduled, real-time live classes and a library of on-demand recorded content.

Integrated Community: Community interaction is a core feature, with chat systems contextually integrated with course batches.

3.3. Core Screens and Views
Login / Registration Screen.

Onboarding Questionnaire.

Personalized Home Dashboard.

Course Catalog/Discovery.

Course Detail Page (showing trial options, enrollment, and payment plans).

Enhanced Video Player (with Picture-in-Picture and background audio controls).

Live Class Interface.

Quiz View.

Community Chat (Batch-specific and Platform-wide views).

Test Series Module.

Student Profile and Progress Dashboard.

3.6. Target Device and Platforms: Web Responsive and Mobile (iOS & Android)
current scope is only for the android , ios will be developed post 2months 
This concludes the current version of the document.


4.4. Additional Technical Assumptions and Requests
The student-facing application will be developed using Flutter.

The Admin and Teacher dashboards will be web-based.

Zoom will be integrated for all live streaming and scheduling functionalities.