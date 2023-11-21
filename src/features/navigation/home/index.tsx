import Billboard from './components/Billboard'
import Bottombar from './components/Bottombar'
import Lottie, { LottieRefCurrentProps } from "lottie-react"
import { useRef } from 'react'
import pcAnimationData from "../../../assets/animations/animation_lodk9dks.json"
import windowAnimationData from "../../../assets/animations/animation_lofmc6mj.json"
import './style.sass'
import Report from '../report'
import { useAuthState } from 'react-firebase-hooks/auth'
import Auth from '@/features/authentication/Index'
import { auth } from '@/firebase'
function Home() {
  const heroRef = useRef<LottieRefCurrentProps>(null)

  const [user] = useAuthState(auth);
  return (
    <>
      ${user ? <>
        <div className="home-container flex-col">
          <div className='sm:text-center md:flex md:justify-around flex-1 h-3/4'>
            <div className='home-sidebar flex-1'>
              <div className="billboard">
                <Billboard />
              </div>
              <div className='w-full flex justify-center'>
                <Report />
              </div>
            </div>
            <div className='animation-container lg:h-1/2 bg-amber-500 md:h-1/3'>
              <div className='window'>

              </div>

              <Lottie className="animation" onComplete={() => {
                heroRef.current?.goToAndPlay(35, true)
              }} lottieRef={heroRef} animationData={pcAnimationData} loop={false} />

            </div>

          </div>
          <div className='aboutus'>
            About Us
          </div>


        </div> </>: <>
          <Auth /></>} 

    </>

   )
}

export default Home