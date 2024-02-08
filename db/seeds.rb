puts "Destroying all records..."
User.destroy_all
Chatroom.destroy_all

puts "Creating users..."
User.create(username: "Radahn", email: "rada@rada.com", password: "password") 
User.create(username: "Ranni", email: "ranni@ranni.com", password: "password")

puts "Creating chatrooms..."
Chatroom.create(name: "General")

puts "Done deal!"