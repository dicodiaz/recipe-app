require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
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
    assign(:foods, [
             Food.create!(
               name: 'Name',
               measurement_unit: 'Measurement Unit',
               price: 2.5,
               quantity: 3,
               user: user
             ),
             Food.create!(
               name: 'Name',
               measurement_unit: 'Measurement Unit',
               price: 2.5,
               quantity: 3,
               user: user
             )
           ])
  end

  it 'renders a list of foods' do
    render
    assert_select 'tr>th', text: 'Name'.to_s, count: 1
    assert_select 'tr>th', text: 'Measurement unit'.to_s, count: 1
    assert_select 'tr>th', text: 'Price'.to_s, count: 1
    assert_select 'tr>th', text: 'Quantity'.to_s, count: 1
  end
end
