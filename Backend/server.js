require('dotenv').config();
const express = require('express');  // Replace require with import
const cors = require('cors');
const mysql = require('mysql2');
const db = require('./DataBaseConnection');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
    res.send("Welcome to FilmFusion!")
})

// API Endpoint to Fetch Data from the View
app.get('/movies', (req, res) => {
    const query = 'SELECT * FROM movie_details_view';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error executing query:', err.message);
            res.status(500).send('Error fetching movies data');
            return;
        }
        res.json(results); // Send results as JSON
    });
});

// Endpoint to fetch all genres
app.get('/genres', (req, res) => {
    const query = `SELECT genre_id, genre_name FROM genre`;
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching genres:', err);
            res.status(500).send('Server Error');
            return;
        }
        res.json(results);
    });
});

app.get('/actors', (req, res) => {
    const query = `select * from person;`
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching actors:', err);
            res.status(500).send('Server Error');
            return;
        }
        res.json(results);
    });
});

// Endpoint to fetch full movie details based on genre ID
app.get('/movies/:genreId', (req, res) => {
    const genreId = req.params.genreId;

    const query = `
        SELECT m.movie_id, m.title, m.budget, m.poster_url, m.release_date, m.revenue, m.runtime, m.votes_avg, m.votes_count,
               GROUP_CONCAT(DISTINCT cnt.country_name SEPARATOR ', ') AS countries,
               GROUP_CONCAT(DISTINCT lng.language_name SEPARATOR ', ') AS languages,
               GROUP_CONCAT(DISTINCT g.genre_name SEPARATOR ', ') AS genres,
               GROUP_CONCAT(DISTINCT k.keyword_name SEPARATOR ', ') AS keywords,
               GROUP_CONCAT(DISTINCT pc.company_name SEPARATOR ', ') AS companies,
               p.person_name AS cast_member, cast_tbl.character_name, cast_tbl.cast_order,
               crew.person_name AS crew_member, d.department_name, crew_tbl.job
        FROM movie m
        LEFT JOIN movie_genre mg ON m.movie_id = mg.movie_id
        LEFT JOIN genre g ON mg.genre_id = g.genre_id
        LEFT JOIN production_country pcountry ON m.movie_id = pcountry.movie_id
        LEFT JOIN country cnt ON pcountry.country_id = cnt.country_id
        LEFT JOIN movie_languages ml ON m.movie_id = ml.movie_id
        LEFT JOIN language lng ON ml.language_id = lng.language_id
        LEFT JOIN movie_keywords mk ON m.movie_id = mk.movie_id
        LEFT JOIN keyword k ON mk.keyword_id = k.keyword_id
        LEFT JOIN movie_company mcomp ON m.movie_id = mcomp.movie_id
        LEFT JOIN production_company pc ON mcomp.company_id = pc.company_id
        LEFT JOIN movie_cast cast_tbl ON m.movie_id = cast_tbl.movie_id
        LEFT JOIN person p ON cast_tbl.person_id = p.person_id
        LEFT JOIN movie_crew crew_tbl ON m.movie_id = crew_tbl.movie_id
        LEFT JOIN person crew ON crew_tbl.person_id = crew.person_id
        LEFT JOIN department d ON crew_tbl.department_id = d.department_id
        WHERE mg.genre_id = ?
        GROUP BY m.movie_id, p.person_name, cast_tbl.character_name, cast_tbl.cast_order, crew.person_name, d.department_name, crew_tbl.job
        ORDER BY m.title, cast_tbl.cast_order;
    `;

    db.query(query, [genreId], (err, results) => {
        if (err) {
            console.error('Error fetching full movie details:', err);
            res.status(500).send('Server Error');
            return;
        }
        res.json(results);
    });
});


// Middleware for parsing JSON request body
app.use(express.json());

app.post('/actors/add', (req, res) => {
    const { actor } = req.body;
    console.log(req.body)

    if (!actor) {
        return res.status(400).send('Actor name is required');
    }

    const query = `INSERT INTO person (person_name) VALUES (?)`;

    db.query(query, [actor], (err, results) => {
        if (err) {
            console.error('Error adding actor:', err);
            return res.status(500).send('Server Error');
        }
        res.status(201).json({ message: 'Actor added successfully', actorId: results.insertId });
    });
});


// Start the server
app.listen(process.env.APP_PORT, () => console.log('Server running on port ' + process.env.APP_PORT));
