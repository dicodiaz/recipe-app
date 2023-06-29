require 'rails_helper'

RSpec.describe 'General Shopping List', type: :system do
  before(:each) do
    @user1 = User.new(name: 'Jaime', email: 'jaime@gmail.com', password: 'test123')
    login_as(@user1, scope: :user)
  end

  describe 'index page' do
    before(:each) do
      @user1 = User.create(name: 'Jaime', email: 'jaime@gmail.com', password: 'test123')
      @user2 = User.create(name: 'test', email: 'test@gmail.com', password: 'test123')
      @food1 = Food.create(name: 'Mondongo', measurement_unit: 'Pounds', price: 5.4, quantity: 2, user: @user1)
      @food2 = Food.create(name: 'Mandarina', measurement_unit: 'Units', price: 1.6, quantity: 2, user: @user2)
      @recipe1 = Recipe.create(name: 'Mondongo con arroz', description: 'Mondongo con arroz', user: @user1)
      @food_recipe1 = RecipeFood.create(quantity: 4, recipe: @recipe1, food: @food1)
      login_as(@user1, scope: :user)
      visit "/general_shopping_list?recipe_id=#{@recipe1.id}"
    end

    it 'renders the correct template' do
      expect(page).to have_content("Shopping List for #{@recipe1.name}")
    end

    it 'shows the amount of food items to buy' do
      expect(page).to have_content("Amount of food items to buy: #{@counter}")
    end

    it 'shows the total value of food needed' do
      expect(page).to have_content("Total value of food needed: $#{@food_price}")
    end

    it 'redirects back when clicking on Go Back' do
      click_on 'Go Back'
      expect(page).to have_current_path("/recipes/#{@recipe1.id}")
    end
  end
end
