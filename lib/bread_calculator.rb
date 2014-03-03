#!/usr/bin/env ruby

class Formula        #maybe a formula is a subclass of recipe,
                     #where total_flours is forced to be 100?
  #                  #or is any given recipe a subclass of Formula?
  
end

class Ingredient
  attr_accessor :quantity, :units, :name, :bp_type
  def initialize name, extra_args={}
    @units = 'grams'
    @name = name
    extra_args.each do |k,v| 
      instance_variable_set("@#{k}", v)
    end
  end
end

class Step
  attr_reader :technique, :ingredients, :technique_2
  def initialize technique, ingredients = [], technique_2 = nil
    @technique   = technique
    @ingredients = ingredients
    @technique_2 = technique_2
  end
end

class Recipe
  def initialize metadata, steps
    @metadata = metadata
    @steps    = steps
  end

  [:flours, :liquids, :additives].each do |s|
    define_method("total_#{s}") do
      instance_variable_get("@#{s}").values.reduce(:+)
    end
  end

  def bakers_100_percent
    total_flours
  end

  def bp item
    item / bakers_100_percent.to_f
  end

  def ingredients
    @flours.merge @liquids.merge @additives  
  end

  def weight
    total_flours + total_liquids + total_additives
  end

  def formula
    formula = Hash.new
    self.ingredients.each do |ing, quantity|
      formula[ing] = self.bp quantity
    end
    formula
  end

end

