import { MDXProvider } from '@mdx-js/react'
import 'katex/dist/katex.min.css';

const Layout = ({ children, meta }: any) => {
    return (<MDXProvider><div className="mx-auto max-w-3xl prose lg:prose-xl mb-10">
        {/* {JSON.stringify(meta)} */}
        {children}</div>
    </MDXProvider>)
}

export default Layout