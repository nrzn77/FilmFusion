import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

import MoviesByGenre from "./pages/MoviesByGenre";
import "./App.css";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<MoviesByGenre />} />
      </Routes>
    </Router>
  )
}

export default App;
