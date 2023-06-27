require 'rails_helper'

RSpec.describe '/recipes', type: :request do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }
  let(:valid_attributes) { { name: 'recipe name', description: 'recipe description', user: } }
  let(:invalid_attributes) { { name: nil, description: nil, user: nil } }

  describe 'GET /index' do
    it 'renders a successful response' do
      Recipe.create! valid_attributes
      get recipes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = Recipe.create! valid_attributes
      get recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    before(:each) { login_as(user, scope: :user) }

    context 'with valid parameters' do
      it 'creates a new Recipe' do
        expect { post recipes_url, params: { recipe: valid_attributes } }.to change(Recipe, :count).by(1)
      end

      it 'redirects to the created recipe' do
        post recipes_url, params: { recipe: valid_attributes }
        expect(response).to redirect_to(recipe_url(Recipe.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Recipe' do
        expect { post recipes_url, params: { recipe: invalid_attributes } }.to change(Recipe, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post recipes_url, params: { recipe: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe' do
      recipe = Recipe.create! valid_attributes
      expect do
        delete recipe_url(recipe)
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list' do
      recipe = Recipe.create! valid_attributes
      delete recipe_url(recipe)
      expect(response).to redirect_to(recipes_url)
    end
  end
end
