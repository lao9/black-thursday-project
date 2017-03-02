require_relative '../test/test_helper'

class SalesAnalystTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_default_values
    assert_instance_of MerchantRepository, @sa.mr
    assert_instance_of ItemRepository, @sa.ir
    assert_instance_of Item, @sa.il.first
    assert_instance_of InvoiceRepository, @sa.ivr
    assert_instance_of Invoice, @sa.ivl.first
    assert_instance_of InvoiceItemRepository, @sa.iir
    assert_instance_of InvoiceItem, @sa.iil.first
    assert_instance_of CustomerRepository, @sa.cr
  end

end
