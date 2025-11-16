import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card } from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";

interface PricingStepProps {
  data: any;
  onUpdate: (field: string, value: any) => void;
}

export function PricingStep({ data, onUpdate }: PricingStepProps) {
  const pricing = data.pricing || { fullPrice: 0, isFree: false };
  const courseType = data.basicInfo?.isFree ? 'free' : data.basicInfo?.isLive ? 'live' : 'recorded';
  const liveBatch = data.liveBatch || {
    id: '',
    name: '',
    startDate: '',
    schedule: '',
    time: '',
    capacity: 50,
    enrolled: 0
  };

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Pricing & Details</h2>
        <p className="text-muted-foreground mt-1">Set your course price and additional details</p>
      </div>

      <Tabs value={courseType} onValueChange={(v) => {
        onUpdate('isLive', v === 'live');
        onUpdate('isFree', v === 'free');
        onUpdate('isRecorded', v === 'recorded' || v === 'free');
        if (v === 'free') {
          onUpdate('pricing', { ...pricing, isFree: true, fullPrice: 0 });
        }
      }}>
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="live">Live Course</TabsTrigger>
          <TabsTrigger value="recorded">Recorded</TabsTrigger>
          <TabsTrigger value="free">Free</TabsTrigger>
        </TabsList>

        <TabsContent value={courseType} className="space-y-6 mt-6">
          {courseType !== 'free' && (
            <Card className="p-6 space-y-6">
              <div className="space-y-4">
                <Label className="text-base font-semibold">Pricing</Label>
                
                <div className="grid gap-4 sm:grid-cols-2">
                  <div className="space-y-2">
                    <Label htmlFor="fullPrice">Full Price (₹) *</Label>
                    <Input
                      id="fullPrice"
                      type="number"
                      value={pricing.fullPrice || ''}
                      onChange={(e) => onUpdate('pricing', {
                        ...pricing,
                        fullPrice: parseInt(e.target.value) || 0
                      })}
                      placeholder="4999"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="priceDisplay">Display Price</Label>
                    <Input
                      id="priceDisplay"
                      value={data.basicInfo?.price || ''}
                      onChange={(e) => onUpdate('price', e.target.value)}
                      placeholder="₹4,999"
                    />
                  </div>
                </div>

                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <Label>Offer EMI</Label>
                    <p className="text-sm text-muted-foreground">
                      Allow students to pay in installments
                    </p>
                  </div>
                  <Switch
                    checked={!!pricing.emiMonthlyPrice}
                    onCheckedChange={(checked) => {
                      if (checked) {
                        onUpdate('pricing', {
                          ...pricing,
                          emiMonthlyPrice: Math.ceil((pricing.fullPrice || 0) / 3),
                          emiTenure: 3
                        });
                      } else {
                        onUpdate('pricing', {
                          ...pricing,
                          emiMonthlyPrice: undefined,
                          emiTenure: undefined
                        });
                      }
                    }}
                  />
                </div>

                {pricing.emiMonthlyPrice && (
                  <div className="grid gap-4 sm:grid-cols-2 pl-4 border-l-2 border-primary/20">
                    <div className="space-y-2">
                      <Label htmlFor="emiPrice">Monthly EMI (₹)</Label>
                      <Input
                        id="emiPrice"
                        type="number"
                        value={pricing.emiMonthlyPrice || ''}
                        onChange={(e) => onUpdate('pricing', {
                          ...pricing,
                          emiMonthlyPrice: parseInt(e.target.value) || 0
                        })}
                      />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="emiTenure">Tenure (months)</Label>
                      <Input
                        id="emiTenure"
                        type="number"
                        value={pricing.emiTenure || ''}
                        onChange={(e) => onUpdate('pricing', {
                          ...pricing,
                          emiTenure: parseInt(e.target.value) || 0
                        })}
                      />
                    </div>
                  </div>
                )}
              </div>
            </Card>
          )}

          <Card className="p-6 space-y-4">
            <Label className="text-base font-semibold">Course Features</Label>
            
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <Label htmlFor="certificate">Include Certificate</Label>
                <Switch
                  id="certificate"
                  checked={data.hasCertificate || false}
                  onCheckedChange={(checked) => onUpdate('hasCertificate', checked)}
                />
              </div>

              <div className="flex items-center justify-between">
                <Label htmlFor="quizzes">Include Quizzes</Label>
                <Switch
                  id="quizzes"
                  checked={data.hasQuizzes || false}
                  onCheckedChange={(checked) => onUpdate('hasQuizzes', checked)}
                />
              </div>

              <div className="flex items-center justify-between">
                <Label htmlFor="materials">Downloadable Materials</Label>
                <Switch
                  id="materials"
                  checked={data.hasMaterials || false}
                  onCheckedChange={(checked) => onUpdate('hasMaterials', checked)}
                />
              </div>
            </div>
          </Card>

          {courseType === 'recorded' && (
            <Card className="p-6 space-y-4">
              <Label className="text-base font-semibold">Access Duration</Label>
              <div className="space-y-2">
                <Label htmlFor="accessDays">Days of Access</Label>
                <Input
                  id="accessDays"
                  type="number"
                  value={data.accessDays || ''}
                  onChange={(e) => onUpdate('accessDays', parseInt(e.target.value) || 0)}
                  placeholder="90"
                />
                <p className="text-sm text-muted-foreground">
                  How many days students can access the course
                </p>
              </div>
            </Card>
          )}

          {courseType === 'live' && (
            <Card className="p-6 space-y-4">
              <Label className="text-base font-semibold">Live Batch Details *</Label>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-2 sm:col-span-2">
                  <Label htmlFor="batchId">Batch ID</Label>
                  <Input
                    id="batchId"
                    value={liveBatch.id}
                    onChange={(e) => onUpdate('liveBatch', { ...liveBatch, id: e.target.value })}
                    placeholder="b1_music_jan25"
                  />
                </div>

                <div className="space-y-2 sm:col-span-2">
                  <Label htmlFor="batchName">Batch Name *</Label>
                  <Input
                    id="batchName"
                    value={liveBatch.name}
                    onChange={(e) => onUpdate('liveBatch', { ...liveBatch, name: e.target.value })}
                    placeholder="e.g., January 2025 Batch"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="startDate">Start Date *</Label>
                  <Input
                    id="startDate"
                    type="date"
                    value={liveBatch.startDate ? new Date(liveBatch.startDate).toISOString().split('T')[0] : ''}
                    onChange={(e) => {
                      const date = e.target.value ? new Date(e.target.value).toISOString() : '';
                      onUpdate('liveBatch', { ...liveBatch, startDate: date });
                    }}
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="time">Time *</Label>
                  <Input
                    id="time"
                    value={liveBatch.time}
                    onChange={(e) => onUpdate('liveBatch', { ...liveBatch, time: e.target.value })}
                    placeholder="5:00 PM IST"
                  />
                </div>

                <div className="space-y-2 sm:col-span-2">
                  <Label htmlFor="schedule">Schedule *</Label>
                  <Input
                    id="schedule"
                    value={liveBatch.schedule}
                    onChange={(e) => onUpdate('liveBatch', { ...liveBatch, schedule: e.target.value })}
                    placeholder="Mon, Wed, Fri"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="capacity">Batch Capacity</Label>
                  <Input
                    id="capacity"
                    type="number"
                    value={liveBatch.capacity}
                    onChange={(e) => onUpdate('liveBatch', { ...liveBatch, capacity: parseInt(e.target.value) || 0 })}
                    placeholder="50"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="enrolled">Currently Enrolled</Label>
                  <Input
                    id="enrolled"
                    type="number"
                    value={liveBatch.enrolled}
                    onChange={(e) => onUpdate('liveBatch', { ...liveBatch, enrolled: parseInt(e.target.value) || 0 })}
                    placeholder="0"
                  />
                </div>
              </div>
            </Card>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}
