class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.where(public: true)
  end

  def count_food_recipes
    @food_recipes_count = RecipeFood.where(food_id: params[:food_id]).count
  end
end
