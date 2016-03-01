require_relative 'scrabble.rb'
require 'minitest/autorun'

class TestScrabble < Minitest::Test
  #T1: Do the three database arrays have the same length ?
  def test_check_data_length
    assert_equal LETTERS.length, QUANTITY_OF_LETTERS.length
    assert_equal LETTERS.length, VALUES_OF_LETTERS.length
  end

  #T2: Does the generated stack have the correct quantity of letters ?
  def test_stack_sum
    stack_size = QUANTITY_OF_LETTERS.reduce(0) { |acc,ite| acc + ite }
    assert_equal stack_size, stack.size
  end

  #T3: Do all the drawn letters belong to the stack ?
  def test_draw_included_in_stack
    assert_equal (draw - stack), []
  end

  #T4: Does the function "combine" give back the expected amount of combinations for 7 letters ?
  def test_combine_proper_working
    fictive_draw = %w(a b c d e f g)
    fictive_combinations = combine(fictive_draw)
    expected_combinations = 2**fictive_draw.size - 1
    assert_equal expected_combinations, fictive_combinations.length
  end

  #T5: Does the method "score" work properly ?
  def test_score_working
    assert_equal score("abcdef"), (1 + 3 + 3 + 2 + 1 + 4)
    assert_equal score("zebra"), (10 + 1 + 3 + 1 + 1)
  end
end
