class Enigma
  attr_reader :key_gen

  def initialize(key_gen: KeyGen)
    @keygen = key_gen
  end

  def encrypt(message, key = key_gen.call, date = Date.today.strftime('%d%m%y'))
    encrypted =
      {
        encryption: message,
        key: key,
        date: date
      }
  end

  def decrypt(message, key = key_gen.call, date = Date.today.strftime('%d%m%y'))
    encrypted =
      {
        encryption: message,
        key: key,
        date: date
      }
  end
end
