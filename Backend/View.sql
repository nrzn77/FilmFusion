CREATE VIEW movie_details_view AS
SELECT 
    m.movie_id, 
    m.title, 
    m.budget, 
    m.release_date, 
    m.revenue, 
    m.runtime, 
    m.votes_avg, 
    m.votes_count,
    GROUP_CONCAT(DISTINCT cnt.country_name SEPARATOR ', ') AS countries,
    GROUP_CONCAT(DISTINCT lng.language_name SEPARATOR ', ') AS languages,
    GROUP_CONCAT(DISTINCT g.genre_name SEPARATOR ', ') AS genres,
    GROUP_CONCAT(DISTINCT k.keyword_name SEPARATOR ', ') AS keywords,
    GROUP_CONCAT(DISTINCT pc.company_name SEPARATOR ', ') AS companies,
    p.person_name AS cast_member, 
    cast_tbl.character_name, 
    cast_tbl.cast_order,
    crew.person_name AS crew_member, 
    d.department_name, 
    crew_tbl.job
FROM 
    movie m
LEFT JOIN 
    movie_genre mg ON m.movie_id = mg.movie_id
LEFT JOIN 
    genre g ON mg.genre_id = g.genre_id
LEFT JOIN 
    production_country pcountry ON m.movie_id = pcountry.movie_id
LEFT JOIN 
    country cnt ON pcountry.country_id = cnt.country_id
LEFT JOIN 
    movie_languages ml ON m.movie_id = ml.movie_id
LEFT JOIN 
    language lng ON ml.language_id = lng.language_id
LEFT JOIN 
    movie_keywords mk ON m.movie_id = mk.movie_id
LEFT JOIN 
    keyword k ON mk.keyword_id = k.keyword_id
LEFT JOIN 
    movie_company mcomp ON m.movie_id = mcomp.movie_id
LEFT JOIN 
    production_company pc ON mcomp.company_id = pc.company_id
LEFT JOIN 
    movie_cast cast_tbl ON m.movie_id = cast_tbl.movie_id
LEFT JOIN 
    person p ON cast_tbl.person_id = p.person_id
LEFT JOIN 
    movie_crew crew_tbl ON m.movie_id = crew_tbl.movie_id
LEFT JOIN 
    person crew ON crew_tbl.person_id = crew.person_id
LEFT JOIN 
    department d ON crew_tbl.department_id = d.department_id
GROUP BY 
    m.movie_id, 
    p.person_name, 
    cast_tbl.character_name, 
    cast_tbl.cast_order, 
    crew.person_name, 
    d.department_name, 
    crew_tbl.job
ORDER BY 
    m.title, 
    cast_tbl.cast_order;


