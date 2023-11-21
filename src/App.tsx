import './App.sass'
import { Routes, Route } from 'react-router-dom'
import { BrowserRouter as Router } from 'react-router-dom'
import Auth from './features/authentication/Index.tsx'
import Navbar from './features/navigation/index.tsx'
import About from './features/navigation/components/About.tsx'
import Home from './features/navigation/home/index.tsx'
import Report from './features/navigation/report/index.tsx'
import Lost from './features/navigation/components/Lost.tsx'
import firebase from 'firebase/compat/app';
import 'firebase/compat/firestore';
import 'firebase/compat/auth';
import { useAuthState } from 'react-firebase-hooks/auth';
import { useCollectionData } from 'react-firebase-hooks/firestore';

// const firebaseConfig = {
//   apiKey: "AIzaSyAGkdm360eJWyEUTpsqK44Es-m63gAa61s",
//   authDomain: "inxpecta-93c53.firebaseapp.com",
//   projectId: "inxpecta-93c53",
//   storageBucket: "inxpecta-93c53.appspot.com",
//   messagingSenderId: "443516795908",
//   appId: "1:443516795908:web:6fa903d49394ddc0934951",
//   measurementId: "G-6KPW74R1NN"
// };

// firebase.initializeApp(firebaseConfig);
// const auth = firebase.auth();
// const firestore = firebase.firestore();

function App() {

  return (
    <>
      <Router>
        <Navbar />
        <Routes>
          <Route path='/' element={<Home />}></Route>
          <Route path='/report' element={<Report />}></Route>
          <Route path='/about' element={<About />}></Route>
          <Route path='/auth' element={<Auth />}></Route>
          <Route path='*' element={<Lost />} />
        </Routes>
      </Router>

    </>
  )
}


export default App
