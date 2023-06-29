require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    @user2 = User.create(name: 'user2 name', email: 'user2_email@mail.com', password: 'user2_password')
    @recipe = Recipe.create(name: 'recipe name', description: 'recipe description', user: @user)
    @recipe2 = Recipe.create(name: 'recipe2 name', description: 'recipe2 description', user: @user2)
    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before(:each) { visit recipes_path }

    it "displays a 'New recipe' button that redirects to the new page" do
      click_button('New recipe')
      expect(page).to have_current_path(new_recipe_path)
    end

    it "displays the recipe's name and description" do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
    end

    it "does not display other users' recipes' information" do
      expect(page).not_to have_content(@recipe2.name)
      expect(page).not_to have_content(@recipe2.description)
    end

    it "displays a 'Remove' button that deletes the recipe" do
      click_button('Remove')
      expect(page).to have_content('Recipe was successfully destroyed.')
      expect(page).not_to have_content(@recipe.name)
    end
  end

  describe 'new page' do
    before(:each) { visit new_recipe_path }

    it 'displays all expected labels' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Preparation time')
      expect(page).to have_content('Cooking time')
      expect(page).to have_content('Description')
      expect(page).to have_content('Public')
    end

    it "displays a 'Create recipe' button that creates the recipe and redirects to the show page" do
      fill_in('recipe_name', with: 'recipe name')
      fill_in('recipe_description', with: 'recipe description')
      click_button('Create Recipe')
      sleep(1)
      expect(page).to have_current_path(recipe_path(Recipe.last))
    end

    it "displays a 'Back to recipes' button that redirects to the index page" do
      click_button('Back to recipes')
      expect(page).to have_current_path(recipes_path)
    end
  end

  describe 'show page' do
    before(:each) { visit recipe_path(@recipe) }

    it "displays the recipe's name and description" do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
    end

    it "displays the recipe's preparation and cooking time when they're present" do
      expect(page).not_to have_content('Preparation time')
      @recipe.update(preparation_time: 'recipe preparation time', cooking_time: 'recipe cooking time')
      refresh
      expect(page).to have_content("Cooking time: #{@recipe.cooking_time}")
    end

    it "displays a checked or unchecked disabled 'Public' checkbox" do
      expect(page).to have_field('public_switch', type: 'checkbox', disabled: true, unchecked: true)
      @recipe.update(public: true)
      refresh
      expect(page).to have_field('public_switch', type: 'checkbox', disabled: true, checked: true)
    end

    it "displays a 'Generate shopping list' button that redirects to /general_shopping_list" do
      click_button('Generate shopping list')
      expect(page).to have_current_path("/general_shopping_list?recipe_id=#{@recipe.id}")
    end

    it "displays an 'Add ingredient' button that redirects to recipe_foods/new with the recipe's id query param" do
      click_button('Add ingredient')
      expect(page).to have_current_path(new_recipe_food_path(recipe_id: @recipe.id))
    end

    context 'ingredients table' do
      before(:each) do
        @food = Food.create(name: 'food name', measurement_unit: 'Grams', price: 2.0, quantity: 3, user: @user)
        @recipe_food = RecipeFood.create(quantity: 1, recipe: @recipe, food: @food)
        refresh
      end

      it "displays an associated recipe_food's information" do
        expect(page).to have_content('Food')
        expect(page).to have_content('Quantity')
        expect(page).to have_content('Value')
        expect(page).to have_content('Actions')
        expect(page).to have_content(@recipe_food.food.name)
        expect(page).to have_content(@recipe_food.measured_quantity)
        expect(page).to have_content(@recipe_food.value)
      end

      it "displays a disabled 'Modify' button for an ingredient" do
        expect(page).to have_button('Modify', disabled: true)
      end

      it "displays a 'Remove' button that deletes the ingredient and refreshes the page" do
        click_button('Remove')
        expect(page).to have_current_path(recipe_path(@recipe))
        expect(page).to have_content('Ingredient was successfully destroyed.')
        expect(page).not_to have_content(@recipe_food.food.name)
      end
    end
  end
end
