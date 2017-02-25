require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
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
    assert_equal 4.25, @sa.average_items_per_merchant
  end

  def test_it_returns_a_standard_dev
    assert_equal 3.48, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 1, @sa.merchants_with_high_item_count.count
    assert_equal "NatalieWoolSocks", @sa.merchants_with_high_item_count.first.name
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334178)
    assert_equal BigDecimal(55), @sa.average_item_price_for_merchant(12334178)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal (BigDecimal(475625) / 1000), @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 1, @sa.golden_items.count
    assert_equal "Baby Goats in PJs", @sa.golden_items.first.name
  end


end
