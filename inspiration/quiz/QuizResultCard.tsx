import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Clock, Calendar, TrendingUp, Award, RotateCcw } from "lucide-react";

export interface QuizResult {
  id: string;
  quizId: string;
  title: string;
  category: string;
  icon: string;
  score: number;
  correctAnswers: number;
  totalQuestions: number;
  timeSpent: number;
  completedAt: string;
  difficulty: "easy" | "medium" | "hard";
  passed: boolean;
}

interface QuizResultCardProps {
  result: QuizResult;
  onRetake?: () => void;
  onViewDetails?: () => void;
}

const difficultyColors = {
  easy: "bg-success text-success-foreground",
  medium: "bg-accent text-accent-foreground",
  hard: "bg-destructive text-destructive-foreground",
};

const getScoreColor = (score: number) => {
  if (score >= 90) return "text-success";
  if (score >= 70) return "text-accent";
  return "text-destructive";
};

const getPerformanceBadge = (score: number) => {
  if (score >= 90) return { label: "Excellent", color: "bg-success text-success-foreground" };
  if (score >= 80) return { label: "Great", color: "bg-primary text-primary-foreground" };
  if (score >= 70) return { label: "Good", color: "bg-accent text-accent-foreground" };
  if (score >= 60) return { label: "Pass", color: "bg-secondary text-secondary-foreground" };
  return { label: "Needs Work", color: "bg-destructive text-destructive-foreground" };
};

export const QuizResultCard = ({ result, onRetake, onViewDetails }: QuizResultCardProps) => {
  const performance = getPerformanceBadge(result.score);
  const formattedDate = new Date(result.completedAt).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });
  const formattedTime = new Date(result.completedAt).toLocaleTimeString("en-US", {
    hour: "2-digit",
    minute: "2-digit",
  });

  return (
    <Card className="group overflow-hidden transition-all duration-300 hover:shadow-lg bg-gradient-card animate-fade-in">
      <div className="p-5 space-y-4">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-3 flex-1">
            <div className="w-12 h-12 rounded-xl bg-gradient-primary flex items-center justify-center text-2xl shadow-primary">
              {result.icon}
            </div>
            <div className="flex-1 min-w-0">
              <h3 className="font-semibold text-base text-foreground line-clamp-1">
                {result.title}
              </h3>
              <div className="flex items-center gap-2 mt-1 flex-wrap">
                <Badge variant="secondary" className="text-xs">
                  {result.category}
                </Badge>
                <Badge className={`${difficultyColors[result.difficulty]} text-xs capitalize`}>
                  {result.difficulty}
                </Badge>
              </div>
            </div>
          </div>
          <Badge className={`${performance.color} text-xs font-semibold`}>
            {performance.label}
          </Badge>
        </div>

        {/* Score Display */}
        <div className="relative">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-muted-foreground">Score</span>
            <span className={`text-2xl font-bold ${getScoreColor(result.score)}`}>
              {result.score}%
            </span>
          </div>
          <Progress value={result.score} className="h-3" />
          <div className="flex items-center justify-between mt-1 text-xs text-muted-foreground">
            <span>
              {result.correctAnswers}/{result.totalQuestions} correct
            </span>
            {result.passed ? (
              <div className="flex items-center gap-1 text-success">
                <Award className="w-3.5 h-3.5" />
                <span className="font-medium">Passed</span>
              </div>
            ) : (
              <span className="text-destructive font-medium">Failed</span>
            )}
          </div>
        </div>

        {/* Stats */}
        <div className="flex items-center gap-4 pt-3 border-t border-border text-xs text-muted-foreground">
          <div className="flex items-center gap-1.5">
            <Calendar className="w-3.5 h-3.5" />
            <span>{formattedDate}</span>
          </div>
          <div className="flex items-center gap-1.5">
            <Clock className="w-3.5 h-3.5" />
            <span>{result.timeSpent} min</span>
          </div>
          <div className="flex items-center gap-1.5 ml-auto">
            <span className="text-muted-foreground">{formattedTime}</span>
          </div>
        </div>

        {/* Actions */}
        <div className="flex gap-2 pt-2">
          <Button
            variant="outline"
            size="sm"
            className="flex-1"
            onClick={onViewDetails}
          >
            <TrendingUp className="w-4 h-4 mr-2" />
            View Details
          </Button>
          <Button
            variant="default"
            size="sm"
            className="flex-1"
            onClick={onRetake}
          >
            <RotateCcw className="w-4 h-4 mr-2" />
            Retake
          </Button>
        </div>
      </div>
    </Card>
  );
};
