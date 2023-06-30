require 'rails_helper'

RSpec.describe '/foods', type: :request do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }

  let(:valid_attributes) { { name: 'food name', measurement_unit: 'Grams', price: 2.0, quantity: 3, user: } }
  let(:invalid_attributes) { { name: nil, measurement_unit: nil, price: nil, quantity: nil, user: nil } }

  describe 'GET /index' do
    it 'renders a successful response' do
      Food.create! valid_attributes
      get foods_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      food = Food.create! valid_attributes
      get food_url(food)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_food_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    before(:each) { login_as(user, scope: :user) }

    context 'with valid parameters' do
      it 'creates a new Food' do
        expect do
          post foods_url, params: { food: valid_attributes }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the created food' do
        post foods_url, params: { food: valid_attributes }
        expect(response).to redirect_to(foods_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Food' do
        expect do
          post foods_url, params: { food: invalid_attributes }
        end.to change(Food, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post foods_url, params: { food: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested food' do
      food = Food.create! valid_attributes
      expect do
        delete food_url(food)
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the foods list' do
      food = Food.create! valid_attributes
      delete food_url(food)
      expect(response).to redirect_to(foods_url)
    end
  end
end
