require 'rails_helper'

RSpec.describe 'chef show page' do
  before(:each) do
    @chef1 = Chef.create!(name: 'Bobby Ramsey')
    @chef2 = Chef.create!(name: 'Gordon Fieri')
    @chef3 = Chef.create!(name: 'Guy Flay')
    @dish1 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish2 = @chef1.dishes.create!(name: 'Mac', description: 'Mac and chz without the chz.')
    @dish3 = @chef2.dishes.create!(name: 'Test Plate', description: 'Has no flavor and no ingredients, probably do not order')
    @ingredient1 = @dish1.ingredients.create!(name: 'macaroni elbow noodles', calories: 225)
    @ingredient2 = @dish1.ingredients.create!(name: 'Velveeta Sauce', calories: 345)
    @ingredient3 = @dish1.ingredients.create!(name: 'Hot Red Pepper Flakes', calories: 2)
    @ingredient4 = @dish1.ingredients.create!(name: 'Steeze', calories: 0)
    DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @ingredient1.id)
  end

  it 'shows the name of the chef and their dishes' do
    visit chef_path(@chef1)

    expect(page).to have_content(@chef1.name)
    @chef1.dishes.each do |dish| 
      expect(page).to have_content(dish.name)
    end
  end

  it 'has a form to add a dish to the chefs menu via dish ID' do
    visit chef_path(@chef1)

    fill_in :dish_id, with: @dish3.id
    click_button "Submit"

    expect(current_path).to eq(chef_path(@chef1))
  end
end

