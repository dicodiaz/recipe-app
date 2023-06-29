class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :delete_all

  validates :name, presence: true
  validates :description, presence: true

  def total_food_items
    recipe_foods.count
  end

  def total_price
    sum = 0
    Recipe.includes(:recipe_foods).find(id).recipe_foods.each { |item| sum += (item.food.price * item.quantity) }
    "$#{sum}"
  end
end
