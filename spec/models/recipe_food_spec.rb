require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }
  let(:recipe) { Recipe.create(name: 'recipe name', description: 'recipe description', user:) }
  let(:food) { Food.create(name: 'food name', measurement_unit: 'Grams', price: 2.0, quantity: 3, user:) }
  let(:recipe_food) { RecipeFood.create(quantity: 2, recipe:, food:) }

  context '#measured_quantity' do
    it "should return a string with the recipe_food's quantity and the food's measurement unit" do
      expect(recipe_food.measured_quantity).to eq('2 Grams')
    end
  end

  context '#value' do
    it "should return a string with the total price of the recipe_food's quantity" do
      expect(recipe_food.value).to eq('$4.0')
    end
  end
end
