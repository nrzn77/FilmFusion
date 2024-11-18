import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Navbar from "./component/Navbar";
import AllMovies from "./pages/AllMovies";
import MoviesByGenre from "./pages/MoviesByGenre";
import Actors from "./pages/Actors";
import "./App.css";

function App() {
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route path="/" element={<AllMovies />} />
        <Route path="/genre-search" element={<MoviesByGenre />} />
        <Route path="/actors" element={<Actors />} />
      </Routes>
    </Router>
  )
}

export default App;
