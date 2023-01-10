require 'rails_helper'

RSpec.describe 'chef ingredients show page' do
  before(:each) do
    @chef1 = Chef.create!(name: 'Bobby Ramsey')
    @dish1 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @dish2 = @chef1.dishes.create!(name: 'Mac', description: 'Mac and chz without the chz.')
    @dish3 = @chef1.dishes.create!(name: 'Test Plate', description: 'Has no flavor and no ingredients, probably do not order')
    @ingredient1 = @dish1.ingredients.create!(name: 'macaroni elbow noodles', calories: 225)
    @ingredient2 = @dish1.ingredients.create!(name: 'Velveeta Sauce', calories: 345)
    @ingredient3 = @dish1.ingredients.create!(name: 'Hot Red Pepper Flakes', calories: 2)
    @ingredient4 = @dish1.ingredients.create!(name: 'Steeze', calories: 0)
    @ingredient5 = Ingredient.create!(name: 'Not here', calories: 100)
    DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @ingredient1.id)
  end

  it 'is linked to from the chefs show page' do
    visit chef_path(@chef1)
    click_button "View #{@chef1.name}'s Ingredients"

    expect(current_path).to eq(chef_ingredients_path(@chef1))
  end

  it 'lists all of the unique ingredients the chef uses' do
    visit chef_ingredients_path(@chef1)

    expect(page).to have_content(@chef1.name)
    expect(page).to have_content(@ingredient1.name).once
    expect(page).to have_content(@ingredient2.name).once
    expect(page).to have_content(@ingredient3.name).once
    expect(page).to have_content(@ingredient4.name).once
    expect(page).to_not have_content(@ingredient5.name)
  end
end

# Story 3 of 3
# ```
# As a visitor
# When I visit a chef's show page
# I see a link to view a list of all ingredients that this chef uses in their dishes.
# When I click on that link
# I'm taken to a chef's ingredients index page
# and I can see a unique list of names of all the ingredients that this chef uses.
# ```
 