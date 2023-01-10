class DishesController < ApplicationController
  
  def show
    @dish = Dish.find(params[:id])
  end

  private

  def dish_params
    params
  end
end