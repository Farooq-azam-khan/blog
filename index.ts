import './tailwind.css'
import { Elm } from './src/Main.elm' 

document.addEventListener('DOMContentLoaded', () => {
    renderLatexElements() 
    const app = Elm.Main.init({
          node: document.getElementById('app')
    })
    
    // render the math formulas when the url changes
    app.ports.sendUrlChangedData.subscribe((data) => {
        console.log('changed url...')
        renderPageOnLoad()
    })
      renderPageOnLoad()
})

function renderPageOnLoad() {
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
