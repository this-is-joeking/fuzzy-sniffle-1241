class DishesController < ApplicationController
  
  def show
    @dish = Dish.find(params[:id])
  end

  def update
    if Dish.where(id: params[:dish_id]).empty?
      redirect_to chef_path(params[:chef_id])
      flash[:error] = "That is not a valid dish id"

    else
      dish = Dish.find(params[:dish_id])
      dish.update(dish_params)
      redirect_to chef_path(params[:chef_id])
    end
  end

  private

  def dish_params
    params.permit(:name, :description, :chef_id)
  end
end