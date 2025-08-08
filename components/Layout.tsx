import { MDXProvider } from "@mdx-js/react";
import "katex/dist/katex.min.css";
import {
  ClipboardDocumentIcon,
  EyeIcon,
  EyeSlashIcon,
} from "@heroicons/react/24/solid";
import Navbar from "./Navbar";
import { useEffect, useState } from "react";
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
  const [visible, setVisible] = useState(true);
  const txt = innerText(children);
  const toggleVisible = () => setVisible((v) => !v);
  return (
    <div className="relative my-6">
      {visible ? (
        <pre className="overflow-x-auto bg-stone-700 rounded-md p-4">
          {children}
        </pre>
      ) : (
        <div className="overflow-x-auto bg-stone-700 rounded-md p-4 text-center text-sm text-stone-400 italic">
          Code hidden
        </div>
      )}
      {visible && (
        <CopyToClipboard text={txt}>
          <button
            type="button"
            className="absolute top-2 right-2 z-10 p-1 bg-stone-600 hover:bg-stone-500 rounded"
          >
            <ClipboardDocumentIcon className="h-5 w-5 text-white" />
          </button>
        </CopyToClipboard>
      )}
      <button
        type="button"
        onClick={toggleVisible}
        className="absolute top-2 right-10 z-10 p-1 bg-stone-600 hover:bg-stone-500 rounded"
      >
        {visible ? (
          <>
            <EyeSlashIcon className="h-5 w-5 text-white" />
          </>
        ) : (
          <>
            <EyeIcon className="h-5 w-5 text-white" />
          </>
        )}
      </button>
    </div>
  );
}
const Layout = ({ children }: any) => {
  useEffect(() => {}, []);
  return (
    <>
      <Navbar />
      <div className="bg-secondary-background px-10 space-y-16 pb-10">
        <div className="w-full prose md:prose-lg lg:prose-xl 3xl:prose-2xl prose-code:font-mono prose-p:text-foreground prose-li:text-foreground prose-p:font-normal prose-li:font-normal">
          <MDXProvider components={{ pre: PreWithCopy }}>
            {children}
          </MDXProvider>
        </div>
      </div>
    </>
  );
};

export function MdxLayout({ children }: { children: React.ReactNode }) {
  // Create any shared layout or styles here
  return <div className="">{children}</div>;
}

export default Layout;
