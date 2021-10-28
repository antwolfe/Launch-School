require "pry"


puts "Please pick 1 or 2"
user_input = gets.chomp
binding.pry
if user_input == 1
  puts "You picked 1"
elsif user_input == 2
  puts "you picked 2"
else
  puts "Invalid input"
end

