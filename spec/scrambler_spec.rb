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
    it 'creates a 4 part keys scramble/1' do
      actual = scrambler.scrambilze(KeyGen.generate)
      expected =
        { A: 12,
          B: 23,
          C: 34,
          D: 45 }
      expect(actual).to eq(Scrambler)
    end
  end
end
