#PART 1: Define database
LETTERS = ["a", "b", "c", "d", "e", "f" ,"g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",]
#LETTERS = ["A", "B", "C", "D", "E", "F" ,"G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",]
QUANTITY_OF_LETTERS = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
VALUES_OF_LETTERS = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]
#Test of checking if sizes of LETTERS and QUANTITY_OF_LETTERS are equal:
#- is in main code if this 2 entry vectors are given by the User
#- is in test code if this 2 database vectors are implemented in main code.

#PART 2: Generate the stack from database
def stack
	stack_sum  = 0
	QUANTITY_OF_LETTERS.length.times { |x| stack_sum += QUANTITY_OF_LETTERS[x] }
	stack           = []
	current_counter = 0
	counter	        = QUANTITY_OF_LETTERS[current_counter]

	stack_sum.times do |x|
	 if x < counter
	   stack[x] = LETTERS[current_counter]
	 else
	   current_counter = current_counter + 1
	   counter         = counter + QUANTITY_OF_LETTERS[current_counter]
	   stack[x]        = LETTERS[current_counter]
	 end
	end
	stack
	#Only last sentence of a function is returned.
end

#PART 3: Draw 7 letters from the stack
def draw
	draw = stack.sample(7)
	#draw_tom = LETTERS.zip(NOMBRES).flat_map { |c, n| Array.new(n,c) }
	draw
end

#PART 4: Form every possible combination with the 7 drawed letters
def combine(draw_input)
  #Avoid drawing = []
  #Avoid draw_input.length.times ..
  combinations = draw_input.map { |_| draw_input.clone }
  combinations.length.times { |n| combinations[n].slice!(n) }
  new_combinations = combinations.map { |e| combine(e)}.flatten(1) + [draw_input]
  new_combinations.uniq.reject(&:empty?)
  #Also working: reject(x==[])
  #Also working: reject(|x| x.empty?)
end

#PART 5: Import existing words database and purge the set of combinations
#http://www.freescrabbledictionary.com/sowpods/download/sowpods.txt
def words
	words_raw = File.readlines("words.txt")
	words = words_raw.map{ |x| x.delete("\n")}
end

def existing_words
	existing_words = []
	words_current = words
	draw_current = draw
	p draw_current
	combinations = combine(draw_current).map { |e| e.join }
		combinations.length.times do |x|
			if words_current.include?(combinations[x])
				existing_words = existing_words + [combinations[x]]
		  end
		end
	existing_words
end

#PART 6: Choose the most valuable word
def score(word)
	score = 0
  word.length.times { |x| score += VALUES_OF_LETTERS[LETTERS.index(word[x])]}
  score
  #score = word.reduce(0) {|acc, x| acc + VALUES_OF_LETTERS[LETTERS.index(word[x])]}
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
		p "These #{existing_words_current.length} words are possible: "
		p existing_words_current
		p "The most valuable word is #{best_word} (#{score(best_word)} points)."
	end
	best_word
end
best_word