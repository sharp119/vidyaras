import { useState, useMemo } from "react";
import { QuizResultCard, QuizResult } from "./QuizResultCard";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Calendar, TrendingUp, Award, Loader2 } from "lucide-react";
import { toast } from "sonner";

// Mock data - in real app, fetch from API
const mockResults: QuizResult[] = [
  {
    id: "r1",
    quizId: "1",
    title: "JavaScript Fundamentals",
    category: "Programming",
    icon: "💻",
    score: 92,
    correctAnswers: 18,
    totalQuestions: 20,
    timeSpent: 14,
    completedAt: "2025-01-20T14:30:00",
    difficulty: "easy",
    passed: true,
  },
  {
    id: "r2",
    quizId: "7",
    title: "CSS Flexbox & Grid",
    category: "Programming",
    icon: "🎨",
    score: 85,
    correctAnswers: 20,
    totalQuestions: 24,
    timeSpent: 19,
    completedAt: "2025-01-19T10:15:00",
    difficulty: "medium",
    passed: true,
  },
  {
    id: "r3",
    quizId: "3",
    title: "World Geography",
    category: "Geography",
    icon: "🌍",
    score: 76,
    correctAnswers: 23,
    totalQuestions: 30,
    timeSpent: 18,
    completedAt: "2025-01-18T16:45:00",
    difficulty: "medium",
    passed: true,
  },
  {
    id: "r4",
    quizId: "2",
    title: "React Hooks Deep Dive",
    category: "Programming",
    icon: "⚛️",
    score: 68,
    correctAnswers: 17,
    totalQuestions: 25,
    timeSpent: 28,
    completedAt: "2025-01-17T11:20:00",
    difficulty: "hard",
    passed: true,
  },
  {
    id: "r5",
    quizId: "9",
    title: "Basic Algebra",
    category: "Mathematics",
    icon: "➗",
    score: 94,
    correctAnswers: 24,
    totalQuestions: 26,
    timeSpent: 17,
    completedAt: "2025-01-16T09:30:00",
    difficulty: "easy",
    passed: true,
  },
  {
    id: "r6",
    quizId: "5",
    title: "Physics 101",
    category: "Science",
    icon: "🔬",
    score: 58,
    correctAnswers: 18,
    totalQuestions: 32,
    timeSpent: 32,
    completedAt: "2025-01-15T13:10:00",
    difficulty: "hard",
    passed: false,
  },
  {
    id: "r7",
    quizId: "6",
    title: "Spanish Basics",
    category: "Language",
    icon: "🇪🇸",
    score: 88,
    correctAnswers: 16,
    totalQuestions: 18,
    timeSpent: 11,
    completedAt: "2025-01-14T15:50:00",
    difficulty: "easy",
    passed: true,
  },
  {
    id: "r8",
    quizId: "4",
    title: "Ancient History",
    category: "History",
    icon: "🏛️",
    score: 82,
    correctAnswers: 23,
    totalQuestions: 28,
    timeSpent: 23,
    completedAt: "2025-01-13T12:40:00",
    difficulty: "medium",
    passed: true,
  },
];

