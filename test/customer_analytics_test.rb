require_relative "../test/test_helper"

class CustomerAnalyticsTest < Minitest::Test

  include TestSetup
  include CustomerAnalytics

  def test_one_time_buyer_item
    skip
    # which item most one_time_buyers bought
    # => [item]
    assert_instance_of Item, @sa.one_time_buyers_item
    assert "", @sa.one_time_buyers_item
  end

  def test_items_bought_in_a_years
    skip
    # which items a given customer bought in given year
    # (by the created_at on the related invoice):
    # => [item]
    assert_instance_of Array, @sa.items_bought_in_year(customer_id, year)
    assert_equal 1, @sa.items_bought_in_year(customer_id, year)
    assert_instance_of Item, @sa.items_bought_in_year(customer_id, year).first
    assert_equal 1, @sa.items_bought_in_year(customer_id, year).first.id
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
