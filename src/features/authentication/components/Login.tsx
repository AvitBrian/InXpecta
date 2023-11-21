
import { FaLock, FaEnvelope } from "react-icons/fa";
import { auth, signInWithGooglePopup } from "../../../firebase";
import { signInWithEmailAndPassword } from "firebase/auth";
import "../style.sass";
import { useState } from "react";
import { Button } from "@/components/ui/button";



function Login() {
    const [emailFocused, setEmailFocused] = useState(false);
    const [passwordFocused, setPasswordFocused] = useState(false);
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const logIn = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        signInWithEmailAndPassword(auth, email, password)
            .then((useCredentials) => {
                console.log(useCredentials)
            }).catch((error) => console.error(error))
    }
    return (
        <form className="login-container" onSubmit={logIn}>
            <p className="text-xs text-start mt-1 overline" >Let's Sign you in...</p>
            <div className="input">

                <FaEnvelope className={`icon ${emailFocused ? "text-amber-500" : ""}`} />
                <input
                    type="text"
                    placeholder="Email"
                    onFocus={() => setEmailFocused(true)}
                    onBlur={() => setEmailFocused(false)}
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                />
            </div>
            <div className="input">
                <FaLock className={`icon ${passwordFocused ? "text-amber-500" : ""}`} />
                <input
                    type="password"
                    placeholder="Password"
                    onFocus={() => setPasswordFocused(true)}
                    onBlur={() => setPasswordFocused(false)}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
            </div>
            <div className="text-xs text-start pl-2">
                <a>Forgot</a> Password?
            </div>

            <button type="submit" className="button w-full">let's Gooo!</button>
            <div></div>
            <Button className="bg-white w-full h-50 text-amber-500"><p className="px-2">Continue with google</p><img src="/src/assets/icons/google.png" height={30} width={30} /></Button>
        </form>
    );
}

export default Login;
