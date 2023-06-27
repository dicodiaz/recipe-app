class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    # @foods = current_user.foods
    @foods = Food.where(user: current_user)
  end

  def show; end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to '/foods', flash: { success: 'Food was successfully created.' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    if @food.update(food_params)
      redirect_to '/foods', flash: { success: 'Food was successfully updated.' }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy
    redirect_to '/foods', notice: 'Food was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user: current_user)
  end
end
