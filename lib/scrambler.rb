class Scrambler
  attr_reader :message, :date, :key, :character_set
  def initialize(message, date, key)
    @message = message
    @date = date
    @key = key
    @character_set = ('a'..'z').to_a << ' '
  end

  def keys(key, date = Date.today.strftime('%d%m%y'))
    keys =
      {
        A: key[0..1].to_i,
        B: key[1..2].to_i,
        C: key[2..3].to_i,
        D: key[3..4].to_i
      }

  end

  def shifts(date = Date.today.strftime('%d%m%y'))
    phase_1 = date.to_i * date.to_i
    phase_2 = phase_1.digits.reverse[-4,4]
    phase_3 = {}
    phase_3[:A] = phase_2[0]
    phase_3[:B] = phase_2[1]
    phase_3[:C] = phase_2[2]
    phase_3[:D] = phase_2[3]
    phase_3
  end

  def combined(key, date = Date.today.strftime('%d%m%y') )
    the_keys = keys(key)
    the_shifts = shifts(date)
    keys_with_shifts = the_keys.merge!(the_shifts) do |h, oldv, newv|
      oldv + newv
    end
  end

  def splice
    shifter = combined(@key, @date)
    indexed = index_values(@message)
    ciphered = ""
    until indexed.count == 0
      if indexed.count > 0
      ciphered.concat(character_set.rotate(indexed[0] + shifter[:A])[0])
      indexed.shift
    end
      if indexed.count > 0
      ciphered.concat(character_set.rotate(indexed[0] + shifter[:B])[0])
      indexed.shift
    end
      if indexed.count > 0
      ciphered.concat(character_set.rotate(indexed[0] + shifter[:C])[0])
      indexed.shift
    end
      if indexed.count >0
      ciphered.concat(character_set.rotate(indexed[0] + shifter[:D])[0])
      indexed.shift
    end
  end
    ciphered
  end

  def index_values(message)
    msg_array = message.chars
    character_set_new = character_set.group_by.with_index{|chr, index,| index }.transform_values{|letter| letter[0]}.invert
    msg_array.each_with_object([]) do |(msg, v), arr|
      arr << character_set_new[msg]
    end
  end
  def index_value_shifts(array_values, shifts)
    shifts.keys.map do |shift|
    end
  end
end
