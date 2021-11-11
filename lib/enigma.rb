class Enigma
  attr_reader :key_gen

  def initialize(key_gen: KeyGen)
    @keygen = keygen
  end

  def encrypt(message, key = key_gen.call, date = Date.today)
    encrypted =
      {
        encryption: message,
        key: key,
        date: date
      }
  end

  def decrypt(message, key = key_gen.call, date = Date.today)
    encrypted =
      {
        encryption: message,
        key: key,
        date: date
      }
  end
end
