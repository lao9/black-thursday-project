require './lib/item_repository'
require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv"
      })
    @ir = se.items
  end

  def test_all
    assert_instance_of Array, @ir.all
    assert_equal 5, @ir.all.count
    assert_instance_of Item, @ir.all.first
  end

  def test_find_by_id

    assert_instance_of Item, @ir.find_by_id(263395237)
    assert_equal 263395237, @ir.find_by_id(263395237).id
    assert_equal 'RealPush Icon Set', @ir.find_by_id(263395237).name
    assert_nil @ir.find_by_id(000000)
  end

  def test_find_by_name

    assert_instance_of Item, @ir.find_by_name('RealPush Icon Set')
    assert_equal 263395237, @ir.find_by_name('RealPush Icon Set').id
    assert_equal 'RealPush Icon Set', @ir.find_by_name('RealPush Icon Set').name
    assert_nil @ir.find_by_name('fakename')
    assert_equal 'RealPush Icon Set', @ir.find_by_name('REALPUSH ICON SET').name
  end

  def test_find_all_with_description

    assert_equal [], @ir.find_all_by_description('poohead')
    assert_equal 3, @ir.find_all_by_description('oil').count
    assert_equal 3, @ir.find_all_by_description('OIL').count
  end

  def test_find_all_by_price

    assert_equal [], @ir.find_all_by_price(2000)
    assert_equal 2, @ir.find_all_by_price(5000).count
    assert_equal 263395237, @ir.find_all_by_price(1200).first.id
    assert_equal 'RealPush Icon Set', @ir.find_all_by_price(1200).first.name
  end

  def test_find_all_by_price_in_range

    assert_equal [], @ir.find_all_by_price_in_range(500..1000)
    assert_equal 2, @ir.find_all_by_price_in_range(1000..4000).count
  end

  def test_find_all_by_merchant_id

    assert_equal [], @ir.find_all_by_merchant_id(00000000)
    assert_equal 1, @ir.find_all_by_merchant_id(12334141).count
    assert_equal 263395237, @ir.find_all_by_merchant_id(12334141).first.id
    assert_equal 'RealPush Icon Set', @ir.find_all_by_merchant_id(12334141).first.name
  end
end
