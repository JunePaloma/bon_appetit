require "./lib/recipe"
require 'pry'
class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
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

end

    # key is the ingredient, value is a hash {quantity => num, units =>numb}
    # iterate over the outer hash first, then iterate over the inner hash
  #   If the recipe calls for more than 100 Units of an ingredient, convert it to Centi-units
  #  If the recipe calls for less than 1 Units of an ingredient, convert it to Milli-units
