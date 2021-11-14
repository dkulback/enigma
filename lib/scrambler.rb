class Scrambler
  attr_reader :message, :date, :key, :character_set

  def initialize(message, date, key)
    @message = message
    @date = date
    @key = key
    @character_set = ('a'..'z').to_a << ' '
  end

  def keys
    keys =
      {
        A: key[0..1].to_i,
        B: key[1..2].to_i,
        C: key[2..3].to_i,
        D: key[3..4].to_i
      }
  end

  def shifts
    phase_1 = @date.to_i * @date.to_i
    phase_2 = phase_1.digits.reverse[-4, 4]
    phase_3 = {}
    phase_3[:A] = phase_2[0]
    phase_3[:B] = phase_2[1]
    phase_3[:C] = phase_2[2]
    phase_3[:D] = phase_2[3]
    phase_3
  end

  def combined
    keys.merge!(shifts) do |_h, oldv, newv|
      oldv + newv
    end
  end

  def index_values
    msg_array = message.downcase.chars
    character_set_new = character_set.group_by.with_index do |_chr, index,|
                          index
                        end.transform_values { |letter| letter[0] }.invert
    msg_array.each_with_object([]) do |(msg, _v), arr|
      if !character_set.include?(msg)
        arr << msg
      else
      arr << character_set_new[msg]
    end
    end
  end

  def splice
    message_values = index_values
    ciphered = ''
    until message_values.count == 0
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] + combined[:A])[0])
        message_values.shift
      end
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] + combined[:B])[0])
        message_values.shift
      end
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] + combined[:C])[0])
        message_values.shift
      end
      while message_values.count > 0 && message_values[0].class == String
        ciphered.concat(message_values[0])
        message_values.shift
      end
      if message_values.count > 0
        ciphered.concat(character_set.rotate(message_values[0] + combined[:D])[0])
        message_values.shift
      end
    end
    ciphered
  end
end
