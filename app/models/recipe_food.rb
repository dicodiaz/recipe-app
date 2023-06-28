class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  def measured_quantity
    "#{quantity} #{food.measurement_unit}"
  end

  def value
    "$#{quantity * food.price}"
  end
end
