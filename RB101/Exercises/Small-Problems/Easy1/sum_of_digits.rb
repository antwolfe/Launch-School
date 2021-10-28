=begin

# Write a method that takes one argument, a positive integer, 
# and returns the sum of its digits.

Problem - 
input: integer
output: integer
main objective:  take a positive integer and add all individual digits
-ignore spaces


Data Structures - 
array


Algorithm - 

Create an array
Add individual integers into array without looping
sum up the array
output the sum

=end



def sum(int)
  arr = int.digits
  result = arr.sum

  result
end




puts sum(23)  == 5
puts sum(496) == 19
puts sum(123_456_789) == 45