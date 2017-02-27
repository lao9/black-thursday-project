require_relative '../test/test_setup'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TransactionRepositoryTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @tr = se.transactions
  end

  def test_all
      assert_instance_of Array, @tr.all
      assert_equal 99, @tr.all.count
      assert_instance_of Transaction, @tr.all.first
  end

  def test_find_by_id
    assert_instance_of Transaction, @tr.find_by_id(1)
    assert_equal 1, @tr.find_by_id(1).id
    assert_nil @tr.find_by_id(000000)
  end

  def test_find_by_invoice_id
    skip
    assert_instance_of Array, @tr.find_by_invoice_id(2179)
    assert_equal 1, @tr.find_by_invoice_id(2179).count
  end

  def test_find_all_by_credit_card_number
    skip
    assert_nil @tr.find_all_by_credit_card_number(000000)
    assert_equal 1, @tr.find_all_by_credit_card_number(4068631943231470)
  end

  def test_find_all_by_result
    skip
    assert_equal [], @tr.find_all_by_result(000000)
    assert_equal 1, @tr.find_all_by_result("success")
  end

end
