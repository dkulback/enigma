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
    xit 'has a message' do
      actual = scrambler.message
      expected = message
      expect(actual).to eq(expected)
    end
    xit 'has a optional date' do
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
      actual = scrambler.keys
      expected =
        { A: 2,
          B: 27,
          C: 71,
          D: 15 }
      expect(actual).to eq(expected)
    end
  end
  describe '#shifts' do
    it 'creates offset values with date' do
      actual = scrambler.shifts
      expected = {
        A: 1,
        B: 0,
        C: 2,
        D: 5
      }
      expect(actual).to eq(expected)
    end
  end
  describe '#combined' do
    it 'combines the key postion with the shifts' do
      actual = scrambler.combined
      expected =
        { A: 3,
          B: 27,
          C: 73,
          D: 20 }
      expect(actual).to eq(expected)
    end
  end
  describe 'index_values' do
    it 'returns array of index values for a word' do
      actual = scrambler.index_values
      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(actual).to eq(expected)
    end
    it 'doesnt index special characters' do
      scrambler = Scrambler.new('hello world!', key, date)
      actual = scrambler.index_values
      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, '!']
      expect(actual).to eq(expected)
      scrambler = Scrambler.new('<hello world!', key, date)
      actual = scrambler.index_values
      expected = ['<', 7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, '!']
      expect(actual).to eq(expected)
    end
    it 'downcases capital letters' do
      scrambler = Scrambler.new('Hello world', key, date)
      actual = scrambler.index_values
      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(actual).to eq(expected)
    end
  end

  describe '#rotation_values' do
    it 'adds shift values alphabet' do
      actual = scrambler.rotation_values
      expected = [10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76]
      expect(actual).to eq(expected)
    end
    it 'forgives special CHARACTERS' do
      scrambler = Scrambler.new('!Hello! world', date, key)
      actual = scrambler.rotation_values
      expected = ['!', 10, 31, 84, 31, 17, '!', 53, 95, 34, 20, 38, 76]
      expect(actual).to eq(expected)
    end
  end
  describe '#splice' do
    it 'rotates message by keys and offsets' do
      actual = scrambler.splice
      expected = 'keder ohulw'
      expect(actual).to eq(expected)
    end
    it 'skips special characters and downcases uppercase' do
      scrambler = Scrambler.new('!Hello world', date, key)
      actual = scrambler.splice
      expected = '!keder ohulw'
      expect(actual).to eq(expected)
      scrambler = Scrambler.new('!!!Hello wo!rld', date, key)
      actual = scrambler.splice
      expected = '!!!keder oh!ulw'
      expect(actual).to eq(expected)
    end
  end
end
