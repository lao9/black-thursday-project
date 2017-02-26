require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv",
      :invoices => "./test_fixtures/invoices_test_fixture.csv"
      })
    @ivr = se.invoices
  end

  def test_all
    assert_instance_of Array, @ivr.all
    assert_equal 101, @ivr.all.count
    assert_instance_of Invoice, @ivr.all.first
  end

  def test_find_by_id
    assert_instance_of Invoice, @ivr.find_by_id(1)
    assert_equal 1, @ivr.find_by_id(1).id
    assert_nil @ivr.find_by_id(10000)
  end

  def test_find_all_by_customer_id
    assert_instance_of Array, @ivr.find_all_by_customer_id(1)
    assert_equal 24, @ivr.find_all_by_customer_id(1).count
  end

  def test_find_all_by_merchant_id
    assert_equal [], @ivr.find_all_by_merchant_id(000000)
    assert_equal 40, @ivr.find_all_by_merchant_id(12334178).count
  end

  def test_find_all_by_status
    assert_instance_of Array, @ivr.find_all_by_status(:pending)
    assert_equal 9, @ivr.find_all_by_status(:returned).count
    assert_equal 53, @ivr.find_all_by_status(:pending).count
  end
end
