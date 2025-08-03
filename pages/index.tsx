import type { NextPage } from "next";
import Navbar from "../components/Navbar";
import { BlogPostListView } from "../components/BlogList";
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


export default Home;
