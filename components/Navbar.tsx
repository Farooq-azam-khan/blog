import type { NextPage } from "next";
import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
const Navbar: NextPage = () => {
  return (
    <div className="w-full flex flex-col sm:flex-row sm:justify-between sm:items-center sm:py-2 sm:px-0">
      <div className="flex items-center space-x-4">
        <a href="https://www.github.com/farooq-azam-khan" target="_blank">
          <Image
            width={100}
            height={100}
            alt="Farooq A. Khan"
            src="https://avatars.githubusercontent.com/u/33574913?v=4"
            className="rounded-full"
          />
        </a>
        <Button asChild>
          <Link href="https://farooqkhan.ca">Farooq A. Khan</Link>
        </Button>
      </div>
      <Button variant="neutral" className="text-lg font-heading border-4">
        Home
      </Button>
    </div>
  );
};
export default Navbar;
