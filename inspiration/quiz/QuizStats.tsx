import { Card } from "@/components/ui/card";
import { Trophy, Target, TrendingUp, Zap } from "lucide-react";

interface QuizStatsProps {
  completed: number;
  inProgress: number;
  avgScore: number;
  streak: number;
}

export const QuizStats = ({ completed, inProgress, avgScore, streak }: QuizStatsProps) => {
  return (
    <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6">
      <Card className="p-4 bg-gradient-card">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-gradient-success flex items-center justify-center">
            <Trophy className="w-5 h-5 text-success-foreground" />
          </div>
          <div>
            <p className="text-2xl font-bold text-foreground">{completed}</p>
            <p className="text-xs text-muted-foreground">Completed</p>
          </div>
        </div>
      </Card>

      <Card className="p-4 bg-gradient-card">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-gradient-primary flex items-center justify-center">
            <Target className="w-5 h-5 text-primary-foreground" />
          </div>
          <div>
            <p className="text-2xl font-bold text-foreground">{inProgress}</p>
            <p className="text-xs text-muted-foreground">In Progress</p>
          </div>
        </div>
      </Card>

      <Card className="p-4 bg-gradient-card">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-gradient-accent flex items-center justify-center">
            <TrendingUp className="w-5 h-5 text-accent-foreground" />
          </div>
          <div>
            <p className="text-2xl font-bold text-foreground">{avgScore}%</p>
            <p className="text-xs text-muted-foreground">Avg Score</p>
          </div>
        </div>
      </Card>

      <Card className="p-4 bg-gradient-card">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-gradient-accent flex items-center justify-center animate-pulse-glow">
            <Zap className="w-5 h-5 text-accent-foreground" />
          </div>
          <div>
            <p className="text-2xl font-bold text-foreground">{streak}</p>
            <p className="text-xs text-muted-foreground">Day Streak</p>
          </div>
        </div>
      </Card>
    </div>
  );
};
