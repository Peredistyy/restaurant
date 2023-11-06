class RecipesController < ApplicationController
  def index
    scope = Recipe.only_favorite_by(current_user).last(50)

    render json: RecipeShortSerializer.new(scope, {params: {current_user: current_user}}).serializable_hash
  end
  def show
    recipe_id = params[:id].to_i || 0
    recipe = recipe_id == 0 ? recipe_service.random : Recipe.find(recipe_id)

    render json: RecipeSerializer.new(recipe, {params: {current_user: current_user}}).serializable_hash
  end

  def update
    recipe = Recipe.find(params[:id])

    recipe.mark_as_favorite(current_user) if ['true', true].include?(params[:favorite])
    recipe.unmark_as_favorite(current_user) if ['false', false].include?(params[:favorite])

    render json: RecipeSerializer.new(recipe, {params: {current_user: current_user}}).serializable_hash
  end

  private

  def recipe_service
    @recipe_service ||= RecipeService.new
  end
end
