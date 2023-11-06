import React, { Component } from "react";
import axios from "axios";
import BootstrapSwitchButton from 'bootstrap-switch-button-react'

class RecipePage extends Component {
    constructor(props) {
        super(props);
        this.state = {
            recipe: null,
            favorite_recipes: []
        };
    }

    loadRandomRecipe() {
        this.loadRecipe(0)
    }

    loadRecipe(id) {
        axios
            .get("/recipes/" + id)
            .then((res) => {
                this.setState({ recipe: res.data.data });
            });
    }

    loadFavoriteRecipes() {
        axios
            .get("/recipes")
            .then((res) => {
                this.setState({ favorite_recipes: res.data.data });
            });
    }

    changeFavoriteStatus(status) {
        axios
            .put("/recipes/" + this.state.recipe.id, {favorite: status})
            .then((res) => {
                this.setState({recipe: res.data.data});
                this.actualizeFavoriteRecipes(res.data.data);
            });
    }

    actualizeFavoriteRecipes(recipe) {
        if (recipe.attributes.favorite) {
            this.setState({
                favorite_recipes: [...this.state.favorite_recipes, recipe]
            });
        } else {
            this.setState({
                favorite_recipes: this.state.favorite_recipes.filter(function(favoriteRecipe) {
                    return favoriteRecipe.id !== recipe.id
                })
            });
        }
    }

    componentDidMount() {
        this.loadRandomRecipe();
        this.loadFavoriteRecipes();
    }

    render() {
        return (
            <div>
                {this.navigationHTML()}
                <div className="container">
                    <div className="row">
                        <div className="col-sm">
                            {(this.state.recipe ? this.recipeHTML() : this.preloaderHTML())}
                        </div>
                        <div className="col-sm">
                            {(this.state.favorite_recipes ? this.favoriteRecipesHTML() : this.preloaderHTML())}
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    navigationHTML() {
        return (
            <nav className="navbar navbar-light bg-light justify-content-between">
                <a className="navbar-brand" style={{paddingLeft: "25px"}}>Restaurant</a>
                <button
                    type="button"
                    className="btn btn-primary"
                    onClick={() => this.loadRandomRecipe()}
                >Get Random</button>
                <form className="form-inline" style={{paddingRight: "25px"}}>
                    <a href="/users/sign_out" data-method="delete" rel="nofollow">Logout</a>
                </form>
            </nav>
        );
    }

    recipeHTML() {
        return (
            <div className="card">
                <img src={this.state.recipe.attributes.image_url} className="card-img-top" style={{"width" : "150px"}}/>
                <div className="card-body">
                    <div>
                        <h5 className="card-title">{this.state.recipe.attributes.name}</h5>
                        <div className="form-group row">
                            <label className="col-sm-2 col-form-label">
                                <strong>Favorite</strong>
                            </label>
                            <div className="col-sm-10">
                                <BootstrapSwitchButton
                                    checked={this.state.recipe.attributes.favorite}
                                    width={100}
                                    onlabel='Yes'
                                    offlabel='No'
                                    onstyle="success"
                                    offstyle="dark"
                                    onChange={(checked) => {
                                        this.changeFavoriteStatus(checked);
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                    <p className="card-text">{this.state.recipe.attributes.instructions}</p>
                </div>
            </div>
        );
    }

    favoriteRecipesHTML() {
        return (
            <div className="card">
                <div className="card-header">
                    Favorites
                </div>
                {(this.state.favorite_recipes.length > 0 ? this.recipesListHTML() : this.noRecordsHTML())}
            </div>
        );
    }

    recipesListHTML() {
        return (
            <ul className="list-group list-group-flush">
                {this.state.favorite_recipes.map((recipe) => {
                    return (
                        <li className="list-group-item" recipe={recipe} key={recipe.id}>
                            <span className="text-primary" role="button" onClick={() => this.loadRecipe(recipe.id)}>
                                {recipe.attributes.name}
                            </span>
                        </li>
                    );
                })}
            </ul>
        );
    }

    noRecordsHTML() {
        return (
            <p className="text-center" style={{marginTop: "15px"}}>No Records</p>
        );
    }

    preloaderHTML() {
        return (
            <div className="card" style={{"width" : "300px"}}>
                <div className="spinner-border text-primary" role="status">
                    <span className="sr-only"></span>
                </div>
            </div>
        );
    }
}

export default RecipePage;