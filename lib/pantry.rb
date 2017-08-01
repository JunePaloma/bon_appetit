require "./lib/recipe"
require 'pry'
class Pantry

  attr_reader :stock, :cookbook

  def initialize
    @stock = {}
    @cookbook = []
  end

  def stock_check(item) #maybe refactor using find
    quantity_count = 0
    @stock.each do |stocked_item, quantity|
      if stocked_item == item
        quantity_count += quantity
      end
    end
    quantity_count
  end

  def restock (item, quantity) #possible to use memoization to set the value of a key?
    if @stock[item] == nil
        @stock[item] = quantity
    else
    @stock[item] += quantity
    end
  end

  def convert_units(recipe)
    i = recipe.ingredients
      new_i_hash = {}
    i.each do |ingredient, amount|
        measurement_hash = {}
      if amount <= 1
        amount = (amount *1000).to_i
        measurement_hash[:quantity] = amount
        measurement_hash[:units] = "Milli-Units"
      elsif amount >= 100
          amount = amount/100
          measurement_hash[:quantity] = amount
          measurement_hash[:units] = "Centi-Units"
      else
        measurement_hash[:quantity] = amount
        measurement_hash[:units] = "Universal-Units"
      end
      new_i_hash[ingredient] = measurement_hash
    end
    new_i_hash
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    possible_recipes = []
      @cookbook.each do |recipe|
        ingredients_i_have = []
        recipe_ingredients = recipe.ingredients
          recipe.ingredients.each do |ingredient, amount|
            @stock.each do |in_pantry, stocked_amount|
              if ingredient == in_pantry && stocked_amount >= amount
                ingredients_i_have << ingredient
              end
            end
          end
          if ingredients_i_have.length == recipe_ingredients.length
          possible_recipes << recipe.name
        end
      end
    possible_recipes
  end

  def how_many_can_i_make
    recipes = get_recipe_objs
    recipe_hash = Hash.new 0
    recipes.each do |recipe_obj|
      ingredients_i_have_enough_of = {}
      recipe_obj.ingredients.each do |ingredient, amount|
          @stock.each do |stocked_item, stocked_quantity|
            if stocked_item == ingredient
              ingredients_i_have_enough_of [stocked_item] =(stocked_quantity/amount).to_i
            end
          end
    
      ingredients_i_have_enough_of #I'll have a hash with the ingredients I have, I need to find the lowest value from the key value pairs, that will be the amount of the recipe I can make. Then I add the recipe name, and that low value to the the recipe hash.
      end
    # returns a hash with recipe name and the quantity I can make
    end
  end

  def get_recipe_objs
    possible_recipes = what_can_i_make
    recipe_arr = []
    @cookbook.each do |recipe_obj|
      possible_recipes.each do |recipe_name|
        if recipe_name == recipe_obj.name
          recipe_arr << recipe_obj
        end
      end
    end
    recipe_arr
  end

end
