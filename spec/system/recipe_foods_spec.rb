require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :system do
  describe 'new page' do
    before(:each) do
      @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
      @food = Food.create(name: 'food name', measurement_unit: 'Grams', price: 2.0, quantity: 3, user: @user)
      @food2 = Food.create(name: 'food2 name', measurement_unit: 'Units', price: 3.0, quantity: 2, user: @user)
      @recipe = Recipe.create(name: 'recipe name', description: 'recipe description', user: @user)
      login_as(@user, scope: :user)
      visit new_recipe_food_path(recipe_id: @recipe.id)
    end

    it 'displays all expected labels' do
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Recipe')
      expect(page).to have_content('Choose your ingredient:')
    end

    it "displays a disabled recipe text field with the recipe's name" do
      expect(page).to have_field('recipe_food_recipe', type: 'text', disabled: true, with: @recipe.name)
    end

    it 'includes a recipe_id hidden field' do
      expect(page).to have_field('recipe_food_recipe_id', type: 'hidden')
    end

    it "displays a ingredient select field with the user's foods options" do
      expect(page).to have_select('recipe_food_food_id', options: @user.select_foods.map(&:first))
    end

    it "displays an 'Add ingredient to recipe' button that creates it and redirects to the recipe's show page" do
      fill_in('recipe_food_quantity', with: '1')
      click_button('Add ingredient to recipe')
      sleep(1)
      # redirects to the recipes path when there's no session information
      expect(page).to have_current_path(recipes_path)
      visit recipe_path(@recipe)
      expect(page).to have_content(RecipeFood.last.food.name)
    end

    it "displays a 'Create new ingredient' button that redirects to the food's new page" do
      click_button('Create new ingredient')
      expect(page).to have_current_path(new_food_path)
    end

    it "displays a 'Back to recipe' button that redirects to the recipe's show page" do
      click_button('Back to recipe')
      expect(page).to have_current_path(recipe_path(@recipe))
    end
  end
end
