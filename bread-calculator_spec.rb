load  "#{File.dirname(__FILE__)}/bread-calculator"

describe Bakers_percentage do
  before do
    @bp = Bakers_percentage.new
  end

  it 'can write and read liquids' do
    @bp.liquids=35
    @bp.liquids.should eq 35
  end

  it 'will not set liquids >100' do
    @bp.liquids=101
    @bp.liquids.should be_false
  end
end

describe Recipe do
  before do
    @recipe = Recipe.new
  end

end

