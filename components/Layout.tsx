import { MDXProvider } from '@mdx-js/react'
import 'katex/dist/katex.min.css';
import Navbar from './Navbar';
const Layout = ({ children, meta }: any) => {
    return (
       
        <div className="mx-auto max-w-3xl mb-10">
        <div className="mt-10"><Navbar/></div>
        {/* {JSON.stringify(meta)} */}
        <div className="prose lg:prose-xl mt-16">
            <MDXProvider>{children}</MDXProvider></div>
        </div>
    )
}

export default Layout