class RecipeTag < ApplicationRecord
  belongs_to :recipes
  belongs_to :tags
end
