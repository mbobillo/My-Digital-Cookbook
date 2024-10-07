class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if params[:recipe_ingredients].present?
      @ingredients_list = params[:recipe_ingredients].split(',').map(&:strip).uniq
    else
      @ingredients_list = []
    end

    Rails.logger.debug "Ingredients list: #{@ingredients_list.inspect}"

    if @recipe.save
      @ingredients_list.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        RecipeIngredient.create(recipe: @recipe, ingredient: ingredient)
      end

      redirect_to recipes_path, notice: 'Recette créée avec succès'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @recipes = Recipe.all

    if params[:category].present?
      @selected_category = Category.find(params[:category])
      @recipes = @recipes.where(category_id: params[:category])
    else
      @selected_category = nil
    end

    if params[:main_ingredient].present?
      @recipes = @recipes.where("main_ingredient ILIKE ?", "%#{params[:main_ingredient]}%")
      @main_ingredient = params[:main_ingredient]
    end

    if params[:ingredients].present?
      @ingredients_list = Ingredient.where(id: params[:ingredients])
      @recipes = @recipes.joins(:ingredients).where(ingredients: { id: params[:ingredients] })
    else
      @ingredients_list = []
    end

    if params[:tags].present?
      @selected_tags = Tag.where(id: params[:tags])
      @recipes = @recipes.joins(:tags).where(tags: { id: params[:tags] })
    else
      @selected_tags = []
    end
  end

  def show
    @selected_category = @recipe.category
    @main_ingredient = @recipe.main_ingredient
    @ingredients_list = @recipe.ingredients
    @selected_tags = @recipe.tags
  end

  def edit
  end

  def update
    @recipe.upate(params[:recipe])
    redirect_to recipes_path(@recipe), notice: 'Recette modifiée avec succès'
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, status: :see_other, notice: "Recette supprimée avec succès"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :main_ingredient, :category_id, :recipe_ingredients, :source_url, images: [], tags: [])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
