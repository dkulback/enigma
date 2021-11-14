require './scrambler'
class Descrambler < Scrambler

  def initialize(message, date, key)
    super(message, date, key)
  end

  def desplice
    message_values = index_values
    ciphered = ''
    until message_values.count == 0
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] - combined[:A])[0])
        message_values.shift
      end
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] - combined[:B])[0])
        message_values.shift
      end
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] - combined[:C])[0])
        message_values.shift
      end
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] - combined[:D])[0])
        message_values.shift
      end
    end

    ciphered
  end
end
