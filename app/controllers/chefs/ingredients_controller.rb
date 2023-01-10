module Chefs
  class IngredientsController < ApplicationController
    
    def index
      @chef = Chef.find(params[:chef_id])
      @ingredients = @chef.uniq_ingredients
    end
  end
end
