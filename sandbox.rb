def words
  words_raw = File.readlines("words.txt")
  words_raw.map { |x| x.delete("\n") }
end

WORD_BANKS = words

LETTERS = ('a'..'z').to_a
test = "helloa"

UPPER_BOUND_INI = WORD_BANKS.length
LOWER_BOUND_INI = 0
NO_ITERATION_INI = 0
N_MAX = 20

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
    elsif (delta == 0)and(n+1 == word.length)
      return "word_egalto_wordbank"
    else
      next
    end
  end
end

def search(word, upper_bound, lower_bound, no_iteration)
  middle_index = ((upper_bound + lower_bound) / 2).to_i
p no_iteration
p WORD_BANKS[middle_index]
  if no_iteration > N_MAX
    p "No results found after #{N_MAX} iterations."
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
    return [1]
  end
end

p search(test, UPPER_BOUND_INI, LOWER_BOUND_INI, NO_ITERATION_INI)
