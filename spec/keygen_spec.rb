require './lib/keygen'

RSpec.describe KeyGen do
  let(:keygen) { KeyGen.new('12544') }
  it 'exits' do
    actual = keygen
    expected = KeyGen
    expect(actual).to be_a(expected)
  end
  describe '#generate' do
    it 'generates 5 digit random numbers' do
      actual = KeyGen.generate
      expected = '12987'
    end
  end
end
