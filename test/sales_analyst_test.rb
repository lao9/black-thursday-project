require_relative '../test/test_helper'

class SalesAnalystTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_average
    assert_equal 2.13, @sa.average_items_per_merchant
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
    assert_equal (BigDecimal(47563) / 100), @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 1, @sa.golden_items.count
    assert_equal "Baby Goats in PJs", @sa.golden_items.first.name
  end

  def test_average_invoices_per_merchant
    assert_equal 12.63, @sa.average_invoices_per_merchant
  end

  def test_standard_deviation_invoices_per_merchant
    assert_equal 11.51, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_top_performers
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_equal 1, @sa.top_merchants_by_invoice_count.count
    assert_equal "NatalieWoolSocks", @sa.top_merchants_by_invoice_count.first.name
  end

  def test_it_returns_lowest_performers
    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_returns_top_invoice_days
    assert_instance_of Array, @sa.top_days_by_invoice_count
    assert_equal ["Friday"], @sa.top_days_by_invoice_count
  end

  def test_it_returns_percent_of_invoice_status
    assert_equal 38.61, @sa.invoice_status(:shipped)
    assert_equal 52.48, @sa.invoice_status(:pending)
    assert_equal 8.91, @sa.invoice_status(:returned)
  end


end
