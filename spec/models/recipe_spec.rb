require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }
  let(:recipe) { Recipe.create(name: 'recipe name', description: 'recipe description', user:) }

  context 'validations' do
    it('should be valid') do
      expect(recipe).to be_valid
    end

    it 'should be invalid when name is not present' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end

    it 'should be invalid when description is not present' do
      recipe.description = nil
      expect(recipe).not_to be_valid
    end
  end
end
