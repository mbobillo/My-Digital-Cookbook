class CreateRecipeTags < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_tags do |t|
      t.references :recipes, null: false, foreign_key: true
      t.references :tags, null: false, foreign_key: true

      t.timestamps
    end
  end
end
