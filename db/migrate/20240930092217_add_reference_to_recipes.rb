class AddReferenceToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :category, null: false, foreign_key: true
  end
end
