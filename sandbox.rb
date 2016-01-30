def words
  words_raw = File.readlines("words.txt")
  words_raw.map { |x| x.delete("\n") }
end

WORD_BANKS = words

LETTERS = ('a'..'z').to_a
test = "hello"

upper_bound_ini = WORD_BANKS.length
lower_bound_ini = 0
no_iteration_ini = 0
N_MAX = 20

def search(word_test, upper_bound, lower_bound, no_iteration)
  middle_index = ((upper_bound + lower_bound) / 2).to_i
  
  if no_iteration > N_MAX
    p "No results found after #{N_MAX} iterations."
    return [0]
    exit
  else
    no_iteration += 1
p no_iteration
p WORD_BANKS[middle_index]
  end

  if word_test == WORD_BANKS[middle_index]
    p "Found!"
    return [1]
  else
    WORD_BANKS[middle_index].length.times do |i|
      if word_test[i] == nil
        search(word_test, middle_index, lower_bound, no_iteration)
      else
        delta = LETTERS.rindex(word_test[i]) - LETTERS.rindex(WORD_BANKS[middle_index][i])
        if delta == 0
          if (i+1 == WORD_BANKS[middle_index].length)&&(word_test.length > WORD_BANKS[middle_index].length)
            search(word_test, upper_bound, middle_index, no_iteration)
          else
            next        
          end
        elsif delta < 0
          search(word_test, middle_index, lower_bound, no_iteration)
        else
          search(word_test, upper_bound, middle_index, no_iteration)
        end 
      end
    end
  end
end

a = search(test, upper_bound_ini, lower_bound_ini, no_iteration_ini)
p a
