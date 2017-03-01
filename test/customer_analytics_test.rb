require_relative "../test/test_helper"

class CustomerAnalyticsTest < Minitest::Test

  include TestSetup
  include CustomerAnalytics

  def setup
    @sa = SalesAnalyst.new
  end

  def test_it_finds_the_top_buyers
    skip
    assert_instance_of Array, @sa.top_buyers(3)
    assert_equal 3, @sa.top_buyers(3).count
    assert_instance_of Customer, @sa.top_buyers(3).first
    assert_equal 1, @sa.top_buyers(3).first.id
    assert_equal 3, @sa.top_buyers(3).last.id
  end

  def test_it_defaults_the_top_20_buyers
    skip
    assert_instance_of Array, @sa.top_buyers
    assert_equal 6, @sa.top_buyers.count
    assert_instance_of Customer, @sa.top_buyers.first
    assert_equal 6, @sa.top_buyers.last.id
  end

  def test_it_returns_the_top_merchant
    skip
    assert_instance_of Merchant, @sa.top_merchant_for_customer(customer_id)
    assert_equal 12334178, @sa.top_merchant_for_customer(customer_id).id
    assert_equal "NatalieWoolSocks", @sa.top_merchant_for_customer(customer_id).name
  end

  def test_it_returns_one_time_buyers
    skip
    assert_instance_of Array, @sa.one_time_buyers
    assert_equal 1, @sa.one_time_buyers.count
    assert_instance_of Customer, @sa.one_time_buyers.first
    assert_equal 6, @sa.one_time_buyers.first.id
  end

  def test_one_time_buyer_item
    skip
    assert_instance_of Array, @sa.one_time_buyers_item
    assert_equal 1, @sa.one_time_buyers_item.count
    assert 263399956, @sa.one_time_buyers_item.first.id
  end

  def test_items_bought_in_a_years
    skip
    # which items a given customer bought in given year
    # (by the created_at on the related invoice):
    # => [item]
    assert_instance_of Array, @sa.items_bought_in_year(1, 2003)
    # [8, 48, 88]
    # 263399965
    # 263399966
    # 263523156
    # 263558464
    # 263406625
    # 263395237
    # 263399749
    # 263399825
    assert_equal 8, @sa.items_bought_in_year(1, 2003).count
    assert_instance_of Item, @sa.items_bought_in_year(customer_id, year).first
    assert_equal 263399965, @sa.items_bought_in_year(customer_id, year).first.id
    assert_equal 263399825, @sa.items_bought_in_year(customer_id, year).last.id
  end

  def test_most_recently_bought_items
    skip
    # all items purchaed most if there are several with the same quantity
    # => [item, item, item]
    assert_instance_of Array, @sa.most_recently_bought_items(customer_id)
    assert_equal 1, @sa.most_recently_bought_items(customer_id).count
    assert_instance_of Item, @sa.most_recently_bought_items(customer_id).first
    assert_equal 1, @sa.most_recently_bought_items(customer_id).first.id
  end

  def test_customers_with_unpaid_invoices
    skip
    # find customers with unpaid invoices => [customer, customer, customer]
    assert_instance_of Array, @sa.customers_with_unpaid_invoices
    assert_equal 1, @sa.customers_with_unpaid_invoices.count
    assert_instance_of Customer, @sa.customers_with_unpaid_invoices.first
    assert_equal 1, @sa.customers_with_unpaid_invoices.first.id
  end

  def test_best_invoice_by_revenue
    skip
    # invoices are unpaid if one or more of the invoices
    # are not paid in full (see method invoice#is_paid_in_full?).
    # Find the best invoice, the invoice with the highest dollar amount:
    #=> invoice
    assert_instance_of Invoice, @sa.best_invoice_by_revenue
    assert_equal 1, @sa.best_invoice_by_revenue.id
  end

  def test_someting
    skip
    assert_instance_of Invoice, @sa.best_invoice_by_quantity
    assert_equal 1, @sa.best_invoice_by_quantity.id
  end

end
