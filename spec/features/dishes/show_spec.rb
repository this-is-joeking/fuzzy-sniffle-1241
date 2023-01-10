require 'rails_helper'

RSpec.describe 'dish show page' do
  before(:each) do
    @chef1 = Chef.create!(name: 'Bobby Ramsey')
    @chef2 = Chef.create!(name: 'Gordon Fieri')
    @chef3 = Chef.create!(name: 'Guy Flay')
    @dish1 = @chef1.dishes.create!(name: 'Mac & Steeze', description: 'Mac and chz with more steeze.')
    @ingredient1 = @dish1.ingredients.create!(name: 'macaroni elbow noodles', calories: 225)
    @ingredient2 = @dish1.ingredients.create!(name: 'Velveeta Sauce', calories: 345)
    @ingredient3 = @dish1.ingredients.create!(name: 'Hor Red Pepper Flakes', calories: 2)
    @ingredient4 = @dish1.ingredients.create!(name: 'Steeze', calories: 0)
  end

  it 'shows the name and description of the dish' do
    visit dish_path(@dish1.id)
    
    expect(page).to have_content(@dish1.name)
    expect(page).to have_content(@dish1.description)
  end

  it 'lists all ingredients for the dish' do
    visit dish_path(@dish1.id)

    expect(page).to have_content(@ingredient1.name)
    expect(page).to have_content(@ingredient1.calories)
    expect(page).to have_content(@ingredient2.name)
    expect(page).to have_content(@ingredient2.calories)
    expect(page).to have_content(@ingredient3.name)
    expect(page).to have_content(@ingredient3.calories)
    expect(page).to have_content(@ingredient4.name)
    expect(page).to have_content(@ingredient4.calories)
  end

  it 'shows total calorie count for the dish' do
    visit dish_path(@dish1.id)

    expect(page).to have_content('Calories: 572')
  end

  it 'shows the chefs name' do
    visit dish_path(@dish1.id)

    expect(page).to have_content("Created by Chef #{@chef1.name}")
  end
end


# As a visitor
# When I visit a dish's show page
# I see the dish’s name and description
# And I see a list of ingredients for that dish
# and a total calorie count for that dish
# And I see the chef's name.
