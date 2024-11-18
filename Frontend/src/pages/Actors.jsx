import React, { useState, useEffect } from 'react'
import axios from "axios";

export default function Actors() {
    const [actors, setActors] = useState([]);
    const [newActor, setNewActor] = useState("");


    useEffect(() => {
        axios
            .get(`http://localhost:3001/actors`)
            .then((response) => {
                setActors(response.data)
                console.log(response.data)
            })
            .catch((error) => console.error("Error fetching actors:", error));

    }, []);

    const addNewActor = (e) => {
        e.preventDefault();
        // const formData = new FormData();
        // formData.append('actor', newActor); // Properly append data to FormData
        // console.log(newActor)

        axios
            .post(`http://localhost:3001/actors/add`, { actor: newActor })
            .then((response) => {
                console.log(response.data); // Log response data
                setActors((prev) => [...prev, newActor]);
                setNewActor("")
            })
            .catch((error) => {
                console.error("Error adding actor:", error); // Proper error logging
            });
    };


    return (
        <div className="App">
            <h1>Actors</h1><hr />
            {actors.length && actors.map((actor, index) => (
                <h2 key={index}>{actor.person_name}</h2>
            ))}
            <form onSubmit={e => addNewActor(e)}>
                <input placeholder='New Actor' value={newActor} onChange={e => setNewActor(e.target.value)} /><button>Add</button>
            </form>
        </div>
    );
}
