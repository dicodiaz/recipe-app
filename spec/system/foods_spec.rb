require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  before(:each) do
    @user1 = User.new(name: 'Jaime', email: 'jaimevillegas296@gmail.com', password: 'test123')
    login_as(@user1, scope: :user)
  end

  describe 'index page' do
    before(:each) do
      @user1 = User.create(name: 'Jaime', email: 'jaimevillegas296@gmail.com', password: 'test123')
      @user2 = User.create(name: 'test', email: 'test@test.com', password: 'test123')
      @food1 = Food.create(name: 'Mondongo', measurement_unit: 'Pounds', price: 5.4, quantity: 2, user: @user1)
      @food2 = Food.create(name: 'Mandarina', measurement_unit: 'Units', price: 1.6, quantity: 2, user: @user2)
      login_as(@user1, scope: :user)
      visit '/foods'
    end

    it 'renders the correct template' do
      expect(page).to have_content('FOODS')
    end

    it 'shows the name of the foods for a certain user' do
      expect(page).to have_content(@food1.name)
    end

    it 'does not show the name of the foods for another user' do
      expect(page).to_not have_content(@food2.name)
    end

    it 'shows the price of the foods for a certain user' do
      expect(page).to have_content(@food1.price)
    end

    it 'redirects to delete food page when clicking Delete' do
      click_link('Delete', match: :first)
      expect(page).to have_content('Confirm Delete')
    end

    it 'redirects to New Food page when clicking New Food' do
      click_on 'New food'
      expect(page).to have_current_path('/foods/new')
    end
  end

  describe 'New food' do
    before(:each) { visit '/foods/new' }

    it 'renders the correct template' do
      expect(page).to have_content('NEW FOOD')
    end

    it 'display the correct fields' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Measurement unit')
      expect(page).to have_content('Price')
      expect(page).to have_content('Quantity')
    end

    it 'display Create food button' do
      expect(page).to have_button('Create Food')
    end
  end
end
