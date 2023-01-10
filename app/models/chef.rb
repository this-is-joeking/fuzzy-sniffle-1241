class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :dish_ingredients, through: :dishes
  has_many :ingredients, through: :dish_ingredients

  def uniq_ingredients
    self.ingredients.distinct
  end

  def top_3_ingredients
    self.ingredients.select('ingredients.*, count(ingredients) as times_used').group(:id).order(times_used: :desc).limit(3)
  end
end