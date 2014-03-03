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
  attr_reader :steps, :metadata
  def initialize metadata, steps
    @metadata = metadata
    @steps    = steps
    @ingredients = self.ingredients
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
    a = Array.new
    self.steps.each do |step|
      step.ingredients.each do |ing|
        a << ing
      end
    end
    a
  end

  def total_flours
    self.ingredients.select{|i| i.bp_type == :flour}.map{|i| i.quantity}.reduce(:+)
  end

  def weight
    self.ingredients.map{|i| i.quantity}.reduce(:+)
  end

  def formula
    h = Hash.new
    self.ingredients.map do |i|
      h[i.name] = self.bp i.quantity
    end
    h
  end

end

