require  "#{File.dirname(__FILE__)}/bread_calculator"

describe Formula do
  before do
    @formula = Formula.new
  end

  it 'can write and read liquids' do
    @formula.liquids = {:water => 55, :egg => 4}
    @formula.liquids[:water].should eq 55
  end

  it 'sets a baker\'s percentage' do
    pending
  end
end

