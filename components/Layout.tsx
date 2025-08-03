import { MDXProvider } from "@mdx-js/react";
import "katex/dist/katex.min.css";
import { ClipboardDocumentIcon } from "@heroicons/react/24/solid";
import Navbar from "./Navbar";
import { useEffect } from "react";
import "@wooorm/starry-night/style/dark";
import { CopyToClipboard } from "react-copy-to-clipboard";

function hasProps(jsx: any) {
  return Object.prototype.hasOwnProperty.call(jsx, "props");
}

function reduceJsxToString(previous: string, current: any): string {
  return previous + innerText(current);
}
function innerText(jsx: any) {
  if (jsx === null || typeof jsx === "boolean" || typeof jsx === "undefined") {
    return "";
  }
  if (typeof jsx === "number") {
    return jsx.toString();
  }
  if (typeof jsx === "string") {
    return jsx;
  }
  if (Array.isArray(jsx)) {
    return jsx.reduce(reduceJsxToString, "");
  }
  if (
    hasProps(jsx) &&
    Object.prototype.hasOwnProperty.call(jsx.props, "children")
  ) {
    return innerText(jsx.props.children);
  }
  return "";
}

function PreWithCopy({ children }: any) {
  const txt = innerText(children);
  return (
    <pre className="relative bg-stone-700">
      {children}
      <button className="absolute right-0 top-0 z-10 p-1 rounded-md ">
        <CopyToClipboard text={txt}>
          <ClipboardDocumentIcon className="h-6 w-6 " />
        </CopyToClipboard>
      </button>
    </pre>
  );
}
const Layout = ({ children }: any) => {
  useEffect(() => {}, []);
  return (
    <div className="px-10 lg:mx-auto lg:max-w-6xl mb-10 space-y-16">
      <div className="mt-10">
        <Navbar />
      </div>
      <div className="w-full prose md:prose-lg lg:prose-xl 3xl:prose-2xl prose-code:font-mono prose-p:text-foreground prose-li:text-foreground prose-p:font-normal prose-li:font-normal">
        <MDXProvider
          components={function () {
            return { pre: PreWithCopy };
          }}
        >
          {children}
        </MDXProvider>
      </div>
    </div>
  );
};

export function MdxLayout({ children }: { children: React.ReactNode }) {
  // Create any shared layout or styles here
  return <div className="">{children}</div>;
}

export default Layout;