export const QuizHistory = () => {
  const [timeFilter, setTimeFilter] = useState("all");
  const [categoryFilter, setCategoryFilter] = useState("all");
  const [visibleResults, setVisibleResults] = useState(6);
  const [isLoadingMore, setIsLoadingMore] = useState(false);

  const categories = useMemo(() => {
    const cats = new Set(mockResults.map((r) => r.category));
    return Array.from(cats);
  }, []);

  const filteredResults = useMemo(() => {
    let results = [...mockResults];

    // Time filter
    if (timeFilter !== "all") {
      const now = new Date();
      const filterDate = new Date();
      
      switch (timeFilter) {
        case "week":
          filterDate.setDate(now.getDate() - 7);
          break;
        case "month":
          filterDate.setMonth(now.getMonth() - 1);
          break;
        case "3months":
          filterDate.setMonth(now.getMonth() - 3);
          break;
      }
      
      results = results.filter(
        (r) => new Date(r.completedAt) >= filterDate
      );
    }

    // Category filter
    if (categoryFilter !== "all") {
      results = results.filter((r) => r.category === categoryFilter);
    }

    return results;
  }, [timeFilter, categoryFilter]);

  const displayedResults = filteredResults.slice(0, visibleResults);
  const hasMore = visibleResults < filteredResults.length;

  const stats = useMemo(() => {
    const total = filteredResults.length;
    const passed = filteredResults.filter((r) => r.passed).length;
    const avgScore =
      filteredResults.reduce((acc, r) => acc + r.score, 0) / (total || 1);
    const totalTime = filteredResults.reduce((acc, r) => acc + r.timeSpent, 0);

    return {
      total,
      passed,
      avgScore: Math.round(avgScore),
      totalTime,
    };
  }, [filteredResults]);

  const handleLoadMore = () => {
    setIsLoadingMore(true);
    setTimeout(() => {
      setVisibleResults((prev) => prev + 6);
      setIsLoadingMore(false);
    }, 500);
  };

  const handleRetake = (result: QuizResult) => {
    toast.success(`Retaking "${result.title}"`, {
      description: "Quiz will start in a moment...",
    });
  };

  const handleViewDetails = (result: QuizResult) => {
    toast.info(`Viewing details for "${result.title}"`, {
      description: `Score: ${result.score}% • ${result.correctAnswers}/${result.totalQuestions} correct`,
    });
  };

  return (
    <div className="space-y-6">
      {/* Stats Overview */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <div className="p-4 rounded-xl bg-gradient-card border border-border">
          <div className="flex items-center gap-2 mb-1">
            <Calendar className="w-4 h-4 text-primary" />
            <span className="text-xs text-muted-foreground">Total Quizzes</span>
          </div>
          <p className="text-2xl font-bold text-foreground">{stats.total}</p>
        </div>

        <div className="p-4 rounded-xl bg-gradient-card border border-border">
          <div className="flex items-center gap-2 mb-1">
            <Award className="w-4 h-4 text-success" />
            <span className="text-xs text-muted-foreground">Passed</span>
          </div>
          <p className="text-2xl font-bold text-foreground">{stats.passed}</p>
        </div>

        <div className="p-4 rounded-xl bg-gradient-card border border-border">
          <div className="flex items-center gap-2 mb-1">
            <TrendingUp className="w-4 h-4 text-accent" />
            <span className="text-xs text-muted-foreground">Avg Score</span>
          </div>
          <p className="text-2xl font-bold text-foreground">{stats.avgScore}%</p>
        </div>

        <div className="p-4 rounded-xl bg-gradient-card border border-border">
          <div className="flex items-center gap-2 mb-1">
            <Calendar className="w-4 h-4 text-muted-foreground" />
            <span className="text-xs text-muted-foreground">Time Spent</span>
          </div>
          <p className="text-2xl font-bold text-foreground">{stats.totalTime}m</p>
        </div>
      </div>

      {/* Filters */}
      <div className="flex flex-col sm:flex-row gap-3">
        <Select value={timeFilter} onValueChange={setTimeFilter}>
          <SelectTrigger className="w-full sm:w-[180px]">
            <SelectValue placeholder="Time Period" />
          </SelectTrigger>
          <SelectContent className="bg-popover">
            <SelectItem value="all">All Time</SelectItem>
            <SelectItem value="week">Last 7 Days</SelectItem>
            <SelectItem value="month">Last Month</SelectItem>
            <SelectItem value="3months">Last 3 Months</SelectItem>
          </SelectContent>
        </Select>

        <div className="flex gap-2 overflow-x-auto pb-2 hide-scrollbar">
          <Badge
            variant={categoryFilter === "all" ? "default" : "outline"}
            className="cursor-pointer whitespace-nowrap transition-all hover:scale-105 px-4 py-2"
            onClick={() => setCategoryFilter("all")}
          >
            All Categories
          </Badge>
          {categories.map((category) => (
            <Badge
              key={category}
              variant={categoryFilter === category ? "default" : "outline"}
              className="cursor-pointer whitespace-nowrap transition-all hover:scale-105 px-4 py-2"
              onClick={() => setCategoryFilter(category)}
            >
              {category}
            </Badge>
          ))}
        </div>
      </div>

      {/* Results Count */}
      <div className="flex items-center justify-between">
        <p className="text-sm text-muted-foreground">
          {filteredResults.length} {filteredResults.length === 1 ? "result" : "results"} found
        </p>
      </div>

      {/* Results Grid */}
      {displayedResults.length > 0 ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {displayedResults.map((result) => (
            <QuizResultCard
              key={result.id}
              result={result}
              onRetake={() => handleRetake(result)}
              onViewDetails={() => handleViewDetails(result)}
            />
          ))}
        </div>
      ) : (
        <div className="text-center py-16">
          <div className="text-6xl mb-4">📊</div>
          <h3 className="text-xl font-semibold mb-2 text-foreground">No quiz history yet</h3>
          <p className="text-muted-foreground">
            Complete some quizzes to see your results here
          </p>
        </div>
      )}

      {/* Load More */}
      {hasMore && (
        <div className="flex justify-center pt-4">
          <Button
            onClick={handleLoadMore}
            disabled={isLoadingMore}
            size="lg"
            variant="outline"
            className="min-w-[200px]"
          >
            {isLoadingMore ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Loading...
              </>
            ) : (
              `Load More (${filteredResults.length - visibleResults} remaining)`
            )}
          </Button>
        </div>
      )}

      <style>{`
        .hide-scrollbar::-webkit-scrollbar {
          display: none;
        }
        .hide-scrollbar {
          -ms-overflow-style: none;
          scrollbar-width: none;
        }
      `}</style>
    </div>
  );
};
