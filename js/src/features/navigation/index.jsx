import { Link } from "react-router-dom";
import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuIndicator,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger,
  navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { auth } from "../../firebase";
import "./style.sass";
import "../authentication/AuthState";
import { useAuthState } from 'react-firebase-hooks/auth'

import AuthState from "../authentication/AuthState";
import { FaIcons } from "react-icons/fa";
import { HomeIcon, PersonIcon } from "@radix-ui/react-icons";
import { AuthProvider } from "../../providers/auth_provider";

function Navbar() {

    const [user] = useAuthState(auth);
  
  return (
    <>
      <div className="navbar ">
        <NavigationMenu className="">
          <NavigationMenuList>
           {user ?
            <NavigationMenuItem className="">
            <NavigationMenuTrigger className="h-full nav-trigger hover:border-0">
              <div className="flex text-right w-full h-full ">
                <Avatar className="h-full">
                  
                     <AvatarImage src={user.photoURL}/> :
                    <AvatarFallback>
                      <PersonIcon />
                    </AvatarFallback>
                </Avatar>
                <div className="block px-1 m-auto">
                  {user != null ? user.displayName : <p></p>}
                </div>
              </div>
            </NavigationMenuTrigger>
            <NavigationMenuContent >
                <Button className="text-brown-500 bg-transparent hover:bg-transparent hover:border-0 hover:text-indigo-500 active:bg-red-600 font-bold uppercase px-8 py-3 rounded outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150">Profile</Button>
              <Button className="text-red-500 bg-transparent hover:bg-transparent hover:border-0 hover:text-indigo-500 active:bg-red-600 font-bold uppercase px-8 py-3 rounded outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                onClick={() => {
                  auth.signOut();
                }}
              >
                signOut
              </Button>
            </NavigationMenuContent>
          </NavigationMenuItem>: <></>}
            <NavigationMenuItem>
            {user != null ?             <NavigationMenuItem className={navigationMenuTriggerStyle()}>
                <Link to="/">Home</Link>
              </NavigationMenuItem>: <></>}
            </NavigationMenuItem>
              <NavigationMenuItem className={navigationMenuTriggerStyle()}>
                <Link to="/report">Report</Link>
              </NavigationMenuItem>
                {user == null ?             <NavigationMenuItem className={navigationMenuTriggerStyle()}>
                <Link to="/auth" >Authenticate</Link>
              </NavigationMenuItem>: <></>}

          </NavigationMenuList>
        </NavigationMenu>
        <Button className="border border-amber-900">Download App</Button>
      </div>
    </>
  );
}

export default Navbar;
