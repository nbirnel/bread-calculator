def human_round number, base_precision = 0
    precision = base_precision
    if number < 10
      precision = base_precision + 1
    end
    if number < 1
      precision = base_precision + 2
    end
    f_number = sprintf "%.#{precision}f", number
end

##
# Classes for manipulating bread recipes and baker's percentages

module BreadCalculator

  require 'cgi'

  ##
  # Make a reasonably precise representation of +number+
  
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
      #@units = 'grams'
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

    #FIXME refactor scale_by and as_bp 
    
    ##
    # Returns a new unitless Ingredient as a baker's percentage of +bp_100+
    
    def as_bp bp_100
      info = self.info.reject{|k,v| k == :units}

      scaled = Hash.new
      info.each do |k, v|
        scaled[k] = v
        scaled[k] = v / bp_100.to_f  if k == :quantity
      end
      Ingredient.new(self.name, scaled)
    end
    
    ##
    # Print a nice text version of Ingredient
    
    def to_s
      #FIXME check for existance
      "\t#{human_round(@quantity)} #{@units} #{@name}\n"
    end

    ##
    # Print ingredient as an html unordered list item
    
    def to_html
      "  <li>#{CGI.escapeHTML(self.to_s.strip.chomp)}</li>\n"
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
    
    ##
    # Print a nice text version of Step
    
    def to_s
      out = ''
      self.techniques.each do |t| 
        tmp =  t.is_a?(Ingredient) ? t.to_s : "#{t.chomp}\n"
        out << tmp
      end
      out << "\n"
      out
    end

    ##
    # Print Step as an html paragraph

    def to_html
      out = "<p>\n"
      self.techniques.each do |t| 
        tmp =  t.is_a?(Ingredient) ? t.to_html : "#{CGI.escapeHTML(t.chomp)}"
        out << tmp
      end
      out << "\n</p>\n"
      out
    end

  end

  ##
  # This class represents a recipe.
  #
  # Runtime-generated methods:
  #
  #     total_flours 
  #     total_liquids
  #     total_additives
  #
  # return totals of their respective types

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
        step_args = s.techniques.map do |t| 
          t.is_a?(Ingredient) ? t.scale_by(ratio) : t
        end
        Step.new step_args
      end

      Recipe.new self.metadata, new_steps
    end

    ##
    # Returns a Summary
    
    def summary
      new_meta = self.metadata
      [:flours, :liquids, :additives].each do |s|
        new_meta["total_#{s}"] = eval "self.bakers_percent self.total_#{s}"
      end
      
      #l_ingredients = Hash.new
      #self.ingredients.map do |i|
      #  l_ingredients[i.name] = self.bakers_percent i.quantity
      #end

      new_steps = self.steps.map do |s| 
        step_args = s.techniques.map do |t| 
          t.is_a?(Ingredient) ? t.as_bp(self.bakers_percent_100) : t
        end
        Step.new step_args
      end

      Summary.new new_meta, new_steps
    end

    ##
    # Print a nice text version of Recipe
    
    def to_s
      out = ''
      self.metadata.each{|k,v| out << "#{k}: #{v}\n"}
      out << "--------------------\n"
      self.steps.each{|s| out << s.to_s }
      out
    end

    ##
    # Print recipe as html.
    # It is the caller's responsibility to provide appropriate headers, etc.

    def to_html
      out = ''
      self.metadata.each{|k,v| out << "<p>\n<b>#{k}</b>: #{v}\n</p>\n"}
      out << "--------------------\n"
      self.steps.each{|s| out << s.to_html }
      out
    end

  end

  ##
  # This class represents a summary of a Recipe - like a Recipe, but:
  #
  # Ingredients will be unitless 
  # and the quantities expressed in baker's percentages,
  #
  # Metadata will include baker's percentages of 
  # flours, liquids, and additives.

  class Summary < Recipe

    def initialize metadata, steps
      super
    end

    def weight
      nil
    end

    def summary
      self
    end

    def to_s
      out = ''
      # find totals and *100, conditional sprintf
      self.metadata.each{|k,v| out << "#{k}: #{v}\n"}
      out << "--------------------\n"
      self.steps.each{|s| out << s.to_s }
      out
    end

  end

  ##
  # This class converts a nearly free-form text file to a Recipe
  
  class Parser

    ##
    # Create a new parser for Recipe
    
    def initialize
      @i = 0
      @args = @steps = []
      @steps[0] = BreadCalculator::Step.new

      @in_prelude = true
      @prelude = ''
      @metadata = Hash.new(nil)
    end

    ##
    # Parse text from IO object +input+. It is the caller's responsibility to
    # open and close the +input+ correctly.
    #
    # text recipes consist of a metadata prelude followed by steps.
    #
    # In prelude lines,
    # anything before a colon is considered to be the name of a metadata field;
    # anything after the colon is a value to populate.
    # Lines without colons are continuations of the 'notes' field.
    # I suggest having at least a 'name' field.
    # 
    # A line starting with a hyphen ends the prelude and starts the first step. 
    # 
    # Each step is delimited by one or more blank lines.
    # 
    # Any line in a step starting with a space or a blank is an ingredient,
    # consisting of quantity, units, and the ingredient itself.
    #
    # A brief sample:
    #
    #     name: imaginary bread
    #     notes: This is a silly fake bread recipe
    #     makes: 1 bad loaf
    #     This line will become part of the notes
    #     ---------------------
    #     Mix:
    #       500 g flour
    #       300 g water
    #
    #     Bake at 375°

    def parse input

      while line = input.gets
        new_step              && next if line =~ /(^-)|(^\s*$)/
        preprocess_meta(line) && next if @in_prelude

        @args << preprocess_step(line.chomp)
      end   

      close_step
      # because we made a spurious one to begin with
      @steps.shift
      Recipe.new @metadata, @steps
    end

    private

    def new_step
      @in_prelude = false
      close_step

      @args = []
      @i += 1
      @steps[@i] = BreadCalculator::Step.new
    end

    def close_step
      @steps[@i].techniques = @args
    end

    def preprocess_meta line
      /^((?<key>[^:]+):)?(?<value>.*)/ =~ line
      match = Regexp.last_match
      key = match[:key] ? match[:key].strip.to_sym : :notes
      if @metadata[key]
        @metadata[key] << "\n\t"
      else
        @metadata[key] = ''
      end
      @metadata[key] << match[:value].strip
    end

    def preprocess_step line
      ing_regex = /^\s+((?<qty>[0-9.]+\s*)(?<units>g)?\s+)?(?<item>.*)/
      h = Hash.new
      if ing_regex =~ line 
        match = Regexp.last_match
        h[:quantity] = match[:qty].strip.to_f
        h[:units]    = match[:units]
        ingredient   = match[:item].strip

        #FIXME refactor
        h[:type] = :additives #if it doesn't match anything else
        h[:type] = :flours    if ingredient =~ /meal/
        h[:type] = :liquids   if ingredient =~ /water/
        h[:type] = :liquids   if ingredient =~ /egg/
        h[:type] = :liquids   if ingredient =~ /mashed/
        h[:type] = :liquids   if ingredient =~ /milk/
        h[:type] = :additives if ingredient =~ /dry/
        h[:type] = :additives if ingredient =~ /powdered/

        h[:type] = :flours    if ingredient =~ /flour/
        h[:type] = :liquids   if ingredient =~ /liquid/
        h[:type] = :liquids   if ingredient =~ /additive/

        ing = BreadCalculator::Ingredient.new ingredient, h
      else
        line.strip
      end
    end

  end

end
