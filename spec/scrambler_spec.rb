require 'simplecov'
SimpleCov.start
require './lib/scrambler'
require './lib/keygen'

RSpec.describe Scrambler do
  let(:scrambler) { Scrambler.new }
  let(:key_gen) { KeyGen.new }
  it 'exists' do
    actual = scrambler
    expected = Scrambler
    expect(actual).to be_a(Scrambler)
  end
  describe '#keys/1' do
    it 'creates a 4 part key values' do
      actual = scrambler.keys('02715')
      expected =
        { A: 2,
          B: 27,
          C: 71,
          D: 15
         }
      expect(actual).to eq(expected)
    end
  end
  describe '#shifts/1' do
    it 'creates offset values' do
      actual = scrambler.shifts('040889')
      expected = [1, 7, 6, 1]
      expect(actual).to eq(expected)
    end
  end

end
