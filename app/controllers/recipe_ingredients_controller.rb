class RecipeIngredientsController < ApplicationController
  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def index
    @recipe_ingredients = RecipeIngredient.all
  end

  def create
    @recipe_ingredient = RecipeIngredient.new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.find(parmas[:ingredient_id])
  end

end
