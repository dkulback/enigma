class Scrambler

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

end
