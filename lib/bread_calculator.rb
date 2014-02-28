#!/usr/bin/env ruby

class Formula
  attr_accessor :flours, :liquids, :additives
  def initialize
    @flours    = Hash.new(0)
    @liquids   = Hash.new(0)
    @additives = Hash.new(0)
  end

end

class Recipe
  attr_accessor :flours, :liquids, :additives
  def initialize 
    @flours    = Hash.new(0)
    @liquids   = Hash.new(0)
    @additives = Hash.new(0)
  end

  def bakers_100_percent
    @flours.map{|k,v| v}.inject(:+).to_f
  end

  def ingredients
    [@flours, @liquids, @additives]
  end

  def bp item
    item / bakers_100_percent * 100
  end

  def weight
    self.ingredients.each.map{|k,v| v}.inject(:+).to_f
  end


end


