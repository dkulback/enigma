require_relative 'scrambler'

class Descrambler < Scrambler
  def initialize(message, date, key)
    super(message, date, key)
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
      item.inject(:-)
    end

    phase_3 = index_values.map.with_index do |letter, iv|
      phase_2.insert(iv, letter) if letter.instance_of?(String)
    end
    phase_2
  end

  def desplice
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
