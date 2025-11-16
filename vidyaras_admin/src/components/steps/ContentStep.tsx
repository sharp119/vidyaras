import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Plus, Trash2, Sparkles } from "lucide-react";

interface ContentStepProps {
  data: any;
  onUpdate: (field: string, value: any) => void;
  onAutoGenerate: (field: string) => void;
}

export function ContentStep({ data, onUpdate, onAutoGenerate }: ContentStepProps) {
  const addItem = (field: 'whatYouLearn' | 'courseIncludes' | 'prerequisites') => {
    const current = data[field] || [];
    onUpdate(field, [...current, '']);
  };

  const updateItem = (field: 'whatYouLearn' | 'courseIncludes' | 'prerequisites', index: number, value: string) => {
    const current = [...(data[field] || [])];
    current[index] = value;
    onUpdate(field, current);
  };

  const removeItem = (field: 'whatYouLearn' | 'courseIncludes' | 'prerequisites', index: number) => {
    const current = [...(data[field] || [])];
    current.splice(index, 1);
    onUpdate(field, current);
  };

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Course Content</h2>
        <p className="text-muted-foreground mt-1">Define what students will learn and get</p>
      </div>

      {/* What You'll Learn */}
      <Card className="p-6 space-y-4">
        <div className="flex items-center justify-between">
          <Label className="text-base font-semibold">What You'll Learn *</Label>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={() => onAutoGenerate('whatYouLearn')}>
              <Sparkles className="h-4 w-4 mr-2" />
              Generate
            </Button>
            <Button variant="outline" size="sm" onClick={() => addItem('whatYouLearn')}>
              <Plus className="h-4 w-4" />
            </Button>
          </div>
        </div>
        <div className="space-y-3">
          {(data.whatYouLearn || []).map((item: string, idx: number) => (
            <div key={idx} className="flex gap-2">
              <Input
                value={item}
                onChange={(e) => updateItem('whatYouLearn', idx, e.target.value)}
                placeholder="Learning objective..."
              />
              <Button
                variant="ghost"
                size="icon"
                onClick={() => removeItem('whatYouLearn', idx)}
              >
                <Trash2 className="h-4 w-4" />
              </Button>
            </div>
          ))}
          {(!data.whatYouLearn || data.whatYouLearn.length === 0) && (
            <p className="text-sm text-muted-foreground text-center py-4">
              No learning objectives yet. Add some or use AI to generate.
            </p>
          )}
        </div>
      </Card>

      {/* Course Includes */}
      <Card className="p-6 space-y-4">
        <div className="flex items-center justify-between">
          <Label className="text-base font-semibold">Course Includes *</Label>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={() => onAutoGenerate('courseIncludes')}>
              <Sparkles className="h-4 w-4 mr-2" />
              Generate
            </Button>
            <Button variant="outline" size="sm" onClick={() => addItem('courseIncludes')}>
              <Plus className="h-4 w-4" />
            </Button>
          </div>
        </div>
        <div className="space-y-3">
          {(data.courseIncludes || []).map((item: string, idx: number) => (
            <div key={idx} className="flex gap-2">
              <Input
                value={item}
                onChange={(e) => updateItem('courseIncludes', idx, e.target.value)}
                placeholder="What's included..."
              />
              <Button
                variant="ghost"
                size="icon"
                onClick={() => removeItem('courseIncludes', idx)}
              >
                <Trash2 className="h-4 w-4" />
              </Button>
            </div>
          ))}
          {(!data.courseIncludes || data.courseIncludes.length === 0) && (
            <p className="text-sm text-muted-foreground text-center py-4">
              No inclusions yet. Add some or use AI to generate.
            </p>
          )}
        </div>
      </Card>

      {/* Prerequisites */}
      <Card className="p-6 space-y-4">
        <div className="flex items-center justify-between">
          <Label className="text-base font-semibold">Prerequisites</Label>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={() => onAutoGenerate('prerequisites')}>
              <Sparkles className="h-4 w-4 mr-2" />
              Generate
            </Button>
            <Button variant="outline" size="sm" onClick={() => addItem('prerequisites')}>
              <Plus className="h-4 w-4" />
            </Button>
          </div>
        </div>
        <div className="space-y-3">
          {(data.prerequisites || []).map((item: string, idx: number) => (
            <div key={idx} className="flex gap-2">
              <Input
                value={item}
                onChange={(e) => updateItem('prerequisites', idx, e.target.value)}
                placeholder="Requirement..."
              />
              <Button
                variant="ghost"
                size="icon"
                onClick={() => removeItem('prerequisites', idx)}
              >
                <Trash2 className="h-4 w-4" />
              </Button>
            </div>
          ))}
          {(!data.prerequisites || data.prerequisites.length === 0) && (
            <p className="text-sm text-muted-foreground text-center py-4">
              No prerequisites. Add if needed.
            </p>
          )}
        </div>
      </Card>
    </div>
  );
}
