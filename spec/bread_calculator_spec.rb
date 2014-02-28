require  "#{File.dirname(__FILE__)}/../lib/bread_calculator"

describe Recipe do
  before do
    @recipe = Recipe.new
    @recipe.liquids = {:water => 55, :egg => 4}
    @recipe.flours = {:whole_wheat => 30, :all_purpose => 70}
    @recipe.additives = {:dry_milk => 4, :raisins => 5}
  end

  it 'can read flours' do
    @recipe.flours[:all_purpose].should eq 70
  end
  it 'displays bakers percentage' do
    @recipe.bp(@recipe.liquids[:egg]).should eq 4
  end

  it 'displays bakers percentage more easily' do
    pending
    @recipe.bp(:egg).should eq 4
  end

  it 'displays total weight' do
    @recipe.weight.should eq 168
  end

  it 'pretty prints' do
    pending
    @recipe.pretty_print.should eq FIXME
  end

  it 'generates a formula' do
    pending
    @recipe.formula.should eq FIXME
  end
end

