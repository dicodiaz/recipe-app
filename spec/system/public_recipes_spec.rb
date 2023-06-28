require 'rails_helper'

RSpec.describe 'Public recipes', type: :system do
  # before(:each) do
  #   @user1 = User.create(name: 'test', email: 'test@test.com', password: 'test123')
  #   login_as(@user, scope: :user)
  # end

  describe 'index page' do
    before(:each) do
      @user1 = User.create(name: 'test', email: 'test@test.com', password: 'test123')
      @user2 = User.create(name: 'test2', email: 'test2@test.com', password: 'test123')
      @recipe1 = Recipe.create(name: 'Jugo de borojo', preparation_time: '20 minutes', cooking_time: '5 minutes',
                               description: 'Agregue agua y fruta y ponga a licuar', public: true, user_id: @user1.id)
      @recipe2 = Recipe.create(name: 'Sancocho', preparation_time: '30 minutes', cooking_time: '2 hours',
                               description: 'Lorem ipsum dolor sit atemr. Ppotenti.', public: true, user_id: @user2.id)
      @recipe3 = Recipe.create(name: 'Tamales', preparation_time: '30 minutes', cooking_time: '2 hours',
                               description: 'Lorem ipsum dolor sit atemr. Ppotenti.', public: false, user_id: @user2.id)
      login_as(@user1, scope: :user)
      visit public_recipes_path
    end

    it 'displays the recipe name and description' do
      expect(page).to have_content(@recipe1.name)
    end

    it 'does not display private recipes' do
      expect(page).not_to have_content(@recipe3.name)
    end

    it 'displays a counter of food items' do
      expect(page).to have_content(@recipe1.count_food_recipes)
    end

    it 'should have a link to the recipe and redirects to recipe details' do
      expect(page).to have_link(@recipe1.name, href: recipe_path(@recipe1))
    end
  end
end
