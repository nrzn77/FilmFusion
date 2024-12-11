const axios = require('axios');
const fs = require('fs')
require('dotenv').config();


const apiKey = process.env.OMDB_API_KEY;


const movieTitles = [
  'Fight Club',
  'Dead Poets Society',
  'The French Dispatch',
  '1917',
  'The Batman'
];

const Movies = [];


async function fetchMovieData(title) {
  const url = `http://www.omdbapi.com/?apikey=${apiKey}&t=${encodeURIComponent(title)}`;
  try {
    const response = await axios.get(url);
    const movieData = response.data;

    if (movieData.Response === 'True') {
      // console.log(`\nFull JSON Data for "${title}":`);
      // console.log(JSON.stringify(movieData, null, 2));  
      Movies.push(movieData);
    } else {
      console.log(`Movie "${title}" not found.`);
    }
  } catch (error) {
    console.error(`Error fetching data for "${title}":`, error.message);
  }
}

const WriteJSONToFile = (data) => {
  fs.writeFile("Movies.json", JSON.stringify(data, null, 2), function (err) {
    if (err) throw err;
    console.log('File saved in ./Movies.json');
  }
  );
}

async function fetchAllMovies() {
  index = 0
  for(let title in movieTitles){
    await fetchMovieData(title);
    index += 1;
    console.log(index, '/', movieTitles.length)
  }
  WriteJSONToFile(Movies)
}


fetchAllMovies();
