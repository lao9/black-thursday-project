require_relative '../lib/invoice'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'pry'

class InvoiceTest < Minitest::Test

  def setup
    @in = Invoice.new({
      "id"          => "6",
      "customer_id" => "7",
      "merchant_id" => "8",
      "status"      => "pending",
      "created_at"  => "1980-11-23 09:11:30 UTC",
      "updated_at"  => "1980-11-23 09:11:30 UTC",
      }, "parents")
  end

  def test_it_exists
    assert_instance_of Invoice, @in
  end

  def test_it_returns_id
    assert_equal 6, @in.id
  end

  def test_it_returns_customer_id
    assert_equal 7, @in.customer_id
  end

  def test_it_returns_a_merchant_id
    assert_equal 8, @in.merchant_id
  end

  def test_it_returns_status
    assert_equal "pending", @in.status
  end

  def test_it_returns_a_created_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @in.created_at
    assert_instance_of Time, @in.created_at
  end

  def test_it_returns_an_updated_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @in.updated_at
    assert_instance_of Time, @in.updated_at
  end


end
