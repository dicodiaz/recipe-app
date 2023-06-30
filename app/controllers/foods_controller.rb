class FoodsController < ApplicationController
  before_action :set_food, only: %i[show destroy]

  def index
    @foods = Food.where(user: current_user)
  end

  def show; end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to '/foods', flash: { success: 'Food was successfully created.' }
    else
      flash.now[:error] = @food.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @food

    @food.destroy
    redirect_to '/foods', notice: 'Food was successfully destroyed.'
  end

  private

  def set_food
    @food = Food.find_by(id: params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user: current_user)
  end
end
