require "rails_helper"

RSpec.describe Dish, type: :feature do
  before :each do 
    @chef1 = Chef.create(name: "Frenchie")
    @chef2 = Chef.create(name: "Baker Boy")

    @dish1 = @chef1.dishes.create(name: "Soup", description: "Soupy Soup")
    @dish2 = @chef1.dishes.create(name: "Goupy Goup", description: "Goupy Soupy Soup Goup")

    @ingredient1 = Ingredient.create(name: "Onion", calories: 10)
    @ingredient2 = Ingredient.create(name: "Garlic", calories: 20)
    @ingredient3 = Ingredient.create(name: "Tomato", calories: 30)
    @ingredient4 = Ingredient.create(name: "Noodle", calories: 40)
    @ingredient5 = Ingredient.create(name: "Kisses", calories: 50)
    @ingredient6 = Ingredient.create(name: "Hugs", calories: 60)

    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ingredient3.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ingredient5.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ingredient6.id)

    
  end
  describe "dish show page" do
    it "shows dish name and description and ingredients and calories" do
      # Story 1 of 3
      # As a visitor
      # When I visit a dish's show page
      # I see the dish’s name and description
      # And I see a list of ingredients for that dish
      # and a total calorie count for that dish
      # And I see the chef's name.
      visit "/dishes/#{@dish1.id}"

      expect(page).to have_content(@dish1.name)
      expect(page).to have_content(@dish1.description)

      within("#ingredient-list") do
        expect(page).to have_content(@ingredient1.name)
        expect(page).to have_content(@ingredient2.name)
        expect(page).to have_content(@ingredient3.name)
        expect(page).to have_content(@ingredient4.name)
        expect(page).to_not have_content(@ingredient5.name)
        expect(page).to_not have_content(@ingredient6.name)
      end

      expect(page).to have_content("Total Calories: 100")
      expect(page).to have_content(@chef1.name)
    end

    it "has form to add existing ingredient to a dish" do
    # Story 2 of 3
    # As a visitor
    # When I visit a dish's show page
    # I see a form to add an existing Ingredient to that Dish
    # When I fill in the form with the ID of an Ingredient that exists in the database
    # And I click Submit
    # Then I am redirected to that dish's show page
    # And I see that ingredient is now listed. 

    visit "/dishes/#{@dish1.id}"
    expect(page).to have_field(:ingredient_id)
    fill_in :ingredient_id, with: @ingredient6.id
    click_button("Add Ingredient")
    expect(current_path).to eq "/dishes/#{@dish1.id}"
    expect(page).to have_content(@ingredient6.name)
    end

    it "has button to delete ingredient from dish" do
    # Extension 1 of 2
    # As a visitor
    # When I visit a dish's show page
    # I see a button next to each ingredient to delete that ingredient from a dish
    # And when I click that button
    # I am redirected back to that page
    # And the ingredient is no longer listed.

    visit "/dishes/#{@dish1.id}"
    expect(page).to have_button("Delete #{@ingredient1.name}")
    click_button("Delete #{@ingredient1.name}")
    expect(current_path).to eq("/dishes/#{@dish1.id}")
    expect(page).to_not have_content(@ingredient1.name)
    end
  end
end
