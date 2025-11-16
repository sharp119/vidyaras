import { Check } from "lucide-react";
import { cn } from "@/lib/utils";

interface Step {
  id: string;
  title: string;
  description: string;
}

interface StepWizardProps {
  steps: Step[];
  currentStep: number;
  onStepClick?: (index: number) => void;
}

export function StepWizard({ steps, currentStep, onStepClick }: StepWizardProps) {
  return (
    <div className="w-full">
      {/* Mobile: Compact Progress Bar */}
      <div className="md:hidden mb-6">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm font-medium">
            Step {currentStep + 1} of {steps.length}
          </span>
          <span className="text-sm text-muted-foreground">
            {Math.round(((currentStep + 1) / steps.length) * 100)}%
          </span>
        </div>
        <div className="h-2 bg-muted rounded-full overflow-hidden">
          <div
            className="h-full bg-primary transition-all duration-300"
            style={{ width: `${((currentStep + 1) / steps.length) * 100}%` }}
          />
        </div>
        <p className="text-sm font-medium mt-2">{steps[currentStep].title}</p>
      </div>

      {/* Desktop: Full Stepper */}
      <div className="hidden md:block">
        <nav aria-label="Progress">
          <ol className="flex items-center justify-between">
            {steps.map((step, index) => {
              const isCompleted = index < currentStep;
              const isCurrent = index === currentStep;
              
              return (
                <li key={step.id} className="relative flex-1">
                  {index !== 0 && (
                    <div
                      className={cn(
                        "absolute left-0 top-5 -ml-px h-0.5 w-full",
                        isCompleted ? "bg-primary" : "bg-border"
                      )}
                      style={{ transform: "translateX(-50%)" }}
                    />
                  )}
                  
                  <button
                    onClick={() => onStepClick?.(index)}
                    className={cn(
                      "relative flex flex-col items-center group",
                      onStepClick && "cursor-pointer hover:opacity-80"
                    )}
                  >
                    <span
                      className={cn(
                        "flex h-10 w-10 items-center justify-center rounded-full border-2 transition-all",
                        isCompleted && "bg-primary border-primary text-primary-foreground",
                        isCurrent && "border-primary text-primary",
                        !isCompleted && !isCurrent && "border-border text-muted-foreground"
                      )}
                    >
                      {isCompleted ? (
                        <Check className="h-5 w-5" />
                      ) : (
                        <span className="text-sm font-semibold">{index + 1}</span>
                      )}
                    </span>
                    
                    <div className="mt-2 text-center">
                      <span
                        className={cn(
                          "text-sm font-medium",
                          isCurrent && "text-primary",
                          !isCurrent && "text-muted-foreground"
                        )}
                      >
                        {step.title}
                      </span>
                      <p className="text-xs text-muted-foreground mt-1 hidden lg:block max-w-[120px]">
                        {step.description}
                      </p>
                    </div>
                  </button>
                </li>
              );
            })}
          </ol>
        </nav>
      </div>
    </div>
  );
}
