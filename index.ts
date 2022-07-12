import './tailwind.css'
import { Elm } from './src/Main.elm' 

document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('app')
    if (!root) { 
        console.log('root element not found') 
        return 
    } 
    root.onload = renderPageOnLoad()
    const app = Elm.Main.init({
          node: root 
    })
    
    // render the math formulas when the url changes
    app.ports.sendUrlChangedData.subscribe((data) => {
        console.log('changed url...')
        renderPageOnLoad()
    })
    
    app.ports.renderPageData.subscribe((data) => {
        console.log('rendering on load...')
        renderPageOnLoad()
    })


    
})

function renderPageOnLoad() {
    console.log('rendering page on load') 
    renderLatexElements()
    document.querySelectorAll('pre code').forEach(block => hljs.highlightBlock(block))
}


function renderLatexElements() {
    renderMathInElement(document.body, {
        delimiters: [
            {
              left: "$begin-inline$", 
              right: "$end-inline$", 
              display: false
            }, 
            {
              left: "$begin-display$",
              right: "$end-display$", 
              display: true
            }
        ]
    })
}
