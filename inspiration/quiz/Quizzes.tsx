import { useState, useMemo } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { QuizCard, Quiz } from "@/components/QuizCard";
import { QuizFilters, FilterOptions } from "@/components/QuizFilters";
import { QuizStats } from "@/components/QuizStats";
import { QuizHistory } from "@/components/QuizHistory";
import { Search, Loader2, Compass, History } from "lucide-react";
import { toast } from "sonner";

// Mock data - in a real app, this would come from an API
const mockQuizzes: Quiz[] = [
  {
    id: "1",
    title: "JavaScript Fundamentals",
    description: "Master the basics of JavaScript including variables, functions, and control flow.",
    category: "Programming",
    difficulty: "easy",
    duration: 15,
    questions: 20,
    rating: 4.8,
    completions: 1240,
    progress: 65,
    icon: "💻",
  },
  {
    id: "2",
    title: "React Hooks Deep Dive",
    description: "Learn advanced React hooks patterns and custom hook creation.",
    category: "Programming",
    difficulty: "hard",
    duration: 30,
    questions: 25,
    rating: 4.9,
    completions: 856,
    progress: 20,
    icon: "⚛️",
  },
  {
    id: "3",
    title: "World Geography",
    description: "Test your knowledge of countries, capitals, and famous landmarks.",
    category: "Geography",
    difficulty: "medium",
    duration: 20,
    questions: 30,
    rating: 4.5,
    completions: 2100,
    icon: "🌍",
  },
  {
    id: "4",
    title: "Ancient History",
    description: "Explore the civilizations of ancient Egypt, Rome, and Greece.",
    category: "History",
    difficulty: "medium",
    duration: 25,
    questions: 28,
    rating: 4.7,
    completions: 980,
    icon: "🏛️",
  },
  {
    id: "5",
    title: "Physics 101",
    description: "Fundamental concepts in classical mechanics and thermodynamics.",
    category: "Science",
    difficulty: "hard",
    duration: 35,
    questions: 32,
    rating: 4.6,
    completions: 654,
    icon: "🔬",
  },
  {
    id: "6",
    title: "Spanish Basics",
    description: "Learn essential Spanish vocabulary and common phrases.",
    category: "Language",
    difficulty: "easy",
    duration: 12,
    questions: 18,
    rating: 4.8,
    completions: 1560,
    icon: "🇪🇸",
  },
  {
    id: "7",
    title: "CSS Flexbox & Grid",
    description: "Master modern CSS layout techniques with practical examples.",
    category: "Programming",
    difficulty: "medium",
    duration: 22,
    questions: 24,
    rating: 4.9,
    completions: 1120,
    progress: 45,
    icon: "🎨",
  },
  {
    id: "8",
    title: "Renaissance Art",
    description: "Discover the masterpieces and artists of the Renaissance period.",
    category: "Arts",
    difficulty: "medium",
    duration: 18,
    questions: 22,
    rating: 4.7,
    completions: 745,
    icon: "🎭",
  },
  {
    id: "9",
    title: "Basic Algebra",
    description: "Build a strong foundation in algebraic equations and expressions.",
    category: "Mathematics",
    difficulty: "easy",
    duration: 20,
    questions: 26,
    rating: 4.6,
    completions: 1890,
    icon: "➗",
  },
  {
    id: "10",
    title: "World Literature",
    description: "Explore classic works from Shakespeare to modern authors.",
    category: "Literature",
    difficulty: "medium",
    duration: 28,
    questions: 30,
    rating: 4.8,
    completions: 892,
    icon: "📚",
  },
];

const categories = [
  "Programming",
  "Science",
  "History",
  "Geography",
  "Mathematics",
  "Language",
  "Arts",
  "Literature",
];

