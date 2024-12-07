file_path = 'google-10000-english-no-swears.txt'
words = File.readlines(file_path)
           .map(&:chomp)
           .select { |word| word.length.between?(5, 12) }
secret_word = words.sample

def display_word(secret_word, guessed_letters)
  display = ''
  secret_word.each_char do |letter|
    if guessed_letters.include?(letter)
      display += letter
    else
      display += '_'
    end
    display += ' '
  end
  display
end

def display_game_status(incorrect_guesses, max_guesses)
  remaining_guesses = max_guesses - incorrect_guesses.length
  puts "Wrong guesses: #{incorrect_guesses.join(', ')}"
  puts "Remaining guesses: #{remaining_guesses}"
end

def get_guess
  print "Enter a letter: "
  gets.chomp.downcase
end

def play_game(secret_word)
  guessed_letters = []
  incorrect_guesses = []  # Changed from incorrect_letters
  max_guesses = 12

  while true
    puts display_word(secret_word, guessed_letters)
    display_game_status(incorrect_guesses, max_guesses)

    guess = get_guess

    if secret_word.include?(guess)  # Added ? to include
      guessed_letters << guess
      puts "Good Guess!"
    else
      incorrect_guesses << guess    # Fixed variable name
      puts "Sorry, try again!"
    end

    # Check for win
    if secret_word.chars.all? { |letter| guessed_letters.include?(letter) }
      puts "Congratulations! You won! The word was #{secret_word}"
      break
    end

    # Check for loss
    if incorrect_guesses.length >= max_guesses
      puts "Game Over! The word was #{secret_word}"
      break
    end
  end
end

# Start the game
play_game(secret_word)
