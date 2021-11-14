require_relative 'scrambler'
require_relative 'descrambler'
require 'date'

class Enigma
  attr_reader :key_gen

  def initialize(key_gen: KeyGen)
    @key_gen = key_gen
  end

  def encrypt(message, key = key_gen.call, date = Date.today.strftime('%d%m%y'))
    encrypted =
      {
        encryption: Scrambler.new(message, date, key).splice,
        key: key,
        date: date
      }
  end

  def decrypt(message, key = key_gen.call, date = Date.today.strftime('%d%m%y'))
    decrypted =
      {
        decryption: Descrambler.new(message, date, key).desplice,
        key: key,
        date: date
      }
  end
end
