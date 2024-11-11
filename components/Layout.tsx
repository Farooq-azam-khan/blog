import { MDXProvider } from "@mdx-js/react";
import "katex/dist/katex.min.css";
import Navbar from "./Navbar";

// TODO: add highlight styles for code blocks
// TODO: add copy to clipboard for code blocks

const Layout = ({ children }: any) => {
  return (
    <div className="mx-auto max-w-3xl lg:max-w-5xl mb-10">
      <div className="mt-10">
        <Navbar />
      </div>
      {/* {JSON.stringify(meta)} */}
      <div className="prose lg:prose-xl 2xl:prose-2xl mt-16 prose-indigo">
        <MDXProvider>{children}</MDXProvider>
      </div>
    </div>
  );
};

export default Layout;
