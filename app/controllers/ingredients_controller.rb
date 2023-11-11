# this is more rails-y per the docs approach to adding/deleting ingredient association with a dish
#
#class IngredientsController < ApplicationController
#   def create
#     if params[:dish_id]
#       @dish = Dish.find(params[:dish_id])
#       @ingredient = Ingredient.find(params[:ingredient_id]

#       DishIngredient.create(dish: @dish, ingredient: @ingredient) # Or @dish.ingredients << @ingredient
#     end

#     redirect_to ...
#   end
# end