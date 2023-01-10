require 'rails_helper'

RSpec.describe Dish, type: :model do
  before(:each) do
    @chef1 = Chef.create!(name: 'Bobby Ramsey')
    @dish1 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish2 = @chef1.dishes.create!(name: 'Mac', description: 'Mac and chz without the chz.')
    @dish3 = @chef1.dishes.create!(name: 'Test Plate', description: 'Has no flavor and no ingredients, probably do not order')
    @ingredient1 = @dish1.ingredients.create!(name: 'macaroni elbow noodles', calories: 225)
    @ingredient2 = @dish1.ingredients.create!(name: 'Velveeta Sauce', calories: 345)
    @ingredient3 = @dish1.ingredients.create!(name: 'Hor Red Pepper Flakes', calories: 2)
    @ingredient4 = @dish1.ingredients.create!(name: 'Steeze', calories: 0)
    DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @ingredient1.id)

  end
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe '#total_calories' do
    it 'returns the total amount of calories for a dish' do
      expect(@dish1.total_calories).to eq(572)
      expect(@dish2.total_calories).to eq(225)
      expect(@dish3.total_calories).to eq(0)
    end
  end
end