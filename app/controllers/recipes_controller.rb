class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  include RecipesHelper

  def index
    @recipes = Recipe.where(user: current_user)
  end

  def show
    session[:return_to] ||= request.fullpath
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_url(@recipe), flash: { success: 'Recipe was successfully created.' }
    else
      flash.now[:error] = @recipe.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @recipe

    @recipe.destroy
    redirect_to recipes_url, alert: 'Recipe was successfully destroyed.'
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).includes(:user)
  end

  private

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description,
                                   :public).merge(user: current_user)
  end
end
