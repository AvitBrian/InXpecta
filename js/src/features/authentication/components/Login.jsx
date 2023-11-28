import { FaLock, FaEnvelope } from "react-icons/fa";
import { auth, signInWithGooglePopup, provider} from "../../../firebase";
import { signInWithEmailAndPassword } from "firebase/auth";
import "../style.sass";
import { useState } from "react";
import { Button } from "../../../components/ui/button";

function Login() {
  const [emailFocused, setEmailFocused] = useState(false);
  const [passwordFocused, setPasswordFocused] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const logIn = (e) => {
    e.preventDefault();
    signInWithEmailAndPassword(auth, email, password)
      .then((userCredentials) => {
        console.log(userCredentials);
      })
      .catch((error) => console.error(error));
  };
  const googleSignIn = () => {
 signInWithGooglePopup(auth, provider)
  };



  return (
    <>
      <form className="login-container" onSubmit={logIn}>
        <p className="text-xs text-start mt-1 overline">Let's Sign you in...</p>
        <div className="input">
          <FaEnvelope
            className={`icon ${emailFocused ? "text-amber-500" : ""}`}
          />
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
          <FaLock
            className={`icon ${passwordFocused ? "text-amber-500" : ""}`}
          />
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

        <button type="submit" className="button w-full" >
          let's Gooo!
        </button>
        <div className="h-px border-1 my-1 bg-white"></div>
      </form>
      <Button className="bg-white w-full h-25 text-amber-500 flex justify-start"           onClick={googleSignIn}
>
        <img
          src="/src/assets/icons/google.png"
          height={20}
          width={20}
        />
        <p className="text-xs px-2">Continue with google</p>
      </Button>
      <div className="h-1"></div>
      <Button className="bg-blue-700 w-full h-25 text-white flex justify-start">
        <img src="/src/assets/icons/facebook.png" height={20} width={20} />
        <p className="text-xs px-2">Continue with facebook</p>
      </Button>
    </>
  );
}
export default Login;
