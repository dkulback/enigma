require 'simplecov'
SimpleCov.start
require './lib/scrambler'
require './lib/keygen'

RSpec.describe Scrambler do
  let(:message) { 'hello world' }
  let(:key) { '02715' }
  let(:date) { '040895' }
  let(:scrambler) { Scrambler.new(message, date, key) }
  let(:key_gen) { KeyGen.new }
  it 'exists' do
    actual = scrambler
    expected = Scrambler
    expect(actual).to be_a(expected)
  end
  describe '#attrbutes' do
    it 'has a message' do
      actual = scrambler.message
      expected = message
      expect(actual).to eq(expected)
    end
    it 'has a optional date' do
      actual = scrambler.date
      expected = date
      expect(actual).to eq(expected)
    end
    it 'has a optional key' do
      actual = scrambler.key
      expected = key
      expect(actual).to eq(expected)
    end
  end
  describe '#keys/1' do
    it 'creates a 4 step key values with injected key' do
      actual = scrambler.keys('02715')
      expected =
        { A: 2,
          B: 27,
          C: 71,
          D: 15 }
      expect(actual).to eq(expected)
    end
  end
  describe '#shifts/1' do
    it 'creates offset values with date' do
      actual = scrambler.shifts('040889')
      expected = {
        A: 0,
        B: 3,
        C: 2,
        D: 1
      }
      expect(actual).to eq(expected)
    end
    it 'creates offset values using todays date' do
      actual = scrambler.shifts
      expected = {
        A: 6,
        B: 6,
        C: 4,
        D: 1
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
          D: 16 }
      expect(actual).to eq(expected)
    end
  end
  describe '#splice/1' do
    xit 'splices message' do
      scrambler.combined('02715', '040895')
      actual = scrambler.splice_word('hello world')
      expected = 'keder ohulw'
      expect(actual).to eq(expected)
    end
  end
  describe 'index_values/1' do
    it 'returns array of index values for a word' do
      actual = scrambler.index_values('hello world')
      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(actual).to eq(expected)
    end
  end
end
