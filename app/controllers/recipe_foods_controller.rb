class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[destroy]

  def new
    @recipe_food = RecipeFood.new(recipe_id: params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to session.delete(:return_to) || recipes_path, flash: { success: 'Ingredient was successfully created.' }
    else
      flash.now[:error] = @recipe_food.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @recipe_food

    @recipe_food.destroy
    redirect_to session.delete(:return_to) || recipes_path, alert: 'Ingredient was successfully destroyed.'
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find_by(id: params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
