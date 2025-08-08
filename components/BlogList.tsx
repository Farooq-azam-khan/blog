import React from "react";
import {
  Card,
  CardFooter,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import Star39 from "@/components/stars/s39";
import { Button } from "@/components/ui/button";
export type BlogDate = {
  month: string;
  year: number;
  date: string;
};

export type BlogMetaData = {
  title: string;
  summary: string;
  post_link: string;
  published_date: BlogDate;
  tags?: string[]; // Optional tags for categorization
};

// Convert month name or abbreviation to month index (0 = January)
function getMonthIndex(month: string): number {
  switch (month) {
    case "January":
    case "Jan":
      return 0;
    case "February":
    case "Feb":
      return 1;
    case "March":
    case "Mar":
      return 2;
    case "April":
    case "Apr":
      return 3;
    case "May":
      return 4;
    case "June":
      return 5;
    case "July":
      return 6;
    case "August":
    case "Aug":
      return 7;
    case "September":
    case "Sept":
      return 8;
    case "October":
    case "Oct":
      return 9;
    case "November":
    case "Nov":
      return 10;
    case "December":
    case "Dec":
      return 11;
    default:
      return 0;
  }
}

// Create a Date object from published_date metadata
function getDateObj(published_date: BlogDate): Date {
  let day = published_date.date;
  day = day.replace(/st|nd|rd|th/, "");
  const dateNum = parseInt(day, 10);
  return new Date(
    published_date.year,
    getMonthIndex(published_date.month),
    dateNum
  );
}

// Format publication date for display
export function displayPublicationDate(pub_date: BlogDate): string {
  return `${pub_date.month} ${pub_date.date}, ${pub_date.year}`;
}

// Single blog post view
export const BlogPostView: React.FC<{ meta_data: BlogMetaData }> = ({
  meta_data,
}) => {
  const display_str = displayPublicationDate(meta_data.published_date);
  return (
    <Card className="flex flex-col">
      <CardHeader className="pb-0">
        <CardTitle className="text-2xl md:text-3xl">
          {meta_data.title}
        </CardTitle>
        <CardDescription>{display_str}</CardDescription>
      </CardHeader>
      <CardContent className="pt-0 flex-1">
        <p>{meta_data.summary}</p>
      </CardContent>
      <CardFooter className="flex flex-col items-start space-y-4 p-6 pt-0">
        {meta_data.tags && (
          <div className="flex flex-wrap gap-2">
            {meta_data.tags.map((tag) => (
              <span
                key={tag}
                className="border-2 border-border px-2 py-1 text-xs uppercase"
              >
                {tag}
              </span>
            ))}
          </div>
        )}
        <Button asChild className="w-full">
          <a href={meta_data.post_link}>Read Post →</a>
        </Button>
      </CardFooter>
    </Card>
  );
};

// List view of multiple blog posts, sorted by date descending
export const BlogPostListView: React.FC<{ blogs: BlogMetaData[] }> = ({
  blogs,
}) => {
  const sorted = [...blogs].sort((a, b) => {
    return (
      getDateObj(b.published_date).getTime() -
      getDateObj(a.published_date).getTime()
    );
  });
  return (
    <div className="mx-2 sm:mx-10 my-10 grid md:grid-cols-3 gap-5 md:gap-2">
      {sorted.map((blog, idx) => (
        <>
          <BlogPostView meta_data={blog} key={blog.title} />
          {/* <div className="col-span-1"></div> */}
          <div className="hidden md:block">
            <div className="text-main  flex items-center justify-center w-full h-full">
              <Star39 className="w-24 h-24" />
            </div>
          </div>
        </>
      ))}
    </div>
  );
};
