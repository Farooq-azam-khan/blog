import { MDXProvider } from "@mdx-js/react";
import "katex/dist/katex.min.css";
import { ClipboardDocumentIcon, EyeIcon, EyeSlashIcon } from "@heroicons/react/24/solid";
import Navbar from "./Navbar";
import { useEffect, useState, createContext, useContext } from "react";
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

// Context to control visibility of code blocks
const CodeVisibilityContext = createContext({ showCode: true, toggleShowCode: () => {} });
function PreWithCopy({ children }: any) {
  const { showCode } = useContext(CodeVisibilityContext);
  const txt = innerText(children);
  if (!showCode) return null;
  return (
    <div className="relative my-6">
      <pre className="overflow-x-auto bg-stone-700 rounded-md p-4">
        {children}
      </pre>
      <CopyToClipboard text={txt}>
        <button
          type="button"
          className="absolute top-2 right-2 z-10 p-1 bg-stone-600 hover:bg-stone-500 rounded"
        >
          <ClipboardDocumentIcon className="h-5 w-5 text-white" />
        </button>
      </CopyToClipboard>
    </div>
  );
}
const Layout = ({ children }: any) => {
  const [showCode, setShowCode] = useState(true);
  const toggleShowCode = () => setShowCode((prev) => !prev);
  useEffect(() => {}, []);
  return (
    <CodeVisibilityContext.Provider value={{ showCode, toggleShowCode }}>
      <div className="px-10 lg:mx-auto lg:max-w-6xl mb-10 space-y-16">
        <div className="mt-10">
          <Navbar />
        </div>
        <div className="flex justify-end">
          <button
            type="button"
            onClick={toggleShowCode}
            className="flex items-center space-x-1 mb-4 px-2 py-1 bg-stone-700 text-white rounded hover:bg-stone-600"
          >
            {showCode ? (
              <><EyeSlashIcon className="h-5 w-5" /><span>Hide Code</span></>
            ) : (
              <><EyeIcon className="h-5 w-5" /><span>Show Code</span></>
            )}
          </button>
        </div>
        <div className="w-full prose md:prose-lg lg:prose-xl 3xl:prose-2xl prose-code:font-mono prose-p:text-foreground prose-li:text-foreground prose-p:font-normal prose-li:font-normal">
          <MDXProvider
            components={() => ({ pre: PreWithCopy })}
          >
            {children}
          </MDXProvider>
        </div>
      </div>
    </CodeVisibilityContext.Provider>
  );
};

export function MdxLayout({ children }: { children: React.ReactNode }) {
  // Create any shared layout or styles here
  return <div className="">{children}</div>;
}

export default Layout;
