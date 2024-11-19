import { MDXProvider } from "@mdx-js/react";
import "katex/dist/katex.min.css";
import Navbar from "./Navbar";
import hljs from 'highlight.js/lib/core';
import Script from "next/script";
import { useEffect } from "react";
import sql from "highlight.js/lib/languages/sql";

import javascript from "highlight.js/lib/languages/javascript";

import c from "highlight.js/lib/languages/c";

import css from "highlight.js/lib/languages/css";

import scss from "highlight.js/lib/languages/scss";

import shell from "highlight.js/lib/languages/shell";

import python from "highlight.js/lib/languages/python";

import powershell from "highlight.js/lib/languages/powershell";

import cpp from "highlight.js/lib/languages/cpp";

import php from "highlight.js/lib/languages/php";

import phpTemplate from "highlight.js/lib/languages/php-template";

import xml from "highlight.js/lib/languages/xml";



// TODO: add highlight styles for code blocks
// TODO: add copy to clipboard for code blocks

const Layout = ({ children }: any) => {
    useEffect(() => {
        hljs.registerLanguage("sql", sql);

        hljs.registerLanguage("javascript", javascript);

        hljs.registerLanguage("python", python);

        hljs.registerLanguage("c", c);

        hljs.registerLanguage("cpp", cpp);

        hljs.registerLanguage("powershell", powershell);

        hljs.registerLanguage("shell", shell);

        hljs.registerLanguage("scss", scss);

        hljs.registerLanguage("css", css);

        hljs.registerLanguage("php", php);

        hljs.registerLanguage("php-template", phpTemplate);

        hljs.registerLanguage("html", xml);


        hljs.registerLanguage("xml", xml);
        hljs.highlightAll({ detectLanguage: true })
    }, [])
    return (
        <div className="mx-auto max-w-3xl lg:max-w-5xl mb-10">
            <div className="mt-10">
                <Navbar />
            </div>
            {/* {JSON.stringify(meta)} */}
            <div className="prose lg:prose-xl 2xl:prose-2xl mt-16 prose-indigo">
                <Script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></Script>

                <MDXProvider>{children}</MDXProvider>
            </div>
        </div>
    );
};

export default Layout;
