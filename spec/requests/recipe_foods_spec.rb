require 'rails_helper'

RSpec.describe '/recipe_foods', type: :request do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }
  let(:recipe) { Recipe.create(name: 'recipe name', description: 'recipe description', user:) }
  let(:food) { Food.create(name: 'food name', measurement_unit: 'Grams', price: 2.0, quantity: 3, user:) }

  let(:valid_attributes) { { quantity: 2, recipe_id: recipe.id, food_id: food.id } }
  let(:invalid_attributes) { { quantity: nil, recipe_id: recipe.id, food: nil } }

  describe 'GET /index' do
    it 'renders a successful response' do
      RecipeFood.create! valid_attributes
      get recipe_foods_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe_food = RecipeFood.create! valid_attributes
      get recipe_food_url(recipe_food)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_food_url, params: { recipe_id: recipe.id }
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new RecipeFood' do
        expect do
          post recipe_foods_url, params: { recipe_food: valid_attributes }
        end.to change(RecipeFood, :count).by(1)
      end

      it "redirects to the recipes url when there's no session information" do
        post recipe_foods_url, params: { recipe_food: valid_attributes }
        expect(response).to redirect_to(recipes_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new RecipeFood' do
        expect do
          post recipe_foods_url, params: { recipe_food: invalid_attributes }
        end.to change(RecipeFood, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post recipe_foods_url, params: { recipe_food: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe_food' do
      recipe_food = RecipeFood.create! valid_attributes
      expect do
        delete recipe_food_url(recipe_food)
      end.to change(RecipeFood, :count).by(-1)
    end

    it "redirects to the recipes url when there's no session information" do
      recipe_food = RecipeFood.create! valid_attributes
      delete recipe_food_url(recipe_food)
      expect(response).to redirect_to(recipes_url)
    end
  end
end
