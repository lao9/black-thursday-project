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

  def test_highest_volume_item
    #=> [item] or [item, item, item]
    # first go to invoice and look up the invoice_item_id  (for a single customer)
    # in the invoice item table and pull out the quanity
    # return an array of item ids of the highest quantity items
    # [42, 88]
    # look up the items from the invoice_items table
    # [item_ids : 263399749, 263399964]
    # return item objects based on item _id
    assert_instance_of Array, @sa.highest_volume_items(1)
    assert_equal 2, @sa.highest_volume_items(1).count
    assert_instance_of Item, @sa.highest_volume_items(1).first
    assert_equal 263399749, @sa.highest_volume_items(1).first.id
    assert_equal 263399964, @sa.highest_volume_items(1).last.id
  end

  def test_customers_with_unpaid_invoices
    skip
    # use invoice.paid_in_full? on every invoice and return
    # a list of only those that are false
    # [Invoices, Invoices, Invoices ]
    # [Invoices.customer_id].uniq
    # find customers with unpaid invoices => [customer, customer, customer]
    assert_instance_of Array, @sa.customers_with_unpaid_invoices
    assert_equal 3, @sa.customers_with_unpaid_invoices.count
    assert_instance_of Customer, @sa.customers_with_unpaid_invoices.first
    assert_equal 1, @sa.customers_with_unpaid_invoices.first.id
  end

  def test_best_invoice_by_revenue
    skip
    # look up max revenue (price * quantity) in invoice_items
    # return an invoice_id = 7
    # look up the invoice object for that id (findy by id)
    assert_instance_of Invoice, @sa.best_invoice_by_revenue
    assert_equal 7, @sa.best_invoice_by_revenue.id
  end

  def test_someting
    skip
    # max by quantity in invoice_items
    # return invoice_id = 17
    # look up the invoice object for that id (findy by id)
    assert_instance_of Invoice, @sa.best_invoice_by_quantity
    assert_equal 17, @sa.best_invoice_by_quantity.id
  end

end
