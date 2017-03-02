require_relative '../test/test_helper'

class ItemAnalyticsTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @sa = SalesAnalyst.new(se)
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 1, @sa.golden_items.count
    assert_equal "Baby Goats in PJs", @sa.golden_items.first.name
  end

end
