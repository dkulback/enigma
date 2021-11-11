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
    it 'creates a 4 step key values with injected key' do
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
    it 'creates offset values with date' do
      actual = scrambler.shifts('040889')
      expected = {
        A:0,
        B:3,
        C:2,
        D:1
      }
      expect(actual).to eq(expected)
    end
    it 'creates offset values using todays date' do
      actual = scrambler.shifts
      expected = {
        A:6,
        B:6,
        C:4,
        D:1
      }
      expect(actual).to eq(expected)
    end
  end
  describe '#combined/2' do
    it 'combines the key postion with the shifts' do
      actual = scrambler.combined('02715', '040889')
      expected =
      { A: 2,
        B: 30,
        C: 73,
        D: 16
       }
      expect(actual).to eq(expected)
    end
  end

end
