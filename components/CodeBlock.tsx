import SyntaxHighlighter from 'react-syntax-highlighter'
import { CopyToClipboard } from 'react-copy-to-clipboard';

const CodeBlock = ({ children }: any) => {

    return (<div className='flex flex-col items-start mt-5'>
        <CopyToClipboard text={children} >
            <button>Copy Code</button>
        </CopyToClipboard>

        <SyntaxHighlighter language="python">
            {children}
        </SyntaxHighlighter>
    </div>)
}

export default CodeBlock 