import { useState } from 'react'
type Props = {
    start_counter: number
}
const Counter = ({ start_counter }: Props) => {
    const [counter, setCounter] = useState<number>(start_counter)

    return (<div className="flex items-center space-x-6">
        <button className="bg-gray-900 text-white px-5 py-2 rounded-md shadow-md" onClick={() => setCounter(prevVal => prevVal - 1)}>-</button>
        <span>{counter}</span>
        <button className="bg-gray-900 text-white px-5 py-2 rounded-md shadow-md" onClick={() => setCounter(prevVal => prevVal + 1)}>+</button>
    </div>)
}

export default Counter 