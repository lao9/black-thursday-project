require_relative '../test/test_helper'

class StatsCalculatorTest < Minitest::Test

  include TestSetup
  include StatsCalculator

  def setup
    @set1 = [6, 8, 0, 8, 1, 3, 10, 5]
    @expected1 = {6 => 1, 8 => 2, 0 => 1, 1 => 1, 3 => 1, 10 => 1, 5 => 1}
    @set2 = ["hey", "hello", "sup", "greetings", "hello", "hello", "sup"]
    @expected2 = {hey: 1, hello: 3, sup: 2, greetings: 1}
    @set3 = {hey: [1, 2, 3], whatsup: [4, 5, 6], hello: [7, 8, 9]}
    @expected3 = [:hey, :hey, :hey, :whatsup, :whatsup, :whatsup, :hello, :hello, :hello]
    @set4 = {"a" => 6, "b" => 8, "c" => 0, "d" => 8, "e" => 1, "f" => 3, "g" => 10, "h" => 5}
    @expected4 = ["b", "d", "g"]
  end

  def test_it_returns_average
    assert_equal 5.13, calculate_average(@set1)
    assert_equal 5.86, calculate_average(@set1, 7)
  end

  def test_standard_deviation
    assert_equal 3.56, standard_deviation(@set1)
  end

  def test_unique_element_counter
    assert_equal @expected1, unique_element_counter(@set1)
    assert_equal @expected2, unique_element_counter(@set2, true)
  end

  def test_map_by_quantity
    assert_instance_of Array, map_by_quantity(@set3)
    assert_equal @expected3, map_by_quantity(@set3)
  end

  def test_compare_list_to_stdev
    assert_instance_of Array, compare_list_to_stdev_threshold(@set4, 6.14)
    assert_equal 3, compare_list_to_stdev_threshold(@set4, 6.14).count
    assert_equal @expected4, compare_list_to_stdev_threshold(@set4, 6.14)
  end

  def test_day_of_week
    assert_instance_of Hash, day_of_the_week
    assert_equal "Sunday", day_of_the_week[0]
    assert_equal "Friday", day_of_the_week[5]
  end

end
