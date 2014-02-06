load  "#{File.dirname(__FILE__)}/bread-calculator"

describe Bakers_percentage do
  before do
    @bp = Bakers_percentage.new
  end

  it 'can write and read liquid' do
    @bp.liquid=35
    @bp.liquid.should eq 35
  end

  it 'will not set liquid >100' do
    @bp.liquid=(101).should_not be_true
  end
end

describe Recipe do
  before do
    @recipe = Recipe.new
  end

end

