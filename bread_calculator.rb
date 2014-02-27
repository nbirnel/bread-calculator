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

  def percent_100
    @flours.map{|k,v| v}.inject(:+).to_f
  end

  def bp item
    item / percent_100 * 100
  end
end


