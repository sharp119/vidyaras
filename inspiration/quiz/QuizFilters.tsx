import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuTrigger,
  DropdownMenuLabel,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import { SlidersHorizontal } from "lucide-react";

export interface FilterOptions {
  category: string;
  difficulty: string;
  sort: string;
}

interface QuizFiltersProps {
  categories: string[];
  selectedCategory: string;
  onCategoryChange: (category: string) => void;
  filters: FilterOptions;
  onFiltersChange: (filters: FilterOptions) => void;
}

export const QuizFilters = ({
  categories,
  selectedCategory,
  onCategoryChange,
  filters,
  onFiltersChange,
}: QuizFiltersProps) => {
  return (
    <div className="space-y-3">
      {/* Category Chips */}
      <div className="flex gap-2 overflow-x-auto pb-2 hide-scrollbar">
        <Badge
          variant={selectedCategory === "all" ? "default" : "outline"}
          className="cursor-pointer whitespace-nowrap transition-all hover:scale-105 px-4 py-2"
          onClick={() => onCategoryChange("all")}
        >
          All
        </Badge>
        {categories.map((category) => (
          <Badge
            key={category}
            variant={selectedCategory === category ? "default" : "outline"}
            className="cursor-pointer whitespace-nowrap transition-all hover:scale-105 px-4 py-2"
            onClick={() => onCategoryChange(category)}
          >
            {category}
          </Badge>
        ))}
      </div>

      {/* Filter & Sort Dropdown */}
      <div className="flex gap-2">
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="outline" size="sm" className="flex-1">
              <SlidersHorizontal className="w-4 h-4 mr-2" />
              Filters
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="start" className="w-56 bg-popover">
            <DropdownMenuLabel>Difficulty</DropdownMenuLabel>
            <DropdownMenuRadioGroup
              value={filters.difficulty}
              onValueChange={(value) =>
                onFiltersChange({ ...filters, difficulty: value })
              }
            >
              <DropdownMenuRadioItem value="all">All Levels</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="easy">Easy</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="medium">Medium</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="hard">Hard</DropdownMenuRadioItem>
            </DropdownMenuRadioGroup>

            <DropdownMenuSeparator />

            <DropdownMenuLabel>Sort By</DropdownMenuLabel>
            <DropdownMenuRadioGroup
              value={filters.sort}
              onValueChange={(value) => onFiltersChange({ ...filters, sort: value })}
            >
              <DropdownMenuRadioItem value="popular">Most Popular</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="rating">Highest Rated</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="newest">Newest</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="shortest">Shortest First</DropdownMenuRadioItem>
            </DropdownMenuRadioGroup>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>

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
