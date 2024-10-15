class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if params[:recipe][:recipe_ingredients].present?
      ingredients_list = params[:recipe][:recipe_ingredients].split(',').map(&:strip).map(&:downcase).uniq

      ingredients_list.each do |ingredient_name|
        ingredient = Ingredient.where('LOWER(name) = ?', ingredient_name.downcase).first_or_initialize
        ingredient.name = ingredient_name if ingredient.new_record?
        ingredient.save!
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
    @recipes = Recipe.all.order('LOWER(title)')

    if params[:category].present?
      @selected_category = Category.find(params[:category])
      @recipes = @recipes.where(category_id: params[:category])
    else
      @selected_category = nil
    end

    @other_recipes = Recipe.none

    if params[:main_ingredient].present?
      searched_ingredient = params[:main_ingredient].downcase
      @main_ingredient = params[:main_ingredient]
      @recipes = @recipes.where("lower(main_ingredient) LIKE ?", "%#{searched_ingredient}%")
      @other_recipes = Recipe.joins(:ingredients)
        .where("lower(ingredients.name) LIKE ?", "%#{searched_ingredient}%")
        .where.not(id: @recipes.pluck(:id))
        .distinct
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
      ingredients_list = params[:recipe][:recipe_ingredients].split(',').map(&:strip).map(&:downcase).uniq

      @recipe.ingredients.clear
      ingredients_list.each do |ingredient_name|
        ingredient = Ingredient.where('LOWER(name) = ?', ingredient_name).first_or_create(name: ingredient_name)
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
