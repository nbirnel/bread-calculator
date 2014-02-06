load  "#{File.dirname(__FILE__)}/bread-calculator"

describe Formula do
  before do
    @formula = Formula.new
  end

  it 'can write liquid_bp' do
    @formula.liquid_bp=(35).should be_true
  end

  it 'can write and read liquid_bp' do
    @formula.liquid_bp=35
    @formula.liquid_bp.should eq 35
  end

  it 'will not set liquid_bp >100' do
    @formula.liquid_bp=(101).should_not be_true
    # what should it really be? dd
  end
end

describe Recipe do
  before do
    @recipe = Recipe.new
  end

end

