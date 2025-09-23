# VidyaRas: EdTech Learning Platform
## Functional Specification Document & Development Agreement
  
**Date:** February 16, 2025
  
### Developer Details
- **Name:** Aditya Paswan
- **Email:** cs.aditya58@gmail.com
- **Mobile:** +91 7810906454
  
### Client Details
- **Name:** Mohit Dobhal
- **Email:** dobhalmohit@gmail.com
- **Mobile:** +91 7827593145
- **Business Name:** VidyaRas
  
---
  
## 1. Project Overview
VidyaRas is a comprehensive EdTech learning platform designed to provide accessible, culturally grounded, and holistic education in extracurricular domains such as music, wellness, and creative skills. The platform aims to create an integrated, values-based learning environment that blends personal development with tradition through bilingual (Hindi & English) structured instruction.
The application will be developed for Android platform initially, with a hybrid learning model featuring live classes, on-demand content, quizzes, and community chat spaces. The platform targets students preparing for music examinations, learners pursuing extracurricular credentials, and culturally-conscious individuals who value tradition and community in their learning.
  
## 2. Target Audience
- Students preparing for government or international music examinations (e.g., ABRSM, Trinity)
- Learners pursuing extracurricular credentials or skills across music, wellness, yoga, and creative arts
- Educated, culturally-conscious learners who value tradition, personalization, and community in their learning experiences
  
## 3. Technical Architecture
The VidyaRas platform will be developed using the following technical stack:
- **Student-Facing Application**: Flutter framework for Android (iOS development planned post 2-month initial phase)
- **Admin and Teacher Dashboards**: Web-based responsive interfaces
- **Live Streaming Integration**: Zoom platform for all live classes and scheduling
- **Payment Processing**: Razorpay integration for monthly payment collections
- **Content Delivery**: Optimized media player with Picture-in-Picture (PiP) and background audio support
  
## 4. Scope of Work
  
### 4.1 Functional Requirements
  
#### **User Authentication & Profile Management:**
- **FR1:** Users must be able to register, log in, and manage their profiles
- **FR2:** The platform must present a mandatory onboarding questionnaire after registration to capture user interests and learning goals
  
#### **Content Discovery & Personalization:**
- **FR3:** The user's home screen must be a dynamic dashboard with content algorithmically recommended based on their onboarding answers
  
#### **Course Architecture:**
- **FR4:** The platform must support two course types: real-time Live Courses and self-paced Recorded Courses
- **FR5:** A free content strategy shall be implemented, offering limited trials of paid courses and standalone mini-courses
  
#### **Live Course Features:**
- **FR6:** For Live Courses, students must be assigned to batches, receive resources after each class, and if joining mid-batch, get access to previous recordings
  
#### **Recorded Course Features:**
- **FR7:** For Recorded Courses, progress must be gated; users must pass a quiz after a video to unlock the next one
- **FR8:** Students in Recorded Courses must be paired with a live batch to access its specific community chat
  
#### **Payment & Monetization:**
- **FR9:** The platform must support multiple payment models: upfront payment for all courses and monthly fees for Live Courses only
- **FR10:** A discount system must be available, including discounts for upfront payments, bundled courses, and personalized coupon codes
- **FR11:** A student referral program must be implemented, allowing registered users to earn redeemable points
  
#### **Community & Communication:**
- **FR12:** A two-tiered chat system must exist: private, batch-specific chats and a general, platform-wide community forum
  
#### **Assessment & Testing:**
- **FR13:** A dedicated Test Series module must be available for students to take practice tests and track performance
  
#### **Media & Content Delivery:**
- **FR14:** The media player must support picture-in-picture (PiP) playback and a background audio-only mode for practice tracks ("Harmonica Feature")
  
#### **Administration & Management:**
- **FR15:** A web-based admin dashboard with role-based access for Teachers and Admins must be available to manage courses, users, and financials
- **FR16:** The platform must integrate with Zoom for scheduling and conducting all live classes
- **FR17:** The Admin dashboard will include financial reporting to track revenue, EMIs, and refunds
  
#### **Free User Access:**
- **FR18:** Free users will have specific access to: the "Harmonica" background audio feature, the platform-wide community chat, standalone mini-courses, and trial videos for paid courses
  
## 5. Development Phases and Timeline
  
> **Important Note:** All dates and durations mentioned below are tentative milestone checkpoints. The actual completion dates may vary due to unforeseen technical challenges, third-party API issues, or other circumstances beyond the developer's control. The client explicitly acknowledges this by signing this agreement.
  
**Project Start Date:** August 20, 2025
  
### Phase 1: Project Initiation and UI Development
**Timeline:** August 20 - September 10, 2025  
**Duration:** 21 days  
**Deliverables:**
- Mobile app UI implementation for core screens
- Basic user authentication and profile management
- Course browsing and discovery interface
- Initial dashboard structure (both mobile and web)
- Basic admin dashboard setup
  
