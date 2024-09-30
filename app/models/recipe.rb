class Recipe < ApplicationRecord
  has_many :ingredients, through: :recipe_ingredients
  has_many :tags, through: :recipe_tags
  belongs_to :category
  validates :category, presence: true
  validates :title, presence: true
  validates :main_ingredient, presence: true
end
