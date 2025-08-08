import fs from "fs";
import path from "path";
import type { BlogMetaData } from "@/components/BlogList";

/**
 * Reads all MDX blog files in the pages directory
 * and returns their exported metadata.
 */
export async function getAllBlogs(): Promise<BlogMetaData[]> {
  const pagesDir = path.join(process.cwd(), "pages");
  const entries = fs.readdirSync(pagesDir);
  const blogs: BlogMetaData[] = [];
  for (const entry of entries) {
    // Only MDX files (skip _app.tsx, index.tsx, etc.)
    if (!entry.endsWith(".mdx")) continue;
    // Dynamically import the MDX page to read its exported meta
    // This import path is relative to this file, allowing webpack to include all MDX modules
    const mod = await import(
      /* webpackChunkName: "blog-[request]" */
      `../pages/${entry}`
    );
    if (mod.meta) {
      const meta = mod.meta as BlogMetaData;
      blogs.push({ ...meta });
    }
  }
  console.log({blogs})
  const filteredBlogs = blogs.filter((blog) => blog.title && blog.title.length > 0);
  // Sort by date descending
  return filteredBlogs;
}
