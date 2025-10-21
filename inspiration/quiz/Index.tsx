import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { BookOpen, Brain, Trophy, TrendingUp } from "lucide-react";

const Index = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-primary/5 to-accent/5">
      {/* Hero Section */}
      <div className="relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-primary opacity-10 blur-3xl"></div>
        <div className="relative max-w-6xl mx-auto px-4 py-16 sm:py-24">
          <div className="text-center space-y-6 animate-fade-in">
            <div className="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gradient-primary text-primary-foreground text-4xl mb-4 shadow-primary">
              🎓
            </div>
            <h1 className="text-4xl sm:text-6xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              QuizMaster
            </h1>
            <p className="text-lg sm:text-xl text-muted-foreground max-w-2xl mx-auto">
              Challenge yourself with thousands of quizzes across multiple categories. Learn, compete, and track your progress.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
              <Button
                size="lg"
                className="bg-gradient-primary text-primary-foreground hover:opacity-90 shadow-primary text-base px-8"
                onClick={() => navigate("/quizzes")}
              >
                <BookOpen className="w-5 h-5 mr-2" />
                Explore Quizzes
              </Button>
            </div>
          </div>
        </div>
      </div>

      {/* Features Section */}
      <div className="max-w-6xl mx-auto px-4 py-16">
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <div className="p-6 rounded-2xl bg-gradient-card shadow-md hover:shadow-lg transition-shadow animate-fade-in">
            <div className="w-12 h-12 rounded-xl bg-gradient-primary flex items-center justify-center mb-4">
              <Brain className="w-6 h-6 text-primary-foreground" />
            </div>
            <h3 className="text-xl font-semibold mb-2 text-foreground">Multiple Categories</h3>
            <p className="text-muted-foreground">
              From programming to history, find quizzes in subjects that interest you most.
            </p>
          </div>

          <div className="p-6 rounded-2xl bg-gradient-card shadow-md hover:shadow-lg transition-shadow animate-fade-in">
            <div className="w-12 h-12 rounded-xl bg-gradient-success flex items-center justify-center mb-4">
              <TrendingUp className="w-6 h-6 text-success-foreground" />
            </div>
            <h3 className="text-xl font-semibold mb-2 text-foreground">Track Progress</h3>
            <p className="text-muted-foreground">
              Monitor your learning journey with detailed statistics and achievement tracking.
            </p>
          </div>

          <div className="p-6 rounded-2xl bg-gradient-card shadow-md hover:shadow-lg transition-shadow animate-fade-in sm:col-span-2 lg:col-span-1">
            <div className="w-12 h-12 rounded-xl bg-gradient-accent flex items-center justify-center mb-4">
              <Trophy className="w-6 h-6 text-accent-foreground" />
            </div>
            <h3 className="text-xl font-semibold mb-2 text-foreground">Earn Achievements</h3>
            <p className="text-muted-foreground">
              Complete challenges and maintain your learning streak to unlock rewards.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Index;
