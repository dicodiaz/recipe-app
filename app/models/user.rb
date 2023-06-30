class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :foods
  has_many :recipes

  def select_foods
    foods.each_with_object([]) { |food, array| array.push(["#{food.name} (#{food.measurement_unit})", food.id]) }
  end
end
