class Scrambler
  attr_reader :message, :date, :key, :character_set

  def initialize(message, date, key)
    @message = message
    @date = date
    @key = key
    @character_set = ('a'..'z').to_a << ' '
  end

  def keys
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
    indexed = {}
    character_set.each_with_index { |c, i| indexed[c] = i }
    msg_array.each_with_object([]) do |c, result|
      result << (indexed[c] || c)
    end
  end

  def remove_strings
    index_values.reject { |a| a.is_a?(String) }.each_slice(4).to_a
  end

  def add_cipher
    rotated = []
    remove_strings.each do |a|
      rotated << a.zip(combined.values).map(&:sum)
    end
    rotated.flatten
  end

  def splice
    ciphered = ''
    add_cipher.each do |value|
      ciphered.concat(character_set.rotate(value)[0])
    end
    index_values.each_with_index do |c, i|
      ciphered.insert(i, c) if c.is_a? String
    end
    ciphered
  end
end
