require "pry"
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
  #when 'start'
   # game_loop
  when 'score'
   newline()
   display_score
   prompt(MSGS['game_menu'])
   score_answer = gets.chomp
   game_menu(score_answer) 
  else
    puts MSGS['gamemenu_invalid_entry']
    # repeat game intro? Bug here, anything but 'start' or 'rules' exits
  end
end

def intro_and_menu
  display_intro
  game_menu(gets.chomp.downcase)
end

def display_weapon_choices()
  prompt(MSGS['choose_weapon'])
  puts VALID_CHOICES.join(", ")
end

def valid_weapon?(user_choice)
  if VALID_CHOICES.include?(user_choice.to_sym)
    return user_choice
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
      break unless user_weapon == nil 
    end
    return user_weapon
end

def translate_weapon(abbr)
  case abbr
  when 'r'
    return "rock"
  when 'p'
    return "paper"
  when 'sc'
    return "scissors"
  when 'l'
    return 'lizard'
  when 'sp'
    return 'spock'
  when 's'
    puts "What a rebel! I'm picking for you!"
    return ['spock', 'scissors'].sample
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

def take_score(winner, u_score, comp_score)
   if winner == "user"
    u_score += 1
  elsif winner == "comp"
    computer_score += 1
  else
    prompt("No points awarded")
  end
end

def display_score
  puts <<-MSG
  The current score:
  
  Your score is:
  Computer's score is:

  MSG
end

def calculate_wins
  
end

def valid_rounds?(no_of_round)
  if no_of_round.to_s.to_i == no_of_round
    no_of_round
  else
    puts "Invalid number of rounds"
  end
end
  
def game_round
  user_weapon = choose_weapon()
  computer_weapon = VALID_CHOICES.sample

  puts "You chose: #{user_weapon}"
  puts "Computer chose: #{computer_weapon}"

  display_results(user_weapon, computer_weapon)
  newline()
end

def play_again?(input)
  if input == 'y' || input == "yes"
    return true
  elsif input == 'n' || input == "no"
    return false
  # elsif input == 'score' 
    #display_score ()
  elsif input == 'intro'
    intro_and_menu()
  else
    prompt(MSGS['play_again_invalid'])
    play_again?(gets.chomp)
  end
end 

def game_loop
  user_score = 0
  computer_score = 0
  puts "no. of rounds:"
  rounds = gets.chomp.to_i
  no_of_game_rounds = valid_rounds?(rounds) 

  loop do

    if no_of_game_rounds

    while no_of_game_rounds > 0 do  
        loop do
          game_round
          no_of_game_rounds -= 1
          break
        end

        loop do# loop to start new round
          puts "Press enter"
          break if gets.chomp == ""
          puts "There's no where else to go. Finish the game!"

          break
          #end new round loop
        end
      clear_screen
    end

    prompt(MSGS['play_again_msg']) 
    if play_again?(gets.chomp) == true
      game_loop
    else
      break
    end

    else
      prompt("Not valid round number")

      
     end

  puts "user score : #{user_score}"
  puts "comp score: #{computer_score}"
  break

  # calculate new score
  # 
end

end


# reset_score? 
# user_score = 0
# computer_score = 0
#intro_and_menu()


game_loop
