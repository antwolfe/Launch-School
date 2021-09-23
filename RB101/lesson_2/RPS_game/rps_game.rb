VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts(">>> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")

  elsif win?(computer, player)
    prompt("Computer won!")

  else
    prompt("It's a tie")
  end
end

def clear_screen
  system('clear')
end

loop do # Main Loop
  clear_screen()
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("Not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  puts("You chose: #{choice.upcase}.\n
       Computer chose: #{computer_choice.upcase}.")

  display_results(choice, computer_choice)

  prompt("Do  you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
