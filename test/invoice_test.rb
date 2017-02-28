require_relative '../test/test_helper'

class InvoiceTest < Minitest::Test

  include TestSetup

  def setup
    @se = sales_engine_setup
    @in = Invoice.new({
      "id"          => "46",
      "customer_id" => "7",
      "merchant_id" => "8",
      "status"      => "pending",
      "created_at"  => "1980-11-23 09:11:30 UTC",
      "updated_at"  => "1980-11-23 09:11:30 UTC",
      }, @se.invoices)
    @in2 = Invoice.new({
      "id"          => "1752",
      "customer_id" => "7",
      "merchant_id" => "8",
      "status"      => "pending",
      "created_at"  => "1980-11-23 09:11:30 UTC",
      "updated_at"  => "1980-11-23 09:11:30 UTC",
      }, @se.invoices)
    @in3 = Invoice.new({
      "id"          => "1",
      "customer_id" => "7",
      "merchant_id" => "8",
      "status"      => "pending",
      "created_at"  => "1980-11-23 09:11:30 UTC",
      "updated_at"  => "1980-11-23 09:11:30 UTC",
      }, @se.invoices)
  end

  def test_it_exists
    assert_instance_of Invoice, @in
  end

  def test_it_returns_id
    assert_equal 46, @in.id
  end

  def test_it_returns_customer_id
    assert_equal 7, @in.customer_id
  end

  def test_it_returns_a_merchant_id
    assert_equal 8, @in.merchant_id
  end

  def test_it_returns_status
    assert_equal :pending, @in.status
  end

  def test_it_returns_a_created_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @in.created_at
    assert_instance_of Time, @in.created_at
  end

  def test_it_returns_an_updated_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @in.updated_at
    assert_instance_of Time, @in.updated_at
  end

  def test_if_invoice_is_paid_in_full
    assert @in.is_paid_in_full?
    refute @in2.is_paid_in_full?
    refute @in3.is_paid_in_full?
  end

  def test_it_returns_total
    assert_instance_of BigDecimal, @in.total
    assert_equal 5149.76, @in.total.to_f
  end

end
