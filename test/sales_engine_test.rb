require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv"
      })
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

end
