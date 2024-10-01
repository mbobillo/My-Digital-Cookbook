class RecipeTagsController < ApplicationController

  def new
    @recipe_tag = RecipeTag.new
  end

  def index
    @recipe_tags = RecipeTag.all
  end

  def create
    @recipe_tag = RecipeTag.new
    @recipe = Recipe.find(params[:recipe_id])
    @tag = Tag.find(params[:tag_id])
  end
end
