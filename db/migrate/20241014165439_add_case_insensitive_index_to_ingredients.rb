class AddCaseInsensitiveIndexToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_index :ingredients, 'lower(name)', unique: true
  end
end
