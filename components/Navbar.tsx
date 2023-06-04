import type { NextPage } from 'next'
import Image from 'next/image'
import Link from 'next/link'

const Navbar: NextPage = () => {
    return (<div className='sm:flex sm:items-center space-x-3'>
    <a
      target="blank"
      href='https://www.github.com/farooq-azam-khan'>
      <Image 
        className='rounded-full' 
        width={128}
        height={128}
        alt="image of Farooq Azam Khan" 
        src="https://avatars.githubusercontent.com/u/33574913?v=4" 
      />
    </a>
    <Link href="/"><h1 className="text-3xl font-bold underline">
        Farooq Azam Khan</h1></Link>
  </div>)
  }
export default Navbar; 