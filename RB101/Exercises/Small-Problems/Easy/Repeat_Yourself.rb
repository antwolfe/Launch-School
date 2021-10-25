# Write a method that takes two arguments, a string and a positive integer, 
# and prints the string as many times as the integer indicates.

# Problem: 

# **Rules**
#  - Method
#  - Takes two arguments 
#  - Input: a string, a positive integer
#  - Output: string or multiple strings
#  - Must output string according to integer arguments

#  **Examples**
#  repeat('Hello', 3) --> 
#  Hello
#  Hello
#  Hello

# **Data Structure**
# String

# **Algorithm**
 
def repeat(input_str, number)
  number.times {puts input_str}
end

repeat('Hello', 3)


