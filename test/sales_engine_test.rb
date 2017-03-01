require_relative '../test/test_helper'

class SalesEngineTest < Minitest::Test
  include TestSetup

  def setup
    @se = sales_engine_setup
  end

  def test_from_csv_method
    assert_instance_of SalesEngine, @se
    assert_instance_of CSV, @se.merchant_raw_data
    assert_instance_of CSV, @se.item_raw_data
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of ItemRepository, @se.items
  end

  def test_merchant_to_item_relationship
    merchant = @se.merchants.find_by_id(12334112)
    assert_instance_of Merchant, merchant
    assert_equal 2, merchant.items.count
    assert_equal "Jumping Llamas", merchant.items.first.name
  end

  def test_item_to_merchant_relationship
    item = @se.items.find_by_id(263399954)
    assert_instance_of Item, item
    assert_equal "Candisart", item.merchant.name
  end

  def test_invoice_to_merchant_relationship
    invoice = @se.invoices.find_by_id(1)
    assert_instance_of Invoice, invoice
    assert_equal "NatalieWoolSocks", invoice.merchant.name
  end

  def test_merchant_to_invoice_relationship
    merchant = @se.merchants.find_by_id(12334178)
    assert_instance_of Merchant, merchant
    assert_equal 40, merchant.invoices.count
    assert_equal 1, merchant.invoices.first.id
  end

  def test_invoice_to_items_relationship
    invoice = @se.invoices.find_by_id(20)
    assert_instance_of Invoice, invoice
    assert_instance_of Array, invoice.items
    assert_equal 3, invoice.items.count
    assert_instance_of Item, invoice.items.first
    assert_equal 263399962, invoice.items.first.id
    assert_equal 263399964, invoice.items.last.id
  end

  def test_invoice_to_transactions_relationship
    invoice = @se.invoices.find_by_id(14)
    assert_instance_of Array, invoice.transactions
    assert_equal 1, invoice.transactions.count
    assert_equal 40, invoice.transactions.first.id
  end

  def test_invoice_to_customers_relationship
    invoice = @se.invoices.find_by_id(14)
    assert_instance_of Customer, invoice.customer
    assert_equal 2, invoice.customer.id
    assert_equal "Osinski", invoice.customer.last_name
  end

  def test_transaction_to_invoice_relationship
    transaction = @se.transactions.find_by_id(40)
    assert_instance_of Transaction, transaction
    assert_instance_of Invoice, transaction.invoice
    assert_equal 14, transaction.invoice.id
  end

  def test_merchant_to_customer_relationship
    merchant = @se.merchants.find_by_id(12334178)
    assert_instance_of Merchant, merchant
    assert_instance_of Array, merchant.customers
    assert_equal 5, merchant.customers.count
    assert_instance_of Customer, merchant.customers.first
    assert_equal 1, merchant.customers.first.id
    assert_equal "Ondricka", merchant.customers.first.last_name
  end

  def test_customer_to_merchant_relationship
    customer = @se.customers.find_by_id(1)
    assert_instance_of Customer, customer
    assert_instance_of Array, customer.merchants
    assert_equal 3, customer.merchants.count
    assert_instance_of Merchant, customer.merchants.first
    assert_equal 12334178, customer.merchants.first.id
  end

end
