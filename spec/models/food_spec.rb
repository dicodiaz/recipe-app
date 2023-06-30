require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user1 = User.new(name: 'Jaime', email: 'jaimevillegas296@gmail.com', password: 'test123')
    @food = Food.new(name: 'Mondongo', measurement_unit: 'Pounds', price: 5.4, quantity: 2, user: @user1)
  end

  describe 'Initialize' do
    it 'is valid with valid attributes' do
      expect(@food).to be_valid
    end

    it 'is not valid without a name' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid without a measurement_unit' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid without a price' do
      @food.price = nil
      expect(@food).to_not be_valid
    end
  end
end
