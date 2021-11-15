require_relative 'enigma'
require_relative 'keygen'

handle = File.open('./lib/' + ARGV[0], 'r')

text = handle.read.strip

handle.close

decrypted_text = Enigma.new.decrypt(text, ARGV[2], ARGV[3])

decryption = File.open('./lib/' + ARGV[1], 'w')

decryption.write(decrypted_text[:decryption])
decryption.close

puts "Created #{decryption.path.sub!('./lib/',
                                     '')} with the key #{decrypted_text[:key]} and date #{decrypted_text[:date]}"
