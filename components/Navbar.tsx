import type { NextPage } from "next";
import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
const Navbar: NextPage = () => {
  return (
    <div className="w-full flex flex-col sm:flex-row sm:justify-between sm:items-center sm:py-2 sm:px-0">
      <div className="flex items-center space-x-2">
        <div>
          <a
            target="blank"
            className="w-full h-full"
            href="https://www.github.com/farooq-azam-khan"
          >
            <Image
              className="rounded-full"
              width={128}
              height={128}
              alt="image of Farooq Azam Khan"
              src="https://avatars.githubusercontent.com/u/33574913?v=4"
            />
          </a>
        </div>
        <Button variant="link" className="text-xl">
          <Link href="/">
            <h2>Farooq A. Khan</h2>
          </Link>
        </Button>
      </div>
      <Button variant="link" className="text-xl">
        <Link href="/">Home</Link>
      </Button>
    </div>
  );
};
export default Navbar;
