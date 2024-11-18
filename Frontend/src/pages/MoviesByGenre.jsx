import React, { useState, useEffect } from 'react'
import axios from "axios";
import GenreSelector from "../component/GenreSelector";
import MovieList from "../component/MovieList";


export default function MoviesByGenre() {
    const [genres, setGenres] = useState([]);
    const [selectedGenre, setSelectedGenre] = useState(null);
    const [movies, setMovies] = useState([]);
  
    useEffect(() => {
      axios
        .get("http://localhost:3001/genres") // assuming we have an endpoint for genres
        .then((response) => setGenres(response.data))
        .catch((error) => console.error("Error fetching genres:", error));
    }, []);
  
    useEffect(() => {
      if (selectedGenre) {
        axios
          .get(`http://localhost:3001/movies/${selectedGenre}`)
          .then((response) => setMovies(response.data))
          .catch((error) => console.error("Error fetching movies:", error));
      }
    }, [selectedGenre]);
  
    return (
      <div className="App">
        <h1>Movie Browser</h1>
        <GenreSelector genres={genres} onSelectGenre={setSelectedGenre} />
        {selectedGenre && <MovieList movies={movies} />}
      </div>
    );
}
