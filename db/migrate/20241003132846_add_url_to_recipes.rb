class AddUrlToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :source_url, :string
  end
end
