class Enigma
  attr_reader :key_generator
  def initialize(key_generator: GenerateKey)
    @key_generator = key_generator
  end
  def encrypt(message, key = key_generator.call, date = Date.today)
      encrypted =
      {
        encryption: message,
        key: key,
        date: date
      }
end
