##
# This class represents an ingredient in a Recipe

class Ingredient
  attr_accessor :info, :name, :quantity, :units, :type

  ##
  # Creates a new ingredient +name+, with the optional qualities +info+.
  #
  # +info+ should usually contain <tt>:quantity, :units, :type</tt>.
  # +:type+, in the context of bakers' percentage, would be +:flours+, 
  # +:liquids+, or +:additives+.
  
  def initialize name, info={}
    @units = 'grams'
    @name = name
    @info = info
    info.each do |k,v| 
      instance_variable_set("@#{k}", v)
    end
  end

  ##
  # Returns a new Ingredient, scaled from current instance by +ratio+
  
  def scale_by ratio
    scaled = Hash.new
    self.info.each do |k, v|
      scaled[k] = v
      scaled[k] = v*ratio  if k == :quantity
    end
    Ingredient.new(self.name, scaled)
  end
end

## 
# This class represents a discrete step in a Recipe.

class Step
  attr_reader :techniques, :ingredients

  ##
  # Creates a new step with the the optional array +techniques+,
  # which consists of  ministep strings, and +Ingredients+.
  #
  # This is intended to read something like:
  # <tt>"Mix:", @flour, @water, "thoroughly."</tt>
  #
  # or:
  #
  # <tt>"Serve forth."</tt>
  
  def initialize *args
    self.techniques = args.flatten
  end

  ##
  # Sets +Step.techniques+ to +args+, and defines +Step.ingredients+
  def techniques= args
    @techniques = args
    @ingredients = args.select{|arg| arg.is_a? Ingredient}
  end
end

##
# This class represents a recipe.

class Recipe
  attr_reader :steps, :metadata
  
  ##
  # Creates a new Recipe with hash +metadata+ and array of Steps +steps+
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
  # Returns an array of all Ingredients in Recipe
  
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
  # Returns the total weight of Ingredients in Recipe
  
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
  # Returns the baker's percentage of a weight
  
  def bakers_percent weight
    weight / bakers_percent_100.to_f
  end

  ##
  # Returns a Formula
  
  def bakers_percent_formula
    ratio = 100.0 / self.total_flours
    self.scale_by ratio
  end
  
  ## 
  # Returns new Recipe scaled by +ratio+

  def scale_by ratio
    new_steps = self.steps.map do |s| 
      step_args =  s.techniques.map do |t| 
        t.is_a?(Ingredient) ? t.scale_by(ratio) : t
      end
      Step.new step_args
    end

    Recipe.new self.metadata, new_steps
  end

  ##
  # Returns a unit-less summary of Recipe in baker's percentages
  
  def bakers_percent_summary
    h = Hash.new
    [:flours, :liquids, :additives].each do |s|
      h["total_#{s}"] = self.bakers_percent eval("self.total_#{s}")
    end
    
    self.ingredients.map do |i|
      h[i.name] = self.bakers_percent i.quantity
    end
    h
  end

end

