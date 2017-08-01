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
        recipe_ingredients = recipe.ingredients.keys
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
  #
  #
  #     ingredients.each do |ingredient|
  #       available.each do |in_pantry|
  #         if ingredient == inpantry
  #
  #     @stock.each do |ingredient_in_pantry|
  #       ingredients.each do |ingredient|
  #         if
  #
  #
  #
  #     ingredients << recipe.
  #     @stock.each do |ingredient|
  #       if recipe.ingredient
  #
  #     end
  #   end
  #
  # binding.pry
  #   # iterate over stock
  #   # iterate over cookbook.ingredients  if the key  matches the ingredients and the value is greater than or equal to the quantity, return that recipe
  #
  # end



end
