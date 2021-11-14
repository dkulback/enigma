require_relative 'enigma'
require_relative 'keygen'

handle = File.open(ARGV[0], 'r')

incoming_text = handle.read.strip
handle.close
encrypted_text = Enigma.new.encrypt(incoming_text)

puts encrypted_text
