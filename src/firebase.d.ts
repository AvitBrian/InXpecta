// firebase.d.ts

declare module 'firebase' {
  import { Auth } from 'firebase/auth';

  // Export the types for the Firebase module.
  export interface Firebase {
    auth: Auth;
    // Add other Firebase services here if needed.
  }

  // Export the Firebase instance.
  const firebase: Firebase;
  export default firebase;
}

// Import and use Firebase in your TypeScript code
import firebase from 'firebase';

// Now you can access Firebase services like auth
const auth = firebase.auth;