**Payment Milestone:** ₹13,000 upon completion by September 10, 2025
  
### Phase 2: Core Functionality and Dashboard Development
**Timeline:** September 11 - October 10, 2025  
**Duration:** 29 days  
**Deliverables:**
- Complete admin and teacher dashboard functionality
- Payment integration with Razorpay
- Live course and recorded course core features
- Chat system implementation
- Quiz and testing module
- Enhanced media player with PiP and Harmonica features
  
**Payment Milestone:** ₹13,000 upon completion by October 10, 2025
  
### Phase 3: Final Integration and Deployment
**Timeline:** October 11 - October 31, 2025  
**Duration:** 20 days  
**Deliverables:**
- Complete app testing and bug fixes
- Zoom integration implementation
- Final quality assurance and optimization
- Play Store deployment and app approval
  
**Payment Milestone:** ₹5,500 upon successful Play Store deployment in October 2025
  
## 6. Budget and Payment Terms
  
**Total Project Cost:** ₹35,000
  
**Payment Schedule**:
  
### Payment Schedule:
  
1. **Advance Payment (10% of total project cost)**
   - **Amount:** ₹3,500
   - **Due:** Upon signing of this agreement (before August 20, 2025)
   - **Triggers:** Project initiation and requirement finalization
  
2. **Phase 1 Payment**
   - **Amount:** ₹13,000
   - **Due:** Upon completion of Phase 1 deliverables by September 10, 2025
   - **Criteria:** Mobile app UI completion and basic functionality demonstration
  
3. **Phase 2 Payment**
   - **Amount:** ₹13,000
   - **Due:** Upon completion of Phase 2 deliverables by October 10, 2025
   - **Criteria:** Dashboard completion and core app functionality demonstration
  
4. **Final Payment**
   - **Amount:** ₹5,500
   - **Due:** Upon successful Play Store deployment in October 2025
   - **Criteria:** App live on Play Store and fully functional
  
## 7. Legal Disclaimers and Liability Limitations
  
### 7.1 Developer's Role and Limitations
  
The developer, Aditya Paswan, is contracted solely for technical development of the VidyaRas EdTech application. The developer's role is strictly limited to:
- Writing and implementing application code
- Creating specified technical functionalities
- Basic testing of implemented features
- Deployment to specified platforms (Android initially, iOS later)
  
### 7.2 Explicit Non-Liability Areas
  
The developer explicitly disclaims any liability for:
  
#### a) Educational Content and Service Quality:
- Quality, accuracy, or effectiveness of educational content provided through the application
- Teaching methodologies, curriculum design, or educational outcomes
- Instructor qualifications, teaching quality, or student satisfaction
- Course completion rates or student performance results
- Accuracy of course descriptions, learning objectives, or skill assessments
- Any claims related to educational certification or credential recognition
- The developer is not responsible for educational content as the application merely facilitates delivery
  
#### b) Business Operations:
- Student verification, instructor vetting, or user authentication beyond technical implementation
- Monthly payment collection issues not directly related to technical payment processing
- Customer service, student support, or dispute resolution
- Course scheduling, class management, or educational delivery logistics
- Pricing accuracy, discount calculations, or promotional content
- Course content management beyond technical implementation
- Marketing claims, educational promises, or outcome guarantees
  
#### c) Data and Content Management:
- Educational content licensing or intellectual property compliance
- Student data privacy compliance beyond basic technical security measures
- Content moderation in community chats beyond providing reporting tools
- User-generated content management and liability
- Third-party content integration and licensing
- Student progress data accuracy beyond technical tracking
- Data backup and recovery beyond basic technical implementation
  
#### d) Technical Integration and Third-Party Services:
- Zoom API failures, service changes, or availability issues
- Razorpay payment gateway failures or transaction processing issues
- Google Play Store approval delays or rejection
- Third-party service interruptions or policy changes
- Network connectivity issues affecting app performance
- Device compatibility beyond specified Android/iOS versions
- Server downtime not directly related to application code
  
#### e) Legal and Regulatory Compliance:
- EdTech industry regulations and compliance requirements
- Educational licensing and accreditation requirements
- Consumer protection laws specific to online education
- Data protection law compliance (DPDP Act, GDPR where applicable)
- Regional education regulations and government compliance
- Tax implications of course sales and student payments
- Employment law compliance for instructors using the platform
  
#### f) Timeline and Development Delays:
- Delays caused by unforeseen technical challenges or third-party API changes
- Client-related delays (feedback delays, requirement changes, approval processes)
- Force majeure events (natural disasters, government restrictions, etc.)
- Platform policy changes affecting deployment (Play Store, App Store policies)
- The timelines specified are estimates and milestone checkpoints only
  
