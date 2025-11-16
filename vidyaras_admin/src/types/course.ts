export interface Course {
  id: string;
  title: string;
  instructor: string;
  thumbnailUrl?: string;
  rating: number;
  reviewCount: number;
  enrolledCount: number;
  price?: string;
  duration?: string;
  isFree: boolean;
  isLive: boolean;
  hasFreeTrial: boolean;
  isRecorded: boolean;
  progress?: number;
  categories?: string[];
  createdAt?: string;
}

export interface PricingOption {
  fullPrice: number;
  emiMonthlyPrice?: number;
  emiTenure?: number;
  isFree: boolean;
}

export interface BatchInfo {
  id: string;
  name: string;
  startDate: string;
  schedule: string;
  time: string;
  capacity: number;
  enrolled: number;
}

export interface LessonItem {
  id: string;
  title: string;
  durationMinutes: number;
  isLocked: boolean;
  isCompleted: boolean;
  description?: string;
}

export interface SectionInfo {
  id: string;
  title: string;
  lessons: LessonItem[];
  totalDurationMinutes?: number;
}

export interface CourseReview {
  id: string;
  userName: string;
  userAvatar?: string;
  rating: number;
  reviewText: string;
  createdAt: string;
}

export interface CourseDetail {
  basicInfo: Course;
  description: string;
  whatYouLearn: string[];
  courseIncludes: string[];
  prerequisites: string[];
  curriculum: SectionInfo[];
  pricing: PricingOption;
  reviews: CourseReview[];
  liveBatch?: BatchInfo;
  accessDays?: number;
  accessExpiryDate?: string;
  language?: string;
  hasCertificate: boolean;
  hasQuizzes: boolean;
  hasMaterials: boolean;
}

export type CourseType = 'live' | 'recorded' | 'free';

export interface MissingFields {
  critical: string[];
  optional: string[];
}
