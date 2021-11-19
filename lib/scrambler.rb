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
    index_alphabet = character_set.each_with_index.map do |letter, index|
      [letter, index]
    end.to_h
    msg_array = message.downcase.chars
    msg_array.each_with_object([]) do |(msg, _v), arr|
      arr << if !character_set.include?(msg)
               msg
             else
               index_alphabet[msg]
             end
    end
  end

  def rotation_values
    shifts = combined.values
    phase_1 = shifts.map do |shift|
      until shifts.length == index_values.count { |value| value.instance_of?(Integer) }
        shifts << shift
        break
      end
    end
    phase_2 = index_values.reject { |value| value.instance_of?(String) }.zip(shifts).flat_map do |item|
      item.sum
    end

    phase_3 = index_values.map.with_index do |letter, iv|
      phase_2.insert(iv, letter) if letter.instance_of?(String)
    end

    phase_2
  end

  def splice
    ciphered = ''
    rotation_values.map do |value|
      if value.instance_of?(String)
        ciphered.concat(value)
      else
        ciphered.concat(character_set.rotate(value)[0])
      end
    end
    ciphered
  end
end