### 7.3 Developer Legal Limitations
  
#### a) Legal Compliance Responsibility:
- The developer is not responsible for ensuring the client's compliance with educational, content licensing, data protection, or EdTech-specific laws and regulations
- The client is solely responsible for consulting appropriate legal bodies for guidance on regulatory compliance
- Any specific legal requirements must be communicated to the developer by the client after proper legal consultation
  
#### b) Monthly Payment System:
- The platform implements a monthly payment reminder system through Razorpay integration
- The developer is not responsible for payment collection, processing disputes, or subscription management
- All payment-related legal compliance (RBI guidelines, consumer protection) is the client's responsibility
  
#### c) Educational Content Liability:
- The developer bears no responsibility for the accuracy, quality, or effectiveness of educational content provided by the client
- Course content, teaching methodologies, and educational outcomes are entirely the client's responsibility
- The developer's role is limited to providing the technical platform for content delivery
  
#### d) Data Misuse and Privacy:
- The developer is not liable for any misuse of user data collected through the platform
- Data protection compliance, privacy policies, and user consent management are the client's sole responsibility
- The client must ensure proper data handling practices and legal compliance
  
#### e) User Satisfaction and Disputes:
- The developer disclaims all liability for user dissatisfaction with courses, content, or educational services
- Student complaints, refund requests, and service quality issues are the client's responsibility
- The developer's obligation is limited to technical platform functionality
  
### 7.4 Warranty and Support
  
- The application is provided "as is" without warranty of any kind
- Post-deployment support limited to bug fixes for 6 months after Play Store launch
- Feature modifications or enhancements require separate agreement and additional cost
- No guarantee of Play Store approval or continuous platform compliance
- No warranty regarding educational effectiveness or student outcomes
  
### 7.5 Indemnification
  
