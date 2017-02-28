require_relative '../test/test_helper'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
      "id"          => "6",
      "item_id"     => "7",
      "invoice_id"  => "1",
      "quantity"    => "2",
      "unit_price"  => "13635",
      "created_at"  => "2012-03-27 14:54:09 UTC",
      "updated_at"  => "2012-03-27 14:54:09 UTC"
      }, "parents")
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_returns_id
    assert_equal 6, @ii.id
  end

  def test_it_returns_item_id
    assert_equal 7, @ii.item_id
  end

  def test_it_returns_invoice_id
    assert_equal 1, @ii.invoice_id
  end

  def test_it_returns_quantity
    assert_equal 2, @ii.quantity
  end

  def test_it_returns_a_unit_price_in_big_decimal
    assert_instance_of BigDecimal, @ii.unit_price
  end

  def test_it_returns_a_created_at_time_instance
    assert_equal Time.new(2012, 3, 27, 14, 54, 9, 0000).utc, @ii.created_at
    assert_instance_of Time, @ii.created_at
  end

  def test_it_returns_an_updated_at_time_instance
    assert_equal Time.new(2012, 3, 27, 14, 54, 9, 0000).utc, @ii.updated_at
    assert_instance_of Time, @ii.updated_at
  end

  def test_it_returns_unit_price_in_dollars
    assert_equal 136.35, @ii.unit_price_to_dollars
  end


end
