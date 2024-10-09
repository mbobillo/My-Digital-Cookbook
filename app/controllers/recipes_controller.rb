class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if params[:recipe][:recipe_ingredients].present?
      ingredients_list = params[:recipe][:recipe_ingredients].split(',').map(&:strip).uniq

      ingredients_list.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        @recipe.ingredients << ingredient
      end
    end

    if params[:tags].present?
      @recipe.tags = Tag.where(id: params[:tags])
    end

    if @recipe.save
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

    if params[:recipe][:recipe_ingredients].present?
      ingredients_list = params[:recipe][:recipe_ingredients].split(',').map(&:strip).uniq

      @recipe.ingredients.clear
      ingredients_list.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        @recipe.ingredients << ingredient
      end
    end

    if params[:tags].present?
      @recipe.tags = Tag.where(id: params[:tags])
    end

    if params[:remove_all_images] == "true"
      @recipe.images.purge
    end

    if @recipe.update(recipe_params.except(:images))
      if params[:recipe][:images].present?
        params[:recipe][:images].each do |image|
          @recipe.images.attach(image)
        end
      end
      redirect_to recipe_path(@recipe, return_to: params[:return_to]), notice: 'Recette mise à jour avec succès'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.images.purge
    @recipe.destroy
    redirect_to recipes_path, status: :see_other, notice: "Recette supprimée avec succès"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :main_ingredient, :category_id, :source_url, images: [], tags: [])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
