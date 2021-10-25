# Write a method that takes one argument, a positive integer, 
# and returns a string of alternating 1s and 0s, always starting with 1. 
# The length of the string should match the given integer.

def stringy(input)
  result = []
  counter = 0

  result << '1'
  
  until result.size == input
    result[counter] == '1'? result << '0' : result << '1'
    counter += 1
  end
  
  result.join('')
end

# def stringy(int)
#   result = []

#   loop do
#     break if result.size == int
#     result << '1'
#     break if result.size == int
#     result << '0'
#     break if result.size == int
#   end
  
#   result.join('')
# end


puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

