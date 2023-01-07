import type { NextPage } from 'next'
import Link from 'next/link'

const Home: NextPage = () => {
  return (
    <div className="sm:mx-0 mx-auto prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10">
      <div className='sm:flex sm:items-center space-x-3'>
        <a
          target="blank"
          href='https://www.github.com/farooq-azam-khan'>
          <img className='rounded-full w-32 h-32' alt="image of Farooq Azam Khan" src="https://avatars.githubusercontent.com/u/33574913?v=4" /></a>
        <h1 className="text-3xl font-bold underline">Farooq Azam Khan</h1>
      </div>
      <section className="space-y-2">
        Blog List goes here
      </section>
      <section>
        <h2 className='text-gray-700'>Drafts</h2>
        <ul className='list-disc'>
          <li>Singular Value Decomposition and Recommendation Engines</li>
          <li>What Principal Component Analysis teaches us about Dimensionality reduction</li>
          <li>The Deep Learning Model Development Architecture</li>
          <li>Linear Regression: The Basis for all Modern Deep Learning Algorithms</li>
          <li>What RNNs are and why they are Turing Complete!</li>
        </ul>
      </section>

    </div>
  )
}

export default Home
