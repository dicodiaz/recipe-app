require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before(:each) do
      @user2 = User.create(name: 'user2 name', email: 'user2_email@mail.com', password: 'user2_password')
      @recipe = Recipe.create(name: 'recipe name', description: 'recipe description', user: @user)
      @recipe2 = Recipe.create(name: 'recipe2 name', description: 'recipe2 description', user: @user2)
      login_as(@user, scope: :user)
      visit recipes_path
    end

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

    it 'displays a the expected labels' do
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
end
