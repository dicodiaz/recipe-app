require 'rails_helper'

RSpec.describe 'foods/edit', type: :view do
  let(:food) do
    Food.create!(
      name: 'Mondongo',
      measurement_unit: 'Pounds',
      price: 1.5,
      quantity: 1,
      user: user
    )
  end

  let(:user) do
    User.create!(
      name: 'Jaime',
      email: 'jaimevillegas296@gmail.com',
      password: 'test123'
    )
  end

  before(:each) do
    assign(:food, food)
    assign(:user, user)
  end

  it 'renders the edit food form' do
    render

    assert_select 'form[action=?][method=?]', food_path(food), 'post' do
      assert_select 'input[name=?]', 'food[name]'

      assert_select 'input[name=?]', 'food[measurement_unit]'

      assert_select 'input[name=?]', 'food[price]'

      assert_select 'input[name=?]', 'food[quantity]'
    end
  end
end
