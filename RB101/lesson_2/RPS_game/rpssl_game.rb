require 'yaml'
MSGS = YAML.load_file('rpssl_message.yml')

WINNING_MOVES = {
  'rock': ['scissors', 'lizard'],
  'paper': ['rock', 'spock'],
  'scissors': ['paper', 'lizard'],
  'spock': ['scissors', 'rock'],
  'lizard': ['spock', 'paper']
}

VALID_CHOICES = WINNING_MOVES.keys

def prompt(message)
  puts(">>> #{message}")
end

def clear_screen
  system('clear')
end

def newline
  puts "\n"
end

def display_intro
  clear_screen
  prompt(MSGS['intro'])
end

def display_rules
  clear_screen
  prompt(MSGS['rules'])
end

def game_menu(answer)
  while answer
    case answer
    when 'rules'
      display_rules()
      newline()
      prompt(MSGS['game_menu'])
      answer = gets.chomp
    when 'start'
      game_loop
      break
    else
      puts MSGS['gamemenu_invalid_entry']
      answer = gets.chomp
    end
  end
end

def intro_and_menu
  display_intro()
  game_menu(gets.chomp.downcase)
end

def display_weapon_choices
  prompt(MSGS['choose_weapon'])
  puts VALID_CHOICES.join(", ")
end

def valid_weapon?(user_choice)
  if VALID_CHOICES.include?(user_choice.to_sym)
    user_choice
  else
    prompt(MSGS['invalid_weapon'])
  end
end

def choose_weapon
  user_weapon = ""
  loop do
    display_weapon_choices()
    user_weapon = translate_weapon(gets.chomp.downcase)
    newline()
    break unless user_weapon.nil?
  end
  user_weapon
end

def translate_weapon(abbr)
  case abbr
  when 'r'then "rock"
  when 'p'then "paper"
  when 'sc' then "scissors"
  when 'l' then "lizard"
  when 'sp' then "spock"
  when 's' then
    puts ">> What a rebel! I'm picking for you! <<"
    ['spock', 'scissors'].sample
  else
    valid_weapon?(abbr)
  end
end

def win?(player1, player2)
  WINNING_MOVES[player1.to_sym].include?(player2.to_s)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("You lost!")
  else
    prompt("It's a tie!")
  end
end

def take_score(player, computer, score)
  if win?(player, computer)
    score[0] += 1
  elsif win?(computer, player)
    score[1] += 1
  else
    prompt("No points awarded")
  end
end

def display_score(scoreboard)
  puts <<-MSG
  The score:
  
  Your score is: #{scoreboard[0]}
  Computer's score is: #{scoreboard[1]}
  MSG
end

def display_final_score_and_winner(scoreboard)
  display_score(scoreboard)
  newline()
  if scoreboard[0] > scoreboard[1]
    prompt("YOU WON!")
  else
    prompt("COMPUTER WON!")
  end
end

def win_limit(scoreboard)
  scoreboard[0].eql?(3) || scoreboard[1].eql?(3)
end

# could also use method logic to do user controlled points?
# (see play_user_choice_wins)

# def user_pick_win_limit(scoreboard, points)
#   scoreboard[0].eql?(points) || scoreboard[1].eql?(points)
# end

def valid_rounds?(no_of_round)
  if no_of_round == ""
    "limit"
  elsif no_of_round.to_i.to_s == no_of_round
    no_of_round.to_i
  else
    puts "Invalid number of rounds. Try again."
    valid_rounds?(gets.chomp)
  end
end

def game_round(score)
  user_weapon = choose_weapon()
  computer_weapon = VALID_CHOICES.sample

  puts "You chose: #{user_weapon}"
  puts "Computer chose: #{computer_weapon}"

  take_score(user_weapon, computer_weapon, score)
  display_results(user_weapon, computer_weapon)
  newline()
  display_score(score)
  newline()
  prompt("Press enter")
  enter_to_continue(gets.chomp)
  clear_screen()
end

def play_again?
  prompt(MSGS['play_again_msg'])
  loop do
    input = gets.chomp
    if input.eql?('y') || input.eql?('yes')
      return true
    elsif input.eql?('n') || input.eql?("no")
      return false
    else
      prompt(MSGS['play_again_invalid'])
    end
  end
end

def enter_to_continue(input)
  if input.empty?
    input
  else
    input.clear
  end
end

def play_until_3_wins(scoreboard)
  until win_limit(scoreboard)
    game_round(scoreboard)
  end
  display_final_score_and_winner(scoreboard)
  newline()
end

def play_user_choice_wins(points, scoreboard)
  while !scoreboard.include?(points)
    game_round(scoreboard)
    clear_screen()
  end
  display_final_score_and_winner(scoreboard)
  newline()
end

def game_loop
  loop do
    clear_screen()
    scoreboard = [0, 0]
    prompt(MSGS['begin_game'])
    rounds = gets.chomp
    no_of_game_points = valid_rounds?(rounds)

    if no_of_game_points == "limit"
      play_until_3_wins(scoreboard)
    else
      play_user_choice_wins(no_of_game_points, scoreboard)
    end

    break unless play_again?()
  end
  prompt("Thanks for playing! Goodbye!")
end

intro_and_menu()
