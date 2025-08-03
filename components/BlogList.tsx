import React from 'react';

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
};

// Convert month name or abbreviation to month index (0 = January)
function getMonthIndex(month: string): number {
  switch (month) {
    case 'January':
    case 'Jan':
      return 0;
    case 'February':
    case 'Feb':
      return 1;
    case 'March':
    case 'Mar':
      return 2;
    case 'April':
    case 'Apr':
      return 3;
    case 'May':
      return 4;
    case 'June':
      return 5;
    case 'July':
      return 6;
    case 'August':
    case 'Aug':
      return 7;
    case 'September':
    case 'Sept':
      return 8;
    case 'October':
    case 'Oct':
      return 9;
    case 'November':
    case 'Nov':
      return 10;
    case 'December':
    case 'Dec':
      return 11;
    default:
      return 0;
  }
}

// Create a Date object from published_date metadata
function getDateObj(published_date: BlogDate): Date {
  let day = published_date.date;
  day = day.replace(/st|nd|rd|th/, '');
  const dateNum = parseInt(day, 10);
  return new Date(published_date.year, getMonthIndex(published_date.month), dateNum);
}

// Format publication date for display
export function displayPublicationDate(pub_date: BlogDate): string {
  return `${pub_date.month} ${pub_date.date}, ${pub_date.year}`;
}

// Single blog post view
export const BlogPostView: React.FC<{ meta_data: BlogMetaData }> = ({ meta_data }) => {
  const display_str = displayPublicationDate(meta_data.published_date);
  return (
    <div className="hover:bg-indigo-50 py-2 rounded-sm hover:rounded-lg ease-in duration-200 border-l-4 border-white hover:border-indigo-400 px-3 flex flex-col space-y-2">
      <span className="text-indigo-600">{display_str}</span>
      <span className="mt-3">
        <a href={meta_data.post_link}>{meta_data.title}</a>
      </span>
      <span className="text-gray-700">{meta_data.summary}</span>
    </div>
  );
};

// List view of multiple blog posts, sorted by date descending
export const BlogPostListView: React.FC<{ blogs: BlogMetaData[] }> = ({ blogs }) => {
  const sorted = [...blogs].sort((a, b) => {
    return getDateObj(b.published_date).getTime() - getDateObj(a.published_date).getTime();
  });
  return <>{sorted.map((blog) => <BlogPostView meta_data={blog} key={blog.title} />)}</>;
}
