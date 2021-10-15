# Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.

# P: 
# - a method
# - input: a positive integer
# - output: array of digits

# E: 
# puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
# puts digit_list(7) == [7]                     # => true
# puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
# puts digit_list(444) == [4, 4, 4]             # => true

# D: 
# array
# [1, 2, 3, 4, 5]

# A:
# 1. Create method w/ integer as argument
# 2. Create empty array for output
# 3. Add each digit to empty array
# 4. Output completed array

def digit_list(integer)
 integer.digits.reverse
end

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true
