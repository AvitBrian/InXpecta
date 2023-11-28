import Billboard from "./components/Billboard";
import Bottombar from "./components/Bottombar";
import Lottie from "lottie-react";
import { useRef } from "react";
import pcAnimationData from "../../../assets/animations/animation_lodk9dks.json";
import workAnimationData from "../../../assets/animations/animation_working.json";
import "./style.sass";
import Report from "../report";
import { useAuthState } from "react-firebase-hooks/auth";
import Auth from "../../authentication/Index";
import { auth } from "../../../firebase";
import Sources from "../../sources/sources";
import DonutChart from "./components/charts";
import AboutUsSection from "../about/About_us";

function Home() {
  const heroRef = useRef(null);
  const srcs = Sources().slice(0, 5);

  const [user] = useAuthState(auth);
  return (
    <>
      {user ? (
        <>
          {/* home container */}
          <div className="home_container mt-14 p-5 relative">
            {/* billboard container*/}
            <div className="billboard_container ">
              <div className="m-1 overflow-hidden">
              <div className="billboard">
                <Billboard />
              </div>
              </div>
            </div>

            {/* animation container */}
            <div className="animation_container bg-amber-500">
              <Lottie
                className="animation "
                onComplete={() => {
                  heroRef.current?.goToAndPlay(35, true);
                }}
                lottieRef={heroRef}
                animationData={pcAnimationData}
                loop={false}
              />
            </div>
            {/* chart-container */}
            <div className="chart_container bg-amber-300">
              <DonutChart data={srcs} className="chart "/>
            </div>

            {/* about us container */}
            <div className="about_us_container ">
              <div className="about_us_section">
                <AboutUsSection />
              </div>
            </div>

          </div>
          <div className="animation_container  absolute bottom-0 right-4">
              <Lottie
                className=" h-52 w-720"
                lottieRef={heroRef}
                animationData={workAnimationData}
                loop={true}
              />
            </div>
        </>
      ) : (
        <>
          <Auth />
        </>
      )}
    </>
  );
}

export default Home;
