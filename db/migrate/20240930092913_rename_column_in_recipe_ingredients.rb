class RenameColumnInRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipe_ingredients, 'recipes_id', 'recipe_id'
    rename_column :recipe_ingredients, 'ingredients_id', 'ingredient_id'
  end
end
