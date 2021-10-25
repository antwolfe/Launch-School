books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

# counter = 0
# years_arr = []

# loop do
#   current_book = books[counter]
#   year = current_book[:published]
#   years_arr << year
#   break if years_arr.size == books.size
#   counter += 1
# end

# p years_arr.map {|el| el.to_i}.sort


books.sort_by do |book|
  book[:published]
end

puts books