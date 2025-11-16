import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Download, Copy, CheckCircle2, AlertCircle } from "lucide-react";
import { toast } from "sonner";
import { CourseDetail, MissingFields } from "@/types/course";
import { ScrollArea } from "@/components/ui/scroll-area";
import { useState } from "react";

interface ReviewStepProps {
  data: Partial<CourseDetail>;
}

export function ReviewStep({ data }: ReviewStepProps) {
  const [copied, setCopied] = useState(false);

  const getMissingFields = (): MissingFields => {
    const critical: string[] = [];
    const optional: string[] = [];

    if (!data.basicInfo?.title) critical.push("Course Title");
    if (!data.basicInfo?.instructor) critical.push("Instructor");
    if (!data.description) critical.push("Description");
    if (!data.whatYouLearn || data.whatYouLearn.length === 0) critical.push("Learning Objectives");
    if (!data.courseIncludes || data.courseIncludes.length === 0) critical.push("Course Includes");
    if (!data.curriculum || data.curriculum.length === 0) critical.push("Curriculum");
    
    // Check if curriculum has lessons
    const hasLessons = data.curriculum?.some(section => section.lessons && section.lessons.length > 0);
    if (!hasLessons) critical.push("Curriculum Lessons (add lessons to sections)");
    
    if (!data.pricing) critical.push("Pricing");
    if (!data.language) critical.push("Language");
    
    // Check for liveBatch if course is live
    if (data.basicInfo?.isLive && !data.liveBatch?.name) {
      critical.push("Live Batch Details");
    }

    if (!data.basicInfo?.thumbnailUrl) optional.push("Thumbnail");
    if (!data.basicInfo?.duration) optional.push("Duration");
    if (!data.prerequisites || data.prerequisites.length === 0) optional.push("Prerequisites");

    return { critical, optional };
  };

  const missingFields = getMissingFields();
  const isComplete = missingFields.critical.length === 0;
  
  // Create clean JSON export (remove undefined/null fields)
  const cleanData = JSON.parse(JSON.stringify(data, (key, value) => {
    if (value === undefined || value === null || value === '') return undefined;
    return value;
  }));
  
  const jsonString = JSON.stringify(cleanData, null, 2);

  const handleCopy = () => {
    navigator.clipboard.writeText(jsonString);
    setCopied(true);
    toast.success("JSON copied!");
    setTimeout(() => setCopied(false), 2000);
  };

  const handleDownload = () => {
    const blob = new Blob([jsonString], { type: "application/json" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `course-${data.basicInfo?.id || 'draft'}.json`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    toast.success("JSON downloaded!");
  };

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Review & Export</h2>
        <p className="text-muted-foreground mt-1">Check everything and export your course JSON</p>
      </div>

      {/* Status Card */}
      <Card className={`p-6 ${isComplete ? 'border-success' : 'border-warning'}`}>
        <div className="flex items-start gap-4">
          {isComplete ? (
            <CheckCircle2 className="h-8 w-8 text-success flex-shrink-0" />
          ) : (
            <AlertCircle className="h-8 w-8 text-warning flex-shrink-0" />
          )}
          
          <div className="flex-1">
            <h3 className="font-semibold text-lg mb-2">
              {isComplete ? "Course Ready!" : "Missing Information"}
            </h3>
            
            {!isComplete && missingFields.critical.length > 0 && (
              <div className="space-y-2">
                <p className="text-sm text-muted-foreground">Critical fields to complete:</p>
                <div className="flex flex-wrap gap-2">
                  {missingFields.critical.map((field) => (
                    <Badge key={field} variant="destructive">{field}</Badge>
                  ))}
                </div>
              </div>
            )}

            {missingFields.optional.length > 0 && (
              <div className="space-y-2 mt-3">
                <p className="text-sm text-muted-foreground">Optional fields:</p>
                <div className="flex flex-wrap gap-2">
                  {missingFields.optional.map((field) => (
                    <Badge key={field} variant="outline">{field}</Badge>
                  ))}
                </div>
              </div>
            )}

            {isComplete && (
              <p className="text-sm text-muted-foreground">
                All required fields are filled. Your course JSON is ready to export!
              </p>
            )}
          </div>
        </div>
      </Card>

      {/* Export Actions - Prominent and sticky */}
      <Card className="p-4 bg-gradient-to-r from-primary/5 to-primary-glow/5 border-primary/20 sticky top-0 z-10 shadow-lg">
        <div className="flex flex-col sm:flex-row gap-3">
          <Button 
            onClick={handleCopy} 
            size="lg" 
            variant="outline"
            className="flex-1 h-14 text-base font-semibold border-2"
          >
            <Copy className="h-5 w-5 mr-2" />
            {copied ? "✓ Copied to Clipboard!" : "Copy JSON to Clipboard"}
            {copied && <CheckCircle2 className="h-5 w-5 ml-2" />}
          </Button>
          <Button 
            onClick={handleDownload} 
            size="lg"
            variant="gradient"
            className="flex-1 h-14 text-base font-semibold shadow-xl"
          >
            <Download className="h-5 w-5 mr-2" />
            Download JSON File
          </Button>
        </div>
      </Card>

      {/* JSON Preview */}
      <Card className="overflow-hidden">
        <div className="bg-muted px-4 py-3 border-b flex items-center justify-between">
          <h3 className="font-semibold">JSON Preview</h3>
        </div>
        
        <ScrollArea className="h-[400px]">
          <pre className="p-4 text-xs font-mono">
            <code>{jsonString}</code>
          </pre>
        </ScrollArea>
      </Card>

      {/* Course Summary */}
      <Card className="p-6">
        <h3 className="font-semibold mb-4">Course Summary</h3>
        <dl className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm">
          <div>
            <dt className="text-muted-foreground">Title</dt>
            <dd className="font-medium mt-1">{data.basicInfo?.title || "—"}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">Instructor</dt>
            <dd className="font-medium mt-1">{data.basicInfo?.instructor || "—"}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">Type</dt>
            <dd className="font-medium mt-1">
              {data.basicInfo?.isFree ? "Free" : data.basicInfo?.isLive ? "Live" : data.basicInfo?.isRecorded ? "Recorded" : "—"}
            </dd>
          </div>
          <div>
            <dt className="text-muted-foreground">Price</dt>
            <dd className="font-medium mt-1">
              {data.basicInfo?.isFree ? "Free" : `₹${data.pricing?.fullPrice || 0}`}
            </dd>
          </div>
          <div>
            <dt className="text-muted-foreground">Sections</dt>
            <dd className="font-medium mt-1">{data.curriculum?.length || 0}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">Total Lessons</dt>
            <dd className="font-medium mt-1">
              {data.curriculum?.reduce((acc, s) => acc + s.lessons.length, 0) || 0}
            </dd>
          </div>
        </dl>
      </Card>
    </div>
  );
}
