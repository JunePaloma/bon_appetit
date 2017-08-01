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


    assert_equal ({"Cayenne Pepper"=>{:quantity=>25, :units=>"Milli-Units"}, "Cheese"=>{:quantity=>75, :units=>"Universal-Units"}, "Flour"=>{:quantity=>5, :units=>"Centi-Units"}}), pantry.convert_units(r)
  end

  def test_that_pantry_can_add_recipes_to_cookbook
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    assert_equal 1, pantry.cookbook.length

    pantry.add_to_cookbook(r2)
    assert_equal 2, pantry.cookbook.length

    pantry.add_to_cookbook(r3)
    assert_equal 3, pantry.cookbook.length

    assert_equal Recipe, pantry.cookbook[0].class
  end

  def test_pantry_makes_reccomendations

    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

assert_equal ["Brine Shot", "Peanuts"], pantry.what_can_i_make

assert_equal ({"Brine Shot" => 4, "Peanuts" => 2}), pantry.how_many_can_i_make

  end


end
