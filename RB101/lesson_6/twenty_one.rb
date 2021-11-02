require 'pry'
=begin

1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.

=end

# rubocop:disable Layout/HashAlignment
CARDS_HSH = {
  'Ace'   => [11, 1],
  'King'  => 10,
  'Queen' => 10,
  'Jack'  => 10,
  '2'     => 2,
  '3'     => 3,
  '4'     => 4,
  '5'     => 5,
  '6'     => 6,
  '7'     => 7,
  '8'     => 8,
  '9'     => 9,
  '10'    => 10
}
# rubocop:enable Layout/HashAlignment

YES_NO = ['y', 'yes', 'n', 'no']
HIT_STAY = ['h', 'hit', 's', 'stay']

def total(cards)
  sum = 0

  cards.map do |card|
    value = CARDS_HSH[card] if CARDS_HSH.key?(card)

    sum +=
      if card == 'Ace'
        value[0]
      else
        value.to_i
      end
  end

  cards.select { |is_ace| is_ace == 'Ace' }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def user_turn(players_hand)
  answer = nil

  loop do
    puts "Your total is: #{total(players_hand)}"
    break if busted?(players_hand)
    puts '(h)it or (s)tay?'
    answer = gets.chomp.downcase

    newline
    if answer == ('s' || 'stay') || busted?(players_hand)
      break
    elsif answer == 'h' || 'hit'
      deal_card(players_hand)
    else
      puts "Try Again"
    end
  end

  if busted?(players_hand)
    puts "Busted. Dealer Wins!"
    "Busted"
  else
    puts 'You chose to stay'
  end
end

def dealer_turn(dealers_hand)
  loop do
    puts "Dealer's hand is: #{show_hand(dealers_hand)}"
    puts "Dealer's total is: #{total(dealers_hand)}"
    newline
    break if total(dealers_hand) >= 17
    deal_card(dealers_hand)
  end

  if busted?(dealers_hand)
    newline
    puts "Busted. Player Wins!!"
    "Busted"
  end
end

def busted?(cards)
  total(cards) > 21
end

def deal_card(to_hand)
  to_hand << CARDS_HSH.keys.sample
end

def show_hand(cards)
  cards.to_s
end

def calculate_winner(players_hand, dealers_hand)
  players_total = total(players_hand)
  dealers_total = total(dealers_hand)

  if dealers_total == players_total
    puts "It's a tie"
  elsif players_total > dealers_total
    puts "Player won"
  else
    puts "Computer won"
  end
end

def play_again?
  puts "-------------"
  puts "Do you want to play again? (y or n)"
  answer = gets.chomp.downcase
  YES_NO.include?(answer)
end

def newline
  puts "\n"
end

# Game Loop
loop do
  system 'clear'
  puts "Welcome to Twenty-One"
  newline

  players_hand = []
  dealers_hand = []

  2.times do
    deal_card(players_hand)
    deal_card(dealers_hand)
  end

  puts "Your hand is: #{show_hand(players_hand)}"
  # puts "Your total is: #{total(players_hand)}"
  newline
  puts "Dealer's hand is: #{show_hand(dealers_hand[0])} and [??]"
  newline

  loop do
    break if user_turn(players_hand) == "Busted"
    newline
    break if dealer_turn(dealers_hand) == "Busted"
    newline
    calculate_winner(players_hand, dealers_hand)
    break
  end

  break unless play_again?
end

puts "Thanks for playing. Goodbye!"
