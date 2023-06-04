/** @type {import('next').NextConfig} */
const nextConfig = {

  // Append the default value with md extensions
  pageExtensions: ['ts', 'tsx', 'js', 'jsx', 'md', 'mdx'],
  reactStrictMode: true,
  swcMinify: true,
  images: {
    formats:  ["image/avif", "image/webp"],
    remotePatterns: [{
      protocol: 'https',
      hostname: 'avatars.githubusercontent.com',
      port: '',
      pathname: '/u/**',
    }]
  }
}

// next.config.js

const withMDX = require('@next/mdx')({
  extension: /\.mdx?$/,
  options: {
    remarkPlugins: [],
    rehypePlugins: [],
    // mdxRs: true, // experimental rust based compiler
    // If you use `MDXProvider`, uncomment the following line.
    providerImportSource: "@mdx-js/react",
  }
})
module.exports = withMDX(nextConfig)


