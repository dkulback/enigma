class Scrambler
  attr_reader :message, :date, :key, :character_set

  def initialize(message, date, key)
    @message = message
    @date = date
    @key = key
    @character_set = ('a'..'z').to_a << ' '
  end

  def keys(key, _date = Date.today.strftime('%d%m%y'))
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
    phase_2 = phase_1.digits.reverse[-4, 4]
    phase_3 = {}
    phase_3[:A] = phase_2[0]
    phase_3[:B] = phase_2[1]
    phase_3[:C] = phase_2[2]
    phase_3[:D] = phase_2[3]
    phase_3
  end

  def combined(key, date = Date.today.strftime('%d%m%y'))
    the_keys = keys(key)
    the_shifts = shifts(date)
    keys_with_shifts = the_keys.merge!(the_shifts) do |_h, oldv, newv|
      oldv + newv
    end
  end

  def splice_word(word)
    scramble_word = word.split('')
    rotator = combined(key, date)
    new_word = ' '
    character_set_1 = character_set.group_by.with_index do |_chr, index,|
                        index
                      end.transform_values { |letter| letter[0] }.invert
    scramble_word.map do |letter|
      rotator.map do |k, _v|
        character_set.rotate(character_set_1[letter] + rotator[k])
      end
    end
  end

  def index_values(message)
    msg_array = message.split('')
    character_set_new = character_set.group_by.with_index do |_chr, index,|
                          index
                        end.transform_values { |letter| letter[0] }.invert
    msg_array.each_with_object([]) do |(msg, _v), arr|
      arr << character_set_new[msg]
    end
  end
end
