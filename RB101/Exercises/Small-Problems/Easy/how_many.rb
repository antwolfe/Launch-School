# Write a method that counts the number of occurrences of each element in a given array.

vehicles = [
  'car', 'car', 'truck', 'car', 'suv', 'SUV', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'TRUCK', 'CAR', 'truck'
]


def count_occurrences(arr)
  arr = arr.map! { |veh| veh.downcase }
  arr.uniq.each_with_object({}) do |ele, hash|
    hash[ele] = arr.count(ele)
  
    puts "#{ele} => #{hash[ele]}"
  end
end

count_occurrences(vehicles)