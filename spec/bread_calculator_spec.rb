require  "#{File.dirname(__FILE__)}/../lib/bread_calculator"



describe Ingredient do
  before do
    @ww = Ingredient.new "whole wheat flour", :quantity => 300, :units => 'grams', :bp_type =>:flour
    @ap = Ingredient.new "all purpose flour", :quantity => 700, :units => 'grams', :bp_type =>:flour
    @water = Ingredient.new "water", :quantity => 550, :units => 'grams', :bp_type =>:liquids
    @egg = Ingredient.new "egg", :quantity => 40, :units => 'grams', :bp_type =>:liquids
    @milk = Ingredient.new "milk powder", :quantity => 40, :units => 'grams', :bp_type =>:additives
    @raisins = Ingredient.new "raisins", :quantity => 50, :units => 'grams', :bp_type =>:additives
    @yeast = Ingredient.new "yeast", :quantity => 20, :units => 'grams', :bp_type =>:additives
  end
  
  it 'has a quantity' do
    @ww.quantity = 100
  end
end

describe Step do
  before do 
    @ww = Ingredient.new "whole wheat flour", :quantity => 300, :units => 'grams', :bp_type =>:flour
    @ap = Ingredient.new "all purpose flour", :quantity => 700, :units => 'grams', :bp_type =>:flour
    @water = Ingredient.new "water", :quantity => 550, :units => 'grams', :bp_type =>:liquids
    @egg = Ingredient.new "egg", :quantity => 40, :units => 'grams', :bp_type =>:liquids
    @milk = Ingredient.new "milk powder", :quantity => 40, :units => 'grams', :bp_type =>:additives
    @raisins = Ingredient.new "raisins", :quantity => 50, :units => 'grams', :bp_type =>:additives
    @yeast = Ingredient.new "yeast", :quantity => 20, :units => 'grams', :bp_type =>:additives
    @proof = Step.new 'Rehydrate', [@yeast]
    @wet   = Step.new 'in', [@water]
    @dry   = Step.new 'Mix together:', [@ww, @ap, @milk], 'in  a large bowl'
    @mix   = Step.new 'Combine wet and dry ingredients with', [@raisins]
    @bake  = Step.new 'Form a loaf, rise for 2 hours, Bake at 375° for 45 minutes.'
  end

  it 'has a technique' do
    @dry.technique.should eq 'Mix together:'
  end

end

describe Recipe do
  before do
    @ww = Ingredient.new "whole wheat flour", :quantity => 300, :units => 'grams', :bp_type =>:flours
    @ap = Ingredient.new "all purpose flour", :quantity => 700, :units => 'grams', :bp_type =>:flours
    @water = Ingredient.new "water", :quantity => 550, :units => 'grams', :bp_type =>:liquids
    @egg = Ingredient.new "egg", :quantity => 40, :units => 'grams', :bp_type =>:liquids
    @milk = Ingredient.new "milk powder", :quantity => 40, :units => 'grams', :bp_type =>:additives
    @raisins = Ingredient.new "raisins", :quantity => 50, :units => 'grams', :bp_type =>:additives
    @yeast = Ingredient.new "yeast", :quantity => 20, :units => 'grams', :bp_type =>:additives
    @proof = Step.new 'Rehydrate', [@yeast]
    @wet   = Step.new 'in', [@water]
    @dry   = Step.new 'Mix together:', [@ww, @ap, @milk], 'in  a large bowl'
    @mix   = Step.new 'Combine wet and dry ingredients with', [@raisins]
    @bake  = Step.new 'Form a loaf, rise for 2 hours, Bake at 375° for 45 minutes.'
    @recipe = Recipe.new 'metadata', [@proof, @wet, @dry, @mix, @bake]
  end

  it 'lists all ingredients and quantities' do
    @recipe.ingredients.length.should eq 6
  end

  it 'displays total weight' do
    @recipe.weight.should eq 1660
  end

  it 'displays total liquids' do
    @recipe.total_liquids.should eq 550
  end

  it 'pretty prints' do
    pending
    @recipe.pretty_print.should eq FIXME
  end

  it 'generates a formula' do
    @recipe.formula.should == {
      :whole_wheat=>0.3,
      :all_purpose=>0.7,
      :water=>0.55,
      :egg=>0.04,
      :dry_milk=>0.04,
      :raisins=>0.05
    }
  end

end

