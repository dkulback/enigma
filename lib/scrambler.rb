class Scrambler

  def keys_shifts(key, date = Date.today.strftime('%d%m%y'))
    keys =
      {
        A: key[0..1].to_i,
        B: key[1..2].to_i,
        C: key[2..3].to_i,
        D: key[3..4].to_i
      }
    phase_1 = date.to_i * date.to_i
    phase_2 = phase_1.digits[-4, 4]
  end

  def shifts(date = Date.today.strftime('%d%m%y'))
    phase_1 = date.to_i * date.to_i
    phase_2 = phase_1.digits[-4, 4]
  end
end
