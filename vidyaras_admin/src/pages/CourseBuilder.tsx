import { useState } from "react";
import { CourseDetail } from "@/types/course";
import { FloatingAIChat } from "@/components/FloatingAIChat";
import { StepWizard } from "@/components/StepWizard";
import { BasicInfoStep } from "@/components/steps/BasicInfoStep";
import { ContentStep } from "@/components/steps/ContentStep";
import { CurriculumStep } from "@/components/steps/CurriculumStep";
import { PricingStep } from "@/components/steps/PricingStep";
import { ReviewStep } from "@/components/steps/ReviewStep";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight, Sparkles } from "lucide-react";
import { toast } from "sonner";
import { ScrollArea } from "@/components/ui/scroll-area";

const steps = [
  { id: "basic", title: "Basic Info", description: "Course essentials" },
  { id: "content", title: "Content", description: "What students learn" },
  { id: "curriculum", title: "Curriculum", description: "Sections & lessons" },
  { id: "pricing", title: "Pricing", description: "Price & features" },
  { id: "review", title: "Review", description: "Export JSON" },
];

const CourseBuilder = () => {
  const [currentStep, setCurrentStep] = useState(0);
  const [courseData, setCourseData] = useState<Partial<CourseDetail>>({
    basicInfo: {
      id: Date.now().toString(),
      title: "",
      instructor: "",
      rating: 0,
      reviewCount: 0,
      enrolledCount: 0,
      isFree: false,
      isLive: false,
      hasFreeTrial: false,
      isRecorded: false,
    },
    description: "",
    whatYouLearn: [],
    courseIncludes: [],
    prerequisites: [],
    curriculum: [],
    reviews: [],
    hasCertificate: false,
    hasQuizzes: false,
    hasMaterials: false,
    pricing: {
      fullPrice: 0,
      isFree: false,
    },
  });

  const handleAISuggestion = (suggestion: any) => {
    const merged: any = { ...courseData };

    if (suggestion.basicInfo) {
      merged.basicInfo = { ...merged.basicInfo, ...suggestion.basicInfo };
    }

    // Transform curriculum if provided to ensure proper LessonItem structure
    if (suggestion.curriculum) {
      merged.curriculum = suggestion.curriculum.map((section: any, sIdx: number) => {
        const sectionId = section.id || `s${sIdx + 1}`;

        // Transform lessons to proper LessonItem objects
        const lessons = (section.lessons || []).map((lesson: any, lIdx: number) => {
          // If lesson is a string, convert to LessonItem object
          if (typeof lesson === 'string') {
            return {
              id: `${sectionId}_l${lIdx + 1}`,
              title: lesson,
              durationMinutes: 15,
              isLocked: lIdx > 0, // Lock all except first
              isCompleted: false,
              description: ''
            };
          }
          // If already an object, ensure all required fields exist
          return {
            id: lesson.id || `${sectionId}_l${lIdx + 1}`,
            title: lesson.title || '',
            durationMinutes: lesson.durationMinutes || 15,
            isLocked: lesson.isLocked !== undefined ? lesson.isLocked : lIdx > 0,
            isCompleted: lesson.isCompleted || false,
            description: lesson.description || ''
          };
        });

        // Calculate total duration
        const totalDuration = lessons.reduce((sum: number, l: any) => sum + l.durationMinutes, 0);

        return {
          id: sectionId,
          title: section.title || '',
          lessons,
          totalDurationMinutes: totalDuration
        };
      });
    }

    Object.keys(suggestion).forEach((key) => {
      if (key !== 'basicInfo' && key !== 'curriculum') {
        merged[key] = suggestion[key];
      }
    });

    setCourseData(merged);
  };

  const handleAutoGenerate = async (field: string) => {
    toast.info("Generating with AI...");

    try {
      const context = JSON.stringify(courseData, null, 2);
      const response = await fetch(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=AIzaSyAQ2tNsx_swXCqjnQoOdkpJRSo5GWlKrBk",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            contents: [{
              parts: [{
                text: `Generate content for "${field}" field. Context: ${context}

Return ONLY valid JSON with the field and content. Be creative and realistic.

For "description": Generate 2-3 engaging paragraphs.
For "curriculum": Generate 3-4 sections. Each section must have "title" and "lessons" array. Each lesson can be a string (lesson title).
For "whatYouLearn": Generate 5-6 learning objectives.
For "courseIncludes": Generate 5-7 items.
For "prerequisites": Generate 2-4 requirements.

Format: {"${field}": your_content_here}`
              }]
            }],
            generationConfig: { temperature: 0.8, maxOutputTokens: 2048 }
          })
        }
      );

      const data = await response.json();
      const aiResponse = data.candidates?.[0]?.content?.parts?.[0]?.text || "";

      const jsonMatch = aiResponse.match(/```json\n([\s\S]*?)\n```/) || aiResponse.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const jsonStr = jsonMatch[1] || jsonMatch[0];
        const generated = JSON.parse(jsonStr);
        handleAISuggestion(generated);
        toast.success("Content generated!");
      } else {
        toast.error("Failed to generate");
      }
    } catch (error) {
      console.error(error);
      toast.error("Generation failed");
    }
  };

  const updateData = (field: string, value: any) => {
    if (field.includes('.')) {
      const [parent, child] = field.split('.');
      setCourseData(prev => ({
        ...prev,
        [parent]: { ...(prev as any)[parent], [child]: value }
      }));
    } else if (field === 'pricing') {
      // Ensure consistency between basicInfo.isFree and pricing.isFree
      const isFree = value.isFree || value.fullPrice === 0;
      setCourseData(prev => ({
        ...prev,
        pricing: value,
        basicInfo: {
          ...prev.basicInfo!,
          isFree,
          price: isFree ? 'Free' : `₹${value.fullPrice}`
        }
      }));
    } else if (field === 'liveBatch') {
      setCourseData(prev => ({ ...prev, liveBatch: value }));
    } else if (['isLive', 'isFree', 'isRecorded'].includes(field)) {
      setCourseData(prev => {
        const updates: any = {
          ...prev,
          basicInfo: { ...prev.basicInfo!, [field]: value }
        };

        // When switching to/from live, handle liveBatch
        if (field === 'isLive') {
          if (value) {
            // Add liveBatch with defaults
            updates.liveBatch = prev.liveBatch || {
              id: `b1_${prev.basicInfo?.title?.toLowerCase().replace(/\s+/g, '_') || 'course'}_${new Date().getFullYear()}`,
              name: `${prev.basicInfo?.title || 'Course'} Batch`,
              startDate: new Date().toISOString(),
              schedule: 'Mon, Wed, Fri',
              time: '5:00 PM',
              capacity: 50,
              enrolled: 0
            };
          } else {
            // Remove liveBatch when not live
            updates.liveBatch = undefined;
          }
        }

        // Sync isFree with pricing
        if (field === 'isFree') {
          updates.pricing = {
            ...prev.pricing,
            isFree: value,
            fullPrice: value ? 0 : (prev.pricing?.fullPrice || 0)
          };
          updates.basicInfo.price = value ? 'Free' : prev.basicInfo?.price;
        }

        return updates;
      });
    } else if (['title', 'instructor', 'duration', 'thumbnailUrl', 'price', 'categories'].includes(field)) {
      setCourseData(prev => ({
        ...prev,
        basicInfo: { ...prev.basicInfo!, [field]: value }
      }));
    } else {
      setCourseData(prev => ({ ...prev, [field]: value }));
    }
  };

  const nextStep = () => {
    if (currentStep < steps.length - 1) {
      setCurrentStep(currentStep + 1);
    }
  };

  const prevStep = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const renderStep = () => {
    switch (currentStep) {
      case 0:
        return (
          <BasicInfoStep
            data={courseData}
            onUpdate={updateData}
            onAutoGenerate={handleAutoGenerate}
          />
        );
      case 1:
        return (
          <ContentStep
            data={courseData}
            onUpdate={updateData}
            onAutoGenerate={handleAutoGenerate}
          />
        );
      case 2:
        return (
          <CurriculumStep
            data={courseData}
            onUpdate={updateData}
            onAutoGenerate={handleAutoGenerate}
          />
        );
      case 3:
        return <PricingStep data={courseData} onUpdate={updateData} />;
      case 4:
        return <ReviewStep data={courseData} />;
      default:
        return null;
    }
  };

  return (
    <div className="min-h-full flex flex-col">
      {/* Header */}
      <div className="border-b bg-card/95 backdrop-blur supports-[backdrop-filter]:bg-card/80 px-4 py-4">
        <div className="flex items-center gap-3">
          <div className="h-10 w-10 rounded-xl bg-gradient-to-br from-primary to-primary-glow flex items-center justify-center">
            <Sparkles className="h-5 w-5 text-primary-foreground" />
          </div>
          <div>
            <h1 className="text-lg font-bold">Course Builder</h1>
            <p className="text-xs text-muted-foreground">AI-powered JSON generator</p>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <main className="flex-1 flex flex-col">
        <div className="max-w-4xl mx-auto px-4 py-6 md:py-8 flex flex-col flex-1 w-full">
          {/* Step Indicator */}
          <div className="mb-6 md:mb-8">
            <StepWizard
              steps={steps}
              currentStep={currentStep}
              onStepClick={setCurrentStep}
            />
          </div>

          {/* Step Content */}
          <ScrollArea className="flex-1 -mx-4 px-4">
            <div className="pb-24">
              {renderStep()}
            </div>
          </ScrollArea>

          {/* Navigation */}
          <div className="fixed bottom-0 left-0 right-0 p-4 bg-card/95 backdrop-blur border-t supports-[backdrop-filter]:bg-card/80 z-30">
            <div className="max-w-4xl mx-auto flex justify-between gap-4">
              <Button
                variant="outline"
                onClick={prevStep}
                disabled={currentStep === 0}
                className="flex-1 sm:flex-none"
              >
                <ChevronLeft className="h-4 w-4 mr-2" />
                Previous
              </Button>

              {currentStep < steps.length - 1 ? (
                <Button onClick={nextStep} className="flex-1 sm:flex-none">
                  Next
                  <ChevronRight className="h-4 w-4 ml-2" />
                </Button>
              ) : (
                <Button
                  variant="gradient"
                  onClick={() => toast.success("Course ready to export!")}
                  className="flex-1 sm:flex-none"
                >
                  <Sparkles className="h-4 w-4 mr-2" />
                  Complete
                </Button>
              )}
            </div>
          </div>
        </div>
      </main>

      {/* Floating AI Chat */}
      <FloatingAIChat onSuggestion={handleAISuggestion} currentData={courseData} />
    </div>
  );
};

export default CourseBuilder;
