class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :delete_all

  validates :name, presence: true
  validates :description, presence: true

  def total_food_items
    recipe_foods.count
  end

  def total_price
    "$#{recipe_foods.includes(:food).reduce(0) { |sum, item| sum + (item.food.price * item.quantity) }}"
  end
end
