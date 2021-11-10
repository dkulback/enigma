require 'simplecov'
SimpleCov.start
require './lib/enigma'

RSpec.describe Enigma do
  let(:enigma) { Enigma.new }
  it 'exists' do
    actual = enigma
    expected = Enigma
    expect(actual).to be_a(expected)
  end

  describe '#encrypt/3' do
    it 'encrypts messages with key and date' do
      actual = enigma.encrypt("hello world", "02715", "040895")
      expected =
      {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      expect(actual).to eq(expected)
    end
    xit 'encrypts messages with key and uses todays date' do
      actual = enigma.encrypt("hello world", "02715")
      expected =
      {
        encryption: "keder ohulw",
        key: "02715",
        date: Date.today
      }
      expect(actual).to eq(expected)
    end
    xit 'encrypts messages by generating a key and uses today date' do
      actual = enigma.encrypt("hello world")
      expected =
      {
        encryption: "keder ohulw",
        key: GenerateKey.new,
        date: Date.today
      }
      expect(actual).to eq(expected)
    end
  end
  describe '#decrypt/3' do
    xit 'decrypts messages' do
      actual = enigma.decrypt("keder ohulw", "02715", "040895")
      expected =
      {
        encryption: "hello world",
        key: "02715",
        date: "040895"
      }
      expect(actual).to eq(expected)
    end
    xit 'decrypts messages with key and uses todays date' do
      actual = enigma.decrypt("keder ohulw", "02715")
      expected =
      {
        encryption: "hello world",
        key: "02715",
        date: Date.today
      }
      expect(actual).to eq(expected)
    end
    xit 'decrypts messages by generating a key and uses today date' do
      actual = enigma.decrypt("keder ohulw", "02715", "040895")
      expected =
      {
        encryption: "hello world",
        key: GenerateKey.new,
        date: Date.today
      }
      expect(actual).to eq(expected)
    end
  end
end
