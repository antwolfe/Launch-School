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
  case answer
  when 'rules'
    display_rules()
    newline()
    prompt(MSGS['game_menu'])
    rules_answer = gets.chomp
    game_menu(rules_answer)
  when 'start'
    game_loop
  else
    puts MSGS['gamemenu_invalid_entry']
    game_menu(gets.chomp)
    # repeat game intro? Bug here, anything but 'start' or 'rules' exits
  end
end

def intro_and_menu
  display_intro
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
    puts "What a rebel! I'm picking for you!"
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

def win_limit(scoreboard)
  scoreboard[0] == 3 || scoreboard[1] == 3
end

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
  prompt("Press enter")
  enter_to_continue(gets.chomp)
  clear_screen()
end

def play_again?(input)
  if input == 'y' || input == "yes"
    true
  elsif input == 'n' || input == "no"
    false
  elsif input == 'intro'
    intro_and_menu()
  else
    prompt(MSGS['play_again_invalid'])
    play_again?(gets.chomp)
  end
end

def play_again_prompt
  prompt(MSGS['play_again_msg'])
  if play_again?(gets.chomp) == true
    game_loop
  else
    false
  end
end

def enter_to_continue(input)
  if input == ""
    input
  else
    prompt("Please press enter")
  end
end

def play_until_3_wins(scoreboard)
  until win_limit(scoreboard)
    game_round(scoreboard)
  end
  display_score(scoreboard)
  newline()
end

def play_user_choice_game_rounds(game_rounds, scoreboard)
  while game_rounds > 0
    game_round(scoreboard)
    clear_screen()
    game_rounds -= 1
  end

  display_score(scoreboard)
  newline()
end

def game_loop
  clear_screen()
  scoreboard = [0, 0]
  puts "No. of rounds:"
  rounds = gets.chomp
  no_of_game_rounds = valid_rounds?(rounds)

  loop do
    if no_of_game_rounds == "limit"
      play_until_3_wins(scoreboard)
      break unless play_again_prompt()
    end

    play_user_choice_game_rounds(no_of_game_rounds, scoreboard)
    break unless play_again_prompt()
  end

  prompt("Thanks for playing! Goodbye!")
end

intro_and_menu()
