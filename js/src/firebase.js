import { initializeApp } from "firebase/app";
import { signInWithPopup, GoogleAuthProvider, getAuth } from "firebase/auth";
import firebase from "firebase/compat/app";
import { getFirestore } from "firebase/firestore";

// https://firebase.google.com/docs/web/setup#available-libraries

const firebaseConfig = {
    apiKey: "AIzaSyAGkdm360eJWyEUTpsqK44Es-m63gAa61s",
    authDomain: "inxpecta-93c53.firebaseapp.com",
    projectId: "inxpecta-93c53",
    storageBucket: "inxpecta-93c53.appspot.com",
    messagingSenderId: "443516795908",
    appId: "1:443516795908:web:56eb5acd3ec918b0934951",
    measurementId: "G-LMX0S0XRNV"
};

// Initialize Firebase
const app = firebase.initializeApp(firebaseConfig);
// Initialize Firebase Authentication
const auth = getAuth(app);

// initialize firestore
// const firestore = firebase.firestore
const firestore = getFirestore(app);

// Initialize Firebase Auth provider

const provider = new GoogleAuthProvider();

// whenever a user interacts with the provider, we force them to select an account

export const signInWithGooglePopup = () => signInWithPopup(auth, provider);
export { auth, provider, firestore };
