class Ingredient
  attr_accessor :quantity, :units, :name, :type
  def initialize name, extra_args={}
    @units = 'grams'
    @name = name
    extra_args.each do |k,v| 
      instance_variable_set("@#{k}", v)
    end
  end
end

class Step
  #FIXME perhaps ingredients could be embedded in the technique, like a printf
  attr_reader :technique, :ingredients, :technique_2
  def initialize technique, ingredients = [], technique_2 = nil
    @technique   = technique
    @ingredients = ingredients
    @technique_2 = technique_2
  end
end

class Recipe
  attr_reader :steps, :metadata
  #metadata is an extensible hash - :name, prep time, notes, history,
  # serves, makes, attibution, etcc
  def initialize metadata, steps
    @metadata = metadata
    @steps    = steps
    @ingredients = self.ingredients
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

  def weight
    self.ingredients.map{|i| i.quantity}.reduce(:+)
  end

  #FIXME make this a method_missing so we can add new types on the fly
  #RENÉE - 'end.' is weird or no?
  [:flours, :liquids, :additives].each do |s|
    define_method("total_#{s}") do
      instance_variable_get("@ingredients").select{|i| i.type == s}.map do |i|
        i.quantity
      end.reduce(:+)
    end
  end

  alias_method 'bakers_percent_100', 'total_flours'

  def bakers_percent item
    item / bakers_percent_100.to_f
  end

  def formula
    h = Hash.new
    self.ingredients.map do |i|
      h[i.name] = self.bakers_percent i.quantity
    end
    h
  end

end

