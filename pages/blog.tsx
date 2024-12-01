type Post = {
    title: string,
    id: string
}
type Props = {
    posts: Post[]
}

import { NextPage } from "next"
const Blog: NextPage<Props> = ({ posts }: Props) => {
    return (<ul>
        {posts.map(post => <li key={post.id}>{post.title}</li>)}
    </ul>)
}

export async function getStaticProps(): Promise<{ props: Props }> {
    return {
        props: { posts: [{ id: "asdf", title: "Blog #1" }] }
    }
}

export default Blog 
