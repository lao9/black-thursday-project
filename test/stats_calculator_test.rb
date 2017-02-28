require_relative '../test/test_helper'

class StatsCalculatorTest < Minitest::Test

  include TestSetup
  include StatsCalculator

  def setup
    @set1 = [6, 8, 0, 8, 1, 3, 10, 5]
    @expected1 = {6 => 1, 8 => 2, 0 => 1, 3 => 1, 10 => 1, 5 => 1}
    @set2 = ["hey", "hello", "sup", "greetings", "hello", "hello", "sup"]
    @expected2 = {hey: 1, hello: 3, sup: 2, greetings: 1}
  end

  def test_it_returns_average
    skip
    assert_equal 5.13, calculate_average(@set1)
    assert_equal 5.86, calculate_average(@set1, 7)
  end

  def test_standard_deviation
    skip
    assert_equal 3.56, standard_deviation(@set1)
  end

  def test_unique_element_counter
    skip
    assert_equal @expected1, unique_element_counter(@set1)
    assert_equal @expected2, unique_element_counter(@set2, true)
  end

end
