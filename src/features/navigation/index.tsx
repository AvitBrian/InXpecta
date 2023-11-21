import { NavLink } from 'react-router-dom'
import {
    NavigationMenu,
    NavigationMenuContent,
    NavigationMenuIndicator,
    NavigationMenuItem,
    NavigationMenuLink,
    NavigationMenuList,
    NavigationMenuTrigger,
    navigationMenuTriggerStyle
} from "@/components/ui/navigation-menu"
import { Avatar, AvatarFallback, AvatarImage } from "../../components/ui/avatar"
import { Button } from "@/components/ui/button"
import { auth } from '../../firebase'
import './style.sass'
import '../authentication/AuthState'
import AuthState from '../authentication/AuthState'



function Navbar() {

    return (
        <>
            <div className="navbar">
                <NavigationMenu className=''>
                    <NavigationMenuList>
                        <NavigationMenuItem>
                            <NavigationMenuTrigger className=''>
                                <div className='flex '>
                                    <Avatar className="">
                                        <AvatarImage src="https://github.com/shadcn.png" />
                                        <AvatarFallback>CN</AvatarFallback>
                                    </Avatar>
                                    <div className='block px-1 m-auto'>{AuthState()}</div>
                                </div>
                                <NavigationMenuContent>

                                </NavigationMenuContent>
                            </NavigationMenuTrigger>
                            <NavigationMenuContent>
                                <Button onClick={() => {
                                    auth.signOut()
                                }}>signOut</Button>
                            </NavigationMenuContent>
                        </NavigationMenuItem>
                        <NavigationMenuItem>
                            <NavigationMenuLink className={navigationMenuTriggerStyle()} >
                                <NavLink to='/'>Home</NavLink>
                            </NavigationMenuLink>
                        </NavigationMenuItem>
                        <NavigationMenuItem >
                            <NavigationMenuItem className={navigationMenuTriggerStyle()}>
                                <NavLink to='/report'>Report</NavLink>
                            </NavigationMenuItem>
                        </NavigationMenuItem>
                        <NavigationMenuItem >
                            <NavigationMenuItem className={navigationMenuTriggerStyle()}>
                                <NavLink to='/auth'>Authenticate</NavLink>
                            </NavigationMenuItem>
                        </NavigationMenuItem>

                    </NavigationMenuList>
                </NavigationMenu>
                <Button>Download App</Button>
            </div>
        </>

    )
}

export default Navbar