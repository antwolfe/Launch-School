# Write a method that takes one integer argument, which may be positive, negative, or zero.
# This method returns true if the number's absolute value is odd. 
# You may assume that the argument is a valid integer value.

# P:
# - A method
# - one integer argument (pos, neg, or zero)
# - returns boolean
# - returns true if number's abs value is odd

# E:
# puts is_odd?(2)    # => false
# puts is_odd?(5)    # => true
# puts is_odd?(-17)  # => true
# puts is_odd?(-8)   # => false
# puts is_odd?(0)    # => false
# puts is_odd?(7)    # => true

# D:
# ?? Integer ??

# A:
#  1. Create Method
#  2. ??

def is_odd?(integer)
  integer % 2 == 0? false: true
end

# puts is_odd?(2)    # => false
# puts is_odd?(5)    # => true
# puts is_odd?(-17)  # => true
# puts is_odd?(-8)   # => false
# puts is_odd?(0)    # => false
# puts is_odd?(7)    # => true

def is_odd_remainder?(integer)
  integer.remainder(2) == 1 || integer.remainder(2) == -1
end

puts is_odd_remainder?(5)    # => true
puts is_odd_remainder?(2)    # => false
puts is_odd_remainder?(-17)  # => true
puts is_odd_remainder?(-8)   # => false
puts is_odd_remainder?(0)    # => false
puts is_odd_remainder?(7)    # => true

