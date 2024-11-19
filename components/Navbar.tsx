import type { NextPage } from "next";
import Image from "next/image";
import Link from "next/link";

const Navbar: NextPage = () => {
  return (
    <div className="sm:flex sm:items-center space-x-3 sm:space-x-5 ">
      <a target="blank" href="https://www.github.com/farooq-azam-khan">
        <Image
          className="rounded-full"
          width={128}
          height={128}
          alt="image of Farooq Azam Khan"
          src="https://avatars.githubusercontent.com/u/33574913?v=4"
        />
      </a>
      <Link href="/">
        <h2 className="text-5xl font-bold underline">Farooq A. Khan</h2>
      </Link>
    </div>
  );
};
export default Navbar;
