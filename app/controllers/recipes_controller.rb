class RecipesController < ApplicationController
  before_action :set_recipe, only: [show, edit, destroy]

  def new
    @recipe = Recipe.new
  end

  def index
    @recipes = Recipe.all
    if params[:category].present?
      @recipes = @recipes.where(category_id: params[:category])
    end

    if params[:main_ingredient].present?
      @recipes = @recipes.where("main_ingredient ILIKE ?", "%#{params[:main_ingredient]}%")
    end

    if params[:tags].present?
      @recipes = @recipes.joins(:tags).where(tags: { id: params[:tags] })
    end
  end

  def show
    @category = Recipe.find(params[:category_id])
  end

  def create
    @recipe = Recipe.new(recipe_params)

    ingredients_list = params[:recipe][:ingredients].split(',').map(&:strip).uniq

    if @recipe.save
      ingredients_list.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)

        RecipeIngredient.create(recipe: @recipe, ingredient: ingredient)
      end

      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe.upate(params[:recipe])
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, status: :see_other
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :main_ingredient, :category_id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
