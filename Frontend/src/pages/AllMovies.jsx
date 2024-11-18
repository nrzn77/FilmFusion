import React, { useState, useEffect } from 'react'
import axios from "axios";
import MovieList from "../component/MovieList";


export default function AllMovies() {
    const [movies, setMovies] = useState([]);
  
  
    useEffect(() => {
        axios
          .get(`http://localhost:3001/movies`)
          .then((response) => setMovies(response.data))
          .catch((error) => console.error("Error fetching movies:", error));
      
    }, []);
  
    return (
      <div className="App">
        <h1>Movies</h1>
        {movies && <MovieList movies={movies} />}
      </div>
    );
}
