import createMDX from '@next/mdx'
import rehypeStarryNight from 'rehype-starry-night'
import remarkMath from 'remark-math'
import rehypeMathjax from 'rehype-katex'
import rehypeKatex from 'rehype-katex'

/** @type {import('next').NextConfig} */
const nextConfig = {

    // Append the default value with md extensions
    pageExtensions: ['ts', 'tsx', 'js', 'jsx', 'md', 'mdx'],
    reactStrictMode: true,
    // swcMinify: true,
    images: {
        formats: ["image/avif", "image/webp"],
        remotePatterns: [{
            protocol: 'https',
            hostname: 'avatars.githubusercontent.com',
            port: '',
            pathname: '/u/**',
        }]
    }
}

// next.config.js

const withMDX = createMDX({
  extension: /\.mdx?$/,
  options: {
    remarkPlugins: [remarkMath],
    rehypePlugins: [
      // Configure KaTeX to ignore strict warnings (e.g., standalone \\\\)
      [rehypeKatex, { strict: 'ignore' }],
      // rehypeMathjax,
      rehypeStarryNight,
    ],
    // mdxRs: true, // experimental rust based compiler
    // If you use `MDXProvider`, uncomment the following line.
    providerImportSource: "@mdx-js/react",
  },
});
export default withMDX(nextConfig)