The client agrees to indemnify and hold harmless the developer (Aditya Paswan) from and against any and all claims, liabilities, damages, losses, and expenses (including attorney's fees) arising out of or in any way connected with:
- The provision of educational content and services through the application
- Any violation of educational or data protection regulations
- Student data misuse or privacy violations
- The client's business operations and educational service delivery
- Claims related to course quality, instructor performance, or educational outcomes
- The client's use of the application in a manner that violates any law or regulation
  
### 7.6 Intellectual Property
  
#### a) Code Ownership:
The developer (Aditya Paswan) retains ownership of all source code, software libraries, and other intellectual property created during the development of the VidyaRas application.
  
#### b) Licensing:
Upon full payment of the project cost, the client is granted a non-exclusive, non-transferable license to use the application for its intended purpose. The client is not permitted to modify, distribute, or sublicense the application without the express written consent of the developer.
  
#### c) Component Reuse:
The developer reserves the right to reuse components, code snippets, and libraries developed for this project in other projects.
  
## 8. Client Acknowledgments
  
By signing this agreement, the client explicitly acknowledges and agrees that:
  
1. The developer's role is strictly limited to technical implementation of the VidyaRas EdTech platform
  
2. The developer bears no responsibility for:
   - Educational content quality, accuracy, or effectiveness
   - Business operations and student service delivery
   - Legal compliance beyond basic app functionality
   - Course content accuracy or educational outcomes
   - User misuse, data privacy violations, or platform abuse
  
3. Timelines are estimates and subject to variation due to technical challenges or unforeseen circumstances
  
4. All listed non-liability areas in Section 10 are understood and accepted
  
5. The client is solely responsible for compliance with all applicable laws and regulations related to online education, including but not limited to EdTech regulations, educational licensing, and student data protection requirements
  
6. The client acknowledges that the admin and teacher dashboards are multi-user systems with role-based access and is responsible for managing all data, including student information and educational content
  
7. The client acknowledges that the developer is not responsible for any issues arising from the client's use of the application, including but not limited to issues related to:
   - Educational content delivery and quality
   - Student satisfaction and course outcomes
   - Marketing, customer service, or business operations
   - Instructor management and performance
   - Payment collection and subscription management
  
8. The client acknowledges that the developer is not responsible for any delays caused by unforeseen circumstances, including but not limited to:
   - Technical challenges and third-party API issues
   - Client-related delays (feedback, requirement changes, approval processes)
   - Play Store approval processes and policy changes
   - Zoom or Razorpay service interruptions
  
9. The client acknowledges and agrees to comply with all applicable data protection laws and regulations, including:
   - Digital Personal Data Protection Act, 2023 (DPDPA)
   - General Data Protection Regulation (GDPR) where applicable
   - Student privacy protection requirements
   - The client is solely responsible for the security of student and user data
  
10. The client acknowledges that the developer retains ownership of the application's source code and that the client is granted a limited, non-exclusive license to use the application
  
11. The client acknowledges that future platform compatibility, maintenance beyond the initial 6-month bug fix period, and feature enhancements are the client's responsibility and may require separate agreements
  
12. The client acknowledges that educational outcomes, student performance, course effectiveness, and business success are not guaranteed and depend entirely on the client's content quality, teaching methodology, and business operations
  
## 9. Signatures
  
Client acknowledges reading and accepting all terms, especially sections 10 and 11:
  
### Client Agreement
**Name:** Mohit Dobhal  
**Business:** VidyaRas  
**Signature:** _________________  
**Date:** _________________
  
### Developer Agreement
**Name:** Aditya Paswan  
**Signature:** _________________  
**Date:** _________________
  
## 10. Jurisdiction
  
This agreement shall be governed by the laws of India, and any disputes shall be resolved through arbitration in the jurisdiction of the developer's choosing.
  
---
  
## 11. EdTech and E-Commerce Compliance
  
The client acknowledges and accepts full responsibility for ensuring compliance with all applicable EdTech, e-commerce, and educational service laws and regulations, including but not limited to:
  
### a) Consumer Protection and E-Commerce Regulations:
- Consumer Protection (E-Commerce) Rules, 2020
- Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021
- Display of course information, pricing, and terms as required by law
- Implementation of grievance redressal mechanism for students
- Compliance with pricing, discounting, and promotional regulations
  
### b) Educational Service Compliance:
- University Grants Commission (UGC) guidelines for online courses (where applicable)
- All India Council for Technical Education (AICTE) regulations (where applicable)
- State education board regulations and requirements
- Educational advertising standards and guidelines
- Student data privacy and protection requirements
  
### c) Payment and Financial Compliance:
- Reserve Bank of India (RBI) guidelines for digital payments
- Payment and Settlement Systems Act, 2007
- Goods and Services Tax (GST) compliance for educational services
- Income Tax regulations for online course sales
- Foreign Exchange Management Act (FEMA) compliance (if applicable)
  
### d) Content and Intellectual Property Compliance:
- Copyright Act, 1957 for educational content licensing
- Trademark regulations for brand protection
- Traditional Knowledge Digital Library (TKDL) guidelines for cultural content
- Music and arts content licensing requirements
  
The developer bears no responsibility for ensuring the client's compliance with these regulations, as the application merely provides a technical platform for the client's educational business operations.
  
---
  
## 12. Legal Citations and Resources
  
The following legal citations and resources are provided for informational purposes only and do not constitute legal advice. It is recommended that you consult with a qualified legal professional for advice on your specific situation.
  
### Legal References:
  
**1. Digital Personal Data Protection Act, 2023 (India)**  
This act governs the processing of digital personal data in India while protecting the rights of individuals, particularly relevant for student data handling.  
*Relevant to Section 7.2(c) and 7.3(d) regarding student data protection and privacy compliance.*
  
**2. Information Technology Act, 2000 (India)**  
This act provides legal recognition for electronic transactions and addresses various aspects of cybercrime and data security in India.  
*Available at: https://www.indiacode.nic.in/handle/123456789/2178*  
*Relevant to Section 7.2(d) regarding technical security and data protection.*
  
**3. Consumer Protection (E-Commerce) Rules, 2020**  
These rules govern e-commerce platforms and marketplace operations in India, applicable to online course sales.  
*Relevant to Section 11(a) regarding e-commerce compliance for educational services.*
  
**4. University Grants Commission (Online Courses or Programmes) Regulations, 2018**  
These regulations govern the offering of online courses and programs by higher educational institutions.  
*Relevant to educational content delivery and certification aspects of the platform.*
  
**5. Copyright Act, 1957 (India)**  
This act protects the rights of creators of original works, including educational content, software code, and multimedia materials.  
*Available at: https://copyright.gov.in/Documents/Copyright_Act_1957.pdf*  
*Relevant to Section 7.6 regarding intellectual property and educational content licensing.*
  
**6. Indian Contract Act, 1872**  
This act governs the formation and interpretation of contracts in India.  
*Available at: https://legislative.gov.in/sites/default/files/A1872-9.pdf*  
*Relevant to the entire agreement as it governs the enforceability of this development contract.*
  
**7. Reserve Bank of India (RBI) Guidelines on Digital Lending and Payment Systems**  
These guidelines govern digital payment processing and EMI systems used in the platform.  
*Relevant to Section 7.2(d) regarding payment gateway integration and monthly payment processing.*
  
**8. Advertising Standards Council of India (ASCI) Guidelines for EdTech**  
Self-regulatory guidelines for educational technology advertising and marketing practices.  
*Relevant to educational service marketing and promotional content displayed through the platform.*
  
---
  
> **Important Disclaimer:** All legal references and compliance requirements mentioned in this document are for informational purposes only. The client must consult with qualified legal professionals for specific compliance guidance and should not rely solely on this document for legal advice.
  
  