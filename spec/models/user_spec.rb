require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }

  context '#select_foods' do
    before(:each) do
      @food = Food.create(name: 'food name', measurement_unit: 'Grams', price: 2.0, quantity: 3, user:)
      @food2 = Food.create(name: 'food2 name', measurement_unit: 'Units', price: 3.0, quantity: 2, user:)
    end

    it "should return an array with array elements, where each element includes each user's food's information" do
      expect(user.select_foods).to eq([['food name (Grams)', @food.id], ['food2 name (Units)', @food2.id]])
    end
  end
end
