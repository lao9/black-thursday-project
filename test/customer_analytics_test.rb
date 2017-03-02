require_relative "../test/test_helper"

class CustomerAnalyticsTest < Minitest::Test

  include TestSetup
  include CustomerAnalytics

  def setup
    se = sales_engine_setup
    @sa = SalesAnalyst.new(se)
  end

  def test_it_finds_the_top_buyers
    assert_instance_of Array, @sa.top_buyers(1)
    assert_equal 1, @sa.top_buyers(1).count
    assert_instance_of Customer, @sa.top_buyers(1).first
    assert_equal 2, @sa.top_buyers(1).first.id
  end

  def test_it_defaults_the_top_20_buyers
    assert_instance_of Array, @sa.top_buyers
    assert_equal 2, @sa.top_buyers.count
    assert_instance_of Customer, @sa.top_buyers.first
    assert_equal 1, @sa.top_buyers.last.id
  end

  def test_it_returns_the_top_merchant
    assert_instance_of Merchant, @sa.top_merchant_for_customer(1)
    assert_equal 12334105, @sa.top_merchant_for_customer(1).id
  end

  def test_it_returns_one_time_buyers
    assert_instance_of Array, @sa.one_time_buyers
    assert_equal 3, @sa.one_time_buyers.count
    assert_instance_of Customer, @sa.one_time_buyers.first
  end

  def test_one_time_buyer_item
    assert_instance_of Array, @sa.one_time_buyers_items
    assert_equal 1, @sa.one_time_buyers_items.count
    assert_equal 263399954, @sa.one_time_buyers_items.first.id
    assert_instance_of Item, @sa.one_time_buyers_items.first
  end


  def test_items_bought_in_a_years
    assert_instance_of Array, @sa.items_bought_in_year(1, 2003)
    assert_equal 10, @sa.items_bought_in_year(1, 2003).count
    assert_instance_of Item, @sa.items_bought_in_year(1, 2003).first
    assert_equal 263399965, @sa.items_bought_in_year(1, 2003).first.id
    assert_equal 263399964, @sa.items_bought_in_year(1, 2003).last.id
  end

  def test_highest_volume_item
    assert_instance_of Array, @sa.highest_volume_items(1)
    assert_equal 2, @sa.highest_volume_items(1).count
    assert_instance_of Item, @sa.highest_volume_items(1).first
    assert_equal 263399825, @sa.highest_volume_items(1).first.id
    assert_equal 263399953, @sa.highest_volume_items(1).last.id
  end

  def test_customers_with_unpaid_invoices
    assert_instance_of Array, @sa.customers_with_unpaid_invoices
    assert_equal 6, @sa.customers_with_unpaid_invoices.count
    assert_instance_of Customer, @sa.customers_with_unpaid_invoices.first
    assert_equal 1, @sa.customers_with_unpaid_invoices.first.id
  end

  def test_best_invoice_by_revenue
    assert_instance_of Invoice, @sa.best_invoice_by_revenue
    assert_equal 14, @sa.best_invoice_by_revenue.id
  end

  def test_best_invoice_by_quantity
    assert_instance_of Invoice, @sa.best_invoice_by_quantity
    assert_equal 14, @sa.best_invoice_by_quantity.id
  end

end
