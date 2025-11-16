import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";
import { Sparkles } from "lucide-react";
import { Card } from "@/components/ui/card";

interface BasicInfoStepProps {
  data: any;
  onUpdate: (field: string, value: any) => void;
  onAutoGenerate: (field: string) => void;
}

export function BasicInfoStep({ data, onUpdate, onAutoGenerate }: BasicInfoStepProps) {
  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Basic Information</h2>
        <p className="text-muted-foreground mt-1">Let's start with the essentials</p>
      </div>

      <Card className="p-6 space-y-6">
        <div className="grid gap-6 md:grid-cols-2">
          <div className="space-y-2 md:col-span-2">
            <Label htmlFor="title">Course Title *</Label>
            <Input
              id="title"
              value={data.basicInfo?.title || ''}
              onChange={(e) => onUpdate('title', e.target.value)}
              placeholder="e.g., Classical Hindustani Vocal"
              className="text-base"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="instructor">Instructor Name *</Label>
            <Input
              id="instructor"
              value={data.basicInfo?.instructor || ''}
              onChange={(e) => onUpdate('instructor', e.target.value)}
              placeholder="e.g., Pandit Ravi Kumar"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="duration">Duration</Label>
            <Input
              id="duration"
              value={data.basicInfo?.duration || ''}
              onChange={(e) => onUpdate('duration', e.target.value)}
              placeholder="e.g., 3 months"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="category">Category</Label>
            <Input
              id="category"
              value={data.basicInfo?.categories?.[0] || ''}
              onChange={(e) => onUpdate('categories', [e.target.value])}
              placeholder="e.g., music, wellness"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="language">Language</Label>
            <Input
              id="language"
              value={data.language || ''}
              onChange={(e) => onUpdate('language', e.target.value)}
              placeholder="e.g., English, Hindi"
            />
          </div>

          <div className="space-y-2 md:col-span-2">
            <Label htmlFor="thumbnail">Thumbnail URL</Label>
            <Input
              id="thumbnail"
              value={data.basicInfo?.thumbnailUrl || ''}
              onChange={(e) => onUpdate('thumbnailUrl', e.target.value)}
              placeholder="https://..."
              type="url"
            />
          </div>
        </div>

        <div className="space-y-2">
          <div className="flex items-center justify-between">
            <Label htmlFor="description">Course Description *</Label>
            <Button
              variant="outline"
              size="sm"
              onClick={() => onAutoGenerate('description')}
            >
              <Sparkles className="h-4 w-4 mr-2" />
              Auto-generate
            </Button>
          </div>
          <Textarea
            id="description"
            value={data.description || ''}
            onChange={(e) => onUpdate('description', e.target.value)}
            placeholder="Describe what your course is about..."
            rows={4}
            className="text-base"
          />
        </div>
      </Card>
    </div>
  );
}
