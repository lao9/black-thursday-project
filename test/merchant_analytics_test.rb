require_relative '../test/test_helper'

class MerchantAnalyticsTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @sa = SalesAnalyst.new(se)
  end

  def test_it_returns_average
    assert_equal 2.63, @sa.average_items_per_merchant
  end

  def test_it_returns_a_standard_dev
    assert_equal 3.16, @sa.average_items_per_merchant_standard_deviation
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
    assert_equal (BigDecimal(25556) / 100), @sa.average_average_price_per_merchant
  end

end
