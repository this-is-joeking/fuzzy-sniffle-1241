require 'rails_helper'

RSpec.describe Chef, type: :model do
  before(:each) do
    @chef1 = Chef.create!(name: 'Bobby Ramsey')
    @chef2 = Chef.create!(name: 'Gordon Fieri')
    @chef3 = Chef.create!(name: 'Guy Flay')
    @dish1 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish2 = @chef2.dishes.create!(name: 'Mac', description: 'Mac and chz without the chz.')
    @dish3 = @chef1.dishes.create!(name: 'Test Plate', description: 'Has no flavor and no ingredients, probably do not order')
    @dish4 = @chef1.dishes.create!(name: 'Mac 2.0', description: 'Mac and chz without the chz.')
    @ingredient1 = @dish1.ingredients.create!(name: 'macaroni elbow noodles', calories: 225)
    @ingredient2 = @dish1.ingredients.create!(name: 'Velveeta Sauce', calories: 345)
    @ingredient3 = @dish3.ingredients.create!(name: 'Hot Red Pepper Flakes', calories: 2)
    @ingredient4 = @dish1.ingredients.create!(name: 'Steeze', calories: 0)
    @ingredient5 = Ingredient.create!(name: 'Not here', calories: 100)
    DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @ingredient1.id)
    DishIngredient.create!(dish_id: @dish4.id, ingredient_id: @ingredient1.id)
    DishIngredient.create!(dish_id: @dish4.id, ingredient_id: @ingredient3.id)
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:dish_ingredients).through(:dishes)}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "#uniq_ingredients" do
    it "returns all unique ingredients used in chef's dishes" do
      expect(@chef1.uniq_ingredients.sort).to eq([@ingredient1, @ingredient2, @ingredient3, @ingredient4].sort)
      expect(@chef2.uniq_ingredients.count).to eq(1)
      expect(@chef2.uniq_ingredients.first).to eq(@ingredient1)
      expect(@chef3.uniq_ingredients).to eq([])
    end
  end
end