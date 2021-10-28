=begin

Write a method that takes two arguments, 
a positive integer and a boolean, and calculates the bonus 
or a given salary. If the boolean is true, 
the bonus should be half of the salary. 
If the boolean is false, the bonus should be 0.


Problem- 
input: a positive integer, a boolean
output: an integer 
main obj: if the boolean is true return half of the pos. int.
if the boolean is false return 0

Data Structure- 
none

Algorithm-
Define a method that has a positive int & boolean as parameters
READ positive int.
if boolean is true, divide pos. int by 2
  output the result
else
  output 0
end

=end

def calculate_bonus(number, boolean_val)
  boolean_val ? (number / 2) : 0
end


puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000