import type { NextPage } from "next";
import Navbar from "../components/Navbar";
// Blog post metadata imported from MDX pages
import { meta as iterativeMeta } from "./iterative-policy-evaluation-in-a-nutshell.mdx";
import { meta as rlMeta } from "./rl-in-a-nutshell.mdx";
import { meta as logisticMeta } from "./logistic-regression-with-gradient-descent.mdx";
import { meta as mleMeta } from "./mle.mdx";
import { meta as tfidfMeta } from "./tfidf.mdx";
import { meta as techStackMeta } from "./tech-stack.mdx";
import { meta as fastLLMMeta } from "./fast-llm-inferencing.mdx";
import { meta as vectorComparisonMeta } from "./cosine-similarity-pt-2.mdx";
import { meta as cosineMeta } from "./cosine-similarity.mdx";
import { meta as d3Meta } from "./d3-tutorial.mdx";

const blog_metadata: any[] = [
  iterativeMeta,
  rlMeta,
  logisticMeta,
  mleMeta,
  tfidfMeta,
  techStackMeta,
  fastLLMMeta,
  vectorComparisonMeta,
  cosineMeta,
  d3Meta,
];
type BlogDate = {
  month: string;
  year: number;
  date: string;
};

type BlogMetaData = {
  title: string;
  summary: string;
  post_link: string;
  published_date: BlogDate;
};

const BlogPostView = ({ meta_data }: { meta_data: BlogMetaData }) => {
  const display_str = display_publication_date(meta_data.published_date);
  return (
    <div className="hover:bg-indigo-50 py-2 rounded hover:rounded-lg ease-in duration-200 border-l-4  border-white hover:border-indigo-400 px-3 flex flex-col space-y-2">
      <span className="text-indigo-600"> {display_str}</span>
      <span className="mt-3">
        <a href={meta_data.post_link}>{meta_data.title}</a>
      </span>
      <span className="text-gray-700">{meta_data.summary}</span>
    </div>
  );
};

function get_date_obj(published_date: BlogDate): Date {
  // 'st', 'th', 'nd', 'rd'
  let date = published_date.date;
  date = date.replace("st", "");
  date = date.replace("nd", "");
  date = date.replace("rd", "");
  date = date.replace("th", "");
  const b1_date_obj = new Date(
    published_date.year,
    getMonth(published_date.month),
    +date
  );

  return b1_date_obj;
}
function BlogPostListView({ blogs }: { blogs: BlogMetaData[] }) {
  let blogs_clone = [...blogs];
  blogs_clone.sort((blog1: BlogMetaData, blog2: BlogMetaData) => {
    const b1_publised_date = get_date_obj(blog1.published_date);
    const b2_publised_date = get_date_obj(blog2.published_date);
    return b2_publised_date.getTime() - b1_publised_date.getTime();
  });
  return (
    <>
      {blogs_clone.map((blog) => {
        console.log(blog);
        return <BlogPostView meta_data={blog} key={blog.title} />;
      })}
    </>
  );
}

const Home: NextPage = () => {
  return (
    <div className=" sm:mx-0 md:mx-auto prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10 mb-20">
      <Navbar />
      <section className="space-y-2">
        <BlogPostListView blogs={blog_metadata} />
      </section>
      {/* <section>
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
      </section> */}
    </div>
  );
};

function display_publication_date(pub_date: BlogDate) {
  return pub_date.month + " " + pub_date.date + ", " + pub_date.year;
}

function getMonth(month: string): number {
  if (month == "January" || month == "Jan") {
    return 0;
  } else if (month == "February" || month == "Feb") {
    return 1;
  } else if (month == "March" || month == "Mar") {
    return 2;
  } else if (month == "April" || month == "Apr") {
    return 3;
  } else if (month == "May") {
    return 4;
  } else if (month == "June") {
    return 5;
  } else if (month == "July") {
    return 6;
  } else if (month == "August" || month == "Aug") {
    return 7;
  } else if (month == "September" || month == "Sept") {
    return 8;
  } else if (month == "October" || month == "Oct") {
    return 9;
  } else if (month == "November" || month == "Nov") {
    return 10;
  } else if (month == "December" || month == "Dec") {
    return 11;
  }
  return 0;
}

export default Home;
