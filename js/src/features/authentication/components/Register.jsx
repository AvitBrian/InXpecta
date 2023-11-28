
import { FaLock, FaEnvelope } from "react-icons/fa";
import { auth } from "../../../firebase";
import { createUserWithEmailAndPassword } from "firebase/auth";
import "../style.sass";
import { useState } from "react";
// @ts-ignore
import Typed from 'typed.js';
import React from "react";
import { useForm } from 'react-hook-form'
import { z } from 'zod'




function Register() {
    const [emailFocused, setEmailFocused] = useState(false);
    const [passwordFocused, setPasswordFocused] = useState(false);

    //formschema i'll use this for validation
    const FormSchema = z.object({
        email: z
            .string()
            .min(1, { message: "Please enter your email" })
            .email("This is not a valid email"),
        password: z.string().min(1, { message: "please enter your password" }),

    },)


    //initializing useform
    const { register, handleSubmit } = useForm();

    const onSubmit = (data, e) => {
        e?.preventDefault();
        createUserWithEmailAndPassword(auth, data.email, data.password)
            .then((useCredentials) => {
                console.log(useCredentials)
            }).catch((error) => console.error(error))

    }


    const typer = React.useRef(null);

    React.useEffect(() => {
        const typed = new Typed(typer.current, {
            strings: ['in'],
            startDelay: 20,
            typeSpeed: 150,
            backSpeed: 100,
            showCursor: false
        });
        return () => {
            typed.destroy();
        };
    }, []);



    return (
        <form className="register-container" onSubmit={handleSubmit(onSubmit)}>
            <p className="text-xs text-start mt-1 overline" >Let's Sign you <span className="line-through" ref={typer}></span> <b>Up</b>...</p>
            <div className="input">


                <FaEnvelope className={`icon ${emailFocused ? "text-amber-500" : ""}`} />
                <input
                    id="email"
                    type="text"
                    placeholder="Email"
                    onFocus={() => setEmailFocused(true)}
                    {...register("email")}

                />
            </div>
            <div className="input">
                <FaLock className={`icon ${passwordFocused ? "text-amber-500" : ""}`} />
                <input
                    id="password"
                    type="password"
                    placeholder="Password"
                    onFocus={() => setPasswordFocused(true)}
                    {...register("password")}
                />
            </div>

            <button type="submit" className="button w-full">Register</button>
        </form>
    );
}

export default Register;
