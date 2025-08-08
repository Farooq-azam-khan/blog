import type { NextPage, GetStaticProps } from "next";
import Navbar from "../components/Navbar";
import { BlogPostListView } from "../components/BlogList";
import type { BlogMetaData } from "@/components/BlogList";
import { getAllBlogs } from "@/lib/blog";

export const getStaticProps: GetStaticProps<{
  blogs: BlogMetaData[];
}> = async () => {
  const blogs = await getAllBlogs();
  return { props: { blogs } };
};

const Home: NextPage<{ blogs: BlogMetaData[] }> = ({ blogs }) => {
  return (
    <div className="my-10">
      <Navbar />
      <section className="space-y-2">
        <BlogPostListView blogs={blogs} />
      </section>
    </div>
  );
};

export default Home;
