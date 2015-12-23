#PART 1: Define database
LETTERS = ["A", "B", "C", "D", "E", "F" ,"G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",]
QUANTITY_OF_LETTERS = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
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