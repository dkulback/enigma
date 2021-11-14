require 'simplecov'
SimpleCov.start
require './lib/descrambler'
require './lib/scrambler'
require './lib/keygen'

RSpec.describe Descrambler do
  let(:message) { 'keder ohulw' }
  let(:key) { '02715' }
  let(:date) { '040895' }
  let(:descrambler) { Descrambler.new(message, date, key) }
  let(:key_gen) { KeyGen.new }
  it 'exists' do
    actual = descrambler
    expected = Descrambler
    expect(actual).to be_a(expected)
  end
  describe '#attrbutes' do
    it 'has a message' do
      actual = descrambler.message
      expected = message
      expect(actual).to eq(expected)
    end
    it 'has a date' do
      actual = descrambler.date
      expected = date
      expect(actual).to eq(expected)
    end
    it 'has a key' do
      actual = descrambler.key
      expected = key
      expect(actual).to eq(expected)
    end
  end
  describe '#desplice' do
    it 'desplices message with key and date' do
        actual = descrambler.desplice
        expected = 'hello world'
        expect(actual).to eq(expected)
        descrambler = Descrambler.new('keder ohulw!', date, key)
        actual = descrambler.desplice
        expected = 'hello world!'
        expect(actual).to eq(expected)
        descrambler = Descrambler.new("pkfawfqdzry", "131121", "02715")
        actual = descrambler.desplice
        expected = 'hello world'
        expect(actual).to eq(expected)
      end
    end
end
