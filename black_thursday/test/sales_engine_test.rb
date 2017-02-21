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
skip
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

  end

end
