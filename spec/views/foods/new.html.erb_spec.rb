require 'rails_helper'

RSpec.describe 'foods/new', type: :view do
  let(:user) do
    User.create!(
      name: 'Jaime',
      email: 'jaimevillegas296@gmail.com',
      password: 'test123'
    )
  end

  before(:each) do
    allow(view).to receive(:current_user).and_return(user)
    assign(:user, user)
    assign(:food, Food.new(
                    name: 'MyString',
                    measurement_unit: 'MyString',
                    price: 1.5,
                    quantity: 1,
                    user:
                  ))
  end

  it 'renders new food form' do
    render

    assert_select 'form[action=?][method=?]', foods_path, 'post' do
      assert_select 'input[name=?]', 'food[name]'

      assert_select 'input[name=?]', 'food[measurement_unit]'

      assert_select 'input[name=?]', 'food[price]'

      assert_select 'input[name=?]', 'food[quantity]'
    end
  end
end
