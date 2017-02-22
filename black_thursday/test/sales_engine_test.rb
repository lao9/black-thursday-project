require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_from_csv_method
    se = SalesEngine.new
    se.from_csv({
      :items => "./test_fixtures/items_test_fixtures.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv"
      })
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

end
