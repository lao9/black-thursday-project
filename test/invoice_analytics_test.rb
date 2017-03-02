require_relative '../test/test_helper'

class InvoiceAnalyticsTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @sa = SalesAnalyst.new(se)
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
