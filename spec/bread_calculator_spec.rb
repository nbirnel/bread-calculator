require  "#{File.dirname(__FILE__)}/../lib/bread_calculator"

describe BreadCalculator do
  before do
    @ww      = BreadCalculator::Ingredient.new "whole wheat flour", :quantity => 300, :units => 'grams', :type=>:flours
    @ap      = BreadCalculator::Ingredient.new "all purpose flour", :quantity => 700, :units => 'grams', :type=>:flours
    @water   = BreadCalculator::Ingredient.new "water", :quantity => 550, :units => 'grams', :type=>:liquids
    @egg     = BreadCalculator::Ingredient.new "egg", :quantity => 40, :units => 'grams', :type=>:liquids
    @milk    = BreadCalculator::Ingredient.new "dry milk", :quantity => 40, :units => 'grams', :type=>:additives
    @raisins = BreadCalculator::Ingredient.new "raisins", :quantity => 50, :units => 'grams', :type=>:additives
    @yeast   = BreadCalculator::Ingredient.new "yeast", :quantity => 20, :units => 'grams', :type=>:additives
    @proof   = BreadCalculator::Step.new 'Rehydrate', @yeast
    @wet     = BreadCalculator::Step.new 'in', @water, @egg
    @dry     = BreadCalculator::Step.new 'Mix together:', @ww, @ap, @milk, 'in  a large bowl'
    @mix     = BreadCalculator::Step.new 'Combine wet and dry ingredients with', @raisins
    @bake    = BreadCalculator::Step.new 'Form a loaf, rise for 2 hours, Bake at 375° for 45 minutes.'
    @meta    = {:notes => 'nice sandwich bread'}
    @recipe  = BreadCalculator::Recipe.new @meta, [@proof, @wet, @dry, @mix, @bake]
  end

  describe BreadCalculator::Ingredient do
    it 'has a quantity' do
      @ww.quantity = 100
    end
  end

  describe BreadCalculator::Step do
    it 'can be called without arguments' do
      BreadCalculator::Step.new
    end
  end

  describe BreadCalculator::Recipe do
    it 'lists all ingredients and quantities' do
      @recipe.ingredients.length.should eq 7
    end

    it 'displays total weight' do
      @recipe.weight.should eq 1700
    end

    it 'displays total liquids' do
      @recipe.total_liquids.should eq 590
    end

    it 'pretty prints' do
      pending
      @recipe.to_s.is_a?(String).should be_true
    end

    it 'generates a baker\'s percentage summary' do
      @recipe.bakers_percent_summary.should == {

        "total_flours" => 1.0,
        "total_liquids" => 0.59,
        "total_additives" => 0.11,
        "yeast"=>0.02,
        "water"=>0.55,
        "egg"=>0.04,
        "whole wheat flour"=>0.3,
        "all purpose flour"=>0.7,
        "dry milk"=>0.04,
        "raisins"=>0.05
      }
    end

    it 'scales' do
      @scaled = @recipe.scale_by(2)
      ( @scaled.weight == @recipe.weight * 2.0 ).should be_true
    end

    it 'generates a baker\'s percentage formula' do
      @recipe.bakers_percent_formula.is_a?(BreadCalculator::Recipe).should be_true
      @recipe.bakers_percent_formula.total_flours.should eq 100.0
    end

  end

  describe BreadCalculator::Parser do
    before do
      @sample = "#{File.dirname(__FILE__)}/../sample/sandwich-bread.recipe"
      @parser = BreadCalculator::Parser.new 'Sandwich Bread'
      @r = @parser.parse "#{@sample}"
    end

    it 'gets a recipe from a text file' do
      @r.is_a?(BreadCalculator::Recipe).should be_true
    end

    it 'gets a recipe from a standard in' do
      pending
    end

  end

end
