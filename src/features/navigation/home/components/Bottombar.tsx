
import { FaGlobe} from "react-icons/fa"
import {AiOutlineSend} from "react-icons/ai"
import '../style.sass'
function Bottombar() {
  return (
    <>
          <div className="bottoms">
              <div className="profile-icon">
                  <FaGlobe/>
              </div>
              <div className="bottom-inputs">
                  <input type='text' className="bg-orang-500 flex-1" />
          <div className="button"><button><AiOutlineSend/></button></div>
              </div>
        </div>
    </>
  )
}

export default Bottombar