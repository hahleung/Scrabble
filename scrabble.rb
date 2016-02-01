#Scrabble.rb

#PART 1: Define database
LETTERS = ('a'..'z').to_a
QUANTITY_OF_LETTERS = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
VALUES_OF_LETTERS = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]

#PART 2: Generate the stack from database
def stack
  stack_sum = QUANTITY_OF_LETTERS.reduce(0) { |acc, x| acc + x }
  stack = []
  current_counter = 0
  counter = QUANTITY_OF_LETTERS[current_counter]
  stack_sum.times do |x|
    if x < counter
      stack[x] = LETTERS[current_counter]
    else
      current_counter = current_counter + 1
      counter = counter + QUANTITY_OF_LETTERS[current_counter]
      stack[x] = LETTERS[current_counter]
    end
  end
  stack
end
	
#PART 3: Draw 7 letters from the stack
def draw
  stack.sample(7)
end

#PART 4: Form every possible combination with the 7 drawed letters
def combine(draw_input)
  combinations = draw_input.map { |_| draw_input.clone }
  combinations.length.times { |x| combinations[x].slice!(x) }
  new_combinations = combinations.map { |e| combine(e) }.flatten(1) + [draw_input]
  new_combinations.uniq.reject(&:empty?)
end

#PART 5: Import existing words database and purge the set of combinations
#Source : http://www.freescrabbledictionary.com/sowpods/download/sowpods.txt
def words
  words_bank = File.readlines("words.txt")
  words_bank.map { |x| x.delete("\n") }
end
WORD_BANKS = words

#Function that test if a word is existing or not (dichotomy algorithm)
UPPER_BOUND_INI = WORD_BANKS.length
LOWER_BOUND_INI = 0
NO_ITERATION_INI = 0
N_MAX = 50

def relative_position(word, index)
  wordbank = WORD_BANKS[index]
  wordbank.length.times do |n|
    if word[n] == nil
      delta = -1
    else
      delta = LETTERS.rindex(word[n]) - LETTERS.rindex(wordbank[n])
    end

    if (delta > 0) or ((n+1 == wordbank.length)and(word.length > wordbank.length))
      return "word_after_wordbank"
    elsif delta < 0
      return "word_before_wordbank"
    elsif (delta == 0)and(wordbank.length == word.length)and(n+1 == word.length)
      return "word_egalto_wordbank"
    else
      next
    end
  end
end

def search(word, upper_bound, lower_bound, no_iteration)
  middle_index = ((upper_bound + lower_bound) / 2).to_i
  if no_iteration > N_MAX
    return [nil]
  else
    no_iteration_next = no_iteration + 1
  end

  position = relative_position(word, middle_index)
  if position == "word_after_wordbank"
    search(word, upper_bound, middle_index, no_iteration_next)
  elsif position == "word_before_wordbank"
    search(word, middle_index, lower_bound, no_iteration_next)
  elsif position == "word_egalto_wordbank"
    return [word]
  end
end

#Keep only existing words
def existing_words
  draw_current = draw
  p "The 7 letters drawn are:"
  p draw_current

  combinations = combine(draw_current).map { |e| e.join }
  combinations.map{|i| search(i, UPPER_BOUND_INI, LOWER_BOUND_INI, NO_ITERATION_INI)}.flatten.reject{|x| x==nil}
end

#PART 6: Choose the most valuable word
def score(word)
  score = 0
  word.length.times { |x| score += VALUES_OF_LETTERS[LETTERS.index(word[x])]}
  score
end

def best_word
  best_word = []
  existing_words_current = existing_words
  if existing_words_current.empty?
    p 'Sorry, no word available.'
  else
    existing_words_current.length.times do |x|
      if score(best_word) < score(existing_words_current[x])
        best_word = existing_words_current[x]
      end
    end
    p "These #{existing_words_current.length} words are existing: "
    p existing_words_current
    p "The most valuable word is #{best_word} (#{score(best_word)} points)."
  end
  best_word
end
best_word