import React from "react";

function GenreSelector({ genres, onSelectGenre }) {
  return (
    <div>
      <label>Select Genre:</label>
      <select onChange={(e) => onSelectGenre(e.target.value)}>
        <option value="">--Choose Genre--</option>
        {genres.map((genre) => (
          <option key={genre.genre_id} value={genre.genre_id}>
            {genre.genre_name}
          </option>
        ))}
      </select>
    </div>
  );
}

export default GenreSelector;
