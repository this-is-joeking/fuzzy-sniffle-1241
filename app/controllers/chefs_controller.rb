class ChefsController < ApplicationController
  
  def show
    @chef = Chef.find(params[:id])
  end

  private

  def chef_params
    params
  end
end