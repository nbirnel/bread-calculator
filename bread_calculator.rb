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
end


