require '.lib/item_repository'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = se.items
  end

  def test_all
    assert_instance_of Array, @ir.all
    assert_equal 1, @ir.all.count
    assert_instance_of Item, @ir.all.first
  end

  def test_find_by_id
skip
    assert_instance_of Item, @ir.find_by_id(263395237)
    assert_equal '263395237', @ir.find_by_id(263395237).id
    assert_equal 'RealPush Icon Set', @ir.find_by_id(263395237).name
    assert_nil @ir.find_by_id(000000)
  end

  def test_find_by_name
skip
    assert_instance_of Item, @ir.find_by_name('RealPush Icon Set')
    assert_equal '263395237', @ir.find_by_name('SRealPush Icon Set').id
    assert_equal 'RealPush Icon Set', @ir.find_by_name('RealPush Icon Set').name
    assert_nil @ir.find_by_name('fakename')
    assert_equal 'RealPush Icon Set', @ir.find_by_name('REALPUSH ICON SET').name
  end

  def test_find_all_with_description
skip
    assert_equal [], @ir.find_all_by_description('poohead')
    assert_equal 3, @ir.find_all_by_description('shop')
    assert_equal 3, @ir.find_all_by_description('SHOP')
  end

  def test_find_all_by_price
skip
  end

  def test_find_all_by_price_in_range
skip
  end

  def test_find_all_by_merchant_id
skip
  end
end
