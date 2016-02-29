#Scrabble.rb

#PART 1: Define database
LETTERS = ('a'..'z').to_a
QUANTITY_OF_LETTERS = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
VALUES_OF_LETTERS = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]

#PART 2: Generate the stack from database
def stack
  LETTERS.map{|x| [x]*QUANTITY_OF_LETTERS[LETTERS.index(x)]}.flatten.shuffle
end
	
#PART 3: Draw 7 letters from the stack
def draw
  stack.sample(7)
end

#PART 4: Form every possible combination with the 7 drawed letters
def combine(draw_input)
  letters_amount = Array(0..(draw_input.length-1))
  combinations = letters_amount.map{ |x| (letters_amount - [x]).map{ |z| draw_input[z] } }
  smaller_combinations = combinations.map { |e| combine(e) }.flatten(1) + [draw_input]
  smaller_combinations.uniq.reject(&:empty?)
end

#PART 5: Import existing words database and purge the set of combinations
#Source : http://www.freescrabbledictionary.com/sowpods/download/sowpods.txt
def words
  scrabble_words = File.readlines("words.txt")
  scrabble_words.map { |x| x.delete("\n") }
end
SCRABBLE_WORDS = words

#Function that test if a word is existing or not (dichotomy algorithm)
UPPER_BOUND_INI = SCRABBLE_WORDS.length
LOWER_BOUND_INI = 0
NO_ITERATION_INI = 0
N_MAX = 30

def relative_position(word, index)
  authorized_word = SCRABBLE_WORDS[index]
  return :after if word > authorized_word
  return :before if word < authorized_word
  return :equalto if word == authorized_word
end

def search(word, lower_bound, upper_bound, no_iteration)
  middle_index = ((upper_bound + lower_bound) / 2).to_i
  return [nil] if no_iteration > N_MAX
  no_iteration_next = no_iteration + 1

  position = relative_position(word, middle_index)
  case position
  when :before
    search(word, middle_index, upper_bound, no_iteration_next)
  when :after
    search(word, lower_bound, middle_index, no_iteration_next)
  when :equalto
    return [word]
  end
end

#Keep only existing words
def existing_words
  draw_current = draw
  p "The 7 letters drawn are:"
  p draw_current
  p "-"*70

  combinations = combine(draw_current).flat_map{ |w| w.permutation.to_a}.uniq.map { |e| e.join }
  combinations.map{|i| search(i, UPPER_BOUND_INI, LOWER_BOUND_INI, NO_ITERATION_INI)}.flatten.reject{|x| x==nil}
end

#PART 6: Choose the most valuable word
def score(word)
  LETTERS.zip(VALUES_OF_LETTERS).map{|x| word.count(x[0])*x[1] }.reduce(:+)
end

def best_word
  set_words = existing_words
  return "Sorry, no word available." if set_words.empty?
  scores = set_words.reduce({}) { |acc, ite| acc.merge({ite => score(ite)}) }
  best_words = scores.select{ |k,v| v >= scores.values.max }.keys

  p "These #{set_words.length} words are existing: "
  p set_words
  p "-"*70
  p "Among these words, the #{best_words.length} following words make the higher score:"
  best_words.each{ |x| p x }
  p "(with #{scores.values.max} points)"
end

best_word