import SyntaxHighlighter from "react-syntax-highlighter";
import { CopyToClipboard } from "react-copy-to-clipboard";
import { ClipboardDocumentIcon } from "@heroicons/react/24/solid";

function CopyButton({ children }: any) {
  return (
    <button className="absolute right-0 top-0 mt-10 mr-6 z-10 hover:bg-indigo-50 p-1 rounded-md">
      <CopyToClipboard text={children}>
        <ClipboardDocumentIcon className="h-6 w-6 " />
      </CopyToClipboard>
    </button>
  );
}
const CodeBlock = ({ children }: any) => {
  return (
    <SyntaxHighlighter
      className="relative w-full overflow-auto"
      language="python"
    >
      {children}
    </SyntaxHighlighter>
  );
};

export default CodeBlock;
