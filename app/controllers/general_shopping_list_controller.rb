class GeneralShoppingListController < ApplicationController
  def index
    @user_foods = current_user.foods
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_ingredients = @recipe.recipe_foods
    @counter = 0
    @food_price = 0
    @shopping_list_array = []
    @recipe_ingredients.includes([:food]).each do |recipe_ingredient|
      user_ingredient = @user_foods.find { |user_food| user_food.name == recipe_ingredient.food.name }
      next unless (user_ingredient.quantity - recipe_ingredient.quantity).negative?

      @counter += 1
      ingredients_substraction = recipe_ingredient.quantity - user_ingredient.quantity
      ingredients_price_subtotal = (ingredients_substraction * user_ingredient.price).round(2)
      @food_price += ingredients_price_subtotal
      @shopping_list_array << [recipe_ingredient.food.name,
                               "#{ingredients_substraction} #{user_ingredient.measurement_unit}",
                               ingredients_price_subtotal]
    end
  end
end
