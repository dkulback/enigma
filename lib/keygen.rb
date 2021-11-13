class KeyGen
  attr_reader :gen_key

  def initialize(gen_key)
    @gen_key = gen_key
  end

  def self.call
    @gen_key = rand(0..10**5).to_s.rjust(5, '0')
  end
end
