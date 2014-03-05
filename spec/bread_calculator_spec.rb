require  "#{File.dirname(__FILE__)}/../lib/bread_calculator"

describe 'bread_calculator' do
  before do
    @ww      = Ingredient.new "whole wheat flour", :quantity => 300, :units => 'grams', :type=>:flours
    @ap      = Ingredient.new "all purpose flour", :quantity => 700, :units => 'grams', :type=>:flours
    @water   = Ingredient.new "water", :quantity => 550, :units => 'grams', :type=>:liquids
    @egg     = Ingredient.new "egg", :quantity => 40, :units => 'grams', :type=>:liquids
    @milk    = Ingredient.new "dry milk", :quantity => 40, :units => 'grams', :type=>:additives
    @raisins = Ingredient.new "raisins", :quantity => 50, :units => 'grams', :type=>:additives
    @yeast   = Ingredient.new "yeast", :quantity => 20, :units => 'grams', :type=>:additives
    @proof   = Step.new 'Rehydrate', @yeast
    @wet     = Step.new 'in', @water, @egg
    @dry     = Step.new 'Mix together:', @ww, @ap, @milk, 'in  a large bowl'
    @mix     = Step.new 'Combine wet and dry ingredients with', @raisins
    @bake    = Step.new 'Form a loaf, rise for 2 hours, Bake at 375° for 45 minutes.'
    @recipe  = Recipe.new 'metadata', [@proof, @wet, @dry, @mix, @bake]
  end

  describe Ingredient do
    it 'has a quantity' do
      @ww.quantity = 100
    end
  end

  describe Step do
    it 'can be called without arguments' do
      Step.new
    end
  end

  describe Recipe do
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
      @recipe.pretty_print.should eq FIXME
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


  end

end
