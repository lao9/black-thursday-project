require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesEngineTest < Minitest::Test

  def test_from_csv_method
    se = SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv"
      })
    assert_instance_of SalesEngine, se
    assert_instance_of CSV, se.merchant_raw_data
    assert_instance_of CSV, se.item_raw_data
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

end
