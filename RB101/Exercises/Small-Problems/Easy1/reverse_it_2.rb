# Write a method that takes one argument, 
# a string containing one or more words, 
# and returns the given string with words that contain five 
# or more characters reversed. 
# Each string will consist of only letters and spaces. 
# Spaces should be included only when more than one word is present.


def reverse_words(str)
  result = []

   str.split.map do |word| 
    if word.length >= 5
      result << word.reverse
    else
      result << word      
    end
  end

  result.join(" ")
end


puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS