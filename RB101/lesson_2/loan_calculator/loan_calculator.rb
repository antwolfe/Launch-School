# Loan calculator

def prompt(msg)
  puts ">> #{msg}"
end

def valid_integer?(numstring)
  numstring.to_i.to_s == numstring && numstring > '0'
end

def valid_float?(numstring)
  numstring.to_f.to_s == numstring && numstring > '0'
end

def apr_to_months(apr)
  (apr.to_f / 100) / 12
end

def loan_years_to_months(years)
  years.to_f * 12
end

def apr_zero?(apr)
  if apr == '0'
    apr
  end
end

def clear_screen
  system('clear')
end

clear_screen
# Starting calculator
prompt("Welcome to the loan calculator!")

loop do # Main Loop
  user_loan_amount = ''
  loop do
    prompt("Please enter your desired loan amount")
    user_loan_amount = gets.chomp
    if valid_integer?(user_loan_amount)
      break
    else
      prompt("Please enter a valid number")
    end
  end

  apr_in_months = ''
  loop do
    prompt("Please enter your APR amount")
    user_apr_amount = gets.chomp
    if valid_integer?(user_apr_amount) || valid_float?(user_apr_amount)                                                                                
      apr_in_months = apr_to_months(user_apr_amount)
      break
    elsif apr_zero?(user_apr_amount)
      apr_in_months = '0'
      break
    else
      prompt("Please enter a valid APR \n Ex: 5 for 5% or 12.5 for 12.5%")
    end
  end

  user_loan_months = ''
  loop do
    prompt("Please enter your loan duration in years")
    user_loan_years = gets.chomp
    if valid_integer?(user_loan_years) || valid_float?(user_loan_years)
      user_loan_months = loan_years_to_months(user_loan_years)
      break
    else
      prompt("Please enter a valid integer")
    end
  end

  monthly_payment =
    user_loan_amount.to_i *
    (apr_in_months /
    (1 - (1 + apr_in_months)**(-user_loan_months)))

  puts "Your monthly payment is #{monthly_payment.round(2)}"

  prompt("Do you want to calculate again?\n
        (Type 'y' to calculate. 'n' to exit.)")

  calculate_again = gets.chomp.downcase
  unless calculate_again.start_with?('y')
    prompt("Goodbye")
    break
  end
end
