import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import RecipePage from "../components/RecipePage";

export default (
    <Router>
        <Routes>
            <Route path="/" element={<RecipePage />} />
        </Routes>
    </Router>
);