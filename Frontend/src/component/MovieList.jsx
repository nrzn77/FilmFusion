import React from "react";
import "./MovieList.css"; // Make sure to create this CSS file for styling

function MovieList({ movies }) {
  return (
    <div className="movie-list">
      {movies.map((movie) => (
        <div key={movie.movie_id} className="movie-card">
          <h2>{movie.title}</h2>
          <p>
            <strong>Budget:</strong> ${movie.budget}
          </p>
          <p>
            <strong>Release Date:</strong> {movie.release_date}
          </p>
          <p>
            <strong>Revenue:</strong> ${movie.revenue}
          </p>
          <p>
            <strong>Runtime:</strong> {movie.runtime} minutes
          </p>
          <p>
            <strong>Votes Avg:</strong> {movie.votes_avg}
          </p>
          <p>
            <strong>Countries:</strong> {movie.countries}
          </p>
          <p>
            <strong>Languages:</strong> {movie.languages}
          </p>
          <p>
            <strong>Genres:</strong> {movie.genres}
          </p>
          <p>
            <strong>Keywords:</strong> {movie.keywords}
          </p>
          <h3>Cast</h3>
          <ul>
            <li>
              {movie.cast_member} as {movie.character_name} (Order:{" "}
              {movie.cast_order})
            </li>
          </ul>
          <h3>Crew</h3>
          <ul>
            <li>
              {movie.crew_member} - {movie.department_name} ({movie.job})
            </li>
          </ul>
        </div>
      ))}
    </div>
  );
}

export default MovieList;
