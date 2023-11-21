import React, { useEffect, useState } from 'react';
import { auth } from '../../firebase'
import { onAuthStateChanged } from "firebase/auth"


const AuthState = () => {
    const [authUser, setAuthUser] = useState<null | any>(null);

    useEffect(() => {
        const listen = onAuthStateChanged(auth, (user) => {
            if (user) {
                setAuthUser(user)
            } else {
                setAuthUser(null);
            }
        });
        return () => {
            listen();
        }
    }, []);
    return (
        <div>
            {authUser ? <p>{`Welcome back, ${authUser.displayName}!`}</p> : <p>Signed Out</p>}
        </div>
    );

};


export default AuthState