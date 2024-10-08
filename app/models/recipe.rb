class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :tags, through: :recipe_tags
  has_many_attached :images
  belongs_to :category
  validates :category, presence: true
  validates :title, presence: true
  validates :main_ingredient, presence: true
end
