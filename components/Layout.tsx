import { MDXProvider } from "@mdx-js/react";
import "katex/dist/katex.min.css";
import { ClipboardDocumentIcon } from "@heroicons/react/24/solid";
import Navbar from "./Navbar";
import { useEffect } from "react";
import "@wooorm/starry-night/style/dark"
import { CopyToClipboard } from "react-copy-to-clipboard";

function hasProps(jsx: any) {
    return Object.prototype.hasOwnProperty.call(jsx, 'props');
}

function reduceJsxToString(previous: string, current: any): string {
    return previous + innerText(current);
}
function innerText(jsx: any) {
    if (jsx === null ||
        typeof jsx === 'boolean' ||
        typeof jsx === 'undefined') {
        return '';
    }
    if (typeof jsx === 'number') {
        return jsx.toString();
    }
    if (typeof jsx === 'string') {
        return jsx;
    }
    if (Array.isArray(jsx)) {
        return jsx.reduce(reduceJsxToString, '');
    }
    if (hasProps(jsx) &&

        Object.prototype.hasOwnProperty.call(jsx.props, 'children')) {

        return innerText(jsx.props.children);
    }
    return '';
};

function PreWithCopy({ children }: any) {
    const txt = innerText(children)
    return (<pre className="relative">{children}
        <button className="absolute right-0 top-0 z-10 p-1 rounded-md">
            <CopyToClipboard text={txt}>
                <ClipboardDocumentIcon className="h-6 w-6 " />
            </CopyToClipboard>
        </button></pre>)

}
const Layout = ({ children }: any) => {
    useEffect(() => {
    }, [])
    return (
        <div className="mx-auto max-w-3xl lg:max-w-5xl mb-10">
            <div className="mt-10">
                <Navbar />
            </div>
            {/* {JSON.stringify(meta)} */}
            <div className="prose lg:prose-xl 2xl:prose-2xl mt-16 prose-indigo">
                <MDXProvider components={function() {
                    return { pre: PreWithCopy }
                }}>{children}</MDXProvider>
            </div>
        </div>
    );
};

export default Layout;
