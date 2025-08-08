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
    const filePath = path.join(pagesDir, entry);
    const slug = entry.replace(/\.mdx$/, "");
    // Dynamically import the MDX module to access its meta export
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    const mod = await import(path.join(pagesDir, entry));
    if (mod.meta) {
      const meta = mod.meta as BlogMetaData;
      blogs.push({ ...meta });
    }
  }
  return blogs;
}
