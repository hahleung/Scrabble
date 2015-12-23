require_relative 'scrabble.rb'


#TEST 1: Sizes of LETTERS and QUANTITY_OF_LETTERS are equal
unless LETTERS.length == QUANTITY_OF_LETTERS.length
	puts "Test failure No 1:"
	puts "#{LETTERS.length} letters have been defined."
	puts "Number of #{QUANTITY_OF_LETTERS.length} letters are known."
  puts "Please review."
end

#TEST 2: The size of the stack is correct
#size_stack = QUANTITY_OF_LETTERS.reduce(0, :+)
#size_stack = QUANTITY_OF_LETTERS.reduce(0, &:+)
size_stack = QUANTITY_OF_LETTERS.reduce(0) { |acc, x| acc + x }
unless size_stack == stack.length
	puts "Test failure No 2:"
	puts "#{size_stack} letters have been specified."
	puts "A stack of #{stack.length} has been generated."
  puts "Please review."
end

#TEST 3: The 7 letters drawn are included in the stack
if (draw - stack).any?
#do not write	unless stack.include?(draw[x]) == true, because
# a == (a == true) when a is a Boolean (redundancy)
	puts "Test failure No 3:"
	puts "The letter #{draw[x]} is not included in the stack."
  puts "Please review."
end


#TEST 4: The number of possibilities of combination of letters from the 7 drawn letters is correct 
draw_checking = ["A", "B", "C", "D", "E", "F", "G"]
drawing_checking = drawing(draw_checking)
unless drawing_checking.size == 2**draw_checking.size - 1
  puts "Test failure No 4:"
  puts "Expected to have 2^n-1 possiblities if all the letters are different."
  puts "Expected #{2**draw_checking.size - 1} but got #{drawing_checking.size}."
  puts "Please review."
end

# require 'minitest/autorun'
# describe "addition" do
# 	it "works" do
# 		(1 + 1).must_equal 3
# 	end
# end