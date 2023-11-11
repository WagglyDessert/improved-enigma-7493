class DishIngredientsController < ApplicationController

def create
    @dish = Dish.find(params[:dish_id])
    @ingredient = Ingredient.find(params[:ingredient_id])
    DishIngredient.create(dish: @dish, ingredient: @ingredient) 
    # Or @dish.ingredients << @ingredient
    redirect_to "/dishes/#{@dish.id}"
  end

  def destroy
    @dish = Dish.find(params[:dish_id])
    @ingredient = Ingredient.find(params[:id])
    @dish_ingredient = DishIngredient.find_by(dish: @dish, ingredient: @ingredient)
    @dish_ingredient.destroy
    redirect_to "/dishes/#{@dish.id}"
  end
end