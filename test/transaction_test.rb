require_relative '../test/test_setup'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new({
      "id"          => "1",
      "invoice_id" => "2179",
      "credit_card_number" => "4068631943231470",
      "credit_card_expiration_date" => "217",
      "result" => "success",
      "created_at"  => "1980-11-23 09:11:30 UTC",
      "updated_at"  => "1980-11-23 09:11:30 UTC",
      }, "parents")
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_it_returns_invoice_id
    assert_equal 2179, @t.invoice_id
  end

  def test_it_returns_a_credit_card_number
    assert_equal 4068631943231470, @t.credit_card_number
  end

  def test_it_returns_a_credit_card_expiration_date
    assert_equal 217, @t.credit_card_expiration_date
  end

  def test_it_result
    assert_equal "success", @t.result
  end

  def test_it_returns_a_created_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @t.created_at
    assert_instance_of Time, @t.created_at
  end

  def test_it_returns_an_updated_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @t.updated_at
    assert_instance_of Time, @t.updated_at
  end
end
