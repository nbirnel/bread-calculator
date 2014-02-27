require  "#{File.dirname(__FILE__)}/bread_calculator"

describe Recipe do
  before do
    @recipe = Recipe.new
    @recipe.liquids = {:water => 55, :egg => 4}
    @recipe.flours = {:whole_wheat => 30, :all_purpose => 70}
    @recipe.additives = {:dry_milk => 4, :raisins => 5}
  end

  it 'can write and read liquids' do
    @recipe.liquids[:water].should eq 55
  end

  it 'can write and read flours' do
    @recipe.flours[:all_purpose].should eq 70
  end

  it 'can write and read additives' do
    @recipe.additives[:dry_milk].should eq 4
  end

  it 'displays bakers percentage' do
    @recipe.bp(@recipe.liquids[:egg]).should eq 4
  end

  it 'displays total weight' do
    @recipe.weight.should eq 168
  end
end