const Quizzes = () => {
  const [activeTab, setActiveTab] = useState("explore");
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("all");
  const [filters, setFilters] = useState<FilterOptions>({
    category: "all",
    difficulty: "all",
    sort: "popular",
  });
  const [visibleQuizzes, setVisibleQuizzes] = useState(6);
  const [isLoadingMore, setIsLoadingMore] = useState(false);

  // Filter and sort quizzes
  const filteredQuizzes = useMemo(() => {
    let result = [...mockQuizzes];

    // Search filter
    if (searchQuery) {
      result = result.filter(
        (quiz) =>
          quiz.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
          quiz.description.toLowerCase().includes(searchQuery.toLowerCase())
      );
    }

    // Category filter
    if (selectedCategory !== "all") {
      result = result.filter((quiz) => quiz.category === selectedCategory);
    }

    // Difficulty filter
    if (filters.difficulty !== "all") {
      result = result.filter((quiz) => quiz.difficulty === filters.difficulty);
    }

    // Sort
    switch (filters.sort) {
      case "popular":
        result.sort((a, b) => b.completions - a.completions);
        break;
      case "rating":
        result.sort((a, b) => b.rating - a.rating);
        break;
      case "newest":
        // In a real app, would sort by creation date
        break;
      case "shortest":
        result.sort((a, b) => a.duration - b.duration);
        break;
    }

    return result;
  }, [searchQuery, selectedCategory, filters]);

  const displayedQuizzes = filteredQuizzes.slice(0, visibleQuizzes);
  const hasMore = visibleQuizzes < filteredQuizzes.length;

  const handleLoadMore = () => {
    setIsLoadingMore(true);
    setTimeout(() => {
      setVisibleQuizzes((prev) => prev + 6);
      setIsLoadingMore(false);
    }, 500);
  };

  const handleQuizClick = (quiz: Quiz) => {
    toast.success(`Opening "${quiz.title}"`, {
      description: "Quiz will start in a moment...",
    });
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="bg-gradient-primary text-primary-foreground py-8 px-4">
        <div className="max-w-6xl mx-auto">
          <h1 className="text-3xl sm:text-4xl font-bold mb-2">Explore Quizzes</h1>
          <p className="text-primary-foreground/90 text-sm sm:text-base">
            Test your knowledge and track your progress
          </p>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 py-6 space-y-6">
        {/* Stats */}
        <QuizStats completed={12} inProgress={3} avgScore={85} streak={7} />

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="grid w-full grid-cols-2 max-w-md mx-auto mb-6">
            <TabsTrigger value="explore" className="flex items-center gap-2">
              <Compass className="w-4 h-4" />
              <span>Explore</span>
            </TabsTrigger>
            <TabsTrigger value="history" className="flex items-center gap-2">
              <History className="w-4 h-4" />
              <span>History</span>
            </TabsTrigger>
          </TabsList>

          <TabsContent value="explore" className="space-y-6">
            {/* Search */}
            <div className="relative">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                placeholder="Search quizzes..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-10"
              />
            </div>

            {/* Filters */}
            <QuizFilters
              categories={categories}
              selectedCategory={selectedCategory}
              onCategoryChange={setSelectedCategory}
              filters={filters}
              onFiltersChange={setFilters}
            />

            {/* Results count */}
            <div className="flex items-center justify-between">
              <p className="text-sm text-muted-foreground">
                {filteredQuizzes.length} {filteredQuizzes.length === 1 ? "quiz" : "quizzes"} found
              </p>
            </div>

            {/* Quiz Grid */}
            {displayedQuizzes.length > 0 ? (
              <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {displayedQuizzes.map((quiz) => (
                  <QuizCard key={quiz.id} quiz={quiz} onClick={() => handleQuizClick(quiz)} />
                ))}
              </div>
            ) : (
              <div className="text-center py-16">
                <div className="text-6xl mb-4">🔍</div>
                <h3 className="text-xl font-semibold mb-2 text-foreground">No quizzes found</h3>
                <p className="text-muted-foreground">
                  Try adjusting your filters or search query
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
                    `Load More (${filteredQuizzes.length - visibleQuizzes} remaining)`
                  )}
                </Button>
              </div>
            )}
          </TabsContent>

          <TabsContent value="history">
            <QuizHistory />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
};

export default Quizzes;
