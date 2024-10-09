class RemoveCategoryFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :category, :string
  end
end
