require 'rails_helper'

RSpec.describe Chef, type: :model do
  before(:each) do
    @chef1 = Chef.create!(name: 'Bobby Ramsey')
    @chef2 = Chef.create!(name: 'Gordon Fieri')
    @chef3 = Chef.create!(name: 'Guy Flay')
    @chef4 = Chef.create!(name: 'test')

    @dish1 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish2 = @chef2.dishes.create!(name: 'Mac', description: 'Mac and chz without the chz.')
    @dish3 = @chef1.dishes.create!(name: 'Test Plate', description: 'Has no flavor and no ingredients, probably do not order')
    @dish4 = @chef1.dishes.create!(name: 'Mac 2.0', description: 'Mac and chz without the chz.')
    @dish5 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish6 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish7 = @chef4.dishes.create!(name: 'food', description: "food")

    @ingredient1 = @dish1.ingredients.create!(name: 'macaroni elbow noodles', calories: 225)
    @ingredient2 = @dish1.ingredients.create!(name: 'Velveeta Sauce', calories: 345)
    @ingredient3 = @dish3.ingredients.create!(name: 'Hot Red Pepper Flakes', calories: 2)
    @ingredient4 = @dish1.ingredients.create!(name: 'Steeze', calories: 0)
    @ingredient5 = Ingredient.create!(name: 'Not here', calories: 100)
    @ingredient6 = @dish2.ingredients.create!(name: 'Butter', calories: 80)
    @ingredient7 = @dish7.ingredients.create!(name: 'food', calories: 2000)

    DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @ingredient1.id)
    DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @ingredient3.id)
    DishIngredient.create!(dish_id: @dish4.id, ingredient_id: @ingredient1.id)
    DishIngredient.create!(dish_id: @dish4.id, ingredient_id: @ingredient3.id)

    DishIngredient.create!(dish_id: @dish5.id, ingredient_id: @ingredient1.id)
    DishIngredient.create!(dish_id: @dish5.id, ingredient_id: @ingredient2.id)
    DishIngredient.create!(dish_id: @dish5.id, ingredient_id: @ingredient3.id)
    DishIngredient.create!(dish_id: @dish5.id, ingredient_id: @ingredient4.id)

    DishIngredient.create!(dish_id: @dish6.id, ingredient_id: @ingredient1.id)
    DishIngredient.create!(dish_id: @dish6.id, ingredient_id: @ingredient2.id)
    DishIngredient.create!(dish_id: @dish6.id, ingredient_id: @ingredient3.id)
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
      expect(@chef4.uniq_ingredients.count).to eq(1)
      expect(@chef4.uniq_ingredients.first).to eq(@ingredient7)
      expect(@chef3.uniq_ingredients).to eq([])
    end
  end

  describe '#top_3_ingredients' do
    it 'returns the 3 ingredients chef uses most out of all their recipes' do
      DishIngredient.create!(dish_id: @dish6.id, ingredient_id: @ingredient5.id)

      expect(@chef1.top_3_ingredients.sort).to eq([@ingredient1, @ingredient2, @ingredient3].sort)
      expect(@chef2.top_3_ingredients.sort).to eq([@ingredient1, @ingredient3, @ingredient6].sort)
      expect(@chef3.top_3_ingredients).to eq([])
    end
  end
end