##
# This class represents an ingredient in a Recipe

class Ingredient
  attr_accessor :name, :quantity, :units, :type

  ##
  # Creates a new ingredient +name+, with the optional qualities +info+.
  #
  # +info+ should usually contain <tt>:quantity, :units, :type</tt>.
  # +:type+, in the context of bakers' percentage, would be +:flours+, 
  # +:liquids+, or +:additives+.
  
  def initialize name, info={}
    @units = 'grams'
    @name = name
    info.each do |k,v| 
      instance_variable_set("@#{k}", v)
    end
  end
end

## 
# This class represents a discrete step in a Recipe.

class Step
  attr_reader :technique, :ingredients, :technique_2

  ##
  # Creates a new step with the string +technique+, and an optional array of
  # Ingredients +ingredients+, and an optional second string +technique_2+
  #
  # This is intended to read something like:
  # <tt>"Mix:", [@flour, @water], "thoroughly."</tt>
  #
  # or:
  #
  # <tt>"Serve forth."</tt>
  
  def initialize technique, ingredients = [], technique_2 = nil
    @technique   = technique
    @ingredients = ingredients
    @technique_2 = technique_2
  end
end

##
# This class represents a recipe.

class Recipe
  attr_reader :steps, :metadata
  
  ##
  # Create a new recipe with hash +metadata+ and array of Steps +steps+
  #
  # +metadata+ is freeform, but most likely should include +:name+.
  # Other likely keys are: 
  # <tt>:prep_time, :total_time, :notes, :history, :serves, :makes,
  # :attribution</tt>.
  
  def initialize metadata, steps
    @metadata = metadata
    @steps    = steps
    @ingredients = self.ingredients
  end

  ##
  # Return an array of all Ingredients in all Steps for the Recipe
  
  def ingredients
    a = Array.new
    self.steps.each do |step|
      step.ingredients.each do |ing|
        a << ing
      end
    end
    a
  end

  ##
  # Return the weight of all ingredients
  
  def weight
    self.ingredients.map{|i| i.quantity}.reduce(:+)
  end

  #FIXME make this a method_missing so we can add new types on the fly
  #RENÉE - 'end.' is weird or no?
  #FIXME how do I get this into rdoc?
  [:flours, :liquids, :additives].each do |s|
    define_method("total_#{s}") do
      instance_variable_get("@ingredients").select{|i| i.type == s}.map do |i|
        i.quantity
      end.reduce(:+)
    end
  end

  alias_method 'bakers_percent_100', 'total_flours'

  ##
  # Return the baker's percentage of a weight
  
  def bakers_percent weight
    weight / bakers_percent_100.to_f
  end

  ##
  # Return a unit-less formula for the recipe in baker's percentages
  
  def formula
    h = Hash.new
    self.ingredients.map do |i|
      h[i.name] = self.bakers_percent i.quantity
    end
    h
  end

end

