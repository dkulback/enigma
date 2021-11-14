require 'simplecov'
SimpleCov.start

require './lib/enigma'
require './lib/scrambler'
require 'timecop'

RSpec.describe Enigma do
  class MockGenKey
    def initialize(key)
      @key = key
    end

    def call
      @key
    end
  end

  let(:date) {Timecop.freeze(Date.today.strftime('%y%m%d'))}
  let(:mock_key) { '01234' }
  let(:mock_generate_key) { MockGenKey.new(mock_key) }
  let(:enigma) { Enigma.new(key_gen: mock_generate_key) }

  it 'exists' do
    actual = enigma
    expected = Enigma
    expect(actual).to be_a(expected)
  end

  describe '#encrypt/3' do
    it 'encrypts messages with key and date' do
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
    it 'encrypts messages with key and uses todays date' do
      actual = enigma.encrypt('hello world', '02715')
      expected =
        {
          encryption: 'pkfawfqdzry',
          key: '02715',
          date: date.strftime('%d%m%y')
        }
      expect(actual).to eq(expected)
    end
  end
  describe 'encrypt/1' do
    it 'encrypts messages by generating a key and uses today date' do
      actual = enigma.encrypt('hello world')
      expected =
        {
          encryption: "owltvrwwycd",
          key: mock_key,
          date: date.strftime('%d%m%y')
        }
      expect(actual).to eq(expected)
    end
  end
  describe '#decrypt/3' do
    it 'decrypts messages' do
      actual = enigma.decrypt('keder ohulw', '02715', '040895')
      expected =
        {
          encryption: 'hello world',
          key: '02715',
          date: '040895'
        }
      expect(actual).to eq(expected)
    end
  end
    describe '#decrypt/2' do
      it 'decrypts messages with key and uses todays date' do
        actual = enigma.decrypt("pkfawfqdzry", '02715')
        expected =
          {
            encryption: 'hello world',
            key: '02715',
            date: date.strftime('%d%m%y')
          }
        expect(actual).to eq(expected)
      end
    end
    describe '#decrypt/1' do
      it 'decrypts messages by generating a key and uses today date' do
        actual = enigma.decrypt("owltvrwwycd")
        expected =
          {
            encryption: 'hello world',
            key: mock_key,
            date: date.strftime('%d%m%y')
          }
        expect(actual).to eq(expected)
      end
    end
  end
