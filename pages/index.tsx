import type { NextPage } from 'next'
import { meta as cos_meta } from './cosine-similarity.mdx'
import { meta as cos_pt2_meta } from './cosine-similarity-pt-2.mdx'

type BlogDate = {
  month: string, year: number, date: string
}
type BlogMetaData = {
  title: string,
  summary: string,
  post_link: string,
  published_date: BlogDate
}


const BlogPostListView = ({ meta_data }: { meta_data: BlogMetaData }) => {
  const display_str = display_publication_date(meta_data.published_date)
  return (<div className='hover:bg-orange-100 py-2 rounded hover:rounded-lg ease-in duration-200 border-l-4  border-white hover:border-indigo-400 px-3 flex flex-col space-y-2'>
    <span className='text-indigo-600'> {display_str}
    </span>
    <span className='mt-3'>
      <a href={meta_data.post_link}>
        {meta_data.title}
      </a>
    </span>
    <span className="text-gray-700">{meta_data.summary}</span>
  </div>)
}
const Home: NextPage = () => {
  return (
    <div className="sm:mx-0 md:mx-auto prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10">
      <div className='sm:flex sm:items-center space-x-3'>
        <a
          target="blank"
          href='https://www.github.com/farooq-azam-khan'>
          <img className='rounded-full w-32 h-32' alt="image of Farooq Azam Khan" src="https://avatars.githubusercontent.com/u/33574913?v=4" /></a>
        <h1 className="text-3xl font-bold underline">Farooq Azam Khan</h1>
      </div>
      <section className="space-y-2">
        <BlogPostListView meta_data={cos_pt2_meta} />
        <BlogPostListView meta_data={cos_meta} />

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

function display_publication_date(pub_date: BlogDate) {
  return pub_date.month + " " + pub_date.date + ", " + pub_date.year;
}

export default Home
