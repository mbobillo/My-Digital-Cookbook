class RenameColumnInRecipeTags < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipe_tags, 'recipes_id', 'recipe_id'
    rename_column :recipe_tags, 'tags_id', 'tag_id'
  end
end
