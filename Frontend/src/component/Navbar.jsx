import React from 'react'
import { Link } from 'react-router-dom'

export default function Navbar() {
  return (
    <nav> 
        <ul>
            <li><Link to='/'>Home</Link></li>
            <li><Link to='/genre-search'>Genres</Link></li>
            <li><Link to='/actors'>Actors</Link></li>
        </ul>
    </nav>
  )
}
