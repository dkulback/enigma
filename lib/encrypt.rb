require_relative 'enigma'
require_relative 'keygen'

handle = File.open('./lib/' + ARGV[0], 'r')

text = handle.read.strip

handle.close

encrypted_text = Enigma.new.encrypt(text)

encryption = File.open('./lib/' + ARGV[1], 'w')

encryption.write(encrypted_text[:encryption])

encryption.close

puts "Created #{encryption.path.sub!('./lib/',
                                     '')} with the key #{encrypted_text[:key]} and date #{encrypted_text[:date]}"
