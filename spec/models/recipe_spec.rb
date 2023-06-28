require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }
  let(:recipe) { Recipe.create(name: 'recipe name', description: 'recipe description', user: user) }

  context 'validations' do
    it('should be valid') do
      expect(recipe).to be_valid
    end

    it 'should be invalid when name is not present' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end

    it 'should be invalid when description is not present' do
      recipe.description = nil
      expect(recipe).not_to be_valid
    end
  end

  context 'methods' do
    before(:each) do
      food = Food.create(name: 'food name', measurement_unit: 'Units', price: 5.3, quantity: 2, user: user)
      RecipeFood.create(recipe: recipe, food: food, quantity: 1)
    end

    it 'should return the number of food items' do
      expect(recipe.total_food_items).to eq(1)
    end

    it 'should return the sum of food items' do
      expect(recipe.total_price).to eq('$5.3')
    end
  end
end
