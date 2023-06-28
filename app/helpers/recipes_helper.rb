module RecipesHelper
  def sum_foods(recipe)
    sum = 0
    recipe.recipe_foods.each { |item| sum += (item.food.price * item.quantity) }
    sum
  end
end
