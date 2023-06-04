import type { NextPage } from 'next'
import Image from 'next/image'
import {meta as cos_meta} from './cosine-similarity.mdx'
import {meta as tech_stack} from './tech-stack.mdx'
type BlogDate = {
  month: string, year: number, date: string
}
type BlogMetaData = {
  title: string,
  summary: string,
  post_link: string,
  published_date: BlogDate
}


// export const cos_meta = {
//   title: "Comparing Vectors with Cosine Simlarity Function",
//   published_date: { month: "July", date: "4th", year: 2022 }
//   , summary: "This tutorial will focus on the math behind text vector similarity using numpy, pytorch, and stentence-transformers libraries in python."
//   , post_link: "cosine-similarity"
// }

export const cos_pt2_meta = {
  title: "Large Scale Vector Comparison",
  published_date: { month: "July", date: "9th", year: 2022 }
  , summary: "In this post, we will look at the quora qna dataset and aim to encode and compare all question pairs. The purpose of is to look at a real dataset."
  , post_link: "cosine-similarity-pt-2"
}

export const tfidf_meta = {
  title: "Term Frequency-Inverse Document Frequency",
  published_date: { month: "August", date: "1st", year: 2022 }
  , summary: "In this tutorial we will look at what TF and IDF are and how they can be use to process text data in Machine learning."
  , post_link: "tfidf"
}


const BlogPostView = ({ meta_data }: { meta_data: BlogMetaData }) => {
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


function get_date_obj(published_date: BlogDate): Date {
  // 'st', 'th', 'nd', 'rd'
  let date = published_date.date
  date = date.replace('st', '')
  date = date.replace('nd', '')
  date = date.replace('rd', '')
  date = date.replace('th', '')
  const b1_date_obj = new Date(published_date.year, getMonth(published_date.month), +date)

  return b1_date_obj

}
function BlogPostListView({ blogs }: { blogs: BlogMetaData[] }) {
  let blogs_clone = [...blogs]
  blogs_clone.sort((blog1: BlogMetaData, blog2: BlogMetaData) => {
    const b1_publised_date = get_date_obj(blog1.published_date)
    const b2_publised_date = get_date_obj(blog2.published_date)
    return b2_publised_date.getTime() - b1_publised_date.getTime()
  })
  return (<>
    {blogs_clone.map((blog) => {
      return <BlogPostView meta_data={blog} key={blog.title} />
    })}
  </>)

}
const Home: NextPage = () => {
  return (
    <div className="sm:mx-0 md:mx-auto prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10">
      <div className='sm:flex sm:items-center space-x-3'>
        <a
          target="blank"
          href='https://www.github.com/farooq-azam-khan'>
          <Image 
            className='rounded-full w-32 h-32' 
            alt="image of Farooq Azam Khan" 
            src="https://avatars.githubusercontent.com/u/33574913?v=4" 
            layout="fill" 
          />
          {/* <img className='rounded-full w-32 h-32' alt="image of Farooq Azam Khan" src="https://avatars.githubusercontent.com/u/33574913?v=4" /> */}
        </a>
        <h1 className="text-3xl font-bold underline">Farooq Azam Khan</h1>
      </div>
      <section className="space-y-2">
        <BlogPostListView blogs={[cos_pt2_meta, 
          cos_meta, 
          tfidf_meta, 
          tech_stack
          ]} />

      </section>
      <section>
        <h2 className='text-gray-700'>Drafts</h2>
        <ul className='list-disc'>
          <li>Singular Value Decomposition and Recommendation Engines</li>
          <li>What Principal Component Analysis teaches us about Dimensionality reduction</li>
          <li>The Deep Learning Model Development Architecture</li>
          <li>Linear Regression: The Basis for all Modern Deep Learning Algorithms</li>
          <li>What RNNs are and why they are Turing Complete!</li>
          <li>K-arm bandit</li>
          <li>anomaly detection with gaussian distribution and multi-variate gaussian distribution</li>
        </ul>
      </section>
    </div>
  )
}

function display_publication_date(pub_date: BlogDate) {
  return pub_date.month + " " + pub_date.date + ", " + pub_date.year;
}

function getMonth(month: string): number {
  if (month == 'January' || month == 'Jan') {
    return 0
  } else if (month == 'February' || month == 'Feb') {
    return 1
  } else if (month == 'March' || month == 'Mar') {
    return 2
  } else if (month == 'April' || month == 'Apr') {
    return 3
  } else if (month == 'May') {
    return 4
  } else if (month == 'June') {
    return 5
  } else if (month == 'July') {
    return 6
  } else if (month == 'August' || month == 'Aug') {
    return 7
  } else if (month == 'September' || month == 'Sept') {
    return 8
  } else if (month == 'October' || month == 'Oct') {
    return 9
  } else if (month == 'November' || month == 'Nov') {
    return 10
  } else if (month == 'December' || month == 'Dec') {
    return 11
  }
  return 0
}

export default Home
