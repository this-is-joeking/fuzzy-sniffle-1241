# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
