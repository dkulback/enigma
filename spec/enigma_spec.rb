require 'simplecov'
SimpleCov.start
require './lib/enigma'

RSpec.describe Enigma do
  class MockGenKey
    def initialize(key)
      @key = key
    end

    def call
      @key
    end
  end
  let(:mock_key) { '01234' }
  let(:mock_generate_key) { MockGenKey.new(mock_key) }
  let(:enigma) { Enigma.new(key_generator: mock_generate_key) }

  it 'exists' do
    actual = enigma
    expected = Enigma
    expect(actual).to be_a(expected)
  end

  describe '#encrypt/3' do
    xit 'encrypts messages with key and date' do
      actual = enigma.encrypt('hello world', '02715', '040895')
      expected =
        {
          encryption: 'keder ohulw',
          key: '02715',
          date: '040895'
        }
      expect(actual).to eq(expected)
    end
  end
  describe 'encrypt/2' do
    before do
      Timecop.freeze_at('1995-04-08')
    end
    xit 'encrypts messages with key and uses todays date' do
      actual = enigma.encrypt('hello world', '02715')
      expected =
        {
          encryption: 'keder ohulw',
          key: '02715',
          date: Date.today
        }
      expect(actual).to eq(expected)
    end
  end
  describe 'encrypt/1' do
    before do
      Timecop.freeze_at('1995-04-08')
    end
    it 'encrypts messages by generating a key and uses today date' do
      actual = enigma.encrypt('hello world')
      expected =
        {
          encryption: 'keder ohulw',
          key: mock_key,
          date: Date.today
        }
      expect(actual).to eq(expected)
    end
  end
  describe '#decrypt/3' do
    xit 'decrypts messages' do
      actual = enigma.decrypt('keder ohulw', '02715', '040895')
      expected =
        {
          encryption: 'hello world',
          key: '02715',
          date: '040895'
        }
      expect(actual).to eq(expected)
    end
    describe '#decrypt/2' do
      xit 'decrypts messages with key and uses todays date' do
        actual = enigma.decrypt('keder ohulw', '02715')
        expected =
          {
            encryption: 'hello world',
            key: '02715',
            date: Date.today
          }
        expect(actual).to eq(expected)
      end
    end
    describe '#decrypt/1' do
      xit 'decrypts messages by generating a key and uses today date' do
        actual = enigma.decrypt('keder ohulw')
        expected =
          {
            encryption: 'hello world',
            key: GenKey.new,
            date: Date.today
          }
        expect(actual).to eq(expected)
      end
    end
  end
end
