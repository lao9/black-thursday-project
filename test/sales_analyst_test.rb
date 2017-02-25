require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv"
      })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_average
    assert_equal 1.5, @sa.average_items_per_merchant
  end

  def test_it_returns_a_standard_dev
    assert_equal 0.84, @sa.average_items_per_merchant_standard_deviation
  end


# Then ask/answer these questions:
#
# How many products do merchants sell?
#
# Do most of our merchants offer just a few items or do they represent a warehouse?
#
# sa.average_items_per_merchant # => 2.88
# And what’s the standard deviation?
#
# sa.average_items_per_merchant_standard_deviation # => 3.26


end
