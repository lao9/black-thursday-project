require_relative '../test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  include TestSetup
  def setup
    se = sales_engine_setup
    @iir = se.invoice_items
  end

  def test_all
    assert_instance_of Array, @iir.all
    assert_equal 100, @iir.all.count
    assert_instance_of InvoiceItem, @iir.all.first
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, @iir.find_by_id(1)
    assert_equal 1, @iir.find_by_id(1).id
    assert_equal 263519844, @iir.find_by_id(1).item_id
    assert_nil @iir.find_by_id(000000)
  end

  def test_find_all_by_item_id
    assert_instance_of Array, @iir.find_all_by_item_id(263553272)
    assert_equal 1, @iir.find_all_by_item_id(263553272).count
    assert_equal 92, @iir.find_all_by_item_id(263553272).first.id
    assert_equal [], @iir.find_all_by_item_id(00000)
  end

  def test_find_all_by_invoice_id
    assert_instance_of Array, @iir.find_all_by_invoice_id(18)
    assert_equal 7, @iir.find_all_by_invoice_id(18).count
    assert_equal 88, @iir.find_all_by_invoice_id(18).first.id
    assert_equal 94, @iir.find_all_by_invoice_id(18).last.id
  end


end
