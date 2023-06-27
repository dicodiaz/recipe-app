require 'rails_helper'

RSpec.describe 'foods/show', type: :view do
  let(:user) do
    User.create!(
      name: 'Jaime',
      email: 'jaimevillegas296@gmail.com',
      password: 'test123'
    )
  end

  before(:each) do
    assign(:user, user)
    assign(:food, Food.create!(
                    name: 'Name',
                    measurement_unit: 'Measurement Unit',
                    price: 2.5,
                    quantity: 3,
                    user:
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Measurement Unit/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
  end
end
