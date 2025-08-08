import type { NextPage, GetStaticProps } from "next";
import Navbar from "../components/Navbar";
import { BlogPostListView } from "../components/BlogList";
import type { BlogMetaData } from "@/components/BlogList";
import { getAllBlogs } from "@/lib/blog";

export const getStaticProps: GetStaticProps<{ blogs: BlogMetaData[] }> = async () => {
  const blogs = await getAllBlogs();
  return { props: { blogs } };
};

const Home: NextPage<{ blogs: BlogMetaData[] }> = ({ blogs }) => {
  return (
    <div className="font-mono sm:mx-0 md:mx-auto prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10 mb-20">
      <Navbar />
      <section className="space-y-2">
        <BlogPostListView blogs={blogs} />
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
