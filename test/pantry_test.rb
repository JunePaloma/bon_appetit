require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
 def test_it_exists
   assert_instance_of Pantry, Pantry.new
 end

 def test_pantry_has_stock
   p = Pantry.new
   assert_equal ({}), p.stock
 end

 def test_we_can_check_stock
   p = Pantry.new
   assert_equal 0, p.stock_check("Cheese")
 end

 def test_pantry_can_be_restocked
    p = Pantry.new
    p.restock("Cheese", 10)
    assert_equal 10, p.stock_check("Cheese")
  end


  def test_pantry_can_be_restocked_again_with_even_more_cheese
    p = Pantry.new
    p.restock("Cheese", 10)
    p.restock("Cheese", 20)
    assert_equal 30, p.stock_check("Cheese")
  end

  def test_we_can_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    pantry = Pantry.new


    assert_equal ({"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
    "Cheese"         => {quantity: 75, units: "Universal Units"},
    "Flour"          => {quantity: 5, units: "Centi-Units"}}), pantry.convert_units(r)

  end
end
