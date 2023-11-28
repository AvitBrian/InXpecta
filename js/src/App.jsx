import './App.sass'
import { Routes, Route } from 'react-router-dom'
import { BrowserRouter as Router } from 'react-router-dom'
import Auth from './features/authentication/Index.jsx'
import Navbar from './features/navigation/index.jsx'
import About from './features/navigation/components/About.jsx'
import Home from './features/navigation/home/index.jsx'
import Report from './features/navigation/report/index.jsx'
import Lost from './features/navigation/components/Lost.jsx'
import firebase from 'firebase/compat/app';
import 'firebase/compat/firestore';
import 'firebase/compat/auth';
import { useAuthState } from 'react-firebase-hooks/auth';
import { useCollectionData } from 'react-firebase-hooks/firestore';
import { AuthProvider } from './providers/auth_provider'

function App() {
  return (
    <>
     <AuthProvider>
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
     </AuthProvider>

    </>
  )
}




export default App
