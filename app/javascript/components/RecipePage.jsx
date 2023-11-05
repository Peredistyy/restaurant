import React, { Component } from "react";
import axios from "axios";

class RecipePage extends Component {
    random = () => {
        this.loadRandomRecipe();
    }

    constructor(props) {
        super(props);
        this.state = {
            recipe: null,
        };
    }

    loadRandomRecipe() {
        axios
            .get("/recipes/0")
            .then((res) => {
                this.setState({ recipe: res.data.data });
            });
    }

    componentDidMount() {
        this.loadRandomRecipe();
    }

    render() {
        return (
            <div>
                {(
                    this.state.recipe
                    ? <div>{this.state.recipe.attributes.name}</div>
                    : <div>Loading...</div>
                )}
                <button onClick={this.random}>GET</button>
            </div>
        );
    }
}

export default RecipePage;