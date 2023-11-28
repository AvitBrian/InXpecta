import './style.sass'
import Login from './components/Login'
import Register from './components/Register'
import { useState } from 'react'
import video from '../../assets/videos/background.webm'
// @ts-ignore
import Typed from 'typed.js';
import React from "react";

function Auth() {
    const [action, setAction] = useState("Login")

    const typer = React.useRef(null);

    React.useEffect(() => {
        const typed = new Typed(typer.current, {
            strings: ['In', 'inXpek', 'inXpecta!'],
            startDelay: 70,
            typeSpeed: 150,
            backDelay: 500,
            backSpeed: 140,
            loop: true,
        });
        return () => {
            typed.destroy();
        };
    }, []);
    return (
        <div className="h-screen flex ">
            <div className='background-video'>
                <div className="video-overlay"></div>
                <video src={video} loop autoPlay muted />
            </div>
            <div className='container bg-amber-100/50 w-1/2 my-auto  items-center lg:w-1/3 md:w-2/5'>
                <div className='header text-start'>
                    <p className='text-2xl'>Hey there 👋</p>
                    <p>Welcome to <span ref={typer} className='text-amber-500'>inXpecta</span></p>
                    <div className='h-1 w-2/3 bg-white'></div>
                </div>
                {
                    action === 'Login' ? <Login /> : <Register />
                }
                <div className="submit-container mt-1">
                    <div className={action !== 'Register' ? 'hide' : 'w-full'}>
                        <p className='text-start text-xs'>Already have an account? <a className='hover:underline' onClick={() => { setAction("Login") }}>Login</a>!</p>

                    </div>
                    <div className={action !== 'Login' ? 'hide' : 'w-full'}>
                        <p className='text-start text-xs italic'>Don't have an account? <a className='hover:underline' onClick={() => { setAction("Register") }}>Sign up</a>!</p>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Auth