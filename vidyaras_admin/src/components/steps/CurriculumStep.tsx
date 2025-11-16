import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Plus, Trash2, Sparkles, GripVertical, Lock, Unlock, CheckCircle2 } from "lucide-react";
import { Switch } from "@/components/ui/switch";
import { Textarea } from "@/components/ui/textarea";
import { SectionInfo, LessonItem } from "@/types/course";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";

interface CurriculumStepProps {
  data: any;
  onUpdate: (field: string, value: any) => void;
  onAutoGenerate: (field: string) => void;
}

export function CurriculumStep({ data, onUpdate, onAutoGenerate }: CurriculumStepProps) {
  const curriculum = data.curriculum || [];

  const addSection = () => {
    const newSection: SectionInfo = {
      id: `s${curriculum.length + 1}`,
      title: '',
      lessons: [],
      totalDurationMinutes: 0
    };
    onUpdate('curriculum', [...curriculum, newSection]);
  };

  const updateSection = (index: number, section: SectionInfo) => {
    const updated = [...curriculum];
    // Calculate total duration from lessons
    const totalDuration = section.lessons.reduce((sum, lesson) => sum + (lesson.durationMinutes || 0), 0);
    updated[index] = { ...section, totalDurationMinutes: totalDuration };
    onUpdate('curriculum', updated);
  };

  const removeSection = (index: number) => {
    const updated = [...curriculum];
    updated.splice(index, 1);
    onUpdate('curriculum', updated);
  };

  const addLesson = (sectionIndex: number) => {
    const section = { ...curriculum[sectionIndex] };
    const newLesson: LessonItem = {
      id: `${section.id}_l${section.lessons.length + 1}`,
      title: '',
      durationMinutes: 15,
      isLocked: false,
      isCompleted: false,
      description: ''
    };
    section.lessons = [...section.lessons, newLesson];
    updateSection(sectionIndex, section);
  };

  const updateLesson = (sectionIndex: number, lessonIndex: number, lesson: LessonItem) => {
    const section = { ...curriculum[sectionIndex] };
    section.lessons = [...section.lessons];
    section.lessons[lessonIndex] = lesson;
    updateSection(sectionIndex, section);
  };

  const removeLesson = (sectionIndex: number, lessonIndex: number) => {
    const section = { ...curriculum[sectionIndex] };
    section.lessons = [...section.lessons];
    section.lessons.splice(lessonIndex, 1);
    updateSection(sectionIndex, section);
  };

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Curriculum</h2>
        <p className="text-muted-foreground mt-1">Organize your course into sections and lessons</p>
      </div>

      <div className="flex gap-2">
        <Button variant="outline" onClick={() => onAutoGenerate('curriculum')}>
          <Sparkles className="h-4 w-4 mr-2" />
          Generate Curriculum
        </Button>
        <Button variant="outline" onClick={addSection}>
          <Plus className="h-4 w-4 mr-2" />
          Add Section
        </Button>
      </div>

      {curriculum.length === 0 ? (
        <Card className="p-12">
          <div className="text-center">
            <p className="text-muted-foreground mb-4">No curriculum yet</p>
            <Button onClick={addSection}>
              <Plus className="h-4 w-4 mr-2" />
              Add Your First Section
            </Button>
          </div>
        </Card>
      ) : (
        <Accordion type="single" collapsible className="space-y-4">
          {curriculum.map((section: SectionInfo, sIdx: number) => (
            <AccordionItem key={sIdx} value={`section-${sIdx}`} className="border rounded-lg">
              <Card>
                <AccordionTrigger className="px-6 py-4 hover:no-underline">
                  <div className="flex items-center gap-3 flex-1 text-left">
                    <GripVertical className="h-5 w-5 text-muted-foreground" />
                    <div className="flex-1">
                      <Input
                        value={section.title}
                        onChange={(e) => {
                          e.stopPropagation();
                          updateSection(sIdx, { ...section, title: e.target.value });
                        }}
                        onClick={(e) => e.stopPropagation()}
                        placeholder="Section title..."
                        className="border-0 p-0 h-auto font-semibold text-base focus-visible:ring-0"
                      />
                    </div>
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={(e) => {
                        e.stopPropagation();
                        removeSection(sIdx);
                      }}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </AccordionTrigger>
                
                <AccordionContent className="px-6 pb-4">
                  <div className="space-y-4 mt-2">
                    {section.lessons.length === 0 ? (
                      <div className="text-center py-4 text-muted-foreground text-sm">
                        No lessons yet. Click "Add Lesson" to get started.
                      </div>
                    ) : (
                      section.lessons.map((lesson: LessonItem, lIdx: number) => (
                        <Card key={lIdx} className="p-4 pl-8">
                          <div className="space-y-3">
                            <div className="flex gap-2 items-start">
                              <div className="flex-1 space-y-2">
                                <Input
                                  value={lesson.title}
                                  onChange={(e) =>
                                    updateLesson(sIdx, lIdx, { ...lesson, title: e.target.value })
                                  }
                                  placeholder="Lesson title..."
                                  className="font-medium"
                                />
                                
                                <Textarea
                                  value={lesson.description || ''}
                                  onChange={(e) =>
                                    updateLesson(sIdx, lIdx, { ...lesson, description: e.target.value })
                                  }
                                  placeholder="Lesson description (optional)"
                                  rows={2}
                                  className="text-sm"
                                />
                              </div>
                              
                              <Button
                                variant="ghost"
                                size="icon"
                                onClick={() => removeLesson(sIdx, lIdx)}
                              >
                                <Trash2 className="h-4 w-4" />
                              </Button>
                            </div>

                            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                              <div className="space-y-1.5">
                                <Label className="text-xs">Duration (minutes)</Label>
                                <Input
                                  type="number"
                                  value={lesson.durationMinutes}
                                  onChange={(e) =>
                                    updateLesson(sIdx, lIdx, {
                                      ...lesson,
                                      durationMinutes: parseInt(e.target.value) || 0
                                    })
                                  }
                                  placeholder="15"
                                  className="h-9"
                                />
                              </div>

                              <div className="flex items-end">
                                <div className="flex items-center space-x-2 h-9">
                                  <Switch
                                    id={`locked-${sIdx}-${lIdx}`}
                                    checked={lesson.isLocked}
                                    onCheckedChange={(checked) =>
                                      updateLesson(sIdx, lIdx, { ...lesson, isLocked: checked })
                                    }
                                  />
                                  <Label htmlFor={`locked-${sIdx}-${lIdx}`} className="text-sm flex items-center gap-1.5">
                                    {lesson.isLocked ? <Lock className="h-3.5 w-3.5" /> : <Unlock className="h-3.5 w-3.5" />}
                                    Locked
                                  </Label>
                                </div>
                              </div>

                              <div className="flex items-end">
                                <div className="flex items-center space-x-2 h-9">
                                  <Switch
                                    id={`completed-${sIdx}-${lIdx}`}
                                    checked={lesson.isCompleted}
                                    onCheckedChange={(checked) =>
                                      updateLesson(sIdx, lIdx, { ...lesson, isCompleted: checked })
                                    }
                                  />
                                  <Label htmlFor={`completed-${sIdx}-${lIdx}`} className="text-sm flex items-center gap-1.5">
                                    <CheckCircle2 className="h-3.5 w-3.5" />
                                    Completed
                                  </Label>
                                </div>
                              </div>
                            </div>
                          </div>
                        </Card>
                      ))
                    )}
                    <div className="flex items-center justify-between mt-4">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => addLesson(sIdx)}
                        className="ml-8"
                      >
                        <Plus className="h-4 w-4 mr-2" />
                        Add Lesson
                      </Button>
                      <div className="text-sm text-muted-foreground mr-4">
                        Total: {section.totalDurationMinutes || 0} minutes ({section.lessons.length} lessons)
                      </div>
                    </div>
                  </div>
                </AccordionContent>
              </Card>
            </AccordionItem>
          ))}
        </Accordion>
      )}
    </div>
  );
}
