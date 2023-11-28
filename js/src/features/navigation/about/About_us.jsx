import React from 'react'
import { Link } from 'react-router-dom'

function AboutUsSection() {
  return (
    <>
    <div id="about-us" className="about-us-section text-brown-500 text-left">
      <p>
        Welcome to Inxpecta , a platform dedicated to combating false information on the internet.
      </p>

      <h1 className='transition ease-in-out delay-150 text-brown-500 hover:underline-offset-5 hover:text-indigo-500 duration-300 '>Our Vision</h1>
      <p>
        At inXpecta, we envision a world where Everyone can access accurate and unbiased information fostering critical thinking and informed decision-making.
      </p>
      <h2>Devs</h2>
        <a href="https://www.linkedin.com/in/avitbrian/" target='_blank' className='text-[1.1rem]'>Avit Brian</a> - Software Engineering Student at the African Leadership University
      <h3>Interactive Features</h3>
      <p>
        Explore and interact with our data to understand the impact of false information. 
      </p>
      <ul>
        <li>
          <Link to="/report" className='text-[1.4rem]'>Report notorious sources</Link>
        </li>

        {/* Adds more interactive features as needed */}
      </ul>

      <p>
        Join us in the fight against misinformation! If you have any questions or suggestions, feel free to <a href="mailto:b.mugisha2@gmail.com" target='_blank' className='text-[2rem]'><br></br>contact us</a>.
      </p>
    </div>
    </>
  )
}

export default AboutUsSection