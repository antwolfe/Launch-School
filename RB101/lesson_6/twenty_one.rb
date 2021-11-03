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
MAX_GAME_POINTS = 21
DEALER_MIN_POINTS = 17
ROUNDS = 5
RULES = <<-HERE
  The goal of Twenty-One is to try to get as close to 21 as possible, without going over. 
  If you go over 21, it's a "bust" and you lose.

  Setup: the game consists of a "dealer" and a "player". 
  Both participants are initially dealt 2 cards. 
  The player can see their 2 cards, but can only see one of the dealer's cards.

  Card Values: the numbers 2 through 10 are worth their face value. 
  The jack, queen, and king are each worth 10, and the ace can be worth 1 or 11. 
  The ace's value is determined each time a new card is drawn from the deck. 
  If the value is over 21 the ace's value becomes 1. 
  
  Player turn: the player goes first, and can decide to either "hit" or "stay". 
  A hit means the player will ask for another card. 
  Remember that if the total exceeds 21, then the player "busts" and loses. 
  The turn is over when the player either busts or stays.
  If the player busts, the game is over and the dealer won.

  Dealer turn: when the player stays, it's the dealer's turn. 
  The dealer must follow a strict rule for determining whether to hit or stay: 
  hit until the total is at least 17. If the dealer busts, then the player wins.

  Comparing cards: when both the player and the dealer stay, 
  it's time to compare the total value of the cards 
  Whoever has the higest value wins.

  HERE

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

def user_turn(user_hand, user_total, points)
  answer = nil
  loop do
    user_total = total(user_hand)
    display_hand_and_total("Your", user_hand, user_total)
    break if busted?(user_total)
    puts '(h)it or (s)tay?'
    answer = gets.chomp.downcase

    if %w(s stay).include?(answer)
      break
    elsif %w(h hit).include?(answer)
      puts 'Hit!'
      deal_card(user_hand)
    else
      puts "Try Again"
    end
  end

  if busted?(user_total)
    points[1] += 1
    display_busted("Computer") # Computer wins
  else
    puts 'You chose to stay'
  end
end

def dealer_turn(dealers_hand, dealers_total, points)
  loop do
    dealers_total = total(dealers_hand)
    display_hand_and_total("Dealer's", dealers_hand, dealers_total)
    break if dealers_total >= DEALER_MIN_POINTS
    deal_card(dealers_hand)
  end

  if busted?(dealers_total)
    points[0] += 1
    display_busted("Player") # Player wins
  end
end

def display_hand_and_total(player, current_hand, player_total)
  puts "=============================================="
  puts "#{player} hand is: #{show_hand(current_hand)}"
  puts "#{player} total is: #{player_total}"
  puts "=============================================="
  newline
end

def busted?(player_total)
  player_total > MAX_GAME_POINTS
end

def display_busted(other_player)
  newline
  puts "Busted. #{other_player} wins!!"
  "Busted"
end

def deal_card(to_hand)
  to_hand << CARDS_HSH.keys.sample
end

def show_hand(cards)
  cards.to_s
end

def calculate_winner(user_total, dealers_total, points)
  if user_total == dealers_total
    puts "It's a tie"
  elsif user_total > dealers_total
    puts "Player won"
    points[0] += 1
  else
    puts "Computer won"
    points[1] += 1
  end
end

def play_again?
  puts "-------------"
  puts "Do you want to play again? (y or n)"
  answer = gets.chomp.downcase
  %w(y yes).include?(answer)
end

def newline
  puts "\n"
end

# Game Loop
points = [0, 0]

loop do
  system 'clear'
  puts "Welcome to Twenty-One"
  newline
  puts RULES
  newline
  puts "Rounds will automatically play to 5, " \
       "you can exit between them by pushing 'n'."
  newline

  user_hand = []
  dealers_hand = []

  2.times do
    deal_card(user_hand)
    deal_card(dealers_hand)
  end

  user_total = total(user_hand)
  dealers_total = total(dealers_hand)

  puts "Dealer's hand is: #{show_hand(dealers_hand[0])} and [??]"
  newline

  loop do
    break if user_turn(user_hand, user_total, points) == "Busted"
    break if dealer_turn(dealers_hand, dealers_total, points) == "Busted"
    user_total = total(user_hand)
    dealers_total = total(dealers_hand)
    calculate_winner(user_total, dealers_total, points)
    break
  end

  if points[0] == ROUNDS || points[1] == ROUNDS
    puts "5 rounds completed -- Player: #{points[0]} / Dealer: #{points[1]}"
    break
  elsif !play_again?
    break
  end
end

puts "Thanks for playing. Goodbye!"
