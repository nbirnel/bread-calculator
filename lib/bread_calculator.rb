#!/usr/bin/env ruby

class Formula        #maybe a formula is a subclass of recipe,
                     #where total_flours is forced to be 100?
  #                  #or is any given recipe a subclass of Formula?
  
end

class Recipe
  attr_accessor :units, :flours, :liquids, :additives
  def initialize units = 'grams', flours=Hash.new(0), liquids=Hash.new(0), additives=Hash.new(0)
    @units     = units
    @flours    = flours
    @liquids   = liquids
    @additives = additives
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
    self.ingredients.each do |ing, qty|
      formula[ing] = self.bp qty
    end
    formula
  end

end

